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

  static void setupShutterCallbackChannel(TypeChannelMessenger messenger) {
    final ShutterCallbackChannel channel = new ShutterCallbackChannel(messenger);
    channel.setHandler(new ShutterCallbackHandler());
  }

  static void setupPictureCallbackChannel(TypeChannelMessenger messenger) {
    final PictureCallbackChannel channel = new PictureCallbackChannel(messenger);
    channel.setHandler(new PictureCallbackHandler());
  }

  static void setupMediaRecorderChannel(TypeChannelMessenger messenger) {
    final MediaRecorderChannel channel = new MediaRecorderChannel(messenger);
    channel.setHandler(new MediaRecorderHandler());
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

  public static class ShutterCallbackChannel extends CameraChannelLibrary.$ShutterCallbackChannel {
    public ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
  }

  public static class PictureCallbackChannel extends CameraChannelLibrary.$PictureCallbackChannel {
    public PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
  }

  public static class MediaRecorderChannel extends CameraChannelLibrary.$MediaRecorderChannel {
    public MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
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
      return CameraProxy.getAllCameraInfo(messenger);
    }

    @Override
    public Object $onOpen(TypeChannelMessenger messenger, Integer cameraId) {
      return CameraProxy.open(messenger, textureRegistry, cameraId);
    }
  }

  public static class CameraInfoHandler extends CameraChannelLibrary.$CameraInfoHandler { }

  public static class ShutterCallbackHandler extends CameraChannelLibrary.$ShutterCallbackHandler {
    @Override
    ShutterCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$ShutterCallbackCreationArgs args) {
      return new ShutterCallbackProxy(messenger);
    }
  }

  public static class PictureCallbackHandler extends CameraChannelLibrary.$PictureCallbackHandler {
    @Override
    PictureCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$PictureCallbackCreationArgs args) {
      return new PictureCallbackProxy(messenger);
    }
  }

  public static class MediaRecorderHandler extends CameraChannelLibrary.$MediaRecorderHandler {
    @Override
    MediaRecorderProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$MediaRecorderCreationArgs args) {
      return new MediaRecorderProxy((CameraProxy) args.camera, args.outputFilePath);
    }
  }
}
