package utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils {
  public static String snakeCaseToCamelCase(String str) {
    final Matcher matcher = Pattern.compile("([a-z]+)_*").matcher(str);

    final StringBuilder buffer = new StringBuilder();
    while (matcher.find()) {
      final String match = matcher.group(1);
      buffer.append(match.substring(0, 1).toUpperCase());
      buffer.append(match.substring(1));
    }

    return buffer.toString();
  }
}
