
package regtopToBusTUC;

/**
	Helper class for file dko. 
	getLine1 and getLine2 take a string as input and then locates the fields.
	
	@author Tore Bruland
*/
public class DkoHelper {
	/**
		Specify where each field starts and stops <br>

		field	from	to<br>

	*/
	public DkoHelper() {
		// line 1
		yymmdd   = new FieldHolder("yymmdd",1,7);
      weekday  = new FieldHolder("weekday",7,8); //  TA-080219

		// line 2 ->
		x        = new FieldHolder("x",1,4);
		y        = new FieldHolder("y",4,5);
		dayc     = new FieldHolder("dayc",5,9);
		mask1    = new FieldHolder("mask1",9,16);
		mask2    = new FieldHolder("mask2",16,23);
		mask3    = new FieldHolder("mask3",23,30);
		mask4    = new FieldHolder("mask4",30,37);
		masks    = new FieldHolder("masks",9,401); // TA-090617  WHOLE MASK
	}
	
	/**

		Locates the field in a text string
	*/
	public void getLine1(String iObj) {
		yymmdd.value = iObj.substring(yymmdd.start-1,yymmdd.stop-1);
      weekday.value = iObj.substring(weekday.start-1,weekday.stop-1); // TA-080219
	}
	
	/**
		Locates the fields in a text string
	*/	
	public void getLine2(String iObj) {
		 //	 System.out.println("debug, getLine2: "+iObj.length()+" ,start"+masks.start+", stop="+masks.stop );
		x.value = iObj.substring(x.start-1,x.stop-1);
		y.value = iObj.substring(y.start-1,y.stop-1);
		dayc.value = iObj.substring(dayc.start-1,dayc.stop-1);
		mask1.value = iObj.substring(mask1.start-1,mask1.stop-1);
		mask2.value = iObj.substring(mask2.start-1,mask2.stop-1);
		mask3.value = iObj.substring(mask3.start-1,mask3.stop-1);
		mask4.value = iObj.substring(mask4.start-1,mask4.stop-1);

		masks.value = iObj.substring(masks.start-1,masks.stop-1);
	}
	/**
		Function to display a instance
	*/
	public String toString() {
		return "DkoHelper("+yymmdd+", "+weekday+", "+x+", "+y+", "+dayc+", "+mask1+", "+mask2+", "+mask3+", "+mask4+", '" +masks+ "')";
	} //                                                                                                         //   'Prolog Atom'
	/**
		Diaplay each FieldHolder. The start and stop positions and the length are displayed to output.
	*/
	public void printStatus() {
		System.out.println("DKO:");
		System.out.println(yymmdd);
    	System.out.println(weekday);    
		System.out.println(x);
		System.out.println(y);
		System.out.println(dayc);
		System.out.println(mask1);
		System.out.println(mask2);
		System.out.println(mask3);
		System.out.println(mask4);
		System.out.println(masks);
		System.out.println("MAX:"+MAX+", MAX1:"+MAX1);
	}

	public FieldHolder yymmdd;
	/**
		read from pos 1 to pos 7 in input string (first record)
	*/
	public FieldHolder weekday;
	/**
		read from pos 7 to pos 7 in input string (first record)
	*/


	public FieldHolder dayc;
	/**
		read from pos 5 to pos 9 in input string
	*/
	public FieldHolder mask1;
	/**
		read from pos 9 to pos 16 in input string
	*/
	public FieldHolder mask2;
	/**
		read from pos 16 to pos 23 in input string
	*/
	public FieldHolder mask3;
	/**
		read from pos 23 to pos 30 in input string
	*/
	public FieldHolder mask4;
	/**
		read from pos 30 to pos 37 in input string
	*/
	public FieldHolder masks;
	/**
		read from pos 37 to pos 401 in input string
	*/
	public FieldHolder x;
	/**
		read from pos 4 to pos 5 in input string
	*/
	public FieldHolder y;
	static int MAX=365, MAX1=7;

}
