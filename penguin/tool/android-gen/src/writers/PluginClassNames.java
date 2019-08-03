package writers;

import com.squareup.javapoet.ClassName;

public enum PluginClassNames {
  METHOD_CALL(ClassName.get("io.flutter.plugin.common", "MethodCall")),
  RESULT(ClassName.get("io.flutter.plugin.common.MethodChannel", "Result")),
  METHOD_CALL_HANDLER(ClassName.get("io.flutter.plugin.common.MethodChannel", "MethodCallHandler")),
  REGISTRAR(ClassName.get("io.flutter.plugin.common.PluginRegistry", "Registrar")),
  METHOD_CHANNEL(ClassName.get("io.flutter.plugin.common", "MethodChannel"));

  public final ClassName name;

  PluginClassNames(ClassName name) {
    this.name = name;
  }
}