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

    @Override
    public CameraChannelLibrary.$ErrorCallbackHandler getErrorCallbackHandler() {
      return new ErrorCallbackHandler(this);
    }

    @Override
    public CameraChannelLibrary.$AutoFocusCallbackHandler getAutoFocusCallbackHandler() {
      return new AutoFocusCallbackHandler(this);
    }

    @Override
    public CameraChannelLibrary.$CameraAreaHandler getCameraAreaHandler() {
      return new CameraAreaHandler(this);
    }

    @Override
    public CameraChannelLibrary.$CameraRectHandler getCameraRectHandler() {
      return new CameraRectHandler(this);
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

  public static class ErrorCallbackHandler extends CameraChannelLibrary.$ErrorCallbackHandler {
    public final LibraryImplementations implementations;

    public ErrorCallbackHandler( LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public ErrorCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$ErrorCallbackCreationArgs args) {
      return new ErrorCallbackProxy(implementations);
    }
  }

  public static class AutoFocusCallbackHandler extends CameraChannelLibrary.$AutoFocusCallbackHandler {
    public final LibraryImplementations implementations;

    public AutoFocusCallbackHandler( LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public AutoFocusCallbackProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$AutoFocusCallbackCreationArgs args) {
      return new AutoFocusCallbackProxy(implementations);
    }
  }

  public static class CameraAreaHandler extends CameraChannelLibrary.$CameraAreaHandler {
    public final LibraryImplementations implementations;

    public CameraAreaHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraAreaProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$CameraAreaCreationArgs args) {
      return new CameraAreaProxy((CameraRectProxy) args.rect, args.weight, implementations);
    }
  }

  public static class CameraRectHandler extends CameraChannelLibrary.$CameraRectHandler {
    public final LibraryImplementations implementations;

    public CameraRectHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraRectProxy onCreate(TypeChannelMessenger messenger, CameraChannelLibrary.$CameraRectCreationArgs args) {
      return new CameraRectProxy(args.left, args.top, args.right, args.bottom, implementations);
    }
  }
}
