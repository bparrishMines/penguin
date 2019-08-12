package writers;

import com.squareup.javapoet.ClassName;

public enum CommonClassNames {
  METHOD_CALL(ClassName.get("io.flutter.plugin.common", "MethodCall")),
  RESULT(ClassName.get("io.flutter.plugin.common.MethodChannel", "Result")),
  METHOD_CALL_HANDLER(ClassName.get("io.flutter.plugin.common.MethodChannel", "MethodCallHandler")),
  REGISTRAR(ClassName.get("io.flutter.plugin.common.PluginRegistry", "Registrar")),
  METHOD_CHANNEL(ClassName.get("io.flutter.plugin.common", "MethodChannel")),
  HASH_MAP(ClassName.get("java.util", "HashMap")),
  ARRAY_LIST(ClassName.get("java.util", "ArrayList")),
  LIST(ClassName.get("java.util", "List")),
  MAP(ClassName.get("java.util", "Map"));

  public final ClassName name;

  CommonClassNames(ClassName name) {
    this.name = name;
  }
}