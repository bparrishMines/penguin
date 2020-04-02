package com.example.reference;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  // Used only in embedding v2.
  private final ReferenceManager globalReferenceManager = new ReferenceManager();

  public static void registerWith(Registrar registrar) {
    registrar.publish(new ReferenceManager());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    // Do nothing.
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }

  public static boolean attachToGlobalReferenceManager(final PluginRegistry registry, ReferencePlatform platform) {
    final ReferenceManager globalManager = registry.valuePublishedByPlugin(ReferencePlugin.class.getName());
    return attachToGlobalReferenceManager(globalManager, platform);
  }

  public static boolean attachToGlobalReferenceManager(final FlutterEngine engine, ReferencePlatform platform) {
    final ReferencePlugin plugin = (ReferencePlugin) engine.getPlugins().get(ReferencePlugin.class);
    return attachToGlobalReferenceManager(plugin.globalReferenceManager, platform);
  }

  private static boolean attachToGlobalReferenceManager(ReferenceManager globalReferenceManager, ReferencePlatform platform) {
    return platform.methodCallHandler.referenceManager.attachTo(globalReferenceManager);
  }
}
