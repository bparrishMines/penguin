package writers;

import com.squareup.javapoet.*;
import objects.*;
import javax.lang.model.element.Modifier;
import java.util.List;
import java.util.stream.Collectors;

public class ClassWriter extends Writer<PluginClass, JavaFile> {
  private final ClassName mainPluginClassName;

  public ClassWriter(Plugin plugin, ClassName mainPluginClassName) {
    super(plugin);
    this.mainPluginClassName = mainPluginClassName;
  }

  @Override
  public JavaFile write(PluginClass aClass) {
    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(aClass.details.wrapperClassName.simpleName())
        .addModifiers(Modifier.FINAL)
        .addSuperinterface(CommonClassNames.METHOD_CALL_HANDLER.name)
        .addField(String.class, "handle", Modifier.PRIVATE, Modifier.FINAL)
        .addField(aClass.details.className, aClass.details.variableName, Modifier.FINAL, Modifier.PUBLIC);

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

    final MethodWriter methodWriter = new MethodWriter(plugin, aClass, mainPluginClassName);
    final ConstructorWriter constructorWriter = new ConstructorWriter(plugin, aClass, mainPluginClassName);
    classBuilder.addMethod(buildOnMethodCall(aClass))
        .addMethods(constructorWriter.writeAll(aClass.constructors))
        .addMethods(methodWriter.writeAll(aClass.getFieldsAndMethods()
            .stream().filter(fieldOrMethod -> !Plugin.initialized(fieldOrMethod) || Plugin.mutable(fieldOrMethod))
            .collect(Collectors.toList())));

    if (aClass.details.isReferenced) {
      classBuilder.addMethod(MethodSpec.constructorBuilder()
          .addParameter(String.class, "handle")
          .addParameter(aClass.details.className, aClass.details.variableName)
          .addStatement("this.handle = handle")
          .addStatement("this.$N = $N", aClass.details.variableName, aClass.details.variableName)
          .addStatement("$T.addHandler(handle, this)", mainPluginClassName)
          .build());
    }

    if (aClass.details.hasInitializedFields || aClass.details.isInitializedField) {
      classBuilder.addMethod(buildSerializeInitializers(aClass));
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
        .addParameter(CommonClassNames.METHOD_CALL.name, "call")
        .addParameter(CommonClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    final List<Object> fieldsAndMethods = aClass.getFieldsAndMethods()
        .stream().filter(fieldOrMethod -> !Plugin.initialized(fieldOrMethod) || Plugin.mutable(fieldOrMethod))
        .collect(Collectors.toList());
    for (Object fieldOrMethod : fieldsAndMethods) {
      if (!Plugin.isStatic(fieldOrMethod)) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
            .addCode(CodeBlock.builder().indent().build());

        if (methodCallHasArguments(fieldOrMethod)) {
          builder.addStatement("$N(call, result)", Plugin.name(fieldOrMethod));
        } else {
          builder.addStatement("$N(result)", Plugin.name(fieldOrMethod));
        }

        builder.addStatement("break").addCode(CodeBlock.builder().unindent().build());
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
        .addModifiers(Modifier.STATIC)
        .addParameter(CommonClassNames.METHOD_CALL.name, "call")
        .addParameter(CommonClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    for (PluginConstructor constructor : aClass.constructors) {
      final boolean hasParameters = !constructor.getAllParameters().isEmpty();

      final String allParameterTypesString = String.join(",", constructor.getAllParameterTypes());
      String allParameterNamesString = String.join(", ", constructor.getAllParameterNames());
      if (hasParameters) {
        allParameterNamesString = ", " + allParameterNamesString;
      }

      builder.beginControlFlow("case \"$N(" + allParameterTypesString + ")\":", aClass.name)
          .addCode(CodeBlock.builder().indent().build())
          .addStatement("final $T handle = call.argument($S)", String.class, aClass.details.variableName + "Handle");

      if (hasParameters) {
        builder.addCode(extractParametersFromMethodCall(constructor.getAllParameters(), mainPluginClassName));
      }

      builder.addStatement("new $T(handle" + allParameterNamesString + ")",
          aClass.details.wrapperClassName)
          .addStatement("break")
          .endControlFlow()
          .addCode(CodeBlock.builder().unindent().build());
    }

    for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
      if (Plugin.isStatic(fieldOrMethod)) {
        builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
            .addCode(CodeBlock.builder().indent().build());

        if (methodCallHasArguments(fieldOrMethod)) {
          builder.addStatement("$N(call, result)", Plugin.name(fieldOrMethod));
        } else {
          builder.addStatement("$N(result)", Plugin.name(fieldOrMethod));
        }

        builder.addStatement("break").addCode(CodeBlock.builder().unindent().build());
      }
    }

    builder.addCode("default:\n")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("result.notImplemented()")
        .addCode(CodeBlock.builder().unindent().build());

    return builder.endControlFlow().build();
  }

  private MethodSpec buildSerializeInitializers(PluginClass initClass) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("serializeInitializers")
        .returns(CommonClassNames.HASH_MAP.name)
        .addStatement("final $T<$T, $T> initializers = new $T<>()",
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class,
            CommonClassNames.HASH_MAP.name)
        .addStatement("initializers.put($S, handle)", "handle");

    for (Object field : initClass.getFieldsAndMethods().stream().filter(Plugin::initialized).toArray()) {
      final String fieldName = Plugin.name(field);

      final PluginClass typeClass = classFromString(Plugin.returnType(field));

      if (typeClass == null) {
        builder.addStatement("initializers.put($S, $N.$N)", fieldName, initClass.details.variableName, fieldName);
      } else {
        builder.addStatement("final $T $N = new $T($T.getNextHandle(), $N.$N)",
            typeClass.details.wrapperClassName,
            fieldName,
            typeClass.details.wrapperClassName,
            mainPluginClassName,
            initClass.details.variableName,
            fieldName)
            .addStatement("initializers.put($S, $N.serializeInitializers())", fieldName, fieldName);
      }
    }

    builder.addStatement("return initializers");

    return builder.build();
  }
}
