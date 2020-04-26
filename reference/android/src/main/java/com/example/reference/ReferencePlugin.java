package com.example.reference;

import androidx.annotation.NonNull;
import com.example.reference.templates.GeneratedReferenceManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  public static void registerWith(Registrar registrar) {
    new ReferencePlugin().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new GeneratedReferenceManager(binaryMessenger, "reference_plugin", new GeneratedReferenceManager.GeneratedMessageCodec()) {
      @Override
      public ClassTemplate createClassTemplate(final String referenceId, final int fieldTemplate) {
        return new com.example.reference.templates.ClassTemplate(this, fieldTemplate);
      }
    }.initialize();
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initialize(flutterPluginBinding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }

//  public static boolean attachToGlobalReferenceManager(final PluginRegistry registry, MethodChannelReferencePlatform platform) {
//    final ReferenceManagerOld globalManager = registry.valuePublishedByPlugin(ReferencePlugin.class.getName());
//    return attachToGlobalReferenceManager(globalManager, platform);
//  }
//
//  public static boolean attachToGlobalReferenceManager(final FlutterEngine engine, MethodChannelReferencePlatform platform) {
//    final ReferencePlugin plugin = (ReferencePlugin) engine.getPlugins().get(ReferencePlugin.class);
//    return attachToGlobalReferenceManager(plugin.globalReferenceManagerOld, platform);
//  }
//
//  private static boolean attachToGlobalReferenceManager(ReferenceManagerOld globalReferenceManagerOld, MethodChannelReferencePlatform platform) {
//    final ReferenceManagerOld referenceManagerOld = platform.referenceManagerOld;
//    if (referenceManagerOld instanceof ReferenceManagerOld.ReferenceManagerOldNode) {
//      return ((ReferenceManagerOld.ReferenceManagerOldNode) referenceManagerOld).attachTo(globalReferenceManagerOld);
//    }
//    return false;
//  }
}
