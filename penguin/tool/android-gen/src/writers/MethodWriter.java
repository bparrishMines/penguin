package writers;

import com.squareup.javapoet.ClassName;
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

    final MethodSpec.Builder builder = MethodSpec.methodBuilder(Plugin.name(fieldOrMethod))
        .addModifiers(Modifier.PRIVATE)
        .returns(Object.class);

    if (methodCallHasArguments(fieldOrMethod)) {
      builder.addParameter(CommonClassNames.METHOD_CALL.name, "call", Modifier.FINAL);
    }

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
      if (Plugin.mutable(fieldOrMethod)) {
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
          .addStatement("return null");
    } else if (returnType.equals("void") || returnType.equals("Object")) {
      builder.addStatement(callString, callerName, name);
      builder.addStatement("return null");
    } else {
      final PluginClass returnClass = classFromString(Plugin.returnType(fieldOrMethod));
      if (returnClass == null) {
        builder.addStatement("final $T value = " + callString, bestGuess(returnType), callerName, name)
              .addStatement("return value");
      } else {
        builder.addStatement("final $T handle = call.argument($S)", String.class, "__createdObjectHandle");
        builder.addStatement("final $T value = " + callString, returnClass.details.className, callerName, name);

        if (!returnClass.details.hasInitializedFields) {
          builder.addStatement("new $T(handle, value)", returnClass.details.wrapperClassName);
          builder.addStatement("return null");
        } else {
          builder.addStatement("final $T wrapper = new $T(handle, value)",
              returnClass.details.wrapperClassName,
              returnClass.details.wrapperClassName);
          builder.addStatement("return wrapper.serializeInitializers()");
        }
      }
    }

    return builder.build();
  }
}
