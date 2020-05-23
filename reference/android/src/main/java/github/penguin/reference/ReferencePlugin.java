package github.penguin.reference;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  public static void registerWith(Registrar registrar) {
    // This plugin is only provides a library and has no implementation.
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    // This plugin is only provides a library and has no implementation.
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
