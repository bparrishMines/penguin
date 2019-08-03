package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
import objects.*;

import javax.lang.model.element.Modifier;

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

    final PluginClass returnClass = classFromString(Plugin.returnType(fieldOrMethod));
    if ((fieldOrMethod instanceof PluginMethod && ((PluginMethod) fieldOrMethod).getAllParameterNames().size() > 0) ||
        returnClass != null) {
      builder.addParameter(PluginClassNames.METHOD_CALL.name, "call", Modifier.FINAL);
    }

    builder.addParameter(PluginClassNames.RESULT.name, "result", Modifier.FINAL);

    final Boolean isStatic = Plugin.isStatic(fieldOrMethod);
    final String name = Plugin.name(fieldOrMethod);
    final String returnType = Plugin.returnType(fieldOrMethod);

    if (isStatic) builder.addModifiers(Modifier.STATIC);

    final String callString;
    if (fieldOrMethod instanceof PluginMethod) {
      final PluginMethod method = (PluginMethod) fieldOrMethod;
      final String allParameterNamesString = String.join(", ", method.getAllParameterNames());
      callString = "$N.$N(" + allParameterNamesString + ")";

      if (method.getAllParameters().size() > 0) {
        builder.addCode(extractParametersFromMethodCall(method.getAllParameters(), mainPluginClassName));
      }
    } else {
      callString = "$N.$N";
    }

    final String callerName = isStatic ? pluginClass.details.wrappedClassName.simpleName() : pluginClass.details.wrappedObjectName;

    if (returnType.equals("void") || returnType.equals("Object")) {
      builder.addStatement(callString, callerName, name);
      builder.addStatement("result.success(null)");
    } else {
      if (returnClass == null) {
        builder.addStatement("final $T value = " + callString, bestGuess(returnType), callerName, name)
            .addStatement("result.success(value)");
      } else {
        builder.addStatement("final $T handle = call.argument($S)", Integer.class, returnClass.details.wrappedObjectName + "Handle")
            .addStatement("final $T value = " + callString, returnClass.details.wrappedClassName, callerName, name)
            .addStatement("final $T handler = new $T(handle, value)", returnClass.details.wrapperClassName, returnClass.details.wrapperClassName)
            .addStatement("$T.addHandler(handle, handler)", mainPluginClassName)
            .addStatement("result.success(null)");
      }
    }

    return builder.build();
  }
}
