package github.bparrishMines.penguin.penguin_android_camera;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class ChannelRegistrar extends CameraChannelLibrary.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }

  public static class LibraryImplementations extends CameraChannelLibrary.$LibraryImplementations {
    public final TextureRegistry textureRegistry;
    public LibraryImplementations(TypeChannelMessenger messenger, TextureRegistry textureRegistry) {
      super(messenger);
      this.textureRegistry = textureRegistry;
    }

    @Override
    public CameraHandler getCameraHandler() {
      return new CameraHandler(this, textureRegistry);
    }

    @Override
    public PictureCallbackHandler getPictureCallbackHandler() {
      return new PictureCallbackHandler(this);
    }

    @Override
    public ShutterCallbackHandler getShutterCallbackHandler() {
      return new ShutterCallbackHandler(this);
    }

    @Override
    public MediaRecorderHandler getMediaRecorderHandler() {
      return new MediaRecorderHandler();
    }
  }

  public static class CameraHandler extends CameraChannelLibrary.$CameraHandler {
    public final LibraryImplementations libraryImplementations;
    public final TextureRegistry textureRegistry;

    public CameraHandler(LibraryImplementations libraryImplementations, TextureRegistry textureRegistry) {
      this.libraryImplementations = libraryImplementations;
      this.textureRegistry = textureRegistry;
    }

    @Override
    public List<CameraInfoProxy> $onGetAllCameraInfo(TypeChannelMessenger messenger) {
      return CameraProxy.getAllCameraInfo(libraryImplementations);
    }

    @Override
    public CameraProxy $onOpen(TypeChannelMessenger messenger, Integer cameraId) {
      return CameraProxy.open(libraryImplementations, textureRegistry, cameraId);
    }
  }

  public static class ShutterCallbackHandler extends CameraChannelLibrary.$ShutterCallbackHandler {
    public final LibraryImplementations libraryImplementations;

    public ShutterCallbackHandler( LibraryImplementations libraryImplementations) {
      this.libraryImplementations = libraryImplementations;
    }

    @Override
    public ShutterCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$ShutterCallbackCreationArgs args) {
      return new ShutterCallbackProxy(libraryImplementations);
    }
  }

  public static class PictureCallbackHandler extends CameraChannelLibrary.$PictureCallbackHandler {
    public final LibraryImplementations libraryImplementations;

    public PictureCallbackHandler( LibraryImplementations libraryImplementations) {
      this.libraryImplementations = libraryImplementations;
    }

    @Override
    public PictureCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$PictureCallbackCreationArgs args) {
      return new PictureCallbackProxy(libraryImplementations);
    }
  }

  public static class MediaRecorderHandler extends CameraChannelLibrary.$MediaRecorderHandler {
    @Override
    public MediaRecorderProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$MediaRecorderCreationArgs args) {
      return new MediaRecorderProxy();
    }
  }
}
