package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import objects.Plugin;
import objects.PluginClass;
import objects.PluginParameter;

import java.util.ArrayList;
import java.util.List;

abstract class Writer<T, K> {
  final Plugin plugin;

  Writer(Plugin plugin) {
    this.plugin = plugin;
  }

  public abstract K write(T object);

  public final List<K> writeAll(List<T> objects) {
    final ArrayList<K> list = new ArrayList<>();

    for (T object : objects) {
      list.add(write(object));
    }

    return list;
  }

  final PluginClass classFromString(String className) {
    for (PluginClass pluginClass : plugin.classes) {
      if (pluginClass.name.equals(className)) {
        return pluginClass;
      }
    }

    return null;
  }

  CodeBlock extractParametersFromMethodCall(List<PluginParameter> parameters, ClassName mainPluginClassName) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginParameter parameter : parameters) {
      final PluginClass pluginClass = classFromString(parameter.type);

      if (pluginClass != null) {
        final String handleName = parameter.name.toLowerCase() + "Handle";
        builder.addStatement("final $T $N = call.argument($S)", Integer.class, pluginClass.details.wrappedObjectName + "Handle", handleName)
            .addStatement("final $T $N = ($T) $T.getHandler($N)",
                pluginClass.details.wrapperClassName,
                pluginClass.details.wrapperClassName.simpleName().toLowerCase(),
                pluginClass.details.wrapperClassName,
                mainPluginClassName,
                handleName)
            .addStatement("final $T $N = $N.$N",
                pluginClass.details.wrappedClassName,
                parameter.name,
                pluginClass.details.wrapperClassName.simpleName().toLowerCase(),
                pluginClass.details.wrappedObjectName);
      } else {
        final ClassName className = bestGuess(parameter.type);
        builder.addStatement("final $T $N = call.argument($S)", className, parameter.name, parameter.name);
      }
    }

    return builder.build();
  }

  ClassName bestGuess(String classNameString) {
    switch (classNameString) {
      case "int":
        return ClassName.bestGuess("Integer");
      case "bool":
        return ClassName.bestGuess("Boolean");
      case "double":
        return ClassName.bestGuess("Double");
    }

    return ClassName.bestGuess(classNameString);
  }
}
