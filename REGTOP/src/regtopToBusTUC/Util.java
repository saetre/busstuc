
package regtopToBusTUC;

/**
	Class for the common methods for the package.<BR>
	
	@author Tore Bruland
*/
public class Util {
	/**
		Prune away leading zeroes
	*/
	public static String trimZero(String iStr) {
		if (iStr.length()==0) return iStr;
		int i=0;
		while (i<iStr.length() && iStr.charAt(i)=='0') {
			i++;
		}
		//System.out.println(iStr+" len:"+iStr.length()+" i:"+i);
		if (i==iStr.length()) return "0";
		return iStr.substring(i);
	}
	/**
		convert yalla øæå to æøå
	*/
	public static int strangeAscii(int iVal) {
		if      (iVal == 157 ) return 216;	// Ø
		else if (iVal == 155 ) return 248;	// ø
		else if (iVal == 143 ) return 197;  // Å
		else if (iVal == 134 ) return 229;  // å
		else if (iVal == 146 ) return 198;  // Æ
		else if (iVal == 145 ) return 230;  // æ
      else if (iVal == 130 ) return 101;  // 'Ê' -> e
		return iVal;
	}
	/**
		More than one space is replaced with one space. replaceAll("'","`")
	*/
	public static String reduceSpace(String iStr) {
		String str=iStr.replaceAll("'","`").trim();
		StringBuffer out = new StringBuffer();
		boolean spaceFlag=false;
		for (int i=0;i<str.length();i++) {
			if (spaceFlag && str.charAt(i)!=' ') {
				spaceFlag=false;
				out.append(' ');
				out.append(str.charAt(i));
			} else if (str.charAt(i)!=' ') {
				out.append(str.charAt(i));
			} else {
				spaceFlag=true;
			}
		}
		return out.toString();
	}
	/**
		convert to lowercase (also æøå),<br>
		convert . to space.<br>
		convert  space to _ <br>.
		only alphanumeric (with æøå and _) are accepted, others are printed to standard output.
	*/
	public static String conv_statname(String iStr) {
		// punktum til blank, blanke til slutt fjernes.
		StringBuffer statid = new StringBuffer();
		char tegn = ' ';
		String new_statname = iStr.toLowerCase(); //.trim();
		for (int i=0; i<new_statname.length();i++) {
			tegn = new_statname.charAt(i);
			if (tegn =='.' || tegn =='('  || tegn==')' || tegn=='/' || tegn== '|' || 
             tegn == ',' || tegn == '-' || tegn == '&' || tegn=='`') { // TA-110225
        
				statid.append(' ');
			} else {
				statid.append(tegn);
			}
		}
		//new_statname = new_statname.replaceAll('.'," ");


      /*  1 Replace unwanted characters with ' '
          2 trim
          3 reduce space (n ' ' -> 1 ' ')
          4 convert ' ' to '_'
          5 other 1-1 replacements
		*/

		//		new_statname = new_statname.replaceAll("\\|"," ").replaceAll("/"," ").replaceAll("-"," ");   //1
    	//    new_statname = new_statname.replaceAll("\\("," ").replaceAll("\\)"," "); 

		new_statname = statid.toString().trim();  //2
	
   	new_statname = reduceSpace(new_statname);   //3

		new_statname = new_statname.replaceAll(" ","_"); //4
     
	/* %% TA-110209
		new_statname = statid.toString().trim();
		new_statname = reduceSpace(new_statname);
		//System.out.print("-->"+new_statname);
		new_statname = new_statname.replaceAll(" ","_").replaceAll("-","_").replaceAll("/","_");
   	new_statname = new_statname.replaceAll("\\|","_");
    	new_statname = new_statname.replaceAll("\\(","_").replaceAll("\\)","_");
      new_statname = new_statname.replaceAll("___","_"). replaceAll("__","_");
   */


		// Convert BIG ÆØÅ to small æøå
		new_statname = new_statname.replaceAll("Æ","æ").replaceAll("Ø","ø").replaceAll("Å","å"); //5
		// Convert è é ü
		new_statname = new_statname.replaceAll("è","e").replaceAll("é","e").replaceAll("ü","u");
     	
		
		statid = new StringBuffer();
		for (int i=0; i<new_statname.length();i++) {
			tegn = new_statname.charAt(i);
			if ( Character.isDigit(tegn) || Character.isLetter(tegn) || 
				  tegn == '(' || tegn == ')' || tegn =='&' || tegn == ',' || // %% TA-110209
         tegn =='_' || tegn=='æ' || tegn=='ø' || tegn=='å' ) {
				statid.append(tegn);
			} else {
				System.out.print(tegn);
			}
		}
		return statid.toString();
	}
}
