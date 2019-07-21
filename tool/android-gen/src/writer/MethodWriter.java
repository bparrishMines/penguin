package writer;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.MethodSpec;
import objects.PluginMethod;
import objects.PluginParameter;

import javax.lang.model.element.Modifier;
import java.util.ArrayList;
import java.util.List;

public class MethodWriter extends Writer<PluginMethod, MethodSpec> {
  static private final String RETURNED_VALUE_NAME = "returnedValue";

  final String wrappedObjectName;

  public MethodWriter(String wrappedObjectName) {
    this.wrappedObjectName = wrappedObjectName;
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
      final ClassName returnType = ClassName.bestGuess(method.returns);
      builder.addStatement("final $T $N = " + methodCallString, returnType, RETURNED_VALUE_NAME, wrappedObjectName, method.name);
      builder.addStatement("result.success($N)", RETURNED_VALUE_NAME);
    }

    return builder.build();
  }
}
