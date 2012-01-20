package ldapconnection;

import java.sql.*;
import java.util.*;

class TaggerSQL{
	private Connection conn;
	private int m_iCountSearches;



	public TaggerSQL(Connection _conn){
		conn = _conn;
		m_iCountSearches = 0;
	}

	/*
	* Return: ArrayList size 3
	* 1 - (Tagging) taggedWord
	* 2 - (ArrayList) firstNameList
	* 3 - (ArrayList) lastNameList
	*/
	public ArrayList createTagsAttr(String[] words, String attr, String strConcept){
		ArrayList tagResult = new ArrayList();
		ArrayList firstNameList = new ArrayList();
	 	ArrayList lastNameList = new ArrayList();
		Tagging taggedWord = null;
		String word = words[0];
		boolean office = false;
		for (int i=1; i<words.length; i++) word+= " "+words[i];
		try{
			Statement stmt = conn.createStatement();
			if (attr.equals("givenname")) attr = "givenName";
			String sqlstr = "SELECT givenName,sn FROM person WHERE "+attr+" REGEXP \"[[:<:]]"+word+"\" OR "+attr+" LIKE \".."+word+"\"";
			ResultSet answer = stmt.executeQuery(sqlstr);
			m_iCountSearches++;
			int count=0;
			int exactCount=0;
			while (answer.next()){
				count++;
				String fullName = answer.getString("givenName") + " " + answer.getString("sn");
				if (attr.equals("givenName")){
					firstNameList.add(fullName);
					if (answer.getString("givenName").length() == word.length()) exactCount++;
				} else if (attr.equals("sn")){
					lastNameList.add(fullName);
					if (answer.getString("sn").length() == word.length()) exactCount++;
					if ((answer.getString("sn")).indexOf("..")==0 && count==0){ // iRet==0 fordi det skal kun settes som office når det er eneste svar. (Berg pri som etternavn)
						// "..Instituttkontor IDI" ++
						office = true;
					}
				}
			}
			if (count!=0){
				String strClass = "lastname";
				if (attr.equals("givenName")) strClass = "firstname";
				if (office) strClass = "room";
				taggedWord = new Tagging(word, strClass, count, exactCount);
			}
			tagResult.add(taggedWord);
			tagResult.add(firstNameList);
			tagResult.add(lastNameList);
			answer.close();
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return tagResult;
	}

	/*
	* Return: Updated m_taggedWords
	*/
	public ArrayList createDepTags(String[] words, ArrayList m_taggedWords){
		Tagging tag = null;
		try{
			for (int j=0; j<words.length; j++){
				if (words[j].length() > 2){
					String word = words[j];
					Statement stmt = conn.createStatement();
					String sqlstr = "SELECT DISTINCT org1.ou,org2.ou,org3.ou,org4.ou FROM org1,org2,org3,org4 WHERE org1.org2_id=org2.id AND org2.org3_id=org3.id AND org3.org4_id=org4.id AND ("+
						"org1.ou REGEXP \"[[:<:]]"+word+"[[:>:]]\" OR "+
						"org2.ou REGEXP \"[[:<:]]"+word+"[[:>:]]\" OR "+
						"org3.ou REGEXP \"[[:<:]]"+word+"[[:>:]]\" OR "+
						"org4.ou REGEXP \"[[:<:]]"+word+"[[:>:]]\" )";
					ResultSet answer = stmt.executeQuery(sqlstr);
					m_iCountSearches++;
					int count=0;
					int exactCount=0;
					while (answer.next()){
						count++;
						if (answer.getString("org1.ou").toUpperCase().equals(word.toUpperCase()) ||
							answer.getString("org2.ou").toUpperCase().equals(word.toUpperCase()) ||
							answer.getString("org3.ou").toUpperCase().equals(word.toUpperCase()) ||
							answer.getString("org4.ou").toUpperCase().equals(word.toUpperCase()) ){
								exactCount++;
						}
					}
					if (count!=0 && LDAPSearcher.strStopwords.indexOf(word)==-1){
						tag = new Tagging(word, "department", count, exactCount);
						Tagging oldDepTag = null;
						for (int k=0; k<m_taggedWords.size(); k++){
							Tagging t = (Tagging)m_taggedWords.get(k);
							if (t.m_strClass.equals("department") ) oldDepTag = t;
						}
						boolean okAdd = false;
						if (oldDepTag==null){
							okAdd = true;
						}else if (oldDepTag!=null && oldDepTag.m_strTagged.length()<tag.m_strTagged.length()){
							m_taggedWords.remove(oldDepTag);
							okAdd = true;
						}
						okAdd = true; // test
						if (okAdd){
							m_taggedWords.add(tag);
						}
					}
					answer.close();
					stmt.close();


				}
			}

		}catch(Exception e){
			e.printStackTrace();
		}
		return m_taggedWords;
	}

	public ArrayList getExactNames(){
		return new ArrayList();
	}


	public static void main(String[] args){
		//SearchSQL test = new SearchSQL(null);
		//test.search(new String[]

	}

}