
package regtopToBusTUC;

import java.util.HashMap;
/**
	Helper class for file tda. 
	getLine take a string as input and then locates the fields.
	
	@author Rune Sætre (RS), 2011
	@version 111218 : Adding .tms functionality to replace .tda functions
*/

public class TmsHelper extends TdaHelper{

	/**	Specify where each field starts and stops */	
	public TmsHelper() {	// .tda is replaced by .tms files... %% RS-111218
		id = new FieldHolder("line",5,12); // Line, Dir, Tour

		statnr = new FieldHolder("statnr",15,23);
		arr = new FieldHolder("arr",23,26);
		dep = new FieldHolder("dep",28,31);
	}
	
	/* substring(5,9), (9,10) and (10,12) from input string */
	public FieldHolder id;

	//Number of stops read for current tour
	int currentStopCount = 0;

	//Number of stops for each given tour.
	private static HashMap<String,Integer> nStops = new HashMap<String,Integer>();
	private static HashMap<String,Integer> lineNrs = new HashMap<String,Integer>();

	//Remember the previously read id.
	private String previousId;

	/**	Locates the fields in a text string */
	public void getLine( String iObj, int lineNr ){
		if (iObj != null){
			currentStopCount++;
			id.value = iObj.substring(id.start-1,id.stop-1);
			statnr.value = iObj.substring(statnr.start-1,statnr.stop-1);
			arr.value = iObj.substring(arr.start-1,arr.stop-1);
			dep.value = iObj.substring(dep.start-1,dep.stop-1);
		}else{
			id.value = "null";
		}
		//If new chain of stations, store previous count and reset.
		if ( ! id.value.equals(previousId) ){
			if (previousId != null){
				nStops.put(previousId,	currentStopCount);
			}
			previousId = id.value;
			lineNrs.put( id.value, lineNr);
			currentStopCount=0;
		}
	}//getLine

	public String getNumberOfStops(String ref) {
		if (nStops.get(ref) == null){
			System.out.println("Couldn't find ref: "+ref);
			if ( lineNrs.keySet().iterator().hasNext() ){
				System.out.println("try: "+nStops.keySet().iterator().next());
			}
		}else{
			return nStops.get(ref).toString();
		}//if real TMS-id ref
		return "null";
	}//getNumberOfStops

	public String getLineNrOffset(String ref) {
		if (lineNrs.get(ref) == null){
			System.out.println("Couldn't find ref: "+ref);
			if ( lineNrs.keySet().iterator().hasNext() ){
				System.out.println("try: "+lineNrs.keySet().iterator().next());
			}
		}else{
			return lineNrs.get(ref).toString();
		}//if real TMS-id ref
		return "null";
	}//getLineNumber

	/**	Function to display a instance
	public String toString() {
		return "TdaHelper("+statnr+", "+arr+", "+dep+")";
	}

	/**	Display each FieldHolder.
	 *  The start and stop positions and the length are displayed to output. */
	public void printStatus() {
		System.out.print("TMS: ");
		System.out.println(id);
		super.printStatus();
	}

	/**
	 * 	the station number substring(1,9) from input string
	public FieldHolder statnr;
		substring(9,12) from input string
	public FieldHolder arr;
		substring(12,15) from input string
	public FieldHolder dep;
	static int MAX=20;
	*/
}//TmsHelper
