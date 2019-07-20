package writer;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import objects.Parameter;

public class ParameterWriter extends Writer<Parameter, CodeBlock> {
  @Override
  public CodeBlock write(Parameter parameter) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    final ClassName className = ClassName.bestGuess(parameter.type);

    builder.add("final $T $N = call.argument($S)", className, parameter.name, parameter.name);

    return builder.build();
  }
}
