import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;
import objects.Plugin;

import java.util.Map;

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
      final PluginCreator creator = new PluginCreator(plugin);
      final Map<String, String> filesAndStrings = creator.filesAndStrings();

      for (Map.Entry<String, String> entry : filesAndStrings.entrySet()) {
        System.out.println(entry.getKey());
        System.out.println(entry.getValue());
      }

    } catch (YamlException e) {
      System.out.println(e.toString());
    }
  }
}
