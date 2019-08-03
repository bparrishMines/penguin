package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import com.squareup.javapoet.ParameterSpec;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginParameter;

import javax.lang.model.element.Modifier;
import java.util.List;

public class ParameterWriter extends Writer<PluginParameter, ParameterSpec> {
  ParameterWriter(Plugin plugin) {
    super(plugin);
  }

  @Override
  public ParameterSpec write(PluginParameter parameter) {
    final PluginClass pluginClass = classFromString(parameter.type);

    if (pluginClass == null) {
      return ParameterSpec.builder(bestGuess(parameter.type), parameter.name, Modifier.FINAL).build();
    } else {
      return ParameterSpec.builder(pluginClass.details.wrappedClassName, parameter.name, Modifier.FINAL).build();
    }
  }
}
