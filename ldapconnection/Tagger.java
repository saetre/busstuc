package ldapconnection;

import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.naming.directory.*;
import java.io.*;
import java.text.*;

public class Tagger {
	public static final int LDAP = 1;
	public static final int MYSQL = 2;

	private static final String mysqlAddr = "jdbc:mysql://mysql.stud.ntnu.no/arildw_telefon?user=arildw&password=buster";
	//private static final String mysqlAddr =  "jdbc:mysql://localhost/telefon?user=arild&password=buster";
	public int connectionType = MYSQL; // set type of connection here

	private String str_base_ntnu = "dc=NTNU,dc=NO";
	private String str_base_hist = "dc=HIST,dc=NO";
	private String str_base_sintef = "dc=SINTEF,dc=NO";
  	private String str_base_other = "dc=ANDRE,dc=NO";

	private Connection conn;
	private ArrayList m_taggedWords;
	private ArrayList foundFullNamesGn;
	private ArrayList foundFullNamesSn;
	//private ArrayList foundRooms;
	private int m_iCountSearches;
	private TaggerSQL sqlTagger;
	private TaggerLDAP ldapTagger;
	private ArrayList depList;
	private DirContext m_ctxNTNU;
	private ArrayList exactNames;

	public Tagger(Connection _conn) {
		conn = _conn;
	}

	public Tagger(){
		m_taggedWords = new ArrayList();
		exactNames = new ArrayList();
		m_iCountSearches = 0;
		try{
			//BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("conn.txt")));
			Properties prop = new Properties();
			prop.load(new FileInputStream("conn.txt"));
			String cType = prop.getProperty("connectionType");
			if (cType.equals("MYSQL")) connectionType = MYSQL;
			else connectionType = LDAP;

		}catch(Exception e){
			e.printStackTrace();
			connectionType = LDAP; // default
		}

		try{

			if (connectionType==MYSQL){
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(mysqlAddr);
				sqlTagger = new TaggerSQL(conn);

			}else if (connectionType==LDAP){
				Hashtable env = new Hashtable(11);
      			env.put(Context.REFERRAL, "throw");
      			env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
      			env.put(Context.PROVIDER_URL, "ldap://ldap.ntnu.no:389");
      			m_ctxNTNU = new InitialDirContext(env);
      			ldapTagger = new TaggerLDAP(m_ctxNTNU);
      			BufferedReader br = new BufferedReader(new FileReader("DepList.txt"));
				String line;
				depList = new ArrayList();
				while ((line=br.readLine()) != null) depList.add(line);
	  			br.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}

	}

	public Connection getConnection(){
		return conn;
	}

	public DirContext getContext(){
		return m_ctxNTNU;
	}

	public void closeConnection(){
		if (connectionType==MYSQL){
			try{
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		// else, noe for LDAP?
	}


	public String strTag(String[] words){
		foundFullNamesGn = new ArrayList();
		foundFullNamesSn = new ArrayList();

		// Fiks for bindestrek, eks "Anders Kofod-Petersen"
		for (int i=0; i<words.length; i++){
			if (words[i].equals("-") && i>0 && i<(words.length-1)){
				String[] newWords = new String[words.length-2];
				for (int j=0; j<newWords.length; j++){
					if (j<(i-1)) newWords[j] = words[j];
					else if (j==(i-1)) newWords[j] = words[j]+words[j+1]+words[j+2];
					else if (j>=i) newWords[j] = words[j+2];
				}

				//start test
				/*String[] newWords = new String[words.length];
				String newName = "";
				for (int j=0; j<newWords.length; j++){
					if (j<i) newWords[j] = words[j];
					else if (j>=i && j<(newWords.length-1)){
						newWords[j] = words[j+1];
						if (j==i) newName = words[j-1]+"-"+words[j+1];
					} else if (j>i) newWords[j] = newWords[j] = newName;
				}*/
				//end test
				words = new String[newWords.length];
				for (int j=0; j<newWords.length; j++){
					words[j] = newWords[j];
				}
			}
		}


		createTagsAttr(words, "givenname", "firstname");
		createTagsAttr(words, "sn", "lastname");

		createDepTags(words);

		Collections.sort(m_taggedWords);
		Collections.reverse(m_taggedWords);

		Collections.sort(m_taggedWords);

		filterInitial(words);

	    String strXML = "";
	    ListIterator it = null;



	    for (int i = 0; i < words.length; i++)
	    {
		  if (i<(words.length-2) && words[i].equals(words[i+1])) continue;
	      String strClass = "";
	      it = m_taggedWords.listIterator();

		  String word = null;
	      while (it.hasNext()){
	        Tagging t = (Tagging)it.next();
	        if (t.strWord().toUpperCase().equals(words[i].toUpperCase())){
			  word = t.m_strTagged;
	          strClass += t.toString();
	        }
	      }
	      if (strClass.length() > 0){
	        //String strTag = XMLTagger.strTag("word",words[i]) + '\n';
	        String strTag = XMLTagger.strTag("word",word) + '\n';
	        strTag += XMLTagger.strTag("class",strClass) + '\n';
	        strXML += XMLTagger.strTag("tag",strTag) + '\n';
	      }
	    }
	    try{
	      	strXML = XMLTagger.strTag("result", strXML, new String[] {"sp"}, new String[] {"" + m_iCountSearches});
	    }catch(Exception e){
	      	strXML = XMLTagger.strTag("result", strXML);
	    }

	    strXML = XMLTagger.strMarkXML() + strXML;
	    return strXML;

  	}


	private void createTagsAttr(String[] astrWords, String strAtt, String strConcept){
		Tagging tagNew;
		boolean foundExact = false;
		for (int mainCount = 0; mainCount < astrWords.length; mainCount++) {
			int i=mainCount;
		    if (LDAPSearcher.strStopwords.indexOf(" " + astrWords[i] + " ") != -1 || (astrWords[i].length() < 3 && LDAPSearcher.strOknames.indexOf(" "+astrWords[i]+" ")==-1) //||
		     ) {
		    	continue;
		    }
			if ( (tagNew = isAttrib(new String[] {astrWords[i].toLowerCase()}, strAtt, strConcept)) != null) {
				String str = astrWords[i];
				do{
					boolean okAdd = true;
					for (int l=0; l<m_taggedWords.size(); l++){
						Tagging t = (Tagging)m_taggedWords.get(l);
						if (tagNew.m_iExactCount>0){
							if (t.m_iExactCount==0 && (t.m_strClass.equals(strConcept) || t.m_strTagged.equals(str)) && t.m_strTagged.indexOf(tagNew.m_strTagged)<1){ // klassen er ikke tagget eksakt fra før, gjør det nå
								//System.out.println("remove "+t.m_strTagged);
//								m_taggedWords.remove(l);
//								l--;
							}
						}else if (t.m_iExactCount>0 && t.m_strTagged.equals(str)) okAdd = false; // ordet er tagget eksakt fra før
						else if(t.m_iExactCount>0 && t.m_strClass.equals(strConcept) && t.m_strTagged.length()>str.length()) okAdd = false; // klassen er tagget eksakt fra før
					}
					if (okAdd && !m_taggedWords.contains(tagNew)){
						m_taggedWords.add(tagNew);
					}
		       		i++;
					if (i<astrWords.length){
						String[] astr = new String[i-mainCount+1];
						for (int j=0; j<=(i-mainCount); j++){
							astr[j] = astrWords[mainCount+j].toLowerCase();
						}
						str = "";
						for (int j=0; j<astr.length; j++){
							str+=astr[j]+" ";
						}
						tagNew = isAttrib(astr, strAtt, strConcept);
					}
		        }while(i<astrWords.length && tagNew != null);
		    }
    	} // for
	}

	private Tagging isAttrib(String[] words, String strAttrib, String strConcept) {
		Tagging tag = null;
		ArrayList tagResult = null;
		if (connectionType==MYSQL && sqlTagger!=null) tagResult = sqlTagger.createTagsAttr(words, strAttrib, strConcept);
		else if (connectionType==LDAP && ldapTagger!=null) tagResult = ldapTagger.createTagsAttr(words, strAttrib, strConcept, m_taggedWords);
		if (tagResult!=null && tagResult.size()==3){
			Tagging taggedWord = (Tagging)tagResult.get(0);
			tag = taggedWord;
			ArrayList firstNameList = (ArrayList)tagResult.get(1);
			ArrayList lastNameList = (ArrayList)tagResult.get(2);
			if (taggedWord!=null && !previouslyTagged(taggedWord)){
				m_taggedWords.add(taggedWord);

			}
			for (int i=0; i<firstNameList.size(); i++) foundFullNamesGn.add(firstNameList.get(i));
			for (int i=0; i<lastNameList.size(); i++) foundFullNamesSn.add(lastNameList.get(i));

		}
		return tag;
	}

	private boolean previouslyTagged(Tagging tag){
		boolean taggedBefore = false;
		for (int i=0; i<m_taggedWords.size(); i++){
			Tagging testTag = (Tagging)m_taggedWords.get(i);
			if (testTag.equals(tag)) taggedBefore = true;
		}
		return taggedBefore;
	}

	private int countTagged(Tagging tag){
		int count = 0;
		for (int i=0; i<m_taggedWords.size(); i++){
			Tagging testTag = (Tagging)m_taggedWords.get(i);
			if (testTag.m_strTagged.equals(tag.m_strTagged) /*|| (testTag.m_strTagged.indexOf(tag.m_strTagged)>=0 && countMatches(testTag.m_strTagged, " ")>0)*/) count++; // siste pga "randi berge"
		}
		return count;
	}



	private void createDepTags(String[] words){
		String[] tagWords = new String[words.length];
		for (int i=0; i<words.length; i++){
			if (LDAPSearcher.strStopdeps.indexOf(" " + words[i] + " ") != -1 ) tagWords[i] = "fjalskfjalsk";
			else tagWords[i] = words[i];
		}
		if (connectionType==MYSQL && sqlTagger!=null) m_taggedWords = sqlTagger.createDepTags(tagWords, m_taggedWords);
		else if (connectionType==LDAP && ldapTagger!=null) m_taggedWords = ldapTagger.createDepTags(tagWords, m_taggedWords, depList);


	}


    private void filterInitial(String[] origWords){
		boolean firstnameTagged = false;
		boolean lastnameTagged = false;
		String firstname = null;
		String lastname = null;
		int removeTag = -1;
		for (int i=0; i<m_taggedWords.size(); i++){
			if (((Tagging)m_taggedWords.get(i)).m_strClass.equals("firstname") && !firstnameTagged){
				firstnameTagged = true;
				firstname = ((Tagging)m_taggedWords.get(i)).m_strTagged;
				removeTag = i;
			}else if (((Tagging)m_taggedWords.get(i)).m_strClass.equals("lastname") && !lastnameTagged){
				lastnameTagged = true;
				lastname = ((Tagging)m_taggedWords.get(i)).m_strTagged;
			}
		}
		boolean added = false;
		if (firstnameTagged){
			for (int i=0; i<origWords.length; i++){
				if (firstname.toUpperCase().equals(origWords[i].toUpperCase()) && (i+1<origWords.length) && (origWords[i+1].length()==1 || (origWords[i+1].length()==2 && origWords[i+1].charAt(1)=='.'))){
					/*for (int j=0; j<foundFullNamesGn.size(); j++){
						StringTokenizer st = new StringTokenizer((String)foundFullNamesGn.get(j), " ");
						while(st.hasMoreTokens()){
							if (st.nextToken().toUpperCase().equals(firstname.toUpperCase()) && st.hasMoreTokens() && st.nextToken().charAt(0)==origWords[i+1].charAt(0)){
								m_taggedWords.add(new Tagging(new String[]{origWords[i]+" "+origWords[i+1].charAt(0)}, "firstname", 1, 0));
								added = true;
							}
						}
					}*/
					//System.out.println("legger til: "+origWords[i]+" "+origWords[i+1].charAt(0));
					m_taggedWords.add(new Tagging(new String[]{origWords[i]+" "+origWords[i+1].charAt(0)}, "firstname", 1, 0));
					added = true;
				}
			}
		}else if (!firstnameTagged && lastnameTagged){
			//System.out.println("!firstnameTagged && lastnameTagged");
			for (int i=0; i<origWords.length; i++){
				if (lastname.toUpperCase().equals(origWords[i].toUpperCase()) && (i-1>=0) && (origWords[i-1].length()==1 || (origWords[i-1].length()==2 && origWords[i-1].charAt(1)=='.'))){
					/*for (int j=0; j<foundFullNamesGn.size(); j++){
						StringTokenizer st = new StringTokenizer((String)foundFullNamesSn.get(j), " ");
						while(st.hasMoreTokens()){
							if (st.nextToken().toUpperCase().charAt(0)==origWords[i-1].toUpperCase().charAt(0) && st.hasMoreTokens() && st.nextToken().toUpperCase().equals(origWords[i+1].toUpperCase())){
								m_taggedWords.add(new Tagging(new String[]{""+firstname.charAt(0)}, "firstname", 1, 0));
								added = true;
							}
						}
					}*/
					m_taggedWords.add(new Tagging(new String[]{""+origWords[i-1].charAt(0)}, "firstname", 1, 0));
				}
			}
		}
		//if (added && firstnameTagged){
//			m_taggedWords.remove(removeTag);
	//	}
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

  // Count the number of times srchStr appears in the table
  private int countEntries(String[] table, String srchStr){
	  int count = 0;
	  for (int i=0; i<table.length; i++){
		  if (table[i].toUpperCase().equals(srchStr.toUpperCase())) count++;
	  }
	  return count;
  }



private String replaceSpecial(String input){
	  String output = input;
	  String[][] rChars = { {"æ", "ø", "y", "Æ", "Ø", "Y"}, {"ä", "ö", "ü", "Ä", "Ö", "Ü"} };
	  for (int k=0; k<rChars[0].length; k++){
		  output = output.replaceAll(rChars[0][k], rChars[1][k]);
		  if ((k+3)<rChars[1].length) output = output.replaceAll("\\b"+rChars[1][k], rChars[1][k+3]); // capitalize first character
	  }
	  //System.out.println("output: "+output);
	  return output;
  }

/**
   * Checs if a specified filter gives any returns.
   *
   * @param   strFilter   the filter to check for
   * @return              true if any records coresponding to the filter was found, false if none where found.
   * @throws  Exception   if anything wrong happens with the LDAP connection.
   */
  public boolean boExists(String strFilter) throws Exception {
    // Specify the ids of the attributes to return
    String[] attrIDs = {
        "sn"};
    SearchControls ctls = new SearchControls();
    ctls.setReturningAttributes(attrIDs);
    ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);

    // Search subtree for objects using filter
	//System.out.println("Søker NTNU: " + strFilter);
    NamingEnumeration answer = m_ctxNTNU.search(str_base_ntnu, strFilter, ctls); // endret Tore Bruland
    m_iCountSearches++;

    boolean boRet = answer.hasMore();
    answer.close();
    if (!boRet) {
	  //System.out.println("Søker HIST: " + strFilter);
      //answer = m_ctxHiST.search("", strFilter, ctls);
      answer = m_ctxNTNU.search(str_base_hist, strFilter, ctls);	// endret Tore Bruland
      boRet = answer.hasMore();
      answer.close();
      m_iCountSearches++;
    }
    if (!boRet) {
	  //System.out.println("Søker SINTEF: " + strFilter);
      //answer = m_ctxSINTEF.search("", strFilter, ctls);
      answer = m_ctxNTNU.search(str_base_sintef, strFilter, ctls); // endret Tore Bruland
      boRet = answer.hasMore();
      answer.close();
      m_iCountSearches++;
    }
    if (!boRet) {
	  //System.out.println("Søker ANDRE: " + strFilter);
      //answer = m_ctxOther.search("", strFilter, ctls);
      answer = m_ctxNTNU.search(str_base_other, strFilter, ctls);	// endret Tore Bruland
      boRet = answer.hasMore();
      answer.close();
      m_iCountSearches++;
    }

    return boRet; // return true if anything is found
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
          astrVals[0] + "*)(" + strArg + "=.." + astrVals[0] + "*)(" + strArg + "=*-" + astrVals[0] + ")(" + strArg + "=" + astrVals[0] + "-*)(" + strArg + "=*-" + astrVals[0] + ".))";
      /*strRet += "(|(" + strArg + "=" + astrVals[0] + "*)(" + strArg + "=* " +
          astrVals[0] + "*))";*/
      for (int i = 1; i < astrVals.length; i++) {
        strRet += "(|(" + strArg + "=" + astrVals[i] + "*)(" + strArg + "=* " +
            astrVals[i] + "*)(" + strArg + "=*-" + astrVals[i] + ")(" + strArg + "=" + astrVals[i] + "-*)(" + strArg + "=*-" + astrVals[i] + ".)))";

      }
      if (!strArg.equals("givenname")) {
        //strRet = "(&" + strRet + "(!(givenname=)))";
        strRet = "(&" + strRet + ")"; // endret Tore Bruland
      }

      return strRet;
  }


  public static String strMakeMailFilter(String[] astrVals, String strArg) {
        if (astrVals.length < 1) {
          return "";
        }

        String strRet = "";
        String strNew = "";
        for (int i = 0; i < astrVals.length - 1; i++) {
          strRet += "(&";
        }
        strRet += "(|(" + strArg + "=*@" + astrVals[0] + ".*)(" + strArg + "=*@*." +astrVals[0] + ".*))";
        /*strRet += "(|(" + strArg + "=" + astrVals[0] + "*)(" + strArg + "=* " +
            astrVals[0] + "*))";*/
        for (int i = 1; i < astrVals.length; i++) {
          strRet += "(|(" + strArg + "=*@" + astrVals[i] + ".*)(" + strArg + "=*@*." +astrVals[i] + ".*))";

        }
        if (!strArg.equals("givenname")) {
          //strRet = "(&" + strRet + "(!(givenname=)))";
          strRet = "(&" + strRet + ")"; // endret Tore Bruland
        }

        return strRet;
  }


}