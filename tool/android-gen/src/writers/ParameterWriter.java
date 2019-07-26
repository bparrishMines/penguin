package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import objects.PluginParameter;

import java.util.List;

public class ParameterWriter extends Writer<List<PluginParameter>, CodeBlock> {
  /*
  @Override
  public CodeBlock write(PluginParameter parameter) {
    final ClassName className = ClassName.bestGuess(parameter.type);

    return CodeBlock.builder()
        .add("final $T $N = call.argument($S)", className, parameter.name, parameter.name)
        .build();
  }
  */

  @Override
  public CodeBlock write(List<PluginParameter> parameters) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginParameter parameter : parameters) {
      final ClassName className = ClassName.bestGuess(parameter.type);
      builder.add("final $T $N = call.argument($S)", className, parameter.name, parameter.name);
    }

    return builder.build();
  }
}
