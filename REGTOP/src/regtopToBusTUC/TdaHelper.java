
package regtopToBusTUC;

/**
	Helper class for file tda. 
	getLine take a string as input and then locates the fields.
	
	@author Tore Bruland, 2011
	@author satre
	@version 111218, Rune Sætre (RS): Adding .tms functionality
*/

public class TdaHelper {
	/**	Specify where each field starts and stops */	
	public TdaHelper() {	// Obsolete in case of .tms files... %% RS-111218
		statnr = new FieldHolder("statnr",1,9);
		arr = new FieldHolder("arr",9,12);
		dep = new FieldHolder("dep",12,15);
	}

	public void setTms(boolean tms) {
		if (tms){
			statnr = new FieldHolder("statnr",15,23);
			arr = new FieldHolder("arr",24,27);
			dep = new FieldHolder("dep",29,32);
		}//if .TMS file
	}//setTmsFields

	/**	Locates the fields in a text string	*/
	public void getLine( String iObj, int lineNr ) {
		if (iObj != null){
			statnr.value = iObj.substring(statnr.start-1,statnr.stop-1);
			arr.value = iObj.substring(arr.start-1,arr.stop-1);
			dep.value = iObj.substring(dep.start-1,dep.stop-1);
		}else{ //if not null
			System.out.println("Last one?");
		}
	}//getLine

	/**
		Function to display a instance
	*/		
	public String toString() {
		return "TdaHelper("+statnr+", "+arr+", "+dep+")";
	}

	/**	Display each FieldHolder.
	 *  The start and stop positions and the length are displayed to output.	*/
	public void printStatus() {
		System.out.println("TDA/TMS:");
		System.out.println(statnr);
		System.out.println(arr);
		System.out.println(dep);
		System.out.println("MAX:"+MAX);
	}
	
	/**	statnr = the station number substring(1,9) from input string 15-23 for TMS */
	public FieldHolder statnr;

	/** arr = substring(9,12) from TDA input string or 24-27 for TMS */
	public FieldHolder arr;
	
	/**	substring(12,15) from input string or 29-32 for TMS */
	public FieldHolder dep;
	
	//What's this?
	static int MAX=20;
	
}//TdaHelper

