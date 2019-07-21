package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
import creator.ClassStructure;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginMethod;
import objects.PluginParameter;

import javax.lang.model.element.Modifier;
import java.util.ArrayList;
import java.util.List;

public class MethodWriter extends Writer<PluginMethod, MethodSpec> {
  private final Plugin plugin;
  private final String wrappedObjectName;
  private final String packageName;
  private final ClassName mainPluginClassName;
  private final String classPrefix;

  MethodWriter(
      Plugin plugin,
      String wrappedObjectName,
      String packageName,
      ClassName mainPluginClassName,
      String classPrefix
  ) {
    this.plugin = plugin;
    this.wrappedObjectName = wrappedObjectName;
    this.packageName = packageName;
    this.mainPluginClassName = mainPluginClassName;
    this.classPrefix = classPrefix;
  }

  @Override
  public MethodSpec write(PluginMethod method) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder(method.name)
        .addModifiers(Modifier.PRIVATE, Modifier.FINAL)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call", Modifier.FINAL)
        .addParameter(PluginClassNames.RESULT.name, "result", Modifier.FINAL);

    final ParameterWriter parameterWriter = new ParameterWriter();

    final List<PluginParameter> allParameters = new ArrayList<>();
    allParameters.addAll(method.required_parameters);
    allParameters.addAll(method.optional_parameters);

    final List<String> allParameterNames = new ArrayList<>();
    for (PluginParameter parameter : allParameters) {
      builder.addStatement(parameterWriter.write(parameter));
      allParameterNames.add(parameter.name);
    }

    final String allParametersString = String.join(", ", allParameterNames);
    final String methodCallString = "$N.$N(" + allParametersString + ")";

    if (method.returns.equals("void")) {
      builder.addStatement(methodCallString, wrappedObjectName, method.name);
      builder.addStatement("result.success(null)");
    } else {
      final ClassStructure structure = ClassStructure.tryGetClassStructure(plugin, method.returns);

      if (structure == null) {
        final ClassName returnType = ClassName.bestGuess(method.returns);
        builder.addStatement("final $T value = " + methodCallString, returnType, wrappedObjectName, method.name)
            .addStatement("result.success(value)");
      } else {
        final ClassName handlerName = ClassName.get(packageName,  classPrefix + method.returns);
        final PluginClass pluginClass = ClassStructure.classFromString(plugin, method.returns);
        final ClassName wrappedName = ClassName.get(pluginClass.java_package, pluginClass.name);

        builder.addStatement("final $T handle = call.argument($S)", Integer.class, "handle")
            .addStatement("final $T value = " + methodCallString, wrappedName, wrappedObjectName, method.name)
            .addStatement("final $T handler = $T(handle, value)", handlerName, handlerName)
            .addStatement("$T.addHandler(handle, handler)", mainPluginClassName);
      }
    }

    return builder.build();
  }
}
