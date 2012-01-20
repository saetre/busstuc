
package regtopToBusTUC;

/**
	Helper class for file tix. 
	getLine take a string as input and then locates the fields.
	
	@author Tore Bruland
*/

public class TixHelper {
	/**
		Specify where each field starts and stops
	*/		
	public TixHelper() {
		line = new FieldHolder("line",5,9);
		tour = new FieldHolder("tour",9,13);
		dayc = new FieldHolder("dayc",16,20);
		deptime = new FieldHolder("deptime",44,48);
		nstat = new FieldHolder("nstat",48,51);
		tdax = new FieldHolder("tdax",51,58);
	}

	/**	substring(5,9) from input string*/	
	public FieldHolder line;
	/**	substring(9,13) from input string*/	
	public FieldHolder tour;
	/**	substring(16,20) from input string*/	
	public FieldHolder dayc;
	/**	substring(44,48) from input string*/	
	public FieldHolder deptime;
	/**	substring(48,51) from input string*/	
	public FieldHolder nstat;
	/**	substring(51,58) from input string*/	
	public FieldHolder tdax;
	static int MAX=20;


	/**	Locates the fields in a text string	*/			
	public void getLine(String iObj) {
		line.value = iObj.substring(line.start-1,line.stop-1);
		tour.value = iObj.substring(tour.start-1,tour.stop-1);
		dayc.value = iObj.substring(dayc.start-1,dayc.stop-1);
		deptime.value = iObj.substring(deptime.start-1,deptime.stop-1);
		nstat.value = iObj.substring(nstat.start-1,nstat.stop-1);
		tdax.value = iObj.substring(tdax.start-1,tdax.stop-1);
	}

	/**
		Function to display a instance
	*/		
	public String toString() {
		return "TixHelper("+line+", "+tour+", "+dayc+", "+deptime+", "+nstat+", "+tdax+")";
	}

	/**
		Diaplay each FieldHolder. The start and stop positions and the length are displayed to output.
	*/		
	public void printStatus() {
		System.out.println("TIX v1.1d:");
		System.out.println(line);
		System.out.println(tour);
		System.out.println(dayc);
		System.out.println(deptime);
		System.out.println(nstat);
		System.out.println(tdax);
		System.out.println("MAX:"+MAX);
	}//printStatus

//	public String getNstat() {
//		return nstat.value;
//	}

}//TixHelper v1.1
