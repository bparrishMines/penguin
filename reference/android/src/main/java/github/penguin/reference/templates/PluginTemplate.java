package github.penguin.reference.templates;

import androidx.annotation.NonNull;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

// TODO(bparrishMines) Shouldn't be public.
public class PluginTemplate implements FlutterPlugin {
  @SuppressWarnings({"unused", "deprecation"})
  public static void registerWith(Registrar registrar) {
    new PluginTemplate().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);
    ClassTemplate.setupChannel(messenger);
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
