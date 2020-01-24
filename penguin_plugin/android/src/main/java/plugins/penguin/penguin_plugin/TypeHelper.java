package plugins.penguin.penguin_plugin;

public class TypeHelper {
  public static Integer toInt(Object value) {
    if (value == null) return null;
    return (Integer) value;
  }

  public static Long toLong(Object value) {
    if (value == null) return null;
    if (value instanceof Integer) return ((Integer) value).longValue();
    return (Long) value;
  }

  public static Boolean toBool(Object value) {
    if (value == null) return null;
    return (Boolean) value;
  }

  public static String toString(Object value) {
    if (value == null) return null;
    return (String) value;
  }

  public static Double toDouble(Object value) {
    if (value == null) return null;
    return (Double) value;
  }
}
