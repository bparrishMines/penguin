import com.squareup.javapoet.*;
import objects.Plugin;
import objects.PluginClass;
import writer.ClassWriter;
import writer.PluginClassNames;

import javax.lang.model.element.Modifier;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PluginCreator {
  static public final String CLASS_PREFIX = "Flutter";

  private final Plugin plugin;
  private final String packageName;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;

    final String packageFromChannel = plugin.channel.replace('/', '.');
    this.packageName = packageFromChannel + '.' + plugin.name.replace("_", "");
  }

  public Map<String, String> filesAndStrings() {
    final ClassWriter writer = new ClassWriter(plugin.channel, plugin.name, packageName, CLASS_PREFIX);
    final List<JavaFile> files = writer.writeAll(plugin.classes);

    final Map<String, String> filesAndStrings = new HashMap<>();
    for (int i = 0; i < files.size(); i++) {
      final String filename = CLASS_PREFIX + plugin.classes.get(i).name + ".java";
      filesAndStrings.put(filename, files.get(i).toString());
    }

    filesAndStrings.put(snakeCaseToCamelCase(plugin.name) + ".java", pluginFileString());

    return filesAndStrings;
  }

  private String pluginFileString() {
    final String className = snakeCaseToCamelCase(plugin.name);

    final ClassName sparseArray = ClassName.get("android.util", "SparseArray");
    final ParameterizedTypeName handlerArray = ParameterizedTypeName.get(sparseArray, PluginClassNames.METHOD_CALL_HANDLER.name);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(className)
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addField(FieldSpec.builder(String.class, "CHANNEL_NAME")
            .addModifiers(Modifier.FINAL, Modifier.STATIC)
            .initializer("$S", plugin.channel)
            .build())
        .addField(FieldSpec.builder(handlerArray, "handlers")
            .addModifiers(Modifier.FINAL, Modifier.STATIC)
            .initializer("new $T<>()", sparseArray)
            .build())
        .addField(PluginClassNames.REGISTRAR.name, "registrar", Modifier.PRIVATE, Modifier.STATIC)
        .addField(PluginClassNames.METHOD_CHANNEL.name, "channel", Modifier.PRIVATE, Modifier.STATIC)
        .addMethod(MethodSpec.methodBuilder("registerWith")
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .addParameter(PluginClassNames.REGISTRAR.name, "registrar")
            .addStatement("$T.registrar = registrar", ClassName.get(packageName, className))
            .addStatement("channel = new $T(registrar.messenger(), CHANNEL_NAME)", PluginClassNames.METHOD_CHANNEL.name)
            .addStatement("channel.setMethodCallHandler(new $T())", ClassName.get(packageName, className))
            .build())
        .addMethod(MethodSpec.methodBuilder("addHandler")
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .addParameter(Integer.class, "handle", Modifier.FINAL)
            .addParameter(PluginClassNames.METHOD_CALL_HANDLER.name, "handler", Modifier.FINAL)
            .beginControlFlow("if (handlers.get(handle) != null)")
            .addStatement("final $T message = $T.format($S, handle)", String.class, String.class, "Object for handle already exists: %s")
            .addStatement("throw new $T(message)", ClassName.get(IllegalArgumentException.class))
            .endControlFlow()
            .addStatement("handlers.put(handle, handler)")
            .build())
        .addMethod(MethodSpec.methodBuilder("removeHandler")
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .addParameter(Integer.class, "handle")
            .addStatement("handlers.remove(handle)")
            .build())
        .addMethod(MethodSpec.methodBuilder("getHandler")
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .returns(PluginClassNames.METHOD_CALL_HANDLER.name)
            .addParameter(Integer.class, "handle")
            .addStatement("return handlers.get(handle)")
            .build())
        .addMethod(MethodSpec.methodBuilder("onMethodCall")
            .addAnnotation(Override.class)
            .addModifiers(Modifier.PUBLIC)
            .addParameter(PluginClassNames.METHOD_CALL.name, "call")
            .addParameter(PluginClassNames.RESULT.name, "result")
            .beginControlFlow("switch(call.method)")
            .addStatement("case ")
            .endControlFlow()
            .build());

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build().toString();
  }

  private CodeBlock buildConstructorCaseStatments() {
    final CodeBlock.Builder builder = CodeBlock.builder();

    for (PluginClass aClass : plugin.classes) {
      final ClassName name = ClassName.get(packageName, CLASS_PREFIX + plugin.name);

      builder.addStatement("case \"$T\"", name);
      //builder.addStatement("new $T()")
    }

    return builder.build();
  }

  private String snakeCaseToCamelCase(String str) {
    final Matcher matcher = Pattern.compile("([a-z]+)_*").matcher(str);

    final StringBuffer buffer = new StringBuffer();
    while (matcher.find()) {
      final String match = matcher.group(1);
      buffer.append(match.substring(0, 1).toUpperCase());
      buffer.append(match.substring(1));
    }

    return buffer.toString();
  }
}
