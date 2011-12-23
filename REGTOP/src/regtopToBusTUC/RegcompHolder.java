

package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Class for the prolog predicates regcomp.<BR>
	Extra predicates are generated and thay are marked with prolog comment and generated a number<br>
	The number is a key to where in the code the extra predicate is generated.
	
	@author Tore Bruland
*/

public class RegcompHolder {
	private static final String OUTPUT_ENCODING = ConvertRegTop.OUTPUT_ENCODING;

	/**
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public RegcompHolder(String bustucOutputRootFolder) {
		composite_stat = new ArrayList<String>();
		directory = bustucOutputRootFolder;
		gater = new ArrayList<String>();
		gater.add("gata");
		gater.add("gate");
		gater.add("gaten");
		gater.add("gt");
		gater.add("v");
		gater.add("veg");
		gater.add("vegen");
		gater.add("vei");
		gater.add("veien");
		gater.add("vg");
		gater.add("vn");
	}
	/**
		instance is used to hold several filesets<br>
		method is called before each new fileset is read 
	*/	
	public void clear() {
		composite_stat.clear();
		directory="";
	}
	/**
		collects data from the hpl file<br>
		extra predicates are also generated<br>
	*/	
	public void setHpl(String iStatnr, String iStatname) {
		//String statnr=iStatnr;
		String statname=Util.reduceSpace(iStatname);
		String statid = Util.conv_statname(statname);
		StringTokenizer st = new StringTokenizer(statid,"_");
		String nameOne = "";
		if (st.hasMoreTokens()) nameOne = st.nextToken();
		ArrayList<String> nameTab = new ArrayList<String>();
		while (st.hasMoreTokens()) {
			nameTab.add(st.nextToken());
     	}
		composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+").");
		// nameTab members 1..n
		if (nameTab.size() > 0) {
			// last member a road word.
			if ( isGate(nameTab.get(nameTab.size()-1)) ) {
				if ( nameTab.size()==1) {
					composite_stat.add("composite_stat("+nameOne+nameTab.get(0)+",[],"+statid+"). % generated 1.0");
					composite_stat.add("composite_stat("+nameOne+"_street,[],"+statid+"). % generated 1.1");
					composite_stat.add("composite_stat("+nameOne+",[street],"+statid+"). % generated 1.2");
				} else {
					String last = nameTab.remove(nameTab.size()-1);
					String husk = nameTab.get(nameTab.size()-1);
					nameTab.set(nameTab.size()-1, husk+last);
					composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 2.0");
					nameTab.set(nameTab.size()-1, husk+"_street");
					composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 2.1");
					nameTab.set(nameTab.size()-1, husk);
					nameTab.add("street");
					composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 2.2");
				}

			} else {
				// ends with s +  road word
				IsGateRec theGateRec = isGateEnds(nameTab.get(nameTab.size()-1));
				if ( theGateRec.bEndswith ) {
					if ( nameTab.size()==1) {
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix);
						nameTab.add(theGateRec.strSuffix);
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 3.0");
						nameTab.set(nameTab.size()-1, "street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 3.2");
						nameTab.remove(nameTab.size()-1);
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix+"_street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 3.1");
					} else {
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix+"_street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 7.0");
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix);
						nameTab.add(theGateRec.strSuffix);
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 7.1");
						nameTab.set(nameTab.size()-1, "street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 7.2");
					}
				} else {
					// ends with road word
					theGateRec = isGateEnd(nameTab.get(nameTab.size()-1));
					if ( theGateRec.bEndswith ) {
						/*composite_stat.add("composite_stat("+theGateRec.strPrefix+",["+theGateRec.strSuffix+"],"+statid+"). % generated 6.0");
						composite_stat.add("composite_stat("+theGateRec.strPrefix+",[street],"+statid+"). % generated 6.1");
						composite_stat.add("composite_stat("+theGateRec.strPrefix+"_street,[],"+statid+"). % generated 6.2");
						*/
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix+"_street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 6.0");
						nameTab.set(nameTab.size()-1, theGateRec.strPrefix);
						nameTab.add(theGateRec.strSuffix);
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 6.1");
						nameTab.set(nameTab.size()-1, "street");
						composite_stat.add("composite_stat("+nameOne+","+nameTab+","+statid+"). % generated 6.2");						
					}					
				}
			}
		} else {
			IsGateRec theGateRec = isGateEnds(nameOne);
		 if ( ! (theGateRec.strPrefix.trim().equals(""))) {

   	 	if ( theGateRec.bEndswith ) {
				composite_stat.add("composite_stat("+theGateRec.strPrefix+",["+theGateRec.strSuffix+"],"+statid+"). % generated 4.0");
				composite_stat.add("composite_stat("+theGateRec.strPrefix+",[street],"+statid+"). % generated 4.1");
				composite_stat.add("composite_stat("+theGateRec.strPrefix+"_street,[],"+statid+"). % generated 4.2");
			} else {
				theGateRec = isGateEnd(nameOne);
				if ( theGateRec.bEndswith ) {
					composite_stat.add("composite_stat("+theGateRec.strPrefix+",["+theGateRec.strSuffix+"],"+statid+"). % generated 5.0");
					composite_stat.add("composite_stat("+theGateRec.strPrefix+",[street],"+statid+"). % generated 5.1");
					composite_stat.add("composite_stat("+theGateRec.strPrefix+"_street,[],"+statid+"). % generated 5.2");
			  }
			}
		 }

		}
	}
	/**
		Test if iStr is denoting a street or not.<br>
	*/
	public boolean isGate(String iStr) {
		if ( gater.contains(iStr) ) return true;
		return false;
	}
	/**
		Test if iStr is ending with a string that is denoting a street or not.<br>
	*/
	public IsGateRec isGateEnd(String iStr) {
		if ( iStr.endsWith("gata") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-4),"gata",true);
		}
		if ( iStr.endsWith("gate") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-4),"gate",true);
		}
		if ( iStr.endsWith("gaten") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-5),"gaten",true);
		}
		if ( iStr.endsWith("gt") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-2),"gt",true);
		}		
		if ( iStr.endsWith("v") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-1),"v",true);
		}
		if ( iStr.endsWith("veg") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-3),"veg",true);
		}
		if ( iStr.endsWith("vegen") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-5),"vegen",true);
		}
		if ( iStr.endsWith("vei") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-3),"vei",true);
		}
		if ( iStr.endsWith("veien") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-5),"veien",true);
		}
		if ( iStr.endsWith("vg") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-2),"vg",true);
		}
		if ( iStr.endsWith("vn") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-2),"vn",true);
		}
		return new IsGateRec("","",false);
	}

	/**
		Test if iStr is ending with a string that is denoting a street or not.<br>
	*/	
	public IsGateRec isGateEnds(String iStr) {

		if ( iStr.endsWith("sgata") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-5),"gata",true);
		} 
		if ( iStr.endsWith("sgate") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-5),"gate",true);
		} 
		if ( iStr.endsWith("sgaten") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-6),"gaten",true);
		}
		if ( iStr.endsWith("sgt") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-3),"gt",true);
		}		
		if ( iStr.endsWith("sv") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-2),"v",true);
		}
		if ( iStr.endsWith("sveg") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-4),"veg",true);
		}
		if ( iStr.endsWith("svegen") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-6),"vegen",true);
		}
		if ( iStr.endsWith("svei") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-4),"vei",true);
		}
		if ( iStr.endsWith("sveien") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-6),"veien",true);
		}
		if ( iStr.endsWith("svg") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-3),"vg",true);
		}
		if ( iStr.endsWith("svn") ) {
			return new IsGateRec(iStr.substring(0,iStr.length()-3),"vn",true);
		}
		return new IsGateRec("","",false);
	}
	/**
	 *	write the records of the regcomp predicates to the proper directory and filename regcomp.pl
	 */		
	public void writePredicates() {
		try {
			BufferedWriter outFile = new BufferedWriter(
				new OutputStreamWriter(new FileOutputStream(directory+File.separator+"regcomp.pl"), OUTPUT_ENCODING));
			for (Iterator<String> iter=composite_stat.iterator();iter.hasNext(); ) {
				outFile.write(iter.next()+"\n");
			}
			outFile.close();
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}
	}
	/**
		holds records for the prolog predicate regcomp
	*/
	public ArrayList<String> composite_stat;
	/**
		name of the directory
	*/		
	public String directory;
	/**
		names that denoe a street
	*/		
	public ArrayList<String> gater;
}


