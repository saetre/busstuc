/*

møte 18 jan: 1 time
prog 19 jan: 4
reprog 20 jan 4
regprog 22 jan 3
regprog 23 jan 4
regprog 24 jan 5 + 3 kveld (comp)
regprog 29 jan 1 feilretting
regprog 30 jan 1 feilretting
regprog 6 feb  1, dokumentasjon

*/
package regtopToBusTUC;

import java.io.*;
import java.util.*;

/**
	Program with Main function. Called from a directory with RegTopp files. <BR>
	Program reads the catalog and finds files of type: ["*.dko", "*.hpl", "*.tda", "*.tix"]. <BR>
	The hpl file's æøå is converted into file *_hpl.txt. <BR><BR>
	
	Creates sub directories in catalog based on *.dko files and it's first record: YYMMDD.<BR>
	A file with name R0021.DKO with a first record of 071224 will result in the directory r0021_071224.<BR>
	All prolog files are put in this directory.<BR><BR>
	
	Every input file has its Helper class that take care of position of fields in a the text record.<BR>
	Every prolog predicate file has its Holder class that take care of all the fields that are produced in the prolog predicates.<BR><BR>
	
	Each set of input files are read and after that the prolog predicates are generated. <BR>
	The previous information is deleted before reading a new set of input files.<BR>
	
	ReghlpHolder class must be read before regpasHolder, because regpasHolder uses data generated in ReghlpHolder<br>
	
	@author Tore Bruland
	@author Tore Amble
	@since 110101
	@author Rune Sætre
	@since 111201
*/


public class ConvertRegTop {

	public static final String INPUT_ENCODING = "iso-8859-1";
	public static final String OUTPUT_ENCODING = "iso-8859-1";
	private static final String REGTOP_INPUT_ROOT_FOLDER = "RegTopp AtB";
	private static final String BUSTUC_OUTPUT_ROOT_FOLDER = "C:/users/satre/bt3/db/tables";
	private static final int  DEBUG  = 0;

	/**
		Convert input files into prolog predicates.
	*/
   
   String rmask1; // TA-080220
	 
   int weekdayvalue; 


	public String rotatemask(int  wd, String mask) { // rotates string(1:7) wd times
		  if(wd == 1  ) {return  mask;}
        else
		  return (
				 mask.substring(8-wd,7) + mask.substring(0,8-wd) 
             );
	}
	

@SuppressWarnings("unused")
public void readFiles( String bustucOutputRootFolder ) {
		// classes for the files
		DkoHelper theDKO = new DkoHelper();
		HplHelper theHPL = new HplHelper();
		TdaHelper theTDA = null;
		TixHelper theTIX = null;
		//TdaHelper theTDA = new TdaHelper(); // Will be replaced by TMS in RegTopp version 1.2 
		//TixHelper theTIX = new TixHelper(); // Was changed from version 1.1D to 1.2

		// classes for the Prolog predicates
		RegbusHolder theRegbus = new RegbusHolder( bustucOutputRootFolder );
		RegdepHolder theRegdep = new RegdepHolder( bustucOutputRootFolder );
		ReghplHolder theReghpl = new ReghplHolder( bustucOutputRootFolder );
		RegcompHolder theRegcomp = new RegcompHolder( bustucOutputRootFolder );
		RegdkoHolder theRegdko = new RegdkoHolder( bustucOutputRootFolder );
		RegpasHolder theRegpas = new RegpasHolder( bustucOutputRootFolder );
		theRegpas.setReghplHolder(theReghpl); // regpas uses statid from ReghplHolder class

		RegcutHolder theRegcut = new RegcutHolder(); // added TA

		if (index.size() == 0 ) {
			System.out.println("******> no file sets found.");
			return;
		}
		FileSet theFileSet;

		try {
			for (Iterator<FileSet> iter=index.values().iterator(); iter.hasNext();) {
				theRegbus.clear();
				theRegdep.clear();
				theReghpl.clear();
				theRegcomp.clear();
				theRegdko.clear();
				theRegpas.clear();

      		//theRegcut.clear(); // added TA

				theFileSet = iter.next();

				// read DKO file, the first record and get YYMMDD
				BufferedReader DkoFile = new BufferedReader( new FileReader(theFileSet.dko));

				String origrecord = DkoFile.readLine(); // TA-110208
            String record = origrecord;                    //            
            for (int i=origrecord.length();i < 401;i++) { record +='0';};

				// System.out.println("record.length="+record.length()+" "+record);
				int count_dko=0;
				if (record!=null) {
					theDKO.getLine1(record);
					theFileSet.setFolderDate( BUSTUC_OUTPUT_ROOT_FOLDER, theDKO.yymmdd.value );
					//is directory already created?
					File newDir = new File(theFileSet.directory );
					if ( newDir.mkdir() ) {
						System.out.println(theFileSet.directory+" created ...");
					} else {
						System.out.println(theFileSet.directory+" exists ...");
					}
					theRegbus.directory = theFileSet.directory;
					theRegdep.directory = theFileSet.directory;
					theReghpl.directory = theFileSet.directory;
					theRegcomp.directory = theFileSet.directory;
					theRegdko.directory = theFileSet.directory;
					theRegpas.directory = theFileSet.directory;
	
        //       theRegcut.directory = theFileSet.directory; // added TA

               
					record = DkoFile.readLine(); // TA-110208
               
				}

				// Read DKO file from record 2->
				while (record!=null) {
               
					count_dko++;
  
               for (int i=record.length();i < 401;i++) { record +='0';};
					theDKO.getLine2(record);  // TA-110208
	           

				theRegdko.setDko(theDKO.dayc.value,theDKO.x.value,theDKO.y.value,theDKO.mask1.value,
                                theDKO.mask2.value,theDKO.mask3.value,theDKO.mask4.value,theDKO.masks.value);

   
	            weekdayvalue = new Integer(theDKO.weekday.value).intValue(); // TA-080220
 
               rmask1 = rotatemask(weekdayvalue,theDKO.mask1.value); 

					theRegdep.setDko(theDKO.dayc.value,theDKO.mask1.value); // TA 081223 // theRegdep.setDko(theDKO.dayc.value,rmask1); // ,theDKO.mask1.value);

					record = DkoFile.readLine();
				}
				System.out.println(count_dko+" records are read");
				DkoFile.close();

				// Read HPL file
				//BufferedReader HplFile = new BufferedReader( new FileReader(theFileSet.hpl));
				//BufferedReader HplFile = new BufferedReader( new InputStreamReader( new FileInputStream(theFileSet.hpl), "UTF8") );
				BufferedReader HplFile = new BufferedReader( new InputStreamReader( new FileInputStream(theFileSet.hpl), INPUT_ENCODING) );

				record = HplFile.readLine();
				int count_hpl=0;
				while (record!=null) {
					count_hpl++;
					theHPL.getLine(record);
					theReghpl.setHpl(theHPL.statnr.value,theHPL.statname.value);
					theRegcomp.setHpl(theHPL.statnr.value,theHPL.statname.value);
					record = HplFile.readLine();
				}
				System.out.println(count_hpl+" records are read");
				HplFile.close();

				// Read TDA or TMS file
				BufferedReader TdaHelperFile;
				//boolean tms = false;
				try{
					TdaHelperFile = new BufferedReader( new FileReader(theFileSet.tda));
					theTDA = new TdaHelper();
					theTIX = new TixHelper(); // Was changed from version 1.1D to 1.2
				}catch (FileNotFoundException e){
					System.out.println("Couldn't find .TDA, try .tms instead!");
					//tms = true;
					TdaHelperFile = new BufferedReader( new FileReader(theFileSet.tms));
					theTDA = new TmsHelper();
					theTIX = new Tix2Helper((TmsHelper)theTDA);
				}
				if ( DEBUG >0 ) {
					theDKO.printStatus();
					theHPL.printStatus();
					theTDA.printStatus();
					theTIX.printStatus();
				}//if debug

				//Continue reading TDA / TMS in the right version
				record = TdaHelperFile.readLine();
				int count_TdaHelper=0;
				while (record!=null) {
					count_TdaHelper++;
					theTDA.getLine( record, count_TdaHelper );
					theRegpas.setTda(theTDA.statnr.value,theTDA.arr.value,theTDA.dep.value);
					record = TdaHelperFile.readLine();
				}
				theTDA.getLine( record, count_TdaHelper ); //Make sure the last stopCount is stored!
				System.out.println(count_TdaHelper+" records are read");
				TdaHelperFile.close();

				// Read TIX file
				BufferedReader TixFile = new BufferedReader( new FileReader(theFileSet.tix) );
				record = TixFile.readLine();
				int count_Tix=0;
				while (record!=null) {
					count_Tix++;
					theTIX.getLine(record);
					theRegbus.setTix(theTIX.line.value, theTIX.tour.value);
					theRegdep.setTix(theTIX.line.value, theTIX.tour.value, theTIX.deptime.value, theTIX.tdax.value, theTIX.dayc.value);
					theRegpas.setTix(theTIX.tdax.value, theTIX.nstat.value );
					record = TixFile.readLine();
				}
				System.out.println(count_Tix+" records are read");
				TixFile.close();

				theRegbus.writePredicates();
				theRegdep.writePredicates( theRegpas.tdaxIndex ); // bruker konverteringstabell for tdax nummer som fjernes
				theReghpl.writePredicates();
				theRegcomp.writePredicates();
				theRegdko.writePredicates( theDKO.yymmdd.value, theDKO.weekday.value ); // TA-080219
				theRegpas.writePredicates();

				//theRegcut.writePredicates( bustucOutputRootFolder ); // added TA // RS-111219 ToDo this!

			} // end for iterator
		} catch (IOException e ) {
			System.out.println("********** IOException "+e);
			e.printStackTrace();
		}//try-catch
	}//readFiles

	/**	Get input files sets and put them in a TreeMap<String,FileSet> class.
	 *          index = TreeMap< FileSetName, FileSet >
	 *  Scans all sub-folders, to find more filesets in each sub-folder
	 */
	public TreeMap<String,FileSet> getFileSets( String folderName ) {
	  if ( index == null ){ index = new TreeMap<String,FileSet>(); }
	  try{
		String name, filetype;
		FileSet fileSet;
		// enumerate all files in the directory
		File pathName = new File( folderName );
		String[] fileNames = pathName.list();
		if (fileNames == null){
			String error = new String();
			error += "I couldn't find any files in folder: "+folderName+" !!!";
			error += "Please make sure the pathname REGTOP_PARENT_FOLDER is correct";
			error += "   in (ConvertRegTop.java:45), and try again...";
			throw new IOException( error );
		}else{
			for (int i = 0; i < fileNames.length; i++) {
				File f = new File(pathName.getPath(), fileNames[i]);
				//System.out.println("fileName: "+f.getName());
				if (f.isDirectory() ){
					System.out.println( "Do folder: "+f.getName() );
					index.putAll( getFileSets( folderName+'/'+f.getName() ) ); // Recursive !!!
				}else{
					//Filetype is everything after '.' e.g. .DKO .HPL .TIX .TMS / .TDA
					int pos = f.getName().lastIndexOf('.');
					if (pos > -1) { //if filetype given
						name = f.getName().substring(0,pos);
						filetype = f.getName().substring(pos+1);
						if (filetype.toLowerCase().equals("dko") || filetype.toLowerCase().equals("hpl") || filetype.toLowerCase().equals("tda") || filetype.toLowerCase().equals("tms") || filetype.toLowerCase().equals("tix") ) {
							System.out.println("name("+name+") filetype("+filetype+")");
							// find the previous FileSet or create a new.
							if (index.containsKey(name)) {
								fileSet = index.get(name);
								fileSet.setFilename( folderName, name, filetype);
							} else {
								fileSet = new FileSet();
								fileSet.name = name;
								fileSet.setFilename( folderName, name, filetype);
								index.put(name,fileSet);
							}//if existing name
						}//if correct filetype to add if filetype (.FIL) belongs to RegTopp fileSet.
					}//if pos>-1 : filetype is given
				}//if directory, else file
			}//for each file
		}//if any files...
	  }catch(IOException e) {
		  e.printStackTrace();
	  }//try path REGTOP_PARENTS
	  return index;
	}//getFileSets


	/**
		Convert æøå in hlp file. 
	*/
	public void convertHpl() {
		FileSet temp;
		for (Iterator<FileSet> iter=index.values().iterator(); iter.hasNext();) {
			temp = iter.next();

			File f = new File(temp.hpl);
			String newName = temp.name+"_HPL.txt";
			File f1 = new File(newName);
			if( !f.exists() && f.length()<0 ) {
				System.out.println("The specified file is not exist");
			} else {
				try {
					FileInputStream finp=new FileInputStream(f);
					FileOutputStream foutp=new FileOutputStream(f1);
					int b;
					b=finp.read();
					while ( b !=-1 ) {
						foutp.write(Util.strangeAscii(b));
						b=finp.read();
					}
					finp.close();
					foutp.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
 	    	}
 	    	temp.hpl = newName;
			System.out.println(temp);
		}
	}

	/*public void testFunc() {
		RegcompHolder theObj = new RegcompHolder();
		theObj.setHpl("007","Ugla veien");
		for (Iterator iter=theObj.composite_stat.iterator();iter.hasNext(); ) {
			System.out.println(iter.next());
		}
		IsGateRec temp = theObj.isGateEnds("stortingsv");
		System.out.println("prefix:"+temp.strPrefix);
		System.out.println("suffix:"+temp.strSuffix);
		System.out.println("boolean:"+temp.bEndswith);
  	}*/

	public static void main(String[] args) {
		ConvertRegTop pgm = new ConvertRegTop();
		System.out.println("\nConverting all files in sub-folders of "+ConvertRegTop.REGTOP_INPUT_ROOT_FOLDER+"\n");
		pgm.getFileSets( REGTOP_INPUT_ROOT_FOLDER ); // find all input file sets
		pgm.convertHpl(); // convert æøå in hlp files
		pgm.readFiles( ConvertRegTop.BUSTUC_OUTPUT_ROOT_FOLDER ); // create prolog predicates
	}

	/**
		Holds input file sets
	*/
	public TreeMap<String,FileSet> index;
}





















