
package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Class for the prolog predicate regdko.<BR>
	
	@author Tore Bruland
*/
public class RegdkoHolder {
	/**
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public RegdkoHolder( String bustucOutputRootFolder ) {
		directory = bustucOutputRootFolder;
		dko = new ArrayList<String>();		
	}
	/**
		instance is used to hold several filesets<br>
		method is called before each new fileset is read 
	*/		
	public void clear() {
		dko.clear();
		directory="";
	}
	/**
		collects data from the dko file.
	*/
	public void setDko(String iDayc, String iX, String iY, String iMask1, String iMask2, String iMask3, String iMask4, String iMasks) {
		String dayc=Util.trimZero(iDayc);
		String x=Util.trimZero(iX);
		String y=Util.trimZero(iY);
		String mask1=iMask1; //Util.trimZero(iMask1);
		String mask2=iMask2;
		String mask3=iMask3;
		String mask4=iMask4;
		String masks=iMasks;

		dko.add("dko("+dayc+","+x+","+y+","+mask1+","+mask2+","+mask3+","+mask4+ ",'" +masks+ "').");
	}	// TA-090617                                                               'Prolog Atom'

	/**
	 *	write the records of the regdko predicate to the proper directory and filename regdko.pl
	 * @param bustucOutputRootFolder Where to write the regxxx.pl files (for bustuc/db/tables)
	 */
	public void writePredicates( String issuedate, String weekday ) {
		try {
			BufferedWriter outFile = new BufferedWriter( new FileWriter(directory+File.separator+"regdko.pl"));
		
		 outFile.write("dkodate(" + issuedate + ", " + weekday + ")."  + "\n" + "\n"); // TA-080219
		
		
		for (Iterator<String> iter=dko.iterator();iter.hasNext(); ) {
				outFile.write(iter.next()+"\n");
			}			
			outFile.close();
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}		
	}	
	/**
		holds the record of the prolog predicate regdko
	*/		
	public ArrayList<String> dko;
	/**
		name of the directory
	*/		
	public String directory;
}
