package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import objects.Plugin;
import objects.PluginParameter;

import java.util.List;

public class ParameterWriter extends Writer<List<PluginParameter>, CodeBlock> {
  ParameterWriter(Plugin plugin) {
    super(plugin);
  }

  @Override
  public CodeBlock write(List<PluginParameter> parameters) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginParameter parameter : parameters) {
      final ClassName className = ClassName.bestGuess(parameter.type);
      builder.add("final $T $N = call.argument($S)", className, parameter.name, parameter.name);
    }

    return builder.build();
  }

  @Override
  public List<CodeBlock> writeAll(List<List<PluginParameter>> objects) {
    throw new UnsupportedOperationException();
  }
}
