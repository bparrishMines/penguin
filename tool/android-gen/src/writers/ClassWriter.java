package writers;

import com.squareup.javapoet.*;
import creator.ClassStructure;
import objects.Plugin;
import objects.PluginClass;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<PluginClass, JavaFile> {
  private final Plugin plugin;
  private final String packageName;
  private final String classPrefix;
  private final ClassName mainPluginClassName;

  public ClassWriter(Plugin plugin, String packageName, String classPrefix, ClassName mainPluginClassName) {
    this.plugin = plugin;
    this.packageName = packageName;
    this.classPrefix = classPrefix;
    this.mainPluginClassName = mainPluginClassName;
  }

  @Override
  public JavaFile write(PluginClass aClass) {
    final ClassName wrappedName = ClassName.get(aClass.java_package, aClass.name);

    final String wrappedObjectName = aClass.name.toLowerCase();
    final MethodWriter methodWriter = new MethodWriter(plugin, wrappedObjectName, packageName, mainPluginClassName, classPrefix);
    final FieldWriter fieldWriter = new FieldWriter(plugin, wrappedObjectName, packageName, mainPluginClassName, classPrefix);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(classPrefix + aClass.name)
        .addModifiers(Modifier.FINAL)
        .addField(Integer.class, "handle", Modifier.PRIVATE, Modifier.FINAL)
        .addField(wrappedName, wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE)
        .addMethods(methodWriter.writeAll(aClass.methods))
        .addMethods(fieldWriter.writeAll(aClass.fields));

    final ClassStructure structure = ClassStructure.structureFromClass(plugin, aClass);
    switch (structure) {
      case UNSPECIFIED_PUBLIC:
        classBuilder.addMethod(MethodSpec.constructorBuilder()
            .addParameter(Integer.class, "handle")
            .addStatement("this.handle = handle")
            .addStatement("this.$N = new $T()", wrappedObjectName, wrappedName)
            .build());
        break;
      case UNSPECIFIED_PRIVATE:
        classBuilder.addMethod(MethodSpec.constructorBuilder()
            .addParameter(Integer.class, "handle")
            .addParameter(wrappedName, wrappedObjectName)
            .addStatement("this.handle = handle")
            .addStatement("this.$N = $N", wrappedObjectName, wrappedObjectName)
            .build());
        break;
    }

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build();
  }
}
