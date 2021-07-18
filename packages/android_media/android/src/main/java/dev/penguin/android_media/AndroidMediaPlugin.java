package dev.penguin.android_media;

import androidx.annotation.NonNull;
import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

/** AndroidMediaPlugin */
public class AndroidMediaPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final BinaryMessenger binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);

    final ChannelRegistrar channelRegistrar = new ChannelRegistrar(new ChannelRegistrar.LibraryImplementations(messenger));
    channelRegistrar.registerHandlers();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
