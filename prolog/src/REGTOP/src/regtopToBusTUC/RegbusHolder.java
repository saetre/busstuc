
package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Class for the prolog predicates regbus and route.<BR>
	@author Tore Bruland
	@author satre
	@since 111201
*/
public class RegbusHolder {
	
	/**
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public RegbusHolder( String bustucOutputRootFolder ) {
		directory = bustucOutputRootFolder;
		regbus = new ArrayList<String>();
		route = new ArrayList<String>();
	}
	/**
		instance is used to hold several filesets<br>
		method is called before each new fileset is read 
	*/
	public void clear() {
		directory="";
		regbus.clear();
		route.clear();
	}
	/** collects data from the tix file */
	public void setTix(String iLine, String iTour){
		//  String line=Util.trimZero(iLine); // %% TA-110209
		//  String tour=Util.trimZero(iTour);
         
		String line=iLine.trim(); // %% TA-110209
		String tour=iTour.trim();

		if ( !regbus.contains(line)) {
			regbus.add(line);
		}
		String key = "route(bus_"+line+"_"+tour+","+line+","+line+").";
		if ( !route.contains(key) ) {
			route.add(key);
		}//if not existing key
	}//setTix       





	public void OLDsetTix(String iLine, String iTour) {
		 String line=iLine;  //  Util.trimZero(iLine); // %% TA-110209
		 String tour=iTour;  //  Util.trimZero(iTour);    %% TA-110209
		String key = "bus_"+line+"_"+tour;
		
		if ( !regbus.contains(line)) {
			regbus.add(line);
		}
		//if ( !route.contains(key) ) {
			route.add("route("+key+","+line+","+line+").");
		//}
	}


	/**
	 * write the records of the regpas and route predicates to the proper directory and filename regpas.pl
	 */
	public void writePredicates() {
		try {
			BufferedWriter outFile = new BufferedWriter( new FileWriter(directory+File.separator+"regbus.pl"));
			for (Iterator<String> iter=regbus.iterator();iter.hasNext(); ) {
				outFile.write("regbus("+iter.next()+").\n");
			}
			outFile.write("\n\n");
			for (Iterator<String> iter=route.iterator();iter.hasNext(); ) {
				outFile.write(iter.next()+"\n");
			}				
			outFile.close();
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}		
	}
	
	/**
		holds the records of the regpas predicate
	*/
	public ArrayList<String> regbus;
	/**
		holds the records of the route predicate
	*/	
	public ArrayList<String> route;
	/**
		name of the directory
	*/		
	public String directory;
}
