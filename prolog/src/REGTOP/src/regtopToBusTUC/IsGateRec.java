
package regtopToBusTUC;

/**
	Class is used as a return class for storing streetnames with endings and prefixes.<BR>
	Class also contains a boolean result field  
	
	@author Tore Bruland
*/
public class IsGateRec {
	public IsGateRec(String iPrefix, String iSuffix, boolean iBool) {
		strPrefix = iPrefix;
		strSuffix = iSuffix;
		bEndswith = iBool;
	}
	public String strPrefix;
	public String strSuffix;
	public boolean bEndswith;
}