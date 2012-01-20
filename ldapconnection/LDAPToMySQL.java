package ldapconnection;

import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;

import java.sql.*;

class LDAPToMySQL{

	private static final String ldapAddr = "ldap://ldap.ntnu.no:389";
	private static final String mysqlAddr = "jdbc:mysql://localhost/telefon?user=arild&password=buster";

	private String str_base_ntnu = "dc=NTNU,dc=NO";
	private String str_base_hist = "dc=HIST,dc=NO";
	private String str_base_sintef = "dc=SINTEF,dc=NO";
	private String str_base_other = "dc=ANDRE,dc=NO";
  	private DirContext m_ctxNTNU;

	public LDAPToMySQL(){

		try {
		      Hashtable env = new Hashtable(11);
		      env.put(Context.REFERRAL, "throw");
		      env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		      env.put(Context.PROVIDER_URL, ldapAddr);
		      m_ctxNTNU = new InitialDirContext(env);
		    }
		    catch (Exception e) {
		      e.printStackTrace();
    	}
	}




	public void convAll(){
		conv(str_base_ntnu);
		conv(str_base_hist);
		conv(str_base_sintef);
		conv(str_base_other);
	}

	/*

	ou: 6794
	cn: 6491
	sn : 6490 treff
	telephoneNumber : 6476 treff

	*/




	public void conv(String str) {
		String srchAttr = "telephoneNumber";
		String srchStr = "*";
		Statement stmt = null;
		Connection conn = null;
		NamingEnumeration answer = null;
		try{
			int count = 0;
			String[] attrIDs = {"*"};
			String strFilter = "(&(|("+srchAttr+"="+srchStr+"*)("+srchAttr+"=* "+srchStr+"*)))";

			SearchControls ctls = new SearchControls();
			ctls.setReturningAttributes(attrIDs);
			ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			System.out.println("søkefilter: "+strFilter);

			answer = m_ctxNTNU.search(str_base_ntnu, strFilter, ctls);

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(mysqlAddr);
			stmt = conn.createStatement();

			// <--- REMOVE AFTER TESTING ---> //
			stmt.executeUpdate("DELETE FROM person");
			stmt.executeUpdate("DELETE FROM org");
			stmt.executeUpdate("DELETE FROM top_org");
			//stmt.executeUpdate("DELETE FROM room");
			//stmt.executeUpdate("DELETE FROM top_room");
			// <--- 		END 		 ---> //

			while (answer.hasMore()) {
				//System.out.println("----- Et treff -----");
				SearchResult sr = (SearchResult) answer.next();
				NamingEnumeration ne = sr.getAttributes().getAll();
				int i=1;
				int ounr=0;
				int orgId = -1;
				String first_name = "";
				String surname = "";
				String street = "";
				String telephone_number = "";
				String mail = "";
				String title = "";
				String room = "";
				boolean output = false;
				while(ne.hasMore()){
					Attribute at = (Attribute)ne.next();
					NamingEnumeration ne2 = at.getAll();
					while(ne2.hasMore()){
						Object at2 = ne2.next();
						String foundAtt = at.getID();
						if (foundAtt.equals("givenName")) first_name = (String)at2;
						else if (foundAtt.equals("sn")){ surname = (String)at2; /*if (surname.equals("Amble")) output=true; */}
						else if (foundAtt.equals("street")) street = (String)at2;
						else if (foundAtt.equals("telephoneNumber")) telephone_number = (String)at2;
						else if (foundAtt.equals("mail")) mail = (String)at2;
						else if (foundAtt.equals("title")) title = (String)at2;
						else if (foundAtt.equals("ou")){
							// Register organizations in separate tables
							ounr++;
							//System.out.println("ou nr "+ounr);
							String ou = (String)at2;
							if (output) System.out.println("Ou "+ounr+": "+ou);
							if (ounr==1){
								// Organization at top level (ex. fakultet)
								ResultSet rs = stmt.executeQuery("SELECT top_org.top_org_id FROM top_org WHERE "+
																 "top_org.org_name = '"+ou+"'");
								boolean orgFound = rs.next();
								if (orgFound) orgId = rs.getInt("top_org.top_org_id");
								rs.close();
								if (!orgFound){
									//System.out.println(ou+ " ikke reg fra før");
									stmt.executeUpdate("INSERT INTO top_org VALUES (0,'"+ou+"','')", Statement.RETURN_GENERATED_KEYS);
									ResultSet rs2 = stmt.getGeneratedKeys();
									if (rs2.next()){
										orgId = rs2.getInt(1);
										if (output) System.out.println("orgId set to: "+orgId);
									}
									rs2.close();
								}
							}else{
								// Organization at bottom level (ex. institutt)
								ResultSet rs = stmt.executeQuery("SELECT org_id FROM org WHERE org_name = '"+ou+"'");
								boolean orgFound = rs.next();
								if (orgFound) orgId = rs.getInt("org.org_id");
								rs.close();
								if (!orgFound){
									stmt.executeUpdate("INSERT INTO org VALUES (0,'"+ou+"','',"+orgId+")", Statement.RETURN_GENERATED_KEYS);
									ResultSet rs2 = stmt.getGeneratedKeys();
									if (rs2.next()){
										orgId = rs2.getInt(1);
										if (output) System.out.println("orgId set to: "+orgId);
									}
									rs2.close();
								}
							}



						}else if (foundAtt.equals("roomNumber")){
							// Temporary solution: "room" saved as string in the table 'person'
							room = (String)at2;

							/*
							String fullRoomName = (String)at2;
							StringTokenizer st = new StringTokenizer(fullRoomName, "*");
							int roomLevel = 1;
							while (st.hasMoreTokens()){
								roomLevel++;
								String roomName = st.next();
								if (roomLevel==1){

							}*/
						}




						//System.out.println("annet: "+foundAtt);

						//if (at2 instanceof String) System.out.println(""+i+": "+(String)at2+" ("+at.getID()+")");
						//else System.out.println("annet..");
						i++;
					}




				}

				if (orgId!=-1){ // person have to be registered to an organization (not everyone in ldap database is that)

					String sqlstring = "INSERT INTO person VALUES "+
						"(0,\""+first_name+"\",\""+surname+"\",\""+street+"\",\""+telephone_number+"\",\""+mail+"\",\""+title+"\",\""+room+"\","+orgId+")";
					System.out.println(sqlstring);
					stmt.executeUpdate(sqlstring);

					count++;
					//rs = stmt.executeQuery("SELECT * FROM person");
					// ('first_name','surname','street','telephone_number','mail','title')
				}
				if (output) break;
			}
			System.out.println("Total: "+count);


		}catch(Exception e){
			System.out.println(e);
		}finally{
			try{
				answer.close();
				if (stmt != null) stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	/*private String convertSpecial(String orgString){
		if (orgString.contains("'fdh")) return orgString.replace("'",".");
		else return orgString;
	}*/



	public static void main(String[] args){
		LDAPToMySQL converter = new LDAPToMySQL();
		converter.convAll();
		//System.out.println(converter.convertSpecial("L'Heureux"));
	}



}

