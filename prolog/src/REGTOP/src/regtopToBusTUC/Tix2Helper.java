
package regtopToBusTUC;

/**
	Helper class for file tix.
	getLine take a string as input and then locates the fields.
	
	@author Rune Sætre
	@version RegTopp 1.2
	@since 111219
*/

public class Tix2Helper extends TixHelper{
	
	// A way to get Number of stops for each tour-pattern, now that TDA is replaced by TMS
	TmsHelper TDA;

	/**		Specify where each field starts and stops	*/		
	public Tix2Helper( TmsHelper tda ) {
		this.TDA = tda;
		line = new FieldHolder("line",5,9);
		tour = new FieldHolder("tour",9,13);
		dayc = new FieldHolder("dayc",16,20);
		dirTms = new FieldHolder("dirTms",41,44); //dir and tms-nr
		deptime = new FieldHolder("deptime",44,48);

		//nstat = new FieldHolder("nstat",48,51); //v1.1d
		nstat = new FieldHolder("nstat",0,0);
		tdax = new FieldHolder("tdax",0,0);
	}

	/**	Locates the fields in a text string 
	public void getLine(String iObj) {
		System.out.println("Tix2Helper~31: Use TdaHelper to get number of stops!");
	}
	*/
	/**	Locates the fields in a text string. Gets tdax and nstat from TMS-calc */
	public void getLine(String iObj) {
		line.value = iObj.substring(line.start-1,line.stop-1);
		tour.value = iObj.substring(tour.start-1,tour.stop-1);
		dayc.value = iObj.substring(dayc.start-1,dayc.stop-1);
		dirTms.value = iObj.substring(dirTms.start-1,dirTms.stop-1);
		deptime.value = iObj.substring(deptime.start-1,deptime.stop-1);

		//Referanse fra TURIX til TURMSTR er feltene Linjenr, Retning og Turmønsternr
		String ref = line.value + dirTms.value;

		//nstat.value = iObj.substring(nstat.start-1,nstat.stop-1);
		nstat.value = TDA.getNumberOfStops( ref );
		tdax.value = TDA.getLineNrOffset( ref );		//Use offset in file instead, like in version 1.1d
	}//getLine
	
	/**	Display each FieldHolder.
	 *  The start and stop positions and the length are displayed to output. */
	public void printStatus(){
		System.out.print("TIX v1.2: ");
		super.printStatus();
	}//printStatus

	/**	Function to display a instance
	public String toString() {
		return "Tix2Helper("+line+", "+tour+", "+dayc+", "+deptime+", "+nstat+", "+tdax+")";
	}
	*/		
	/**	From v1.1d
	 * Inherited from TixHelper(1.1d)
	 *	substring(5,9) from input string
			public FieldHolder line;
	 *	substring(9,13) from input string	
			public FieldHolder tour;
	 *	substring(16,20) from input string	
			public FieldHolder dayc;
	 *	substring(44,48) from input string	
			public FieldHolder deptime;
	 *	substring(48,51) from input string	
			public FieldHolder nstat;
	 *	substring(51,58) from input string
			public FieldHolder tdax;
	static int MAX=20;
	**/	

	/**	From v1.2
	 *	substring(41,44) from input string (41 is dir, 42-43 is TurMønsterNr) */
	public FieldHolder dirTms;
	
}//Tix2Helper
