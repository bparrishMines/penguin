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
    final TypeChannelMessenger manager = ReferencePlugin.getMessengerInstance(binaryMessenger);

    final TextureRegistry textureRegistry = flutterPluginBinding.getTextureRegistry();

    Camera.setupChannel(manager, textureRegistry);
    CameraInfo.setupChannel(manager);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
