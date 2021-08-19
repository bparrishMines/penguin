package dev.penguin.android_hardware;

import androidx.annotation.NonNull;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;

/** AndroidHardwarePlugin */
public class AndroidHardwarePlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final BinaryMessenger binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);

    final TextureRegistry textureRegistry = flutterPluginBinding.getTextureRegistry();
    final LibraryImplementations channelRegistrar = new LibraryImplementations(new LibraryImplementations.LibraryImplementations(messenger, textureRegistry));
    channelRegistrar.registerHandlers();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
