import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;

class DepTest{


	private String str_base_ntnu = "dc=NTNU,dc=NO";
	private String str_base_hist = "dc=HIST,dc=NO";
	private String str_base_sintef = "dc=SINTEF,dc=NO";
	private String str_base_other = "dc=ANDRE,dc=NO";
  	private DirContext m_ctxNTNU;

	public DepTest(){
		try{
			Hashtable env = new Hashtable(11);
			env.put(Context.REFERRAL, "throw");
			env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			env.put(Context.PROVIDER_URL, "ldap://ldap.ntnu.no"); // :389
			//env.put(Context.PROVIDER_URL, "ldap://ldap.ntnu.no/o=ntnu,c=no");
			m_ctxNTNU = new InitialDirContext(env);
		}catch(Exception e){
			System.out.println(e);
		}

	}

	public void test(String str) {
		try{
			String[] attrIDs = {"*"};
			String strFilter = "(&(|(mail=*@" + str + ".*)(mail=*@*." + str + ".*)))";

			SearchControls ctls = new SearchControls();
			ctls.setReturningAttributes(attrIDs);
			ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			String test = "prosessteknikk"; // ..Telefax SINTEF Kjemi
			String klasse = "ou";

			strFilter = "(&(|("+klasse+"="+test+"*)("+klasse+"=* "+test+"*)))";

			System.out.println("søkefilter: "+strFilter);

			NamingEnumeration answer = m_ctxNTNU.search(str_base_ntnu, strFilter, ctls);

			while (answer.hasMore()) {
				System.out.println("----- Et treff -----");
				SearchResult sr = (SearchResult) answer.next();
				NamingEnumeration ne = sr.getAttributes().getAll();
				int i=1;
				while(ne.hasMore()){
					Attribute at = (Attribute)ne.next();
					//System.out.println("*** "+at.getID()+" ***");

					NamingEnumeration ne2 = at.getAll();
					while(ne2.hasMore()){
						Object at2 = ne2.next();
						//System.out.println(""+at.size());
						if (at2 instanceof String) System.out.println(""+i+": "+(String)at2+" ("+at.getID()+")");
						else System.out.println("annet..");
						//Attribute at2 = (Attribute)ne2.next();

						//System.out.println("ID: "+at2.getID());
						//String one = (String)at2.get();
						//System.out.println("en ting: "+one+" - attribute: "+at.getID()+" attribute2: "+at2.getID()+" vals: "+at.size());
						i++;
					}
				}
				//Attribute at = sr.getAttributes().get(strAtrId);
				//String str = (String)at.get();
			}

			//boolean boRet = answer.hasMore();
			//System.out.println(boRet);
			answer.close();
		}catch(Exception e){
			System.out.println(e);
		}
	}

	public static void main(String[] args){
		DepTest dt = new DepTest();
		dt.test("idi");
	}

}