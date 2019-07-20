package writer;

import com.squareup.javapoet.*;
import objects.Class;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<Class, JavaFile> {
  static public final String CLASS_PREFIX = "Flutter";

  final String channel;
  final String pluginName;

  public ClassWriter(String channel, String pluginName) {
    this.channel = channel;
    this.pluginName = pluginName;
  }

  @Override
  public JavaFile write(Class aClass) {
    final ClassName className = ClassName.get(aClass.java_package, aClass.name);

    final String wrappedObjectName = aClass.name.toLowerCase();
    final MethodWriter methodWriter = new MethodWriter(wrappedObjectName);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(CLASS_PREFIX + aClass.name)
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addField(className, wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE)
        .addMethods(methodWriter.writeAll(aClass.methods));

    String packageName = channel.replace('/', '.');
    packageName = packageName + '.' + pluginName.replace("_", "");

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build();
  }
}
