package ldapconnection;

/**
 * <p>Title: LDAPConnection</p>
 * <p>Description: Helper class that provides static function to permutate</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: NTNU</p>
 * @author Tor Livar Flugsrud
 * @version 1.0
 */

public class Permutater {
  /**
   * Private constructor since no instances of this class is needed.
   */
  private Permutater() {
  }

  /**
   * Returns all permutations of the given string array
   *
   * @param  arr   an array of String objects to permutate
   * @return       an array of String arrays - all permutations of arr
   */
  public static String[][] permutate(String[] arr)
  {
    if (arr.length == 1)
      return new String[][]{arr};

    String[][] aaRet = new String[iFac(arr.length)][arr.length];
    for (int i = 0; i < arr.length; i++)
    {
      int k = 0;
      String aaRest[] = new String[arr.length - 1];
      for (int j = 0; j < arr.length; j++)
      {
        if (i != j)
          aaRest[k++] = arr[j];
      }

      String[][]aaPRest = permutate(aaRest);
      for (int j = 0; j < aaPRest.length; j++)
      {
        aaRet[i * aaPRest.length + j][0] = arr[i];
        System.arraycopy(aaPRest[j],0,aaRet[i * aaPRest.length + j],1,arr.length-1);
      }
    }
    return aaRet;
  }

  /**
   * Returns all permutations of the given object array
   *
   * @param  arr   an array of objects to permutate
   * @return       an array of Object arrays - all permutations of arr
   */

  public static Object[][] permutate(Object[] arr)
  {
    if (arr.length == 1)
      return new Object[][]{arr};

    Object[][] aaRet = new Object[iFac(arr.length)][arr.length];
    for (int i = 0; i < arr.length; i++)
    {
      int k = 0;
      Object[] aaRest = new Object[arr.length - 1];
      for (int j = 0; j < arr.length; j++)
      {
        if (i != j)
          aaRest[k++] = arr[j];
      }

      Object[][]aaPRest = permutate(aaRest);
      for (int j = 0; j < aaPRest.length; j++)
      {
        aaRet[i * aaPRest.length + j][0] = arr[i];
        System.arraycopy(aaPRest[j],0,aaRet[i * aaPRest.length + j],1,arr.length-1);
      }
    }
    return aaRet;
  }

  /**
   * The faculty function (N!)
   *
   * @param  i   the integer to calculate the faculty of
   * @return     i!
   * @throws     IllegalArgumentException if i < 0
   */
  public static int iFac(int i) throws IllegalArgumentException
  {
    if (i < 0)
      throw new IllegalArgumentException("iFac(int) called with negative argument");
    if (i == 0)
      return 1;
    if (i == 1)
      return 1;
    else
      return i * iFac(i-1);
  }
}