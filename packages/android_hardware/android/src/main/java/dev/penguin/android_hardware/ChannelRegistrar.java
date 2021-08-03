package dev.penguin.android_hardware;

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
    public CameraAreaHandler getHandlerCameraArea() {
      return new CameraAreaHandler(this);
    }

    @Override
    public CameraRectHandler getHandlerCameraRect() {
      return new CameraRectHandler(this);
    }

    @Override
    public ImageFormatHandler getHandlerImageFormat() {
      return new ImageFormatHandler();
    }

    @Override
    public PreviewCallbackHandler getHandlerPreviewCallback() {
      return new PreviewCallbackHandler();
    }

    @Override
    public PictureCallbackHandler getHandlerPictureCallback() {
      return new PictureCallbackHandler();
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

  public static class CameraAreaHandler extends CameraChannelLibrary.$CameraAreaHandler {
    public final LibraryImplementations implementations;

    public CameraAreaHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraAreaProxy $create$(TypeChannelMessenger messenger, CameraChannelLibrary.$CameraRect rect, Integer weight) {
      return new CameraAreaProxy((CameraRectProxy) rect, weight, implementations, false);
    }
  }

  public static class CameraRectHandler extends CameraChannelLibrary.$CameraRectHandler {
    public final LibraryImplementations implementations;

    public CameraRectHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CameraRectProxy $create$(TypeChannelMessenger messenger, Integer top, Integer bottom, Integer right, Integer left) {
      return new CameraRectProxy(left, top, right, bottom, implementations);
    }
  }

  public static class ImageFormatHandler extends CameraChannelLibrary.$ImageFormatHandler {
    @Override
    public Integer $getBitsPerPixel(TypeChannelMessenger messenger, Integer format) {
      return ImageFormatProxy.getBitsPerPixel(format);
    }
  }

  public static class PictureCallbackHandler extends CameraChannelLibrary.$PictureCallbackHandler {
    @Override
    public PictureCallbackProxy $create$(TypeChannelMessenger messenger, CameraChannelLibrary.$DataCallback onPictureTaken) {
      return new PictureCallbackProxy(onPictureTaken);
    }
  }

  public static class PreviewCallbackHandler extends CameraChannelLibrary.$PreviewCallbackHandler {
    @Override
    public PreviewCallbackProxy $create$(TypeChannelMessenger messenger, CameraChannelLibrary.$DataCallback onPreviewFrame) {
      return new PreviewCallbackProxy(onPreviewFrame);
    }
  }
}
