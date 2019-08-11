package creator;

import com.squareup.javapoet.*;
import objects.*;
import utils.StringUtils;
import writers.ClassWriter;
import writers.CommonClassNames;

import javax.lang.model.element.Modifier;
import java.util.*;

public class PluginCreator {
  static private final String CLASS_PREFIX = "Flutter";

  private final Plugin plugin;
  private final String packageName;
  private final ClassName mainPluginClassName;
  private final ClassName flutterWrapperClassName;
  private final ClassName notImplementedClassName;

  public PluginCreator(Plugin plugin) {
    this.plugin = plugin;
    this.packageName = plugin.organization + "." + plugin.name;
    this.mainPluginClassName = ClassName.get(packageName, StringUtils.snakeCaseToCamelCase(plugin.name) + "Plugin");
    this.flutterWrapperClassName = ClassName.get(packageName, "FlutterWrapper");
    this.notImplementedClassName = ClassName.get(packageName, "FlutterWrapper","MethodNotImplemented");

    setupClassDetails();
  }

  private void setupClassDetails() {
    final Set<String> allClassNames = new HashSet<>();
    for (PluginClass theClass : plugin.classes) {
      allClassNames.add(theClass.name);
    }

    final Set<String> referencedClasses = new HashSet<>();
    final Set<String> initializedFields = new HashSet<>();
    for (PluginClass theClass : plugin.classes) {
      for (Object fieldOrMethod : theClass.getFieldsAndMethods()) {
        final String returnType = Plugin.returnType(fieldOrMethod);
        if (!allClassNames.contains(Plugin.returnType(fieldOrMethod))) continue;

        if (!Plugin.mutable(fieldOrMethod)) {
          referencedClasses.add(returnType);
        }

        if (Plugin.initialized(fieldOrMethod)) {
          initializedFields.add(returnType);
        }
      }
    }

    for (PluginClass theClass : plugin.classes) {
      theClass.details = new ClassDetails(
          !theClass.constructors.isEmpty(),
          referencedClasses.contains(theClass.name),
          ClassName.get(theClass.java_package, theClass.name),
          ClassName.get(packageName, CLASS_PREFIX + theClass.name),
          theClass.name.toLowerCase(),
          theClass.getFieldsAndMethods().stream().anyMatch(Plugin::initialized),
          initializedFields.contains(theClass.name));
    }
  }

  public Map<String, String> filesAndStrings() {
    final ClassWriter writer = new ClassWriter(plugin, mainPluginClassName, flutterWrapperClassName, notImplementedClassName);
    final List<JavaFile> files = writer.writeAll(plugin.classes);

    final Map<String, String> filesAndStrings = new HashMap<>();
    for (int i = 0; i < files.size(); i++) {
      final String filename = plugin.classes.get(i).details.wrapperClassName.simpleName() + ".java";
      filesAndStrings.put(filename, files.get(i).toString());
    }

    filesAndStrings.put(mainPluginClassName.simpleName() + ".java", pluginFileString());
    filesAndStrings.put(flutterWrapperClassName.simpleName() + ".java", flutterWrapperFile());

    return filesAndStrings;
  }

  private String pluginFileString() {
    final TypeSpec.Builder classBuilder = TypeSpec.classBuilder(mainPluginClassName.simpleName())
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .addSuperinterface(CommonClassNames.METHOD_CALL_HANDLER.name)
        .addSuperinterface(flutterWrapperClassName)
        .addField(FieldSpec.builder(String.class, "CHANNEL_NAME")
            .addModifiers(Modifier.PRIVATE, Modifier.FINAL, Modifier.STATIC)
            .initializer("$S", plugin.organization + "/" + plugin.name)
            .build())
        .addField(buildWrapperHashMap("wrappers"))
        .addField(buildWrapperHashMap("invokerWrappers"))
        .addField(CommonClassNames.REGISTRAR.name, "registrar", Modifier.PRIVATE, Modifier.STATIC)
        .addField(CommonClassNames.METHOD_CHANNEL.name, "channel", Modifier.PRIVATE, Modifier.STATIC)
        .addMethod(MethodSpec.methodBuilder("registerWith")
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .addParameter(CommonClassNames.REGISTRAR.name, "registrar")
            .addStatement("$T.registrar = registrar", ClassName.get(packageName, mainPluginClassName.simpleName()))
            .addStatement("channel = new $T(registrar.messenger(), CHANNEL_NAME)", CommonClassNames.METHOD_CHANNEL.name)
            .addStatement("channel.setMethodCallHandler(new $T())", ClassName.get(packageName, mainPluginClassName.simpleName()))
            .build())
        .addMethod(buildAddWrapperMethod("addWrapper", "wrappers"))
        .addMethod(buildAddWrapperMethod("addInvokerWrapper", "invokerWrappers"))
        .addMethod(MethodSpec.methodBuilder("removeWrapper")
            .addModifiers(Modifier.STATIC)
            .addParameter(String.class, "handle")
            .addStatement("wrappers.remove(handle)")
            .build())
        .addMethod(MethodSpec.methodBuilder("allocated")
            .addModifiers(Modifier.STATIC)
            .returns(Boolean.class)
            .addParameter(String.class, "handle", Modifier.FINAL)
            .addStatement("return wrappers.containsKey(handle)")
            .build())
        .addMethod(MethodSpec.methodBuilder("getWrapper")
            .addModifiers(Modifier.STATIC)
            .returns(flutterWrapperClassName)
            .addParameter(String.class, "handle")
            .addStatement("final $T wrapper = wrappers.get(handle)", flutterWrapperClassName)
            .addStatement("if (wrapper != null) return wrapper")
            .addStatement("return invokerWrappers.get(handle)")
            .build())
        .addMethod(MethodSpec.methodBuilder("onMethodCall")
            .addAnnotation(Override.class)
            .addModifiers(Modifier.PUBLIC)
            .addParameter(CommonClassNames.METHOD_CALL.name, "call")
            .addParameter(CommonClassNames.RESULT.name, "result")
            .addStatement("invokerWrappers.clear()")
            .addStatement("final $T value = onMethodCall(call)", Object.class)
            .beginControlFlow("if (value instanceof $T)", notImplementedClassName)
            .addStatement("result.notImplemented()")
            .addStatement("return")
            .endControlFlow()
            .addStatement("result.success(value)")
            .addStatement("invokerWrappers.clear()")
            .build())
        .addMethod(buildOnMethodCall());

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build().toString();
  }

  private MethodSpec buildOnMethodCall() {
    final MethodSpec.Builder builder = MethodSpec.methodBuilder("onMethodCall")
        .addAnnotation(Override.class)
        .addModifiers(Modifier.PUBLIC)
        .addParameter(CommonClassNames.METHOD_CALL.name, "call")
        .returns(Object.class)
        .beginControlFlow("switch(call.method)")
        .addCode("case $S:\n", "Invoke")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("$T value = null", Object.class)
        .addStatement("final $T<$T<$T, $T>> allMethodCallData = ($T<$T<$T, $T>>) call.arguments",
            CommonClassNames.ARRAY_LIST.name,
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class,
            CommonClassNames.ARRAY_LIST.name,
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class)
        .beginControlFlow("for($T<$T, $T> methodCallData : allMethodCallData)",
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class)
        .addStatement("final $T method = ($T) methodCallData.get($S);", String.class, String.class, "method")
        .addStatement("final $T<$T, $T> arguments = ($T<$T, $T>) methodCallData.get($S)",
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class,
            CommonClassNames.HASH_MAP.name,
            String.class,
            Object.class,
            "arguments")
        .addStatement("final $T methodCall = new $T(method, arguments)",
            CommonClassNames.METHOD_CALL.name,
            CommonClassNames.METHOD_CALL.name)
        .addStatement("value = onMethodCall(methodCall)")
        .beginControlFlow("if (value instanceof $T)", notImplementedClassName)
        .addStatement("return new $T()", notImplementedClassName)
        .endControlFlow()
        .endControlFlow()
        .addStatement("return value")
        .addCode(CodeBlock.builder().unindent().build());


    for (PluginClass aClass : plugin.classes) {
      for (PluginConstructor constructor : aClass.constructors) {
        final String allParametersString = String.join(",", constructor.getAllParameterTypes());

        builder.addCode("case \"$N(" + allParametersString + ")\":\n", aClass.name)
            .addCode(CodeBlock.builder().indent().build())
            .addStatement("return $T.onStaticMethodCall(call)", aClass.details.wrapperClassName)
            .addCode(CodeBlock.builder().unindent().build());
      }

      for (Object fieldOrMethod : aClass.getFieldsAndMethods()) {
        if (Plugin.isStatic(fieldOrMethod)) {
          builder.addCode("case \"$N#$N\":\n", aClass.name, Plugin.name(fieldOrMethod))
              .addCode(CodeBlock.builder().indent().build())
              .addStatement("return $T.onStaticMethodCall(call)", aClass.details.wrapperClassName)
              .addCode(CodeBlock.builder().unindent().build());
        }
      }
    }

    builder.addCode("default:\n")
        .addCode(CodeBlock.builder().indent().build())
        .addStatement("final $T handle = call.argument($S)", String.class, "handle")
        .beginControlFlow("if (handle == null)")
        .addStatement("return new $T()", notImplementedClassName)
        .endControlFlow()
        .addStatement("final $T wrapper = getWrapper(handle)", flutterWrapperClassName)
        .beginControlFlow("if (wrapper == null)")
        .addStatement("return new $T()", notImplementedClassName)
        .endControlFlow()
        .addStatement("return wrapper.onMethodCall(call)")
        .addCode(CodeBlock.builder().unindent().build())
        .endControlFlow();
    return builder.build();
  }

  private FieldSpec buildWrapperHashMap(String name) {
    final ParameterizedTypeName wrapperMap = ParameterizedTypeName.get(
        CommonClassNames.HASH_MAP.name,
        ClassName.bestGuess("String"),
        flutterWrapperClassName);

    return FieldSpec.builder(wrapperMap, name)
        .addModifiers(Modifier.PRIVATE, Modifier.FINAL, Modifier.STATIC)
        .initializer("new $T<>()", CommonClassNames.HASH_MAP.name)
        .build();
  }

  private MethodSpec buildAddWrapperMethod(String name, String wrapperName) {
    return MethodSpec.methodBuilder(name)
        .addModifiers(Modifier.STATIC)
        .addParameter(String.class, "handle", Modifier.FINAL)
        .addParameter(flutterWrapperClassName, "wrapper", Modifier.FINAL)
        .beginControlFlow("if ($N.get(handle) != null)", wrapperName)
        .addStatement("final $T message = $T.format($S, handle)", String.class, String.class, "Object for handle already exists: %s")
        .addStatement("throw new $T(message)", ClassName.get(IllegalArgumentException.class))
        .endControlFlow()
        .addStatement("$N.put(handle, wrapper)", wrapperName)
        .build();
  }

  private String flutterWrapperFile() {
    final TypeSpec.Builder classBuilder = TypeSpec.interfaceBuilder(flutterWrapperClassName)
        .addModifiers(Modifier.PUBLIC)
        .addMethod(MethodSpec.methodBuilder("onMethodCall")
            .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
            .returns(Object.class)
            .addParameter(CommonClassNames.METHOD_CALL.name, "call")
            .build())
        .addType(TypeSpec.classBuilder(notImplementedClassName)
            .addModifiers(Modifier.PUBLIC, Modifier.STATIC)
            .build());

    final JavaFile.Builder builder = JavaFile.builder(packageName, classBuilder.build());

    return builder.build().toString();
  }
}
