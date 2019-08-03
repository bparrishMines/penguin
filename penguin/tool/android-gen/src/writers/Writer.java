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

  static CodeBlock extractParametersFromMethodCall(List<PluginParameter> parameters) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginParameter parameter : parameters) {
      final ClassName className = bestGuess(parameter.type);
      builder.add("final $T $N = call.argument($S)", className, parameter.name, parameter.name);
    }

    return builder.build();
  }

  static ClassName bestGuess(String classNameString) {
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
