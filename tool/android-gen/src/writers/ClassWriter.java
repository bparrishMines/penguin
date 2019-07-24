package writers;

import com.squareup.javapoet.*;
import creator.ClassStructure;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginField;
import objects.PluginMethod;

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
        .addField(wrappedName, wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE);

    for (PluginField field : aClass.fields) {
      if (field.is_static) {
        classBuilder.addMethod(buildOnStaticMethodCall(aClass));
        break;
      }
    }

    classBuilder.addMethod(buildOnMethodCall(aClass))
        .addMethods(fieldWriter.writeAll(aClass.fields))
        .addMethods(methodWriter.writeAll(aClass.methods));

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

  private MethodSpec buildOnMethodCall(PluginClass aClass) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.PUBLIC)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call")
        .addParameter(PluginClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    for (PluginField field : aClass.fields) {
      if (!field.is_static) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, field.name)
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("$N(call, result)", field.name)
            .addStatement("break")
            .addCode(CodeBlock.builder().unindent().build());
      }
    }

    for (PluginMethod method : aClass.methods) {
      builder.addCode("case \"$N#$N\":\n", aClass.name, method.name)
          .addCode(CodeBlock.builder().indent().build())
          .addStatement("$N(call, result)", method.name)
          .addStatement("break")
          .addCode(CodeBlock.builder().unindent().build());
    }

    builder.addCode("default:\n")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("result.notImplemented()")
        .addCode(CodeBlock.builder().unindent().build());

    return builder.endControlFlow().build();
  }

  private MethodSpec buildOnStaticMethodCall(PluginClass aClass) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onStaticMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.STATIC, Modifier.PUBLIC)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call")
        .addParameter(PluginClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    for (PluginField field : aClass.fields) {
      if (field.is_static) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, field.name)
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("$N(call, result)", field.name)
            .addStatement("break")
            .addCode(CodeBlock.builder().unindent().build());
      }
    }

    builder.addCode("default:\n")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("result.notImplemented()")
        .addCode(CodeBlock.builder().unindent().build());

    return builder.endControlFlow().build();
  }
}
