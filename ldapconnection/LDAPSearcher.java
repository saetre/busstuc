package ldapconnection;

import javax.naming.*;
import javax.naming.directory.*;
import java.io.*;
import java.util.*;
import java.util.regex.*;

import java.sql.*;

/**
 * <p>Title: LDAPConnection</p>
 * <p>Description: TELEBUSTER's connection to the LDAP server</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: NTNU</p>
 * @author Tor Livar Flugsrud
 * @version 1.0
 */

class LDAPSearcher {
    private String MY_HOST = "ldap://ldap.ntnu.no:389";
    private String str_base_ntnu = "dc=NTNU,dc=NO";	// bruland
    private String str_base_hist = "dc=HIST,dc=NO";	// bruland
    private String str_base_sintef = "dc=SINTEF,dc=NO";	// bruland
    private String str_base_other = "dc=ANDRE,dc=NO";	// bruland

	//private static final String mysqlAddr = "jdbc:mysql://localhost/telefon?user=arild&password=buster";

	private Connection conn;

    /**
     * Trace value - if more than 0 some trace information will be written to the error stream on running
     */
    public static int TRACEVAL = 0;

    /**
     * The encoding of the parameter file. If ASCII the ISO8859-1 encoding is enforced and output is konverted to ISO8859-1
     */
    public String m_strEncoding;
    /**
     * The search string - filled in the main function, used in the srch function
     */
    private String m_strSearch;
    /**
     * Context for NTNU
     */
    //private DirContext m_ctxNTNU;
    /**
     * Context for HiST
     */
    //private DirContext m_ctxHiST;
    /**
     * Context for SINTEF
     */
    //private DirContext m_ctxSINTEF;
    /**
     * Context for other
     */
    //private DirContext m_ctxOther;
    /**
     * This field contains the number of searches conducted
     */
    private int m_iCountSearches;
    /**
     * This field contains all words that won't be tagged as anything
     *
     * Containts regular asking words.
     */
    public final static String strStopwords =
            " nei hva til hvor hvem på hvordan for som ved hei takk vet ikke the det tlf kan jeg meg how can han hun det den har med ";

	// Names shorter than 3 letters that should be tagged ok.
	public final static String strOknames  = " jo bø ";

	// Words that shall not be tagged as departments
	public final static String strStopdeps = " andre ";
    /**
                output skal være unicode verdier.
                Adresserer problem hos sintef
     */
    private void konvUt(String iStr) {
        if (m_strEncoding.equals("ASCII")) {
            try {
                DataOutputStream fos = new DataOutputStream(System.out);
                Writer out = new OutputStreamWriter(fos, "ISO8859-1");
                out.write(iStr+"\n");
                out.write('\004');
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println(iStr);
            System.out.print('\004');
        }

    }

    /**
                snatch paramater from shell commando i sicstus
                Kan benytter til debugging, mens man kjører telebuster.
                Adresserer problem hos sintef
     */

    public static void saveParam(String iStr) {
        try {
            BufferedWriter outFile = new BufferedWriter( new FileWriter("paramlog.txt", true));
            char tegn=' ';
            int verdi = 0;
            outFile.write(iStr+"\n");
            /*
            for (int i=0; i<iStr.length(); i++) {
                tegn = iStr.charAt(i);
                verdi= iStr.codePointAt(i); // Unicode code point. Krever java 1.5
                outFile.write(tegn+"("+verdi+") ");
            }
            outFile.write("\n");
            */
            outFile.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * The Tagger object used to perform tagging of words
     */
    private Tagger tagger;


    /**
     * Private constructor
     *
     * Stores the search-string and connects to the LDAP directory server
     *
     * @param  strSearch  the search string, stored in {@link LDAPSearcher.m_strSearch}
     */
    private LDAPSearcher(String strSearch) {
		try {

        m_strSearch = strSearch;
        m_iCountSearches = 0;
       		FileOutputStream fos = new FileOutputStream("LDAP_output.txt");
			System.setErr(new PrintStream(fos));
            //tagger = new Tagger(conn);
            tagger = new Tagger();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Performs the tagging by using the {link Tagger} class.
     */
    //private void tag(String[] words) {
    private void tag(String iStr) {
        String temp = iStr;
        if (iStr.substring(0,4).equals("tag ")) {
            temp = iStr.substring(4);
        }
        StringTokenizer st = new StringTokenizer(temp);
        String[] words = new String[st.countTokens()];
        int teller=0;
        while (st.hasMoreTokens()) {
            words[teller]=new String(st.nextToken());
            teller++;
        }


        String strXML = tagger.strTag(words);


        konvUt(strXML); // bruland, output med 004
        //System.out.println(strXML);
        //System.out.print('\004'); // EOT

    }

    /**
     * The function that organizes searching in LDAP directory.
     *
     * The function uses the member field {@link LDAPSearcher.m_strSearch} to perform the search.
     * The search string should be in format 'select([*],anything,[field1:value1,field2:value2,...],anything)'.
     *
     * @throws IllegalArgumentException  thrown if the value of m_strSearch is invalid
     */
    private void srch()  throws IllegalArgumentException {
        errTrace("Searching for the string \"" + m_strSearch + "\"", 4);

        String[][] rChars = { {"æ", "ø", "å", "ä", "ö", "ü"}, {"Æ", "Ø", "Å", "Ä", "Ö", "Ü"} };
        for (int k=0; k<rChars[0].length; k++){
			m_strSearch = m_strSearch.replaceAll("\\b"+rChars[0][k], rChars[1][k]); // capitalize first character
	    }

        String astrWhereFields[] = null;
        String astrWhereVals[] = null;

        String strFields = null;
        String strWhere = null;

        try{
            Pattern p = Pattern.compile("\\[(.*?)\\]"); // [ followed by any sign any numbers of times, reluctant, followed by ]
            Matcher m = p.matcher(m_strSearch);
            errTrace("m_strSearch: " + m_strSearch,3);
            // Get the fields
            if (m.find()) {
                strFields = m.group(1);
            }
            // Get the where-clauses
            if (m.find()) {
                strWhere = m.group(1);
            } else {
                throw new IllegalArgumentException(
                        "The fields and where-clauses could not be retreived from the search string.");
            }
            p = Pattern.compile("([^:,]+):('(\\\\'|[^'])*'|[^,]*)");
      /* Explanation of the regex:
         [^:,]+      - the fieldname - group nr 1
         :           - the colon separating the field from the value
         ('(\\\\'|[^'])*'|[^,]*)  - the values, two alternatives:
         '(\\\\'|[^'])*'  - ' followed by any number of either \' or any character except ' and finaly another '
                         (nb: the order is important - if [^'] is before \\\\' it will be faster in cases with none
                         escaped ', but a \' would not be caught as the \ is consumed before the other alternative
                         is tested.)
         or [^,]* - any character except a comma (,) (unquoted string).
       */
            m = p.matcher(strWhere);
            errTrace("strWhere: " + strWhere+", strFields: "+strFields	,3);
            while (m.find()) {
                int iNewLen = astrWhereFields == null ? 1 : astrWhereFields.length + 1;
                String[] aTmp = new String[iNewLen];
                if (iNewLen > 1)
                    System.arraycopy(astrWhereFields, 0, aTmp, 0, astrWhereFields.length);
                aTmp[iNewLen - 1] = m.group(1);
                astrWhereFields = aTmp;
                aTmp = new String[iNewLen];
                if (iNewLen > 1)
                    System.arraycopy(astrWhereVals, 0, aTmp, 0, astrWhereVals.length);
                aTmp[iNewLen - 1] = m.group(2);
                astrWhereVals = aTmp;
            }
        }catch(Exception e){
            System.err.println("Error in regex processing:\n" + e.getMessage());
        }

        String strSrch = "";
        ArrayList depList = new ArrayList();
        if (TRACEVAL >= 3) {
            errTrace("astrWhereFields.length = " + astrWhereFields.length, 3);
            for (int i = 0; i < astrWhereFields.length; i++)
                errTrace("astrWhereFields[" + i + "] = " + astrWhereFields[i], 3);
        }

        boolean depListing = false;
        long countLimit = 5;
        boolean namesrch = false;
        String sqlstring = ""; //"SELECT * FROM person,org,top_org WHERE person.org_id=org.org_id AND org.top_org_id=top_org.top_org_id ";

        for (int i = 0; i < astrWhereFields.length; i++) {
			if (tagger.connectionType==tagger.LDAP){
				if (astrWhereFields[i].equals("pname")
				|| astrWhereFields[i].equals("firstname")
				|| astrWhereFields[i].equals("lastname")) {
					countLimit = 0;
					if (strSrch.equals(""))
						strSrch = strMakeSearchString(astrWhereVals[i],astrWhereFields[i]);
					else
						strSrch = strMatchLDAPSearches(strSrch,
								strMakeSearchString(astrWhereVals[i],astrWhereFields[i]), "&");
				} else if (astrWhereFields[i].equals("department") && !(astrWhereFields.length==1 /*&& strFields.equals("department")*/)) {
					String strMailSearch;
					if ((strMailSearch = isMailDep(astrWhereVals[i])) != null) {
						if (strSrch.equals(""))
							strSrch = strStripQuotes(strMailSearch);
						else
							strSrch = strMatchLDAPSearches(strSrch, strStripQuotes(strMailSearch), "&");
					} else{
						depList.addAll(getDepList(astrWhereVals[i]));
						if (depList.size()>0){
							String depSrch = strMakeSearchString(astrWhereVals[i], "ou");
							if (strSrch.equals("")) strSrch = strStripQuotes(depSrch);
							else strSrch = strMatchLDAPSearches(strSrch, strStripQuotes(depSrch), "&");
						}
					}
				} else if (astrWhereFields[i].equals("department") && (astrWhereFields.length==1/* && strFields.equals("department")*/)) {
					depList.addAll(getDepList(astrWhereVals[i]));
					depListing = true;
					errTrace("deplisting ON", 1);
				} else if (astrWhereFields[i].equals("telephonenumber")) {
					if (strSrch.equals(""))
						strSrch = "(telephonenumber=" + astrWhereVals[i] + "*)";
					else
						strSrch = strMatchLDAPSearches(strSrch,
								"(telephonenumber=" + astrWhereVals[i] + "*)", "&");
				}
				errTrace("Search string: " + strSrch, 4);
			}else if(tagger.connectionType==tagger.MYSQL){
				if (astrWhereFields[i].equals("firstname")){
					sqlstring += "AND (givenname LIKE '"+astrWhereVals[i]+"%' OR givenname LIKE '% "+astrWhereVals[i]+"%' OR givenname LIKE '"+astrWhereVals[i].replaceAll(" ","-")+"%' OR givenname LIKE '%-"+astrWhereVals[i]+"') ";
					namesrch = true;
				} else if (astrWhereFields[i].equals("lastname")){
					sqlstring += "AND (sn LIKE '"+astrWhereVals[i]+"%' OR sn LIKE '% "+astrWhereVals[i]+"%') ";
            		namesrch = true;
            	} else if (astrWhereFields[i].equals("department") && astrWhereFields.length!=1){
					sqlstring += "AND (org1.ou LIKE '%"+astrWhereVals[i]+"%' OR org2.ou LIKE '%"+astrWhereVals[i]+"%' OR org3.ou LIKE '%"+astrWhereVals[i]+"%' OR org4.ou LIKE '%"+astrWhereVals[i]+"%' OR person.mail LIKE '%@"+astrWhereVals[i]+".%' OR person.mail LIKE '%@%."+astrWhereVals[i]+".%')";
				} else if (astrWhereFields[i].equals("department") && astrWhereFields.length==1){
					depListing = true;
					sqlstring += "AND (org1.ou LIKE '%"+astrWhereVals[i]+"%' OR org2.ou LIKE '%"+astrWhereVals[i]+"%' OR org3.ou LIKE '%"+astrWhereVals[i]+"%' OR org4.ou LIKE '%"+astrWhereVals[i]+"')";
				}
			}
        }
        if(tagger.connectionType==tagger.MYSQL){
        	if (!namesrch) sqlstring = "SELECT * FROM org1,org2,org3,org4 WHERE org1.org2_id=org2.id AND org2.org3_id=org3.id AND org3.org4_id=org4.id "+sqlstring;
			else sqlstring = "SELECT * FROM person,org1,org2,org3,org4 WHERE person.org_id=org1.id AND org1.org2_id=org2.id AND org2.org3_id=org3.id AND org3.org4_id=org4.id AND "+sqlstring.substring(4,sqlstring.length());
			errTrace(sqlstring, 1);
		}

        String strXML = "";
        int iResCount = 0;

        if (depListing){
			if (tagger.connectionType==tagger.LDAP){
				SearchRes sr = listDeps(strWhere, depList);
				if (sr!=null){
					strXML += sr.m_strXml;
					iResCount += sr.m_iCountRes;
				}
			}else if (tagger.connectionType==tagger.MYSQL){
				StringTokenizer st = new StringTokenizer(strWhere, ":");
				int iElementCount = 0;
				//String strXML = "";
				SearchRes sr = null;
				int depRes = 0;
				if (st.countTokens()==2){
					st.nextToken();
					String dep = st.nextToken();
					for (int i=4; i>1; i--){
						if (depRes==0){
							strSrch = "SELECT org"+(i-1)+".ou FROM org"+(i-1)+",org"+i+" WHERE org"+(i-1)+".org"+i+"_id=org"+i+".id AND org"+i+".ou LIKE '%"+dep+"%'";
							sr = performeSearch(strSrch, ", 0", countLimit, strFields);
							iResCount += sr.m_iCountRes;
							depRes = sr.m_iCountRes;
							errTrace("søk på : "+strSrch+", treff: "+iResCount,1);
						}
					}
				}
				if (depRes>0) strXML += sr.m_strXml;

			}
		}else{
			if (tagger.connectionType==tagger.MYSQL) strSrch = sqlstring;

			int i=0;
			while(i<2 && iResCount==0){
				if (depList.isEmpty()){
					for (int iii=0; iii<4; iii++){
						if (countLimit==0 || iResCount==0){
							SearchRes sr = performeSearch(strSrch, "," + iii, countLimit, strFields);
							strXML += sr.m_strXml;
							iResCount += sr.m_iCountRes;
							errTrace("søk på : "+strSrch+", treff: "+iResCount,1);
						}
					}
				} else{
					ListIterator it = depList.listIterator();
					String use = "";
					while(it.hasNext()){
						String itdep = (String)it.next();
						String newuse = itdep.substring(itdep.length()-1);
						if (!newuse.equals(use)){
							use = newuse;
							SearchRes sr = performeSearch(strSrch, itdep, countLimit, strFields);
							strXML += sr.m_strXml;
							iResCount += sr.m_iCountRes;
							errTrace("søk på(2)["+itdep+"] : "+strSrch+", treff: "+iResCount,1);
						}
					}

				}
				if (iResCount==0){
					String newStrSrch = replaceSpecial(strSrch); // ex. Murat Öztürk
					if(newStrSrch.equals(strSrch)) i++; // do not search again
					else strSrch = newStrSrch;
				}
				i++;
			}
		}

        if (iResCount <= 10 || depListing){

            strXML = XMLTagger.strTag("results", strXML);
        } else{
            strXML = XMLTagger.strTag("resultcount","" + iResCount);
        }

        System.out.print(XMLTagger.strMarkXML());
        konvUt(strXML); // bruland, output med 004
        //System.out.println(strXML);
        //System.out.print('\004'); // EOT
        errTrace(strXML, 0);
    }

    private SearchRes listDeps(String strWhere, ArrayList depList){
		errTrace("listdeps! "+strWhere, 1);
		StringTokenizer st = new StringTokenizer(strWhere, ":");
		int iElementCount = 0;
		String strXML = "";
		if (st.countTokens()==2){
			st.nextToken();
			String dep = st.nextToken();
			String str = "";
				for (int i=0; i<depList.size(); i++){
					String outdep = (String)depList.get(i);
					try{
						outdep = outdep.substring(0, outdep.indexOf("****")).trim();
					}catch(Exception e){
					}
					iElementCount++;
					str += XMLTagger.strTag("ou", outdep) + '\n';
					str = XMLTagger.strTag("result", str);
					strXML += str + "\n";
					errTrace("dep "+i+": "+depList.get(i), 1);
				}
		}
		return new SearchRes(strXML, iElementCount);
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
     * Checks if a string exists in mailadress on department-place
     *
     * @param  strDep  a word to search for in address *@here.*
     *                 or *@*.here.*
     * @return         the LDAP search string that found a result if found, <b>null</b> if not found.
     */
    private String isMailDep(String strDep){
		//return "<b>null</b>";
        String srch = strMakeSearchString(strDep,"mail");
        try{
            if (tagger.boExists(srch))
                return srch;
        } catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Creates a LDAP search string of a value and field
     *
     * @param  str       the value to search for
     * @param  strField  the field to find the value in
     * @return           a String that can be sendt to LDAP server as search string
     */
    private String strMakeSearchString(String str, String strField){
        String[] a = str.split("\\s+");
        String attr;
        if (strField.equals("pname"))
            attr = "cn";
        else if (strField.equals("lastname"))
            attr = "sn";
        else if (strField.equals("firstname"))
            attr = "givenname";
        else
            attr = strField;
        if (attr.equals("mail")) return tagger.strMakeMailFilter(a,attr);
        else return tagger.strMakeCompFilter(a,attr);
    }

    /**
     * Creates a list of departments found in the deps.txt file that correspond to the given key
     *
     * <p>Generates a list of DN (distinguished names) that will be used to search in.
     *
     * @param strKey   this word(s) is searched for in deps.txt
     * @return         a ArrayList with found DNs.
     */
    private ArrayList getDepList(String strKey) {
        ArrayList ret = new ArrayList();
        try{

			BufferedReader br = new BufferedReader(new FileReader("DepList.txt"));
			String line;
			boolean found = false;
			int lvl = -1;
			while ((line=br.readLine()) != null){
				Pattern p = Pattern.compile("\\b" + strKey + "\\b", Pattern.CASE_INSENSITIVE);
				Matcher m = p.matcher(line);
		  		if (m.find() || found){
					if (!found){
						errTrace("foundfirst: "+line, 1);
						found = true;
						lvl = countMatches(line, "\t")+1;
						ret.add(line);
					}else if (found && lvl!=1){						// endret 230406 , var }else{
						if (countMatches(line, "\t")==lvl){
							errTrace("found: "+line, 1);
							//errTrace("tokens: "+countMatches(line, "\t")+" for "+line, 1);
							ret.add(line);
						}else if (countMatches(line, "\t")==(lvl-1)) break;
					}
				}
			}
	  		br.close();
	  		errTrace("return list: "+ret.size(),1);

        } catch(Exception e){
            errTrace("\n\nNei, nei NEI!!!!\n\n", 2);
        }
        return ret;
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

    /**
     * Performs the search given the search-string and dn.
     *
     * The XML-code in the returned object will never contain more than 10 records,
     * but will allways give the correct number of records found.
     *
     * @param   strSrch  	the search-string. If empty the search will include all posts
     * @param   strDN    	the DN to search in
     * @param	countLim 	Sets the maximum number of entries to be returned as a result of the search. 0=no limit
     * @param	strFields	The field(s) to search for
     * @return           A {@link LDAPSearcher.SearchRes} object containg information with the result
     */
    private SearchRes performeSearch(String strSrch, String strDN, long countLim, String strFields) {
		errTrace("strSrch: "+strSrch, 1);
        if (strSrch.equals("")){
            strSrch = "(&(sn=*)(!(givenname=)))";
        }
        /*if (!strFields.equals("*")){ strSrch = strSrch.substring(0,strSrch.length()-1)+"(&(!("+strFields+"=))))";
        	errTrace("ny strsrch: "+strSrch,1);
		}*/
        String strXML = "";
        int iElementCount = 0;
        Statement stmt = null;
        try{
            // Specify the ids of the attributes to return

                if (tagger.connectionType==tagger.MYSQL){
					stmt = tagger.getConnection().createStatement();
					errTrace("SQLSTRING: "+strSrch, 1);
					ResultSet answer = stmt.executeQuery(strSrch);

					if (answer == null)
						throw new Exception("Error in DN string");

					String str = "";
					boolean added = false;

					while (answer.next()) {
						boolean okAdd = true;
						boolean found = false;

						if (countLim>0){
							if (strFields.equals("*")) strFields = "street";
							//Attribute fieldAttr = sr.getAttributes().get(strFields);
							String field = "";
							//if (fieldAttr!=null) found = true;
							//else found = false;
							if (/*found &&*/ !added) okAdd = true;
							else okAdd = false;
							okAdd = true; // <-- ?
							errTrace("strFields: "+strFields+" "+okAdd, 1);
						}

						if (iElementCount <= 10 && okAdd){
							iElementCount++;
							added = true;
							//NamingEnumeration ats = sr.getAttributes().getAll();

							str = XMLTagger.strTag("ou","REPLACEDEP");  // strOu0 .. endre her så det kommer frem rett NTNU/HIST etc.

							//Divider d = new Divider(strDN);
							//while (d.hasMore()) {
								//str += XMLTagger.strTag(d.getClassName(), d.getValue()) + '\n';
							ResultSetMetaData md = answer.getMetaData();
							int cols = md.getColumnCount();
							boolean savedFullName = false;
							String firstName = null;
							String surname = null;
							String fullName = "";
							String mainDep = "NTNU";
							for (int i=0; i<cols; i++){
								if (md.getColumnType(i+1) == java.sql.Types.VARCHAR){
									String colName = md.getColumnName(i+1);
									String colVal = answer.getString(i+1);
									if (colName.equals("givenName")){
										//colName = "givenname";
										firstName = colVal;
									} else if (colName.equals("sn")){
										//colName = "sn";
										surname = colVal;
									}
									if (colName.equals("ou")) mainDep = colVal;
									if (!colVal.equals("")) str += XMLTagger.strTag(colName, colVal) + '\n';
									if (savedFullName==false && firstName!=null && surname!=null){
										savedFullName = true;
										str += XMLTagger.strTag("cn", firstName+" "+surname) + '\n';
									}
								}
							}
							str = str.replaceAll("REPLACEDEP", mainDep);

							str = XMLTagger.strTag("result", str);
							strXML += str + "\n";
						}

					}
				}else if (tagger.connectionType==tagger.LDAP){
					DirContext m_ctxNTNU = tagger.getContext();
					// Specify the ids of the attributes to return
					String[] attrIDs = {
					"telephonenumber", "sn", "givenname", "mail", "title", "roomnumber", "street"};
					SearchControls ctls = new SearchControls();
					ctls.setReturningAttributes(attrIDs);
					ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);
					ctls.setCountLimit(countLim);
					//if (!strFields.equals("*")) ctls.setReturningAttributes(new String[]{strFields});

					// Search subtree for objects using filter
					errTrace("NamingEnumeration answer = m_ctx.search(\"\", " + strSrch + ", ctls);",4);

					NamingEnumeration answer = null;
					errTrace("countLim: "+countLim+" origstrdn: "+strDN,1);
					String use = strDN.substring(strDN.length()-1);
					strDN = strDN.substring(0, strDN.length()-2);
					String strOu0="";

					errTrace("use. "+use,1);

					//System.out.println("***************** strDN:"+strDN+" , strSrch"+strSrch);

					if (use.equals("0")){
						answer = m_ctxNTNU.search(str_base_ntnu, strSrch, ctls);  // bruland
						//answer = m_ctxNTNU.search(strDN, strSrch, ctls);


						strOu0 = "NTNU";
					} else if (use.equals("1")){
						answer = m_ctxNTNU.search(str_base_hist, strSrch, ctls);  // bruland
						//answer = m_ctxHiST.search(strDN, strSrch, ctls);
						strOu0 = "HiST";
					} else if (use.equals("2")){
						answer = m_ctxNTNU.search(str_base_sintef, strSrch, ctls);  // bruland
						//answer = m_ctxSINTEF.search(strDN, strSrch, ctls);
						strOu0 = "SINTEF";
					} else if (use.equals("3")){
						answer = m_ctxNTNU.search(str_base_other, strSrch, ctls);  // bruland
						//answer = m_ctxOther.search(strDN, strSrch, ctls);
						strOu0 = "Andre";
					}

					if (answer == null)
						throw new Exception("Error in DN string");

					String str = "";
					boolean added = false;

					while (answer.hasMore()) {
						errTrace("har svar..", 1);
						//if (countLim==0) iElementCount++;
						SearchResult sr = (SearchResult) answer.next();
						boolean okAdd = true;
						boolean found = false;

						if (countLim>0){
							if (strFields.equals("*")) strFields = "street";
							Attribute fieldAttr = sr.getAttributes().get(strFields);
							String field = "";
							if (fieldAttr!=null) found = true;
							else found = false;
							if (found && !added) okAdd = true;
							else okAdd = false;
							errTrace("strFields: "+strFields+" "+okAdd, 1);
						}

						if (iElementCount <= 10 && okAdd){
							iElementCount++;
							added = true;
							NamingEnumeration ats = sr.getAttributes().getAll();

							str = XMLTagger.strTag("ou",strOu0);

							Divider d = new Divider(strDN);
							while (d.hasMore()) {
								str += XMLTagger.strTag(d.getClassName(), d.getValue()) + '\n';
							}

							d = new Divider(sr.getName());
							while (d.hasMore()) {
								str += XMLTagger.strTag(d.getClassName(), d.getValue()) + '\n';
							}

							while (ats.hasMore()) {
								Attribute a = (Attribute) ats.next();
								str += XMLTagger.strTag(a.getID(), (String) a.get()) + '\n';
							   // errTrace("id: "+a.getID()+" - get: "+(String)a.get(), 1);
							}

							str = XMLTagger.strTag("result", str);
							strXML += str + "\n";
						}
					}

                }
                errTrace("test: "+strXML+"\n count: "+iElementCount, 1);
        }catch(Exception e){
            e.printStackTrace();// for diagnostics
        }finally{
			try{
				if (stmt!=null) stmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
        return new SearchRes(strXML,iElementCount);
    }

    public void closeConnection(){
		tagger.closeConnection();
	}


    /**
     * Prints trace information to the error stream
     *
     * @param str       the string to put on the error stream
     * @param l         only put string  if l <= {@link LDAPSearcher.TRACEVAL}   *
     */
    public static void errTrace(String str, int l){
        if (l <= TRACEVAL)
            System.err.println(str);
    }

    /**
     * Prints usage instructions
     */
    private static void printUsage() {
        System.out.println("Usage: java LDAPSearcher {tag|srch} expression");
        System.out.println("Options:");
        System.out.println("tag: Perform tagging of expression");
        System.out.println("srch: Perform search of expression");
    }

    /**
     * The main loop of the program
     *
     * The program ends if the word 'quit' or a blank line is read from the instream
     */
    public static void main(String[] args) {
        String strSearch = "";
        String m_strEncoding="";
        try {
            FileReader fileRead = new FileReader("theparam.txt");
            m_strEncoding = fileRead.getEncoding();
            //saveParam(m_strEncoding);
            if ( m_strEncoding.equals("ASCII")) {
                fileRead.close();
                BufferedReader aFile = new BufferedReader(new InputStreamReader(new FileInputStream("theparam.txt"),"ISO8859-1"));
                strSearch = aFile.readLine();
                aFile.close();
                //saveParam("Read with ISO8859-1. "+strSearch);
            } else {
                BufferedReader inFile = new BufferedReader( fileRead );
                strSearch = inFile.readLine();
                inFile.close();
                //saveParam(strSearch); // bruland
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        //saveParam(strSearch); // bruland

        errTrace("Started LDAPSearcher, args: " + strSearch,3);

        LDAPSearcher srcher = new LDAPSearcher(strSearch.trim());
        srcher.m_strEncoding = m_strEncoding;

        if (strSearch.substring(0,3).equals("tag"))
            srcher.tag(strSearch);
        else
            srcher.srch();

        try {
			srcher.closeConnection();
			//srcher.conn.close();
            //srcher.m_ctxNTNU.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    /**
     * Combines to LDAP search string with the given combination operator
     *
     * @param  str1      the first search string
     * @param  str2      the second search string
     * @param  strMatch  a String object containing the combination operator (should be "&" or "|")
     */
    private static String strMatchLDAPSearches(String str1, String str2, String strMatch) {
		errTrace("str1: "+str1+", str2: "+str2+", strMatch: "+strMatch,1);
        if (str1.charAt(0) != '(')
            str1 = "(" + str1 + ")";
        if (str2.charAt(0) != '(')
            str2 = "(" + str2 + ")";

        return "(" + strMatch + str1 + str2 + ")";
    }


    /**
     * Strips quotes (' or ") from begining and end of String
     *
     * @param str  the String object to strip
     * @return     the stripped String. If str was not quoted, str is returned.
     */
    public static String strStripQuotes(String str){
        if ((str.startsWith("'") || str.startsWith("\"")) && (str.endsWith("'") || str.endsWith("\"")))
            str = str.substring(1, str.length() - 1);
        return str;
    }


    /**
     * Creates a DN String from a code String
     *
     * <p>In the deps.txt file the departments are stored hiearchly with
     * numbers in parantheses after the departmentnames that shows where in
     * the hiearchy the department belongs. This makes it possible to create
     * a DN from the number code (e.g. (1.2.4) ).
     *
     * @param  code  the code to create a DN from
     * @return       a String object with the DN
     */
    public String createDnFromCode(String code) {
        String strDN = "";

        try {

            Pattern p = Pattern.compile("[0-9]+");
            Matcher m = p.matcher(code);
            int iLevels = 0;
            while (m.find())
                iLevels++;
            m = p.matcher(code);
            String astrNos[] = new String[iLevels];

            for (int i = 0; m.find(); i++) {
                astrNos[i] = m.group(0);

                if (i == 0) {
                    strDN = astrNos[0];
                } else{

                    String find = "";
                    String find2 = "(";
                    for (int j = 0; j < i; j++){
                        find += astrNos[j] + "\\.";
                        find2 += astrNos[j] + ".";
                    }
                    find += astrNos[i];
                    find2 += astrNos[i] + ")";
                    String grepcmd[] = new String[] {
                        "grep",
                                "-i", "-e",
                                "(" + find + ")",
                                "depList.txt"
                    };

                    Runtime rt = Runtime.getRuntime();

                    Process pGrep = rt.exec(grepcmd, null,
                            new File(System.getProperty("user.dir")));
                    errTrace(System.getProperty("user.dir"), 3);
                    InputStream isGrep = pGrep.getInputStream();
                    InputStreamReader isr = new InputStreamReader(isGrep);
                    BufferedReader bfr = new BufferedReader(isr);

                    String strLine = null;
                    if ( (strLine = bfr.readLine()) != null) {
                        strDN = "ou=" + strLine.substring(0, strLine.indexOf(find2) - 1) + "," + strDN;
                    }
                    // close buffer
                    bfr.close();

                }
            }

        } catch (Exception e) {
            errTrace("Error in resolving department DN", 1);
        }
        return strDN;

    }

    private class SearchRes {
        /**
         * The XML code with the result of the search
         */
        public String m_strXml;
        /**
         * Number of records found
         */
        public int m_iCountRes;
        /**
         * Default constructor - does nothing
         */
        public SearchRes() {
        }
        /**
         * Constructor that fills the fields
         *
         * @param  strXML is copied to m_strXML
         * @param  iCount is copied to m_iCount
         */
        public SearchRes(String strXML, int iCount){
            m_strXml = strXML;
            m_iCountRes = iCount;
        }
    }

}
