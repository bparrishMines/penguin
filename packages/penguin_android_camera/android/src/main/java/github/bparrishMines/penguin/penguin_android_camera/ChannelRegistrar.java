package github.bparrishMines.penguin.penguin_android_camera;

import androidx.annotation.NonNull;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class ChannelRegistrar extends CameraChannelLibrary.$ChannelRegistrar {
  public ChannelRegistrar(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  public static class LibraryImplementations implements CameraChannelLibrary.$LibraryImplementations {
    private final CameraInfoChannel cameraInfoChannel;
    private final CameraInfoHandler cameraInfoHandler;
    private final CameraChannel cameraChannel;
    private final CameraHandler cameraHandler;
    private final MediaRecorderChannel mediaRecorderChannel;
    private final MediaRecorderHandler mediaRecorderHandler;
    private final PictureCallbackChannel pictureCallbackChannel;
    private final PictureCallbackHandler pictureCallbackHandler;
    private final ShutterCallbackChannel shutterCallbackChannel;
    private final ShutterCallbackHandler shutterCallbackHandler;

    public LibraryImplementations(TypeChannelMessenger messenger, TextureRegistry textureRegistry) {
      cameraInfoChannel = new CameraInfoChannel(messenger);
      cameraInfoHandler = new CameraInfoHandler();
      cameraChannel = new CameraChannel(messenger);
      cameraHandler = new CameraHandler(this, textureRegistry);
      mediaRecorderChannel = new MediaRecorderChannel(messenger);
      mediaRecorderHandler = new MediaRecorderHandler();
      pictureCallbackChannel = new PictureCallbackChannel(messenger);
      pictureCallbackHandler = new PictureCallbackHandler(this);
      shutterCallbackChannel = new ShutterCallbackChannel(messenger);
      shutterCallbackHandler = new ShutterCallbackHandler(this);
    }

    @Override
    public CameraChannelLibrary.$CameraChannel getCameraChannel() {
      return cameraChannel;
    }

    @Override
    public CameraChannelLibrary.$ShutterCallbackChannel getShutterCallbackChannel() {
      return shutterCallbackChannel;
    }

    @Override
    public CameraChannelLibrary.$PictureCallbackChannel getPictureCallbackChannel() {
      return pictureCallbackChannel;
    }

    @Override
    public CameraChannelLibrary.$CameraInfoChannel getCameraInfoChannel() {
      return cameraInfoChannel;
    }

    @Override
    public CameraChannelLibrary.$MediaRecorderChannel getMediaRecorderChannel() {
      return mediaRecorderChannel;
    }

    @Override
    public CameraChannelLibrary.$CameraHandler getCameraHandler() {
      return cameraHandler;
    }

    @Override
    public CameraChannelLibrary.$ShutterCallbackHandler getShutterCallbackHandler() {
      return shutterCallbackHandler;
    }

    @Override
    public CameraChannelLibrary.$PictureCallbackHandler getPictureCallbackHandler() {
      return pictureCallbackHandler;
    }

    @Override
    public CameraChannelLibrary.$CameraInfoHandler getCameraInfoHandler() {
      return cameraInfoHandler;
    }

    @Override
    public CameraChannelLibrary.$MediaRecorderHandler getMediaRecorderHandler() {
      return mediaRecorderHandler;
    }
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
    public final LibraryImplementations libraryImplementations;
    public final TextureRegistry textureRegistry;

    public CameraHandler(LibraryImplementations libraryImplementations, TextureRegistry textureRegistry) {
      this.libraryImplementations = libraryImplementations;
      this.textureRegistry = textureRegistry;
    }

    @Override
    public Object $onGetAllCameraInfo(TypeChannelMessenger messenger) {
      return CameraProxy.getAllCameraInfo(libraryImplementations);
    }

    @Override
    public Object $onOpen(TypeChannelMessenger messenger, Integer cameraId) {
      return CameraProxy.open(libraryImplementations, textureRegistry, cameraId);
    }
  }

  public static class CameraInfoHandler extends CameraChannelLibrary.$CameraInfoHandler {
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
