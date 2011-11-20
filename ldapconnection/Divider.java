package ldapconnection;

import java.util.regex.*;

/**
 * <p>Title: ldapconnection.Diveder</p>
 * <p>Description: Helper class that divides a String with a LDAP DN and returns the elements</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: NTNU</p>
 * @author Tor Livar Flugsrud
 * @version 1.0
 */

public class Divider {
  /**
   * Regex pattern
   */
  Pattern p;
  /**
   * Regex matcher object
   */
  Matcher m;

  /**
   * List of classes
   */
  private String astrClasses[];
  /**
   * List ov values
   */
  private String astrValues[];

  /**
   * Counter
   */
  private int iCount;
  /**
   * Number of next item to return
   */
  private int iNext;


  /**
   * Constructor that gets a distinguished name and performes the division
   *
   * @param  strName   a String object containing the DN to be split up
   */
  public Divider(String strName) {
    p = Pattern.compile("(\\w+)=((\\\\,|[^,])*)");
    m = p.matcher(strName);
    iCount = 0;
    while (m.find())
      iCount++;
    m = p.matcher(strName);
    astrClasses = new String[iCount];
    astrValues = new String[iCount];
    iNext = iCount;
    for (int i = 0; m.find(); i++)
    {
      astrClasses[i] = m.group(1);
      astrValues[i] = m.group(2);
    }
  }

  /**
   * Moves the iNext pointer to the next member of the arrays.
   *
   * @return   true if there exists more elements to return,
   *           false if all elements have been iterated
   */
  public boolean hasMore()
  {
    return --iNext >= 0;
  }

  /**
   * Returns the classname of the next element
   *
   * @return  the class name of the next element
   */
  public String getClassName()
  {
    return astrClasses[iNext];
  }

  /**
   * Returns the value of the next element
   *
   * @return the value of the next element
   */
  public String getValue()
  {
    return astrValues[iNext];
  }

  /**
   * Splits a string up according to the given regex.
   *
   * This function is static so other classes may use it without initializing a object.
   *
   * The function will find each part of the string that correspond to the given regex
   * opposed to the buildt in function {@link String.split} that splits a string
   * around the given regex
   *
   * @param   str   the string to split up
   * @param   regex the regex to split the string by
   * @return        an array of String objects with the parts of the string after the split.
   *                <b>null</b> if the function was not sucessfull.
   */
  public static String[] SplitString(String str, String regex)
  {
    try{
      Pattern p = Pattern.compile(regex);
      Matcher m = p.matcher(str);
      int iFound = 0;
      while (m.find())
        iFound++;

      String strRet[] = new String[iFound];

      m = p.matcher(str);
      for (int i = 0; m.find(); i++)
      {
        strRet[i] = m.group(0);
        // strip quotes
        if ((strRet[i].startsWith("\"") && strRet[i].endsWith("\"")) ||
            (strRet[i].startsWith("'")  && strRet[i].endsWith("'"))){
          strRet[i] = strRet[i].substring(1, strRet[i].length() - 1);
        }
      }

      return strRet;
    }
    catch(Exception e)
    {
      //e.printStackTrace();
    }
    return null;

  }

}