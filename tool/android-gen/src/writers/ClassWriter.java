package writers;

import com.squareup.javapoet.*;
import objects.*;

import javax.lang.model.element.Modifier;
import java.util.ArrayList;
import java.util.List;

public class ClassWriter extends Writer<PluginClass, JavaFile> {
  private final Plugin plugin;
  private final String packageName;
  private final ClassName mainPluginClassName;

  public ClassWriter(Plugin plugin, String packageName, ClassName mainPluginClassName) {
    this.plugin = plugin;
    this.packageName = packageName;
    this.mainPluginClassName = mainPluginClassName;
  }

  @Override
  public JavaFile write(PluginClass aClass) {
    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(aClass.details.wrapperClassName.simpleName())
        .addModifiers(Modifier.FINAL)
        .addField(Integer.class, "handle", Modifier.PRIVATE, Modifier.FINAL)
        .addField(aClass.details.wrappedClassName, aClass.details.wrappedObjectName, Modifier.FINAL, Modifier.PRIVATE);

    if (aClass.details.hasConstructor) {
      classBuilder.addMethod(buildOnStaticMethodCall(aClass));
    } else {
      for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
        if (Plugin.isStatic(fieldOrMethod)) {
          classBuilder.addMethod(buildOnStaticMethodCall(aClass));
          break;
        }
      }
    }

    classBuilder.addMethod(buildOnMethodCall(aClass));

    if (aClass.details.isReferenced) {
      classBuilder.addMethod(MethodSpec.constructorBuilder()
          .addParameter(Integer.class, "handle")
          .addParameter(aClass.details.wrappedClassName, aClass.details.wrappedObjectName)
          .addStatement("this.handle = handle")
          .addStatement("this.$N = $N", aClass.details.wrappedObjectName, aClass.details.wrappedObjectName)
          .build());
    }

    final JavaFile.Builder builder = JavaFile.builder(
        aClass.details.wrapperClassName.packageName(),
        classBuilder.build());

    return builder.build();
  }

  private MethodSpec buildOnMethodCall(PluginClass aClass) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.PUBLIC)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call")
        .addParameter(PluginClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
      if (!Plugin.isStatic(fieldOrMethod)) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("$N(call, result)", Plugin.name(fieldOrMethod))
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

  private MethodSpec buildOnStaticMethodCall(PluginClass aClass) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onStaticMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.STATIC, Modifier.PUBLIC)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call")
        .addParameter(PluginClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    final ParameterWriter writer = new ParameterWriter();
    for (PluginConstructor constructor : aClass.constructors) {

      final String allParameterTypesString = String.join(",", constructor.getAllParameterTypes());
      final String allParameterNamesString = String.join(", ", constructor.getAllParameterNames());

      builder.addCode("case \"$N(" + allParameterTypesString + ")\":\n", aClass.name)
          .addCode(CodeBlock.builder().indent().build())
          .addStatement("final $T handle = call.argument($S)", Integer.class, aClass.details.wrappedObjectName + "Handle")
          .addStatement(writer.write(constructor.getAllParameters()))
          .addStatement("final $T handler = $T(handle, " + allParameterNamesString + ")", aClass.details.wrapperClassName, aClass.details.wrapperClassName)
          .addStatement("$T.addHandler(handle, handler)", mainPluginClassName)
          .addStatement("break")
          .addCode(CodeBlock.builder().unindent().build());
    }

    for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
      if (Plugin.isStatic(fieldOrMethod)) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("$N(call, result)", Plugin.name(fieldOrMethod))
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
