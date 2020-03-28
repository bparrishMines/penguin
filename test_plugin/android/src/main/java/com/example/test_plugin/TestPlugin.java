package com.example.test_plugin;

import androidx.annotation.NonNull;
import com.example.reference.ReferencePlatform;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin implements FlutterPlugin {
  private static final String CHANNEL_NAME = "test_plugin";
  private final GeneratedPlatform platform = new GeneratedPlatform() {
    @Override
    public TestClass createTestClass(TestClass testClass) {
      return new MyTestClass(testClass);
    }
  };

  public static void registerWith(Registrar registrar) {
    (new TestPlugin()).platform.initializeReferenceMethodChannel(registrar.messenger(), CHANNEL_NAME);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    platform.initializeReferenceMethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL_NAME);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }

  public static ReferencePlatform getPlatform(final FlutterEngine engine) {
    final TestPlugin plugin = (TestPlugin) engine.getPlugins().get(TestPlugin.class);
    if (plugin == null) return null;
    return plugin.platform;
  }
}
