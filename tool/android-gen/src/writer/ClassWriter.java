package writer;

import com.squareup.javapoet.*;
import objects.Class;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<Class, JavaFile> {
  final String channel;
  final String pluginName;

  public ClassWriter(String channel, String pluginName) {
    this.channel = channel;
    this.pluginName = pluginName;
  }

  @Override
  public JavaFile write(Class aClass) {
    final ClassName className = ClassName.get(aClass.java_package, aClass.name);

    final TypeSpec classType = TypeSpec.classBuilder("Flutter" + aClass.name)
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addField(className, aClass.name.toLowerCase(), Modifier.FINAL, Modifier.PRIVATE)
        .build();

    String packageName = channel.replace('/', '.');
    packageName = packageName + '.' + pluginName.replace("_", "");

    final JavaFile.Builder builder = JavaFile.builder(packageName, classType);

    return builder.build();
  }
}
