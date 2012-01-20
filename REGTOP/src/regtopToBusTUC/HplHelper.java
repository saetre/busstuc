
package regtopToBusTUC;

/**
	Helper class for file hlp. 
	getLine take a string as input and then locates the fields.
	
	@author Tore Bruland
*/

public class HplHelper {
	/**
		Specify where each field starts and stops
	*/	
	public HplHelper() {
		statnr = new FieldHolder("statnr",5,13);
		statname = new FieldHolder("statname",13,43);
	}
	
	/**
		Locates the fields in a text string
	*/		
	public void getLine(String iObj) {
		statnr.value = iObj.substring(statnr.start-1,statnr.stop-1);
		statname.value = iObj.substring(statname.start-1,statname.stop-1);
	}
	
	/**
		Function to display a instance
	*/	
	public String toString() {
		return "HplHelper("+statnr+", "+statname+")";
	}
	
	/**
		Diaplay each FieldHolder. The start and stop positions and the length are displayed to output.
	*/	
	public void printStatus() {
		System.out.println("HPL:");
		System.out.println(statnr);
		System.out.println(statname);
		System.out.println("MAX:"+MAX);
	}
	/**
		the station number substring(13,43) from input string
	*/
	public FieldHolder statnr;
	/**
		the station name substring(5,13) from input string
	*/
	public FieldHolder statname;
	static int MAX=89;
}
