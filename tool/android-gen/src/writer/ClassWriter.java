package writer;

import com.squareup.javapoet.*;
import objects.Class;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<Class, JavaFile> {
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
  public JavaFile write(Class aClass) {
    final ClassName className = ClassName.get(aClass.java_package, aClass.name);

    final String wrappedObjectName = aClass.name.toLowerCase();
    final MethodWriter methodWriter = new MethodWriter(wrappedObjectName);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(classPrefix + aClass.name)
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addField(className, wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE)
        .addMethods(methodWriter.writeAll(aClass.methods));

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build();
  }
}
