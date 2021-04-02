package github.penguin.reference.templates;

import androidx.annotation.NonNull;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

// TODO(bparrishMines) Shouldn't be public. Move code to reference_example
public class PluginTemplate implements FlutterPlugin {
  private void initialize(final BinaryMessenger binaryMessenger) {
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);
    final Channels channels = new Channels(messenger);
    channels.registerHandlers();
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
