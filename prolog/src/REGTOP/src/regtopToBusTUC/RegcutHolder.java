
package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Class for the prolog predicate regcut.<BR>
	
	@author Tore Bruland
*/
public class RegcutHolder {
	public RegcutHolder() {
		cut = new ArrayList<String>();		
		directory = "";
		cut.add("cutloop_trace(nil,nil,nil).");
		cut.add("");
		cut.add("cutloop_rid(nil,nil,nil,nil,nil,nil).");
	}	
	/**
		instance is used to hold several filesets<br>
		method is called before each new fileset is read 
	*/		
	public void clear() {
		cut.clear();
		directory="";
	}
	

	/**
	 *write the records of the regcut predicate to the proper directory and filename regcut.pl
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public void writePredicates(String bustucOutputRootFolder) {
		directory = bustucOutputRootFolder;
		try {
			BufferedWriter outFile = new BufferedWriter( new FileWriter(directory+File.separator+"regcut.pl"));
			for (Iterator<String> iter=cut.iterator();iter.hasNext(); ) {
				outFile.write(iter.next()+"\n");
			}			
			outFile.close();
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}		
	}	
	/**
		holds the record of the prolog predicate regcut
	*/		
	public ArrayList<String> cut;
	/**
		name of the directory
	*/		
	public String directory;
}
