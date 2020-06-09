package github.penguin.reference;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  @SuppressWarnings("unused")
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
}
