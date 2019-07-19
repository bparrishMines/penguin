import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;

/**
 * Main
 */
public class GenAndroidCode {
  public String name;
  public static void main(String[] args) {
    final String yaml = args[0];
    final YamlReader reader = new YamlReader(yaml);

    /*
    try {
      GenAndroidCode code = reader.read(GenAndroidCode.class);
      System.out.println(code.name);
    } catch (YamlException e) {
      e.printStackTrace();
    }
    */
  }
}
