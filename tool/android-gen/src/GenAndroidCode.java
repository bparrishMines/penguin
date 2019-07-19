import com.esotericsoftware.yamlbeans.YamlConfig;
import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;

/**
 * Main
 */
public class GenAndroidCode {
  public static void main(String[] args) {
    final String yaml = args[0];

    final YamlReader reader = new YamlReader(yaml);

    final Plugin plugin;
    try {
      plugin = reader.read(Plugin.class);
    } catch (YamlException e) {
      System.out.println(e.toString());
    }
  }
}
