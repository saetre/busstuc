
package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Class for the prolog predicate reghpl.<BR>
	
	@author Tore Bruland
*/
public class ReghplHolder {
	private static final String OUTPUT_ENCODING = ConvertRegTop.OUTPUT_ENCODING;

	/**
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public ReghplHolder(String bustucOutputRootFolder) {
		hlp = new ArrayList<String>();
		directory = bustucOutputRootFolder;
		index = new TreeMap<String,String>();
	}	
	/**
		instance is used to hold several filesets<br>
		method is called before each new fileset is read 
	*/		
	public void clear() {
		hlp.clear();
		directory = "";
	}
	/**
		collects data from the hpl file.
	*/	
	public void setHpl(String iStatnr, String iStatname) {
		String statnr=iStatnr;
		String statname=Util.reduceSpace(iStatname);
		String statid = Util.conv_statname(statname);

		hlp.add("hpl("+statnr+","+statid+","+statid+",'"+statname+"').");
		index.put(statnr,statid);
	}	
	/**
		used by RegpasHolder class
	*/
	public String getStatid(String iStatnr) {
		if (index.containsKey(iStatnr) ) {
			return index.get(iStatnr);
		}
		return "not_found";	// %% TA-110209	
     //	return "statnr="+iStatnr+" not found";
	}
	/**
	 * write the records of the reghpl predicate to the proper directory and filename reghpl.pl
	 */		
	public void writePredicates() {
		try {
			BufferedWriter outFile = new BufferedWriter( 
				//new OutputStreamWriter(new FileOutputStream(directory+File.separator+"reghpl.pl"), "UTF-8"));
				new OutputStreamWriter(new FileOutputStream(directory+File.separator+"reghpl.pl"), OUTPUT_ENCODING));
			for (Iterator<String> iter=hlp.iterator();iter.hasNext(); ) {
				outFile.write(iter.next()+"\n");
			}			
			outFile.close();
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}		
	}	
	/**
		holds the record of the prolog predicate reghpl
	*/			
	public ArrayList<String> hlp;
	/**
		holds stations numbers and station names
	*/
	public TreeMap<String,String> index;
	/**
		name of the directory
	*/		
	public String directory;
}

