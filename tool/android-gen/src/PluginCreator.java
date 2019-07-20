import com.squareup.javapoet.JavaFile;
import objects.Plugin;
import writer.ClassWriter;

public class PluginCreator {
  final Plugin plugin;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;
  }

  public String create() {
    final ClassWriter writer = new ClassWriter();

    JavaFile file = writer.write(plugin.classes.get(0));

    return file.toString();
  }
}
