package github.bparrishMines.penguin.penguin_android_camera;

import androidx.annotation.NonNull;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class Channels {
  static void setupCameraChannel(TypeChannelMessenger messenger, TextureRegistry textureRegistry) {
    final CameraChannel channel = new CameraChannel(messenger);
    channel.setHandler(new CameraHandler(textureRegistry));
  }

  static void setupCameraInfoChannel(TypeChannelMessenger messenger) {
    final CameraInfoChannel channel = new CameraInfoChannel(messenger);
    channel.setHandler(new CameraInfoHandler());
  }

  public static class CameraChannel extends CameraChannelLibrary.$CameraChannel {
    public CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
  }

  public static class CameraInfoChannel extends CameraChannelLibrary.$CameraInfoChannel {
    public CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
  }

  public static class CameraHandler extends CameraChannelLibrary.$CameraHandler {
    public final TextureRegistry textureRegistry;

    public CameraHandler(TextureRegistry textureRegistry) {
      this.textureRegistry = textureRegistry;
    }

    @Override
    public Object $onGetAllCameraInfo(TypeChannelMessenger messenger) {
      return Camera.getAllCameraInfo(messenger);
    }

    @Override
    public Object $onOpen(TypeChannelMessenger messenger, Integer cameraId) {
      return Camera.open(messenger, textureRegistry, cameraId);
    }
  }

  public static class CameraInfoHandler extends CameraChannelLibrary.$CameraInfoHandler { }
}
