import com.squareup.javapoet.JavaFile;
import objects.Plugin;
import writer.ClassWriter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PluginCreator {
  final Plugin plugin;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;
  }

  public Map<String, String> filesAndStrings() {
    final ClassWriter writer = new ClassWriter(plugin.channel, plugin.name);
    final List<JavaFile> files = writer.writeAll(plugin.classes);

    final Map<String, String> filesAndStrings = new HashMap<>();
    for (int i = 0; i < files.size(); i++) {
      final String filename = plugin.classes.get(i).name + ".java";
      filesAndStrings.put(filename, files.get(i).toString());
    }

    return filesAndStrings;
  }
}
