package ldapconnection;

import java.util.regex.*;
import javax.naming.*;
import javax.naming.directory.*;
import java.util.*;

class TaggerLDAP{

	private String str_base_ntnu = "dc=NTNU,dc=NO";
	  private String str_base_hist = "dc=HIST,dc=NO";
	  private String str_base_sintef = "dc=SINTEF,dc=NO";
  private String str_base_other = "dc=ANDRE,dc=NO";

  private int m_iExactCount;
  private int m_iCountSearches;
  private DirContext m_ctxNTNU;
  private ArrayList foundFullNamesGn; // givenname
  private ArrayList foundFullNamesSn; // sn, surname
  private ArrayList exactNames;
  private ArrayList depList;
  private boolean office;

	public TaggerLDAP(DirContext idc){
		m_ctxNTNU = idc;
		m_iExactCount = 0;
		m_iCountSearches = 0;
		foundFullNamesGn = new ArrayList();
		foundFullNamesSn = new ArrayList();
		exactNames = new ArrayList();
		office = false;
	}

	public ArrayList createTagsAttr(String[] astr, String strAttrib, String strConcept, ArrayList m_taggedWords) {
		ArrayList tagResult = new ArrayList();
	 	Tagging taggedWord = null;
		String srchStr = "";
		boolean tooShort = false;
		for (int i=0; i<astr.length; i++){
			srchStr += astr[i]+" ";
			if (astr[i]!=null && astr[i].length()<3 && astr.length>1 && LDAPSearcher.strOknames.indexOf(" "+astr[i]+" ")==-1 ) tooShort = true; // ignore if name has more than one word, and one of them is less than 3 letters
		}
		if (tooShort){
			return null;
		}
	    if (astr.length == 1 && astr[0].length() == 1) {
	      return null;
	    }
	    try {
	      String strFilter = strMakeCompFilter(astr, strAttrib);
	      int i;
	      if ( (i = iExists(strFilter, m_taggedWords)) > 0) {
			  String out ="";
			  for (int j=0; j<astr.length; j++){
				  out+=astr[j];
			  }
			  if (office){
				  strConcept = "room";
				  office = false;
			  }
			  taggedWord = new Tagging(astr, strConcept, i, m_iExactCount);
	      }

	      String strFiltern = null;
	      if (taggedWord==null){
			  // Try capitalizing norwegian characters [æøå] in beginning of words
			  strFiltern = strFilter.replaceAll("\\bæ", "Æ");
			  strFiltern = strFiltern.replaceAll("\\bø", "Ø");
			  strFiltern = strFiltern.replaceAll("\\bå", "Å");
			  strFiltern = strFiltern.replaceAll("\\BÆ", "æ");
			  strFiltern = strFiltern.replaceAll("\\BØ", "ø");
			  strFiltern = strFiltern.replaceAll("\\BÅ", "å");

			  if (strFiltern.indexOf("Æ")!=-1 || strFiltern.indexOf("Ø")!=-1 || strFiltern.indexOf("Å")!=-1 ||
					strFiltern.indexOf("æ")!=-1 || strFiltern.indexOf("ø")!=-1 || strFiltern.indexOf("å")!=-1 ){
				  if ( (i = iExists(strFiltern, m_taggedWords)) > 0) {
					taggedWord = new Tagging(astr, strConcept, i, m_iExactCount);
					// t.capitalizeNorw(); // skaper problemer
				  }
			  }
		  }


		  if (taggedWord==null){
			  String strFilteru = strFiltern;
			  strFilteru = replaceSpecial(strFilteru);
			  if (!strFilteru.equals(strFiltern)){
				  if ( (i = iExists(strFilteru, m_taggedWords)) > 0) {
					taggedWord = new Tagging(astr, strConcept, i, m_iExactCount);
				  }
			  }
		  }

	    }
	    catch (Exception e) {
			//System.out.println(e);
	      // nothing to do - just return null on error
	    }
	    tagResult.add(taggedWord);
		tagResult.add(foundFullNamesGn);
		tagResult.add(foundFullNamesSn);
	    return tagResult;
  }

  private String replaceSpecial(String input){
  	  String output = input;
  	  String[][] rChars = { {"æ", "ø", "y", "Æ", "Ø", "Y"}, {"ä", "ö", "ü", "Ä", "Ö", "Ü"} };
  	  for (int k=0; k<rChars[0].length; k++){
  		  output = output.replaceAll(rChars[0][k], rChars[1][k]);
  		  if ((k+3)<rChars[1].length) output = output.replaceAll("\\b"+rChars[1][k], rChars[1][k+3]); // capitalize first character
  	  }
  	  return output;
  }

  /**
     * Makes a LDAP search filter from a argument name and a list of values to look for
     *
     * @param astrVals    an array of String objects containing the values to look for
     * @param strArg      the argument to search in
     * @return            the filter made of the arguments
     */
    public static String strMakeCompFilter(String[] astrVals, String strArg) {
      if (astrVals.length < 1) {
        return "";
      }

      String strRet = "";
      String strNew = "";
      for (int i = 0; i < astrVals.length - 1; i++) {
        strRet += "(&";
      }
      strRet += "(|(" + strArg + "=" + astrVals[0] + "*)(" + strArg + "=* " +
          astrVals[0] + "*)(" + strArg + "=.." + astrVals[0] + "*)(" + strArg + "=*-" + astrVals[0] + ")(" + strArg + "=" + astrVals[0] + "-*))";
      /*strRet += "(|(" + strArg + "=" + astrVals[0] + "*)(" + strArg + "=* " +
          astrVals[0] + "*))";*/
      for (int i = 1; i < astrVals.length; i++) {
        strRet += "(|(" + strArg + "=" + astrVals[i] + "*)(" + strArg + "=* " +
            astrVals[i] + "*)(" + strArg + "=*-" + astrVals[i] + ")(" + strArg + "=" + astrVals[i] + "-*)))";

      }
      if (!strArg.equals("givenname")) {
        //strRet = "(&" + strRet + "(!(givenname=)))";
        strRet = "(&" + strRet + ")"; // endret Tore Bruland
      }

      return strRet;
  }

  /**
     * Gets a filter and checks if this exists in the LDAP server.
     *
     * Counts the number of times the filter is found, and returns the number.
     * The function also counts the number of exact matches and stores this number
     * in the class member m_iExactCount.
     * <p>
     * <b>Note:</b> The returned number is not necessary the absolute number of items that matches,
     *       since the function won't search any more contexes after a match is found
     * <p>
     * The number of matches, and number of exact matches, is used to give a resonably correct
     * sorting of the tags, so "jens" is marked as
     * a firstname before it is is marked as a lastname (because "jensen" is a lastname).
     *
     * @param strFilter  a String object containing the filter to search for
     * @return           the number of items found
     * @throws Exception If something goes wrong (typically in regex processing)
     *                   can be ignored (treated as if zero occurences is found)
     */
    private int iExists(String strFilter, ArrayList m_taggedWords) throws Exception {
      int iRet = 0;

      Pattern p = Pattern.compile("(\\w+)=([æøåäöüáéóúÆØÅÄÖÜÁÉÓÚ\\-\\w]+[æøåäöüáéóúÆØÅÄÖÜÁÉÓÚ\\w]+)\\*");
      //Pattern p = Pattern.compile("(\\w+)=([\\-\\w]+[\\w]+)\\*");
      Matcher m = p.matcher(strFilter);

      String strMatch = "";
      String strAtrId = "";
      boolean boMatchExact = false;
      //if (m.find()){
  	int numWords = 0;
  	while(m.find()){
        strAtrId = m.group(1);
        if (!strMatch.equals("")) strMatch+=" ";
        strMatch += m.group(2);
        boMatchExact = true;
        numWords++;
      }

      p = Pattern.compile("\\b" + strMatch.replaceAll(" ", "[ \\-]") + "\\b", Pattern.UNICODE_CASE);

      boolean boSkipCount = false;
      if (strAtrId.equals("title"))
        boSkipCount = true;

      m_iExactCount = 0;

      // Specify the ids of the attributes to return
      String[] attrIDs = {
  		//"givenname", "sn" };
          strAtrId.length() > 0 ? strAtrId: "sn"};
      if (strAtrId.equals("givenname") || strAtrId.equals("sn")) attrIDs = new String[]{ "givenname", "sn" };
      SearchControls ctls = new SearchControls();
      ctls.setReturningAttributes(attrIDs);
      ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);

      // Search subtree for objects using filter

  	iRet += searchForMatch(str_base_ntnu, strFilter, ctls, boSkipCount, boMatchExact, p, m, strAtrId);
  	/*if (iRet==0)*/ iRet += searchForMatch(str_base_hist, strFilter, ctls, boSkipCount, boMatchExact, p, m, strAtrId);
  	/*if (iRet==0)*/ iRet += searchForMatch(str_base_sintef, strFilter, ctls, boSkipCount, boMatchExact, p, m, strAtrId);
  	/*if (iRet==0)*/ iRet += searchForMatch(str_base_other, strFilter, ctls, boSkipCount, boMatchExact, p, m, strAtrId);

      if (iRet==1 && numWords>1){
  		StringTokenizer st = new StringTokenizer(strMatch, " ");
  		boolean firstNameExact = false;
  		boolean lastNameExact = false;
  		String[] wordsTab = new String[st.countTokens()];
  		int i = 0;
  		while (st.hasMoreTokens()){
  			wordsTab[i] = st.nextToken();
  			i++;
  		}
  	}
      return iRet; // return  the number of found records
  }


  private int searchForMatch(String str_base, String strFilter, SearchControls ctls,
    				boolean boSkipCount, boolean boMatchExact, Pattern p, Matcher m, String strAtrId){
  	 	int iRet = 0;
  	try{
  		NamingEnumeration answer = m_ctxNTNU.search(str_base, strFilter, ctls);	// endret Tore Bruland
  		while (answer.hasMore()) {
  			if (boSkipCount) break;
  			SearchResult sr = (SearchResult) answer.next();
  			if (boMatchExact){
  				NamingEnumeration ne = sr.getAttributes().getAll();
  				String fullNameFound = "";
  				while(ne.hasMore()){
  					Attribute at = (Attribute)ne.next();
  					fullNameFound += at.get()+" ";
  				}
  				fullNameFound = fullNameFound.trim();
  				Attribute at = sr.getAttributes().get(strAtrId);
  				String str = (String)at.get();
				if (str.indexOf("..")==0 && iRet==0){ // iRet==0 fordi det skal kun settes som office når det er eneste svar. (Berg pri som etternavn)
					str = str.substring(2,str.length()); // "..Instituttkontor IDI" ++
					//office = true;	//OH 081206 Linjen fører til at "bø" blir tagget som room
				}
  				m = p.matcher(str);
  				if (m.matches()){
  				  m_iExactCount++;
  				}
  				if (!office){
					if (strAtrId.equals("givenname")){
						foundFullNamesGn.add(fullNameFound);
					}
					else if (strAtrId.equals("sn")) foundFullNamesSn.add(fullNameFound);
				}

  				int numSrchWords = countMatches(strFilter,"|");
  				int numNameWords = countMatches(fullNameFound," ")+1;
  			}
  			iRet++;
  		}
  		answer.close();
  	}catch(Exception e){}
  	m_iCountSearches++;
  	return iRet;
  }


  private int countMatches(String string, String character){
  	int num = 0;
  	int index = 0;
  	do{
  		index = string.indexOf(character, index); // counts the number of words in the search string
  		if (index!=-1){
  			index++;
  			num++;
  		}
  	}while(index!=-1);
  	return num;
  }

// Tar inn tag-listen, legger til rett dep og returnerer ny liste.
public ArrayList createDepTags(String astrWords[], ArrayList m_taggedWords, ArrayList _depList) {
	depList = _depList;
    Tagging taggNew;
    Tagging taggOld;
    for (int i = 0; i < astrWords.length; i++) {
      if (LDAPSearcher.strStopwords.indexOf(" " + astrWords[i] + " ") != -1 ||
          astrWords[i].length() < 3 ) {
			  continue;
      }
      taggNew = isDepartment(astrWords[i]);
      if ( taggNew != null) {
            Tagging oldDepTag = null;
            for (int j=0; j<m_taggedWords.size(); j++){
				Tagging t = (Tagging)m_taggedWords.get(j);
				if (t.m_strClass.equals("department") ) oldDepTag = t;
			}
			boolean okAdd = false;
			if (oldDepTag==null){
				okAdd = true;
			}else if (oldDepTag!=null && oldDepTag.m_strTagged.length()<taggNew.m_strTagged.length()){
				m_taggedWords.remove(oldDepTag);
				okAdd = true;
			}
			if (okAdd){
				m_taggedWords.add(taggNew);
			}
      } //if
    }//for

	return m_taggedWords;

  }

  private Tagging isDepartment(String str) {
      try {
  		// sjekk fil med vanlige forkortelser, FØR db-søk.
  	  int i=0;
  	  int m_iCount = 0;
  	  m_iExactCount = 0;
  	  boolean found = false;
  	  String depFound = "";
  	  while (i<depList.size() /*&& !found*/){
  		  String dep = (String)depList.get(i);
  		  String orgDep = "";
  		  if (dep.indexOf("****")>-1){
			  int firstIndex = dep.indexOf("****");
			  int nextIndex = dep.indexOf("****", firstIndex+1);
			  if (nextIndex>1){
			  	orgDep = dep.substring(firstIndex+5, nextIndex).trim();
			  }
			  dep = dep.substring(0,firstIndex).trim();
		  }

  		  Pattern p = Pattern.compile("\\b" + str + "\\b", Pattern.UNICODE_CASE | Pattern.CASE_INSENSITIVE); // b - s
  		  Matcher m = p.matcher(dep);
  		  Matcher mOrg = p.matcher(orgDep);
  		  if (m.matches()){
			  found = true;
			  depFound = dep;
			  m_iExactCount++;
		  }else if (m.find()){
  			  found = true;
  			  depFound = dep;
  			  m_iCount++;
  		  }else if (mOrg.matches()){
			  found = true;
			  depFound = dep;
			  m_iExactCount++;
		  }else if (mOrg.find()){
  			  found = true;
  			  depFound = dep;
  			  m_iCount++;
		  }

  		  i++;
  	  }
  	  if (found) return new Tagging(str, "department", m_iCount, m_iExactCount);


      }
      catch (Throwable t) {
        // nothing to do - just return false on error
        t.printStackTrace();
      }
      return null;
  }




}