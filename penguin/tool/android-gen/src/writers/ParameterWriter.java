package writers;

import com.squareup.javapoet.ParameterSpec;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginParameter;

import javax.lang.model.element.Modifier;

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
      return ParameterSpec.builder(pluginClass.details.className, parameter.name, Modifier.FINAL).build();
    }
  }
}
