package creator;

import com.squareup.javapoet.*;
import objects.*;
import utils.StringUtils;
import writers.ClassWriter;
import writers.PluginClassNames;

import javax.lang.model.element.Modifier;
import java.util.*;

public class PluginCreator {
  static private final String CLASS_PREFIX = "Flutter";

  private final Plugin plugin;
  private final String packageName;
  private final ClassName mainPluginClassName;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;

    final String packageFromChannel = plugin.channel.replace('/', '.');
    this.packageName = packageFromChannel + '.' + plugin.name.replace("_", "");

    this.mainPluginClassName = ClassName.get(packageName, StringUtils.snakeCaseToCamelCase(plugin.name));

    setupClassDetails();
  }

  private void setupClassDetails() {
    final Set<String> allClassNames = new HashSet<>();
    for (PluginClass theClass : plugin.classes) {
      allClassNames.add(theClass.name);
    }

    final Set<String> referencedClasses = new HashSet<>();
    for (PluginClass theClass : plugin.classes) {
      for (Object fieldOrMethod : theClass.getFieldsAndMethods()) {
        final Boolean isStatic = Plugin.isStatic(fieldOrMethod);
        final String returnType = Plugin.returnType(fieldOrMethod);
        if ((isStatic || !theClass.name.equals(returnType)) && allClassNames.contains(returnType)) {
          referencedClasses.add(returnType);
        }
      }
    }

    for (PluginClass theClass : plugin.classes) {
      theClass.details = new ClassDetails(
          !theClass.constructors.isEmpty(),
          referencedClasses.contains(theClass.name),
          ClassName.get(theClass.java_package, theClass.name),
          ClassName.get(packageName, CLASS_PREFIX + theClass.name), theClass.name.toLowerCase());
    }
  }

  public Map<String, String> filesAndStrings() {
    final ClassWriter writer = new ClassWriter(plugin, mainPluginClassName);
    final List<JavaFile> files = writer.writeAll(plugin.classes);

    final Map<String, String> filesAndStrings = new HashMap<>();
    for (int i = 0; i < files.size(); i++) {
      final String filename = plugin.classes.get(i).details.wrapperClassName.simpleName() + ".java";
      filesAndStrings.put(filename, files.get(i).toString());
    }

    filesAndStrings.put(StringUtils.snakeCaseToCamelCase(plugin.name) + ".java", pluginFileString());

    return filesAndStrings;
  }

  private String pluginFileString() {
    final ClassName sparseArray = ClassName.get("android.util", "SparseArray");
    final ParameterizedTypeName handlerArray = ParameterizedTypeName.get(sparseArray, PluginClassNames.METHOD_CALL_HANDLER.name);

    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(mainPluginClassName.simpleName())
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
            .addStatement("$T.registrar = registrar", ClassName.get(packageName, mainPluginClassName.simpleName()))
            .addStatement("channel = new $T(registrar.messenger(), CHANNEL_NAME)", PluginClassNames.METHOD_CHANNEL.name)
            .addStatement("channel.setMethodCallHandler(new $T())", ClassName.get(packageName, mainPluginClassName.simpleName()))
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
        .addMethod(buildOnMethodCall(mainPluginClassName.simpleName()));

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build().toString();
  }

  private MethodSpec buildOnMethodCall(String className) {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.PUBLIC)
        .addParameter(PluginClassNames.METHOD_CALL.name, "call")
        .addParameter(PluginClassNames.RESULT.name, "result")
        .beginControlFlow("switch(call.method)");

    for (PluginClass aClass : plugin.classes) {
      for (PluginConstructor constructor : aClass.constructors) {
        final String allParametersString = String.join(",", constructor.getAllParameterTypes());

        builder.addCode("case \"$N(" + allParametersString + ")\":\n", aClass.name)
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("$T.onStaticMethodCall(call, result)", aClass.details.wrapperClassName)
            .addStatement("break")
            .addCode(CodeBlock.builder().unindent().build());
      }

      for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
        if (Plugin.isStatic(fieldOrMethod)) {
          builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
              .addCode(CodeBlock.builder().indent().build())
              .addStatement("$T.onStaticMethodCall(call, result)", aClass.details.wrapperClassName)
              .addStatement("break")
              .addCode(CodeBlock.builder().unindent().build());
        }
      }
    }

    builder.addCode("default:\n")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("final $T handle = call.argument($S)", Integer.class, "handle")
        .beginControlFlow("if (handle == null)")
        .addStatement("result.notImplemented()")
        .addStatement("return")
        .endControlFlow()
        .addStatement("final $T handler = getHandler(handle)", PluginClassNames.METHOD_CALL_HANDLER.name)
        .beginControlFlow("if (handler == null)")
        .addStatement("result.notImplemented()")
        .addStatement("return")
        .endControlFlow()
        .addStatement("handler.onMethodCall(call, result)")
        .addCode(CodeBlock.builder().unindent().build());

    return builder.endControlFlow().build();
  }
}
