
package regtopToBusTUC;

import java.io.File;

/**
	Class designed to hold dko, hpl, tda (/tms) and tix file names and the directory for the files<BR>
	The filename without the file type is put in name<br>
	The dko, hpl, tda (/tms) and tix files share the same name.
	Used by the helper classes<BR>
	
	@author Tore Bruland
	@author Rune Sætre
	@version 111218
	
*/

public class FileSet {
	public FileSet() {
		dko="";
		hpl="";
		tda="";
		tms="";
		tix="";
		name="";
	}
	
	/**	Creates the name of the directory where the files are to be stored. */
	public void setFolderDate( String rootFolder, String iStr ) {
		directory = rootFolder +File.separator+ (name+"_"+iStr).toLowerCase();
	}
	
	/**	Set the name of the files: dko,hpl,tda or tix. */
	public void setFilename(String folder, String iName, String iFiletype) {
		iName = folder+"/"+iName;
		
		if (iFiletype.toLowerCase().equals("dko")) {
			dko=iName+"."+iFiletype;
		} else if (iFiletype.toLowerCase().equals("hpl")) {
			hpl=iName+"."+iFiletype;
		} else if (iFiletype.toLowerCase().equals("tda")) {
			tda=iName+"."+iFiletype;
		} else if (iFiletype.toLowerCase().equals("tms")) {
			tms=iName+"."+iFiletype;
		} else if (iFiletype.toLowerCase().equals("tix")) {
			tix=iName+"."+iFiletype;
		} else {
			System.out.println("********> setFilename filetype = "+iFiletype+", should be in [dko,hpl,tda,tms,tix]");
		}
	}

	public String toString() {
		return "dko="+dko+" hpl="+hpl+" tda="+tda+" tms="+tms+" tix="+tix+" directory="+directory+" name="+name;
	}
	String dko, hpl, tda, tms, tix, directory, name;
}
