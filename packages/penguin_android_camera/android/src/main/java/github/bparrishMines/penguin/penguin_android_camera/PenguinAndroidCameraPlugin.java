package github.bparrishMines.penguin.penguin_android_camera;

import androidx.annotation.NonNull;
import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;

/** PenguinAndroidCameraPlugin */
public class PenguinAndroidCameraPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final BinaryMessenger binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);

    final TextureRegistry textureRegistry = flutterPluginBinding.getTextureRegistry();

    Channels.setupCameraChannel(messenger, textureRegistry);
    Channels.setupCameraInfoChannel(messenger);
    Channels.setupShutterCallbackChannel(messenger);
    Channels.setupPictureCallbackChannel(messenger);
    Channels.setupMediaRecorderChannel(messenger);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
