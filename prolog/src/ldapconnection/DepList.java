/*
* DepList.java
*
* Finds every department registered in the database and writes them to a output file using the format:
* HiST [main department]
* 	Avdeling for informatikk og e-læring (AITeL) [name of dep] ****  AITEL [short] **** 1 [main dep. number: 0=NTNU, 1=HIST, 2=SINTEF, 3=ANDRE]
*		AITeL, faglig personell ****  AITEL **** 1
*		(...)
* 	(...)
*
* The output file is used for fast tagging of departments.
*
*/


package ldapconnection;

import javax.naming.*;
import javax.naming.directory.*;
import java.util.*;
import java.io.*;

class DepList{

	private static final String outputfile = "DepList.txt";

	private String str_base_ntnu = "dc=NTNU,dc=NO";
	private String str_base_hist = "dc=HIST,dc=NO";
	private String str_base_sintef = "dc=SINTEF,dc=NO";
	private String str_base_other = "dc=ANDRE,dc=NO";
  	private DirContext m_ctxNTNU;

	private ArrayList deplist;
  	private PrintWriter pw;

	public DepList() throws Exception {
		Hashtable env = new Hashtable(11);
		env.put(Context.REFERRAL, "throw");
		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		env.put(Context.PROVIDER_URL, "ldap://ldap.ntnu.no"); // :389
		//env.put(Context.PROVIDER_URL, "ldap://ldap.ntnu.no/o=ntnu,c=no");
		m_ctxNTNU = new InitialDirContext(env);

	}

	// Starts the creation of the department list.
	public void createAll() throws Exception{
		deplist = new ArrayList();
		System.out.println("**NTNU**");
		create(str_base_ntnu);
		System.out.println("**HIST**");
		create(str_base_hist);
		System.out.println("**SINTEF**");
		create(str_base_sintef);
		System.out.println("**ANDRE**");
		create(str_base_other);
		if (deplist.size()>0){
			int maindep = 0;
			FileWriter fw = new FileWriter(outputfile);
			pw = new PrintWriter(new BufferedWriter(fw));
			ArrayList firstlist = (ArrayList)deplist.get(0);
			for (int i=0; i<firstlist.size(); i++){
				Department dep = (Department)firstlist.get(i);
				if (dep.title().equals("HiST") || dep.title().equals("SINTEF") || dep.title().equals("Andre") ) maindep++;
				pw.println(dep.title()+" **** "+maindep);
				printChildren(dep, 1, maindep);
			}
			pw.close();
		}
	}

	// Writes information on the given department to the output file
	public void printChildren(Department dep, int fromLvl, int maindep){
		if (fromLvl < deplist.size()){
			ArrayList sublist = (ArrayList)deplist.get(fromLvl);
			Collections.sort(sublist);
			for (int j=0; j<sublist.size(); j++){
				Department testdep = (Department)sublist.get(j);
				if (testdep.parent().equals(dep)){
					testdep.setFinalAddress();
					String address = testdep.getFinalAddress();
					String out = "";
					for (int k=0; k<testdep.lvl(); k++){
						out+="\t";
					}
					out+=testdep.title()+" **** "+testdep.shortTitle()+" **** "+maindep;
					pw.println(out);
					printChildren(testdep, fromLvl+1, maindep);
				}

			}
		}
	}


	// Creates the department objects for the given main department, eg. NTNU, HIST, SINTEF, ANDRE
	public void create(String str_base) throws Exception{


			ArrayList cleanDeps = new ArrayList();
			String[] attrIDs = {"ou", "mail", "sn", "street"};
			//String strFilter = "(&(|(mail=*@" + str + ".*)(mail=*@*." + str + ".*)))";

			SearchControls ctls = new SearchControls();
			ctls.setReturningAttributes(attrIDs);
			ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			String test = "";
			String klasse = "ou";

			String strFilter = "(&(|("+klasse+"="+test+"*)))";

			NamingEnumeration answer = m_ctxNTNU.search(str_base, strFilter, ctls);
			int depCount = 0;
			int hitCount = 0;
			Department parent = null;
			Department origParent = null;
			if (str_base.equals(str_base_ntnu)) parent = new Department("NTNU", 0, null, "");
			else if (str_base.equals(str_base_hist)) parent = new Department("HiST", 0, null, "");
			else if (str_base.equals(str_base_sintef)) parent = new Department("SINTEF", 0, null, "");
			else if (str_base.equals(str_base_other)) parent = new Department("Andre", 0, null, "");
			addDep(parent, "");
			origParent = parent;


			while (answer.hasMore()) {
				SearchResult sr = (SearchResult) answer.next();
				Attribute emailRes = sr.getAttributes().get("mail");
				String email = "";
				if (emailRes!=null){
					String fullEmail = (String)emailRes.get();
					int startIndex = fullEmail.indexOf("@");
					int stopIndex = fullEmail.indexOf(".", startIndex);
					while (stopIndex!=-1){
						String testEmail = fullEmail.substring(startIndex+1, stopIndex).toUpperCase();
						if (!testEmail.equals("NTNU") && !testEmail.equals("SINTEF") && !testEmail.equals("HIST")) email += " "+testEmail;
						startIndex = stopIndex;
						stopIndex = fullEmail.indexOf(".", startIndex+1);
					}
				}
				Attribute snattr = sr.getAttributes().get("sn");
				String sn = "null";
				if (snattr!=null) sn = (String)snattr.get();
				Attribute ouRes = sr.getAttributes().get("ou");
				NamingEnumeration ne = ouRes.getAll();
				Attribute addrAttr = sr.getAttributes().get("street");
				String addr = "";
				if (addrAttr!=null) addr = (String)addrAttr.get();
				//int i=1;
				int lvl = 1;
				while(ne.hasMore()){
					String foundDep = (String)ne.next();
					Department newDep = new Department(foundDep, lvl, parent, email);
					boolean added = false;
					if (snattr!=null) added = addDep(newDep, addr);
					if (added){
						depCount++;
					}
					parent = newDep;
					lvl++;
					hitCount++;
				}
				parent = origParent;
			}
			System.out.println(""+hitCount+" treff, "+depCount+" forskjellige avdelinger");
			answer.close();
	}

	// Adds a department to the list of department objects, if not already added.
	public boolean addDep(Department dep, String addr){
		boolean added = false;
		Department found = null;
		int lvlCount = 0;
		int lvl = dep.lvl();
		if (lvl<deplist.size()){
			ArrayList sublist = (ArrayList)deplist.get(lvl);
			if (!alreadyAdded(dep, addr)){
				sublist.add(dep);
				added = true;
			}else updateEmail(dep);
		}else{
			deplist.add(new ArrayList());
			ArrayList sublist = (ArrayList)deplist.get(lvl);
			dep.addAddress(addr);
			sublist.add(dep);
			added = true;
		}
		return added;
	}

	// Checks if the department is already added to the dep list. Also addr another entry to the addresslist for the department.
	public boolean alreadyAdded(Department dep, String addr){
		boolean added = false;
		for (int i=0; i<deplist.size(); i++){
			ArrayList sublist = (ArrayList)deplist.get(i);
			for (int j=0; j<sublist.size(); j++){
				Department testdep = (Department)sublist.get(j);
				if (testdep.equals(dep)){
					testdep.addAddress(addr);
					sublist.set(j,testdep);
					added = true;
				}
			}
			if (added) deplist.set(i,sublist);
		}
		return added;
	}

	// Updates the email / short title of the dep.
	public void updateEmail(Department dep){
		for (int i=0; i<deplist.size(); i++){
			ArrayList sublist = (ArrayList)deplist.get(i);
			for (int j=0; j<sublist.size(); j++){
				Department testdep = (Department)sublist.get(j);
				StringTokenizer testst = new StringTokenizer(testdep.shortTitle(), " ");
				StringTokenizer st = new StringTokenizer(dep.shortTitle(), " ");
				if (testdep.equals(dep) && testdep.shortTitle.equals("") && !dep.shortTitle.equals("")){
					testdep.setEmail(dep.shortTitle());
					sublist.set(j, testdep);
				}
			}
			deplist.set(i, sublist);
		}
	}


	public static void main(String[] args) throws Exception{
		DepList dl = new DepList();
		dl.createAll();
	}

	private class Department implements Comparable {

		private String title;
		private int lvl;
		private String shortTitle;
		private Department parent;
		private ArrayList addressList;

		private String finalAddress; // set by setFinalAddress()

		public Department(String _title, int _lvl, Department _parent, String _shortTitle){
			title = _title;
			lvl = _lvl;
			parent = _parent;
			shortTitle = _shortTitle;
			addressList = new ArrayList();
		}

		public String title(){
			return title;
		}

		public int lvl(){
			return lvl;
		}
		public Department parent(){
			return parent;
		}
		public String shortTitle(){
			return shortTitle;
		}
		public void setEmail(String email){
			shortTitle = email;
		}

		public boolean equals(Department dep){
			if (title.equals(dep.title()) && ((parent==null && dep.parent()==null) || (parent.equals(dep.parent()))) && lvl==dep.lvl()) return true;
			else return false;
		}

		public String toString(){
			return title+" - "+lvl+" - "+shortTitle+" - parent: "+parent;
		}

		public int compareTo(Object obj){
			Department testDep = (Department)obj;
			return title.compareTo(testDep.title());
		}

		public void addAddress(String address){
			boolean found = false;
			Address foundAddress = null;
			int i=0;
			while (i<addressList.size() && !found){
				Address a = (Address)addressList.get(i);
				if (a.getAddress().equals(address)){
					found = true;
					foundAddress = a;
				}
				i++;
			}
			if (found) foundAddress.addOne();
			else addressList.add(new Address(address));
		}

		public void setFinalAddress(){
			int highestCount = 0;
			Address bestAddress = null;
			for (int i=0; i<addressList.size(); i++){
				Address a = (Address)addressList.get(i);
				if (a.getCount() > highestCount){
					highestCount = a.getCount();
					bestAddress = a;
				}
			}
			if (bestAddress!=null) finalAddress = bestAddress.getAddress();
			else finalAddress = "";
		}

		public String getFinalAddress(){
			return finalAddress;
		}



	}


	private class Address {
		private int count;
		private String address;

		public Address(String _address){
			count = 0;
			address = _address;
		}

		public void addOne(){
			count++;
		}

		public String getAddress(){
			return address;
		}

		public int getCount(){
			return count;
		}

	}

}

