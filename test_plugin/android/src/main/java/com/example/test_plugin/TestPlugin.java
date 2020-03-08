package com.example.test_plugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin implements FlutterPlugin {
  private static final String CHANNEL_NAME = "test_plugin";
  private MethodChannel channel;

  public static void registerWith(Registrar registrar) {
    final TestPluginPlatform platform = new TestPluginPlatform() {
      @Override
      public TestClass createTestClass(TestClass testClass) {
        return new MyTestClass(testClass);
      }
    };
    platform.createMethodChannel(registrar.messenger(), CHANNEL_NAME);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final TestPluginPlatform platform = new TestPluginPlatform() {
      @Override
      public TestClass createTestClass(TestClass testClass) {
        return new MyTestClass(testClass);
      }
    };

    channel = platform.createMethodChannel(flutterPluginBinding.getBinaryMessenger(), CHANNEL_NAME);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
