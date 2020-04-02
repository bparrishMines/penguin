package com.example.test_plugin;

import androidx.annotation.NonNull;
import com.example.reference.ReferencePlatform;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin implements FlutterPlugin {
  private static final String CHANNEL_NAME = "test_plugin";
  // Only used in Embedding v2.
  private GeneratedPlatform platform;

  public static void registerWith(Registrar registrar) {
    final TestPlugin plugin = new TestPlugin();
    plugin.platform = new GeneratedPlatform(registrar.messenger(),
        CHANNEL_NAME,
        new GeneratedPlatform.GeneratedReferenceFactory() {
      @Override
      public GeneratedPlatform.TestClass createTestClass(GeneratedPlatform.TestClass testClass) {
        return new MyTestClass(testClass);
      }
    });
    plugin.platform.initialize();
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    platform = new GeneratedPlatform(flutterPluginBinding.getBinaryMessenger(),
        CHANNEL_NAME,
        new GeneratedPlatform.GeneratedReferenceFactory() {
          @Override
          public GeneratedPlatform.TestClass createTestClass(GeneratedPlatform.TestClass testClass) {
            return new MyTestClass(testClass);
          }
        });
    platform.initialize();
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
