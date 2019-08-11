package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;
import objects.*;

import javax.lang.model.element.Modifier;
import java.util.ArrayList;
import java.util.List;

public class MethodWriter extends Writer<Object, MethodSpec> {
  private final ClassName mainPluginClassName;
  private final PluginClass pluginClass;

  MethodWriter(Plugin plugin, PluginClass pluginClass, ClassName mainPluginClassName) {
    super(plugin);
    this.mainPluginClassName = mainPluginClassName;
    this.pluginClass = pluginClass;
  }

  @Override
  public MethodSpec write(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    final Boolean isStatic = Plugin.isStatic(fieldOrMethod);
    final String name = Plugin.name(fieldOrMethod);
    final String returnType = Plugin.returnType(fieldOrMethod);
    final PluginClass returnClass = classFromString(returnType);

    final MethodSpec.Builder builder = MethodSpec.methodBuilder(Plugin.name(fieldOrMethod))
        .addModifiers(Modifier.PRIVATE)
        .returns(Object.class);

    if (isStatic) builder.addModifiers(Modifier.STATIC);
    if (methodCallHasArguments(fieldOrMethod)) {
      builder.addParameter(CommonClassNames.METHOD_CALL.name, "call", Modifier.FINAL);
    }

    builder.addCode(extractMethodCallArguments(fieldOrMethod));

    final String callString;
    if (fieldOrMethod instanceof PluginMethod) {
      final String allParameterNamesString = String.join(", ", Plugin.method(fieldOrMethod).getAllParameterNames());
      callString = "$N.$N(" + allParameterNamesString + ")";
    } else {
      callString = "$N.$N";
    }

    final String callerName = isStatic ? pluginClass.details.className.simpleName() : pluginClass.details.variableName;

    final CodeBlock openerCode;
    if (Plugin.allocator(fieldOrMethod)) {
      openerCode = CodeBlock.builder()
          .beginControlFlow("if (!$T.allocated(handle))", mainPluginClassName)
          .addStatement("$T.addWrapper(handle, this)", mainPluginClassName)
          .endControlFlow()
          .build();
    } else {
      openerCode = CodeBlock.builder().build();
    }

    if (returnClass != null && (fieldOrMethod instanceof PluginMethod || !Plugin.mutable(fieldOrMethod))) {
      builder.addStatement("final $T handle = call.argument($S)", String.class, "__createdObjectHandle");
      builder.addStatement("final $T value = " + callString, returnClass.details.className, callerName, name).build();
    }

    if (Plugin.mutable(fieldOrMethod)) {
      builder.addStatement(callString + " = $N", callerName, name, Plugin.name(fieldOrMethod))
          .addCode(openerCode)
          .addStatement("return null");
    } else if (returnType.equals("void") || returnType.equals("Object")) {
      builder.addStatement(callString, callerName, name)
          .addCode(openerCode)
          .addStatement("return null");
    } else if (returnClass == null) {
      builder.addStatement("final $T value = " + callString, bestGuess(returnType), callerName, name)
          .addCode(openerCode)
          .addStatement("return value");
    } else if (!returnClass.details.hasInitializedFields) {
      builder.addStatement("new $T(handle, value)", returnClass.details.wrapperClassName)
          .addCode(openerCode)
          .addStatement("return null");
    } else {
      builder.addStatement("final $T wrapper = new $T(handle, value)",
          returnClass.details.wrapperClassName,
          returnClass.details.wrapperClassName)
          .addCode(openerCode)
          .addStatement("return wrapper.serializeInitializers()");
    }

    return builder.build();
  }

  private CodeBlock extractMethodCallArguments(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    final List<PluginParameter> parameters = Plugin.parameters(fieldOrMethod);

    if (Plugin.mutable(fieldOrMethod)) {
      final PluginParameter valueParam = new PluginParameter();
      valueParam.type = Plugin.returnType(fieldOrMethod);
      valueParam.name = Plugin.name(fieldOrMethod);
      parameters.add(valueParam);
    }

    return extractParametersFromMethodCall(parameters, mainPluginClassName).build();
  }
}
