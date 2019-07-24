package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
import creator.ClassStructure;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginField;

import javax.lang.model.element.Modifier;

public class FieldWriter extends Writer<PluginField, MethodSpec> {
  private final Plugin plugin;
  private final String wrappedObjectName;
  private final String packageName;
  private final ClassName mainPluginClassName;
  private final String classPrefix;

  FieldWriter(Plugin plugin, String wrappedObjectName, String packageName, ClassName mainPluginClassName, String classPrefix) {
    this.plugin = plugin;
    this.wrappedObjectName = wrappedObjectName;
    this.packageName = packageName;
    this.mainPluginClassName = mainPluginClassName;
    this.classPrefix = classPrefix;
  }

  @Override
  public MethodSpec write(PluginField field) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder(field.name);
    if (field.is_static) builder.addModifiers(Modifier.STATIC);

    final ClassStructure structure = ClassStructure.tryGetClassStructure(plugin, field.type);

    if (structure == null) {
      final ClassName returnType = ClassName.bestGuess(field.type);
      builder.addStatement("final $T value = $N.$N", returnType, wrappedObjectName, field.name)
          .addStatement("result.success(value)");
    } else {
      final ClassName handlerName = ClassName.get(packageName,  classPrefix + field.type);
      final PluginClass pluginClass = ClassStructure.classFromString(plugin, field.type);
      final ClassName wrappedName = ClassName.get(pluginClass.java_package, pluginClass.name);

      builder.addStatement("final $T handle = call.argument($S)", Integer.class, "handle")
          .addStatement("final $T value = $N.$N", wrappedName, wrappedObjectName, field.name)
          .addStatement("final $T handler = $T(handle, value)", handlerName, handlerName)
          .addStatement("$T.addHandler(handle, handler)", mainPluginClassName);
    }

    return builder.build();
  }
}
