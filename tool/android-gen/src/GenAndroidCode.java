import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;
import creator.PluginCreator;
import objects.Plugin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Main
 */
public class GenAndroidCode {
  private static final String SEPERATOR = "@!!#%@#";
  public static void main(String[] args) {
    final String yaml = args[0];

    final YamlReader reader = new YamlReader(yaml);

    final Plugin plugin;
    try {
      plugin = reader.read(Plugin.class);
      final PluginCreator creator = new PluginCreator(plugin);
      final Map<String, String> filesAndStrings = creator.filesAndStrings();

      final List<Map.Entry<String, String>> entryList = new ArrayList<>(filesAndStrings.entrySet());
      for (int i = 0; i < entryList.size(); i++) {
        System.out.print(entryList.get(i).getKey());
        System.out.print(SEPERATOR);
        System.out.print(entryList.get(i).getValue());

        if (i < entryList.size() - 1) {
          System.out.print(SEPERATOR);
        }
      }

    } catch (YamlException e) {
      System.err.println(e.toString());
      System.err.println(yaml);
      System.exit(2);
    }
  }
}
