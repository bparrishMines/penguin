package writer;

import com.squareup.javapoet.*;
import objects.PluginClass;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<PluginClass, JavaFile> {
  private final String channel;
  private final String pluginName;
  private final String packageName;
  private final String classPrefix;

  public ClassWriter(String channel, String pluginName, String packageName, String classPrefix) {
    this.channel = channel;
    this.pluginName = pluginName;
    this.packageName = packageName;
    this.classPrefix = classPrefix;
  }

  @Override
  public JavaFile write(PluginClass aPluginClass) {
    final ClassName className = ClassName.get(aPluginClass.java_package, aPluginClass.name);

    final String wrappedObjectName = aPluginClass.name.toLowerCase();
    final MethodWriter methodWriter = new MethodWriter(wrappedObjectName);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(classPrefix + aPluginClass.name)
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addField(className, wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE)
        .addMethods(methodWriter.writeAll(aPluginClass.methods));

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build();
  }
}
