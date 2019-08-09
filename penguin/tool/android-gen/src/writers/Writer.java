package writers;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import objects.*;

import java.util.ArrayList;
import java.util.List;

abstract class Writer<T, K> {
  final Plugin plugin;

  Writer(Plugin plugin) {
    this.plugin = plugin;
  }

  public abstract K write(T object);

  public final List<K> writeAll(Iterable<T> objects) {
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

  final CodeBlock extractParametersFromMethodCall(List<PluginParameter> parameters, ClassName mainPluginClassName) {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginParameter parameter : parameters) {
      final PluginClass parameterClass = classFromString(parameter.type);

      if (parameterClass != null) {
        final String handleName = parameter.name.toLowerCase() + "Handle";
        final String wrapperVarName = parameter.name.toLowerCase() + parameterClass.details.wrapperClassName.simpleName().toLowerCase();
        builder.addStatement("final $T $N = call.argument($S)", String.class, handleName, handleName)
            .addStatement("final $T $N = ($T) $T.getWrapper($N)",
                parameterClass.details.wrapperClassName,
                wrapperVarName,
                parameterClass.details.wrapperClassName,
                mainPluginClassName,
                handleName)
            .addStatement("final $T $N = $N.$N",
                parameterClass.details.className,
                parameter.name,
                wrapperVarName,
                parameterClass.details.variableName);
      } else {
        final ClassName className = bestGuess(parameter.type);
        builder.addStatement("final $T $N = call.argument($S)", className, parameter.name, parameter.name);
      }
    }

    return builder.build();
  }

  final ClassName bestGuess(String classNameString) {
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

  final boolean methodCallHasArguments(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginMethod && !Plugin.method(fieldOrMethod).getAllParameters().isEmpty()) {
      return true;
    } else if (Plugin.mutable(fieldOrMethod)) {
      return true;
    } else {
      final PluginClass returnClass = classFromString(Plugin.returnType(fieldOrMethod));
      return returnClass != null && !returnClass.details.hasInitializedFields;
    }
  }
}
