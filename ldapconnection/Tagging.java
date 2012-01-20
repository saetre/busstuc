 package ldapconnection;

 class Tagging
        implements Comparable {
      /**
       * The tagged string
       */
      public String m_strTagged;
      /**
       * The word concept the word is tagged as (class)
       *
       * Examples: firstname, lastname, department
       */
      public String m_strClass;
      /**
       * The key to use for the search
       *
       * Usually the same as the word.
       */
      public String m_strKey;
      /**
       * The number of times the word was found
       */
      public int m_iCount;
      /**
       * The number of times the word was found as a whole word.
       *
       * Makes it possible to separate the word Hans (as a first name)
       * from the word Hansen (which is a last name)
       */
      public int m_iExactCount;

      /**
       * Public constructor. Sets all the fields.
       *
       * @param  strTagged   the text that is tagged
       * @param  strClass    the class/concept the word is tagged as
       * @param  iCount      the number of times the word is found
       * @param  iCountExact the number of times the word is found as an exact match
       */
      public Tagging(String strTagged, String strClass, int iCount, int iCountExact) {
        m_strTagged = strTagged;
        m_strKey = m_strTagged;
        m_strClass = strClass;
        m_iCount = iCount;
        m_iExactCount = iCountExact;
      }

      /**
       * Public constructor. Sets all the fields.
       *
       * @param  astrTagged  the text that is tagged as an array. Will be concatenated with spaces between.
       * @param  strClass    the class/concept the word is tagged as
       * @param  iCount      the number of times the word is found
       * @param  iCountExact the number of times the word is found as an exact match
       */
      public Tagging(String astrTagged[], String strClass, int iCount, int iCountExact) {
  		//System.out.println("strClass: "+strClass);
        m_iCount = iCount;
        m_strTagged = "";
        for (int i = 0; i < astrTagged.length; i++) {
          m_strTagged += astrTagged[i] + " ";
        }
        m_strTagged = m_strTagged.trim();
        m_strKey = m_strTagged;
        m_strClass = strClass;
        m_iExactCount = iCountExact;
		//System.out.println("ble tagget: "+m_strTagged);
      }

      /**
       * Replaces any æ, ø or å in beginning of word with corresponding Æ, Ø or Å.
       */
      public void capitalizeNorw()
      {
        m_strKey = m_strKey.replaceAll("\\bæ", "Æ");
        m_strKey = m_strKey.replaceAll("\\bø", "Ø");
        m_strKey = m_strKey.replaceAll("\\bå", "Å");
      }

      /**
       * Equal-comparison of two objects of this class
       *
       * Two Tagging objects are equal if all parameters are equal
       */
      public boolean equals(Object o) {
        if (! (o instanceof Tagging)) {
          return false;
        }
        Tagging t = (Tagging) o;
        //System.out.println("tester "+t.m_strTagged+" mot "+m_strTagged);
        return t.m_strTagged.equals(m_strTagged) &&
            t.m_strClass.equals(m_strClass); //&&
           // t.m_iCount == m_iCount;
      }

      /**
       * Creates a hashing code for the object
       */
      public int hashCode() {
        return 31 * 31 * m_iCount + 31 * m_strTagged.hashCode() +
            m_strClass.hashCode();
      }

      /**
       * Compare two objects of this class
       *
       * Tagging with higher exact count comes first, when equal the tagging with
       * the higher cound comes, and finaly the strings are compared.
       *
       * @param o    the object to compare to - should be a Tagging object
       * @return     a number showing the order of this two objects
       */
      public int compareTo(Object o) {
        Tagging t = (Tagging) o;
        if (countMatches(t.m_strTagged," ") != countMatches(m_strTagged, " ")){
			return countMatches(t.m_strTagged," ")-countMatches(m_strTagged, " ");
		}else if (t.m_strTagged.equals(m_strTagged) && t.m_strClass.equals("department") && t.m_iExactCount>0) return 1;

		else if (t.m_iExactCount != m_iExactCount ){;
          return (t.m_iExactCount - m_iExactCount);
        }else if (t.m_iCount != m_iCount) {
          return (t.m_iCount - m_iCount);
	    }
        return t.m_strTagged.length()-m_strTagged.length(); //-m_strTagged.compareTo(t.m_strTagged);
      }

      /**
       * Creates a string of the object.
       *
       * The string is the XML representation that can be sendt to the client
       * application
       *
       * @return  A String object with the XML code representing this tagging
       */
      public String toString() {
        String strRet;
        strRet = XMLTagger.strTag("concept", m_strClass);
        strRet += XMLTagger.strTag("key", m_strKey);
        strRet += XMLTagger.strTag("data", m_strTagged);
        strRet += XMLTagger.strTag("exact", ""+m_iExactCount);
        strRet += XMLTagger.strTag("part", ""+m_iCount);
        strRet = XMLTagger.strTag("apo", strRet);

        return strRet;
      }

      /**
       * Returns the first word in the m_strTagged field.
       *
       * Used to sort the tagges before they are returned.
       *
       * @return A String object containing the first word in the m_strTagged field
       */
      public String strWord() {
        int iPos = m_strTagged.indexOf(' ');
        if (iPos == -1) {
          return m_strTagged;
        }
        else {
          return m_strTagged.substring(0, iPos);
        }
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
  }