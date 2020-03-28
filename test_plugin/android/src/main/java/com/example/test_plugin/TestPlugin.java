package com.example.test_plugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin implements FlutterPlugin {
  private static final String CHANNEL_NAME = "test_plugin";
  private static final GeneratedPlatform PLATFORM = new GeneratedPlatform() {
    @Override
    public TestClass createTestClass(TestClass testClass) {
      return new MyTestClass(testClass);
    }
  };

  public static void registerWith(Registrar registrar) {
    PLATFORM.initializeReferenceMethodChannel(registrar.messenger(), CHANNEL_NAME);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    PLATFORM.initializeReferenceMethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL_NAME);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
