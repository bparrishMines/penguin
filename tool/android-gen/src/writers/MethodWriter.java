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
        .addModifiers(Modifier.PRIVATE, Modifier.FINAL)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call", Modifier.FINAL)
        .addParameter(PluginClassNames.RESULT.name, "result", Modifier.FINAL);

    if (fieldOrMethod instanceof PluginMethod) {
      final PluginMethod method = (PluginMethod) fieldOrMethod;
      if (method.getAllParameterNames().size() > 0) {
        builder.addStatement(extractParametersFromMethodCall(method.getAllParameters()));
      }
    }

    final Boolean isStatic = Plugin.isStatic(fieldOrMethod);
    final String name = Plugin.name(fieldOrMethod);
    final String returnType = Plugin.returnType(fieldOrMethod);

    if (isStatic) builder.addModifiers(Modifier.STATIC);

    final String callString;
    if (fieldOrMethod instanceof PluginMethod) {
      final PluginMethod method = (PluginMethod) fieldOrMethod;
      final String allParameterNamesString = String.join(", ", method.getAllParameterNames());
      callString = "$N.$N(" + allParameterNamesString + ")";
    } else {
      callString = "$N.$N";
    }

    final String callerName = isStatic ? pluginClass.details.wrappedClassName.simpleName() : pluginClass.details.wrappedObjectName;

    if (returnType.equals("void") || returnType.equals("Object")) {
      builder.addStatement(callString, callerName, name);
      builder.addStatement("result.success(null)");
    } else {
      final PluginClass returnClass = classFromString(returnType);

      if (returnClass == null) {
        final ClassName returnClassName = ClassName.bestGuess(returnType);
        builder.addStatement("final $T value = " + callString, returnClassName, callerName, name)
            .addStatement("result.success(value)");
      } else {
        builder.addStatement("final $T handle = call.argument($S)", Integer.class, returnClass.details.wrappedObjectName + "Handle")
            .addStatement("final $T value = " + callString, returnClass.details.wrappedClassName, callerName, name)
            .addStatement("final $T handler = $T(handle, value)", returnClass.details.wrapperClassName, returnClass.details.wrapperClassName)
            .addStatement("$T.addHandler(handle, handler)", mainPluginClassName);
      }
    }

    return builder.build();
  }
}
