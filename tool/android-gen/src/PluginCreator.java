import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.TypeSpec;
import objects.Plugin;
import writer.ClassWriter;

import javax.lang.model.element.Modifier;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PluginCreator {
  static public final String CLASS_PREFIX = "Flutter";

  private final Plugin plugin;
  private final String packageName;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;

    final String packageFromChannel = plugin.channel.replace('/', '.');
    this.packageName = packageFromChannel + '.' + plugin.name.replace("_", "");
  }

  public Map<String, String> filesAndStrings() {
    final ClassWriter writer = new ClassWriter(plugin.channel, plugin.name, packageName, CLASS_PREFIX);
    final List<JavaFile> files = writer.writeAll(plugin.classes);

    final Map<String, String> filesAndStrings = new HashMap<>();
    for (int i = 0; i < files.size(); i++) {
      final String filename = CLASS_PREFIX + plugin.classes.get(i).name + ".java";
      filesAndStrings.put(filename, files.get(i).toString());
    }

    filesAndStrings.put(snakeCaseToCamelCase(plugin.name) + ".java", pluginFileString());

    return filesAndStrings;
  }

  private String pluginFileString() {
    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(snakeCaseToCamelCase(plugin.name))
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL);

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build().toString();
  }

  private String snakeCaseToCamelCase(String str) {
    final Matcher matcher = Pattern.compile("([a-z]+)_*").matcher(str);

    final StringBuffer buffer = new StringBuffer();
    while (matcher.find()) {
      final String match = matcher.group(1);
      buffer.append(match.substring(0, 1).toUpperCase());
      buffer.append(match.substring(1));
    }

    return buffer.toString();
  }
}
