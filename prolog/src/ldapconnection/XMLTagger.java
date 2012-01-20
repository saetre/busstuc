package ldapconnection;

import java.util.regex.*;

/**
 * <p>Title: XMLTagger</p>
 * <p>Description: A class that provides a few simple static functions to create XML code</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: NTNU</p>
 * @author Tor Livar Flugsrud
 * @version 1.0
 */

class XMLTagger {

  /**
   * Private constructor - no point in instansiating this class,
   * all methods are static
   */
  private XMLTagger() {}

  /**
   * Creates a XML tag with (or without) contents, without arguments.
   *
   * If strCont is an empty string, a <tag/>-tag is returned, otherwise
   * the returned string will be <tag>contents</tag>.
   *
   * @param   strTag      the name of the tag to return
   *          strCont     the contents of the tag
   * @return              a String object with the created XML tagg
   */
  public static String strTag(String strTag, String strCont) {

    String strRet = "";
    if (strCont.equals("")) {
      strRet = "<" + strTag + "/>";
    }
    else {
      strRet = "<" + strTag.toLowerCase() + ">" + strCont + "</" + strTag.toLowerCase() + ">";
    }

    return strReplaceAmps(strRet);
  }

  /**
   * Creates a XML tag with attributes.
   *
   * If strCont is an empty string, a <tag arg1="val1" arg2="val2"... /> tag is made
   * otherwise the returned string will be <tag arg1="val1" arg2="val2"...>contents</tag>
   *
   * @param  strTag       the name of the tag to return
   *         strCont      the contents of the tag
   *         strArgNames  an array consisting of the names of each argument for the tag
   *         strArgVals   an array consisting of the values of each argument. Must have
   *                      the same array length as strArgNames
   *
       * @return              a String object with the formated XML tag with arguments
   * @see    strTag
   */
  public static String strTag(String strTag, String strCont,
                              String[] strArgNames, String[] strArgVals) throws
      Exception {
    if (strArgNames.length != strArgVals.length)
      throw new Exception(
          "Number of argument values must equal number of argument names");

    String strRet = "";

    String strArgs = "";

    for (int i = 0; i < strArgNames.length; i++)
      strArgs += " " + strArgNames[i] + "=\"" + strArgVals[i] + "\"";

    if (strCont.equals("")) {
      strRet = "<" + strTag + strArgs + "/>";
    }
    else {
      strRet = "<" + strTag + strArgs + ">" + strCont + "</" + strTag + ">";
    }

    return strRet;
  }

  /**
   * returns the xml instruction with correct version and character encoding attributes set.
   *
   */
  public static String strMarkXML() {
    return "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n";
    //return "<?xml version=\"1.0\"?>\n";
  }

  /**
   * Replaces all &amp; with &amp;amp; except where & is the start of a XML class name.
   *
   * @param  str  the string to search and replace in
   * @return      a string where the &amp; is replaced with &amp;amp; where applicable
   */
  public static String strReplaceAmps(String str) {
    StringBuffer sb = new StringBuffer();
    Pattern p = Pattern.compile("&(\\w*[^;\\w])");
    Matcher m = p.matcher(str);
    while (m.find()) {
      m.appendReplacement(sb, "&amp;$1");
    }
    m.appendTail(sb);
    return sb.toString();
  }
}