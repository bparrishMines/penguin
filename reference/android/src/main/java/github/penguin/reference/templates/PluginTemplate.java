package github.penguin.reference.templates;

import androidx.annotation.NonNull;
import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class PluginTemplate implements FlutterPlugin {
  @SuppressWarnings({"unused", "deprecation"})
  public static void registerWith(Registrar registrar) {
    new PluginTemplate().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    final TypeChannelManager manager = ReferencePlugin.getManagerInstance(binaryMessenger);
    ClassTemplate.setupChannel(manager);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initialize(flutterPluginBinding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
