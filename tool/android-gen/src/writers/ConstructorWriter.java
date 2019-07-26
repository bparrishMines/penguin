package writers;

import com.squareup.javapoet.MethodSpec;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginConstructor;

import javax.lang.model.element.Modifier;

public class ConstructorWriter extends Writer<PluginConstructor, MethodSpec> {
  private final ParameterWriter parameterWriter;
  private final PluginClass pluginClass;

  ConstructorWriter(Plugin plugin, PluginClass pluginClass) {
    super(plugin);
    this.parameterWriter = new ParameterWriter(plugin);
    this.pluginClass = pluginClass;
  }

  @Override
  public MethodSpec write(PluginConstructor constructor) {
    final String allParameterNamesString = String.join(", ", constructor.getAllParameterNames());

    return MethodSpec.constructorBuilder()
        .addParameter(Integer.class, "handle", Modifier.FINAL)
        .addParameters(parameterWriter.writeAll(constructor.getAllParameters()))
        .addStatement("this.handle = handle")
        .addStatement("this.$N = $T(" + allParameterNamesString + ")", pluginClass.details.wrappedObjectName, pluginClass.details.wrappedClassName)
        .build();
  }
}
