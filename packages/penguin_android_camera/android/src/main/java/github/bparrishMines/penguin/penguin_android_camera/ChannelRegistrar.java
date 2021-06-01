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
    public CameraHandler getHandlerCamera() {
      return new CameraHandler(this, textureRegistry);
    }

    @Override
    public PictureCallbackHandler getHandlerPictureCallback() {
      return new PictureCallbackHandler(this);
    }

    @Override
    public ShutterCallbackHandler getHandlerShutterCallback() {
      return new ShutterCallbackHandler(this);
    }

    @Override
    public MediaRecorderHandler getHandlerMediaRecorder() {
      return new MediaRecorderHandler();
    }

    @Override
    public ErrorCallbackHandler getHandlerErrorCallback() {
      return new ErrorCallbackHandler(this);
    }

    @Override
    public AutoFocusCallbackHandler getHandlerAutoFocusCallback() {
      return new AutoFocusCallbackHandler(this);
    }

    @Override
    public CameraAreaHandler getHandlerCameraArea() {
      return new CameraAreaHandler(this);
    }

    @Override
    public CameraRectHandler getHandlerCameraRect() {
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
    public List<CameraInfoProxy> $getAllCameraInfo(TypeChannelMessenger messenger) {
      return CameraProxy.getAllCameraInfo(libraryImplementations);
    }

    @Override
    public CameraProxy $open(TypeChannelMessenger messenger, Integer cameraId) {
      return CameraProxy.open(libraryImplementations, textureRegistry, cameraId);
    }
  }

  public static class ShutterCallbackHandler extends CameraChannelLibrary.$ShutterCallbackHandler {
    public final LibraryImplementations libraryImplementations;

    public ShutterCallbackHandler( LibraryImplementations libraryImplementations) {
      this.libraryImplementations = libraryImplementations;
    }

    @Override
    public CameraChannelLibrary.$ShutterCallback $$create(TypeChannelMessenger messenger) throws Exception {
      return new ShutterCallbackProxy(libraryImplementations);
    }
  }

  public static class PictureCallbackHandler extends CameraChannelLibrary.$PictureCallbackHandler {
    public final LibraryImplementations libraryImplementations;

    public PictureCallbackHandler( LibraryImplementations libraryImplementations) {
      this.libraryImplementations = libraryImplementations;
    }

    @Override
    public CameraChannelLibrary.$PictureCallback $$create(TypeChannelMessenger messenger) throws Exception {
      return new PictureCallbackProxy(libraryImplementations);
    }
  }

  public static class MediaRecorderHandler extends CameraChannelLibrary.$MediaRecorderHandler {
    @Override
    public CameraChannelLibrary.$MediaRecorder $$create(TypeChannelMessenger messenger) throws Exception {
      return new MediaRecorderProxy();
    }
  }

  public static class ErrorCallbackHandler extends CameraChannelLibrary.$ErrorCallbackHandler {
    public final LibraryImplementations implementations;

    public ErrorCallbackHandler( LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public ErrorCallbackProxy $$create(TypeChannelMessenger messenger) {
      return new ErrorCallbackProxy(implementations);
    }
  }

  public static class AutoFocusCallbackHandler extends CameraChannelLibrary.$AutoFocusCallbackHandler {
    public final LibraryImplementations implementations;

    public AutoFocusCallbackHandler( LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public AutoFocusCallbackProxy $$create(TypeChannelMessenger messenger) {
      return new AutoFocusCallbackProxy(implementations);
    }
  }

  public static class CameraAreaHandler extends CameraChannelLibrary.$CameraAreaHandler {
    public final LibraryImplementations implementations;

    public CameraAreaHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraAreaProxy $$create(TypeChannelMessenger messenger, CameraChannelLibrary.$CameraRect rect, Integer weight) throws Exception {
      return new CameraAreaProxy((CameraRectProxy) rect, weight, implementations);
    }
  }

  public static class CameraRectHandler extends CameraChannelLibrary.$CameraRectHandler {
    public final LibraryImplementations implementations;

    public CameraRectHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraRectProxy $$create(TypeChannelMessenger messenger, Integer top, Integer bottom, Integer right, Integer left) throws Exception {
      return new CameraRectProxy(left, top, right, bottom, implementations);
    }
  }
}
