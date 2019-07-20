import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;
import objects.Plugin;

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
      final String output = creator.create();

      System.out.println(output);
    } catch (YamlException e) {
      System.out.println(e.toString());
    }
  }
}
