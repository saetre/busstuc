
package regtopToBusTUC;


/**
	Class designed to hold a field name, value and its start and stop position in a test string<BR>
	Used by the helper classes<BR>
	the value field is a substring(start,stop) from input string<br>
	
	@author Tore Bruland
	@author satre
	@since 111219
*/
public class FieldHolder {
	public FieldHolder(String iName, int iStart, int iStop) {
		name = iName;
		value = "";
		start = iStart;
		stop = iStop;
	}
	public String toString() {
		return "fh("+name+", "+start+", "+stop+", len="+(stop-start)+")";
	}
	/**
		the name of the field
	*/
	public String name;
	/**
		the value of name from input string
	*/	
	public String value;
	/**
		the start position in input string
	*/
	public int start;
	/**
		the stop position in input string
	*/	
	public int stop;
}
