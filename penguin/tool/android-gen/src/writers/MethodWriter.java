package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
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

    final MethodSpec.Builder builder = MethodSpec.methodBuilder(Plugin.name(fieldOrMethod))
        .addModifiers(Modifier.PRIVATE);

    if (methodCallHasArguments(fieldOrMethod)) {
      builder.addParameter(PluginClassNames.METHOD_CALL.name, "call", Modifier.FINAL);
    }

    builder.addParameter(PluginClassNames.RESULT.name, "result", Modifier.FINAL);

    final Boolean isStatic = Plugin.isStatic(fieldOrMethod);
    final String name = Plugin.name(fieldOrMethod);
    final String returnType = Plugin.returnType(fieldOrMethod);

    if (isStatic) builder.addModifiers(Modifier.STATIC);

    final String callString;
    if (fieldOrMethod instanceof PluginMethod) {
      final String allParameterNamesString = String.join(", ", Plugin.method(fieldOrMethod).getAllParameterNames());
      callString = "$N.$N(" + allParameterNamesString + ")";

      if (!Plugin.method(fieldOrMethod).getAllParameters().isEmpty()) {
        builder.addCode(extractParametersFromMethodCall(Plugin.method(fieldOrMethod).getAllParameters(), mainPluginClassName));
      }
    } else {
      if (Plugin.field(fieldOrMethod).mutable) {
        final List<PluginParameter> parameters = new ArrayList<>();

        final PluginParameter valueParam = new PluginParameter();
        valueParam.type = Plugin.returnType(fieldOrMethod);
        valueParam.name = Plugin.name(fieldOrMethod);
        parameters.add(valueParam);

        builder.addCode(extractParametersFromMethodCall(parameters, mainPluginClassName));
      }
      callString = "$N.$N";
    }

    final String callerName = isStatic ? pluginClass.details.className.simpleName() : pluginClass.details.variableName;

    if (Plugin.mutable(fieldOrMethod)) {
      builder.addStatement(callString + " = $N", callerName, name, Plugin.name(fieldOrMethod))
          .addStatement("result.success(null)");
    } else if (returnType.equals("void") || returnType.equals("Object")) {
      builder.addStatement(callString, callerName, name);
      builder.addStatement("result.success(null)");
    } else {
      final PluginClass returnClass = classFromString(Plugin.returnType(fieldOrMethod));
      if (returnClass == null) {
        builder.addStatement("final $T value = " + callString, bestGuess(returnType), callerName, name)
              .addStatement("result.success(value)");
      } else {
        builder.addStatement("final $T handle = call.argument($S)", String.class, returnClass.details.variableName + "Handle")
            .addStatement("final $T value = " + callString, returnClass.details.className, callerName, name)
            .addStatement("final $T handler = new $T(handle, value)", returnClass.details.wrapperClassName, returnClass.details.wrapperClassName)
            .addStatement("$T.addHandler(handle, handler)", mainPluginClassName)
            .addStatement("result.success(null)");
      }
    }

    return builder.build();
  }
}
