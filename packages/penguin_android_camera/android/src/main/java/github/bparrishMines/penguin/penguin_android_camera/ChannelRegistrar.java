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

  public static class CameraParametersHandler extends CameraChannelLibrary.$CameraParametersHandler {
    public final LibraryImplementations implementations;

    public CameraParametersHandler( LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public Object $getAutoExposureLock(CameraChannelLibrary.$CameraParameters $instance) {
      return ((CameraParametersProxy) $instance).getAutoExposureLock();
    }

    @Override
    public Object $getFocusAreas(CameraChannelLibrary.$CameraParameters $instance) {
      return ((CameraParametersProxy) $instance).getFocusAreas();
    }

    @Override
    public Object $getFocusDistances(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getFocusDistances();
    }

    @Override
    public Object $getMaxExposureCompensation(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getMaxExposureCompensation();
    }

    @Override
    public Object $getMaxNumFocusAreas(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getMaxNumFocusAreas();
    }

    @Override
    public Object $getMinExposureCompensation(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getMinExposureCompensation();
    }

    @Override
    public Object $getSupportedFocusModes(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getSupportedFocusModes();
    }

    @Override
    public Object $isAutoExposureLockSupported(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).isAutoExposureLockSupported();
    }

    @Override
    public Object $isZoomSupported(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).isZoomSupported();
    }

    @Override
    public Void $setAutoExposureLock(CameraChannelLibrary.$CameraParameters $instance, Boolean toggle)  {
      ((CameraParametersProxy) $instance).setAutoExposureLock(toggle);
      return null;
    }

    @Override
    public Void $setExposureCompensation(CameraChannelLibrary.$CameraParameters $instance, Integer value)  {
      ((CameraParametersProxy) $instance).setExposureCompensation(value);
      return null;
    }

    @Override
    public Void $setFocusAreas(CameraChannelLibrary.$CameraParameters $instance, List<CameraChannelLibrary.$CameraArea> focusAreas)  {
      ((CameraParametersProxy) $instance).setFocusAreas(focusAreas);
      return null;
    }

    @Override
    public Void $setFocusMode(CameraChannelLibrary.$CameraParameters $instance, String value)  {
      ((CameraParametersProxy) $instance).setFocusMode(value);
      return null;
    }

    @Override
    public Object $getFlashMode(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getFlashMode();
    }

    @Override
    public Object $getMaxZoom(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getMaxZoom();
    }

    @Override
    public Object $getPictureSize(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getPictureSize();
    }

    @Override
    public Object $getPreviewSize(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getPreviewSize();
    }

    @Override
    public Object $getSupportedPreviewSizes(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getSupportedPreviewSizes();
    }

    @Override
    public Object $getSupportedPictureSizes(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getSupportedPictureSizes();
    }

    @Override
    public Object $getSupportedFlashModes(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getSupportedFlashModes();
    }

    @Override
    public Object $getZoom(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getZoom();
    }

    @Override
    public Object $isSmoothZoomSupported(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).isSmoothZoomSupported();
    }

    @Override
    public Void $setFlashMode(CameraChannelLibrary.$CameraParameters $instance, String mode)  {
      ((CameraParametersProxy) $instance).setFlashMode(mode);
      return null;
    }

    @Override
    public Void $setPictureSize(CameraChannelLibrary.$CameraParameters $instance, Integer width, Integer height)  {
      ((CameraParametersProxy) $instance).setPictureSize(width, height);
      return null;
    }

    @Override
    public Object $setRecordingHint(CameraChannelLibrary.$CameraParameters $instance, Boolean hint)  {
      ((CameraParametersProxy) $instance).setRecordingHint(hint);
      return null;
    }

    @Override
    public Object $setRotation(CameraChannelLibrary.$CameraParameters $instance, Integer rotation)  {
      ((CameraParametersProxy) $instance).setRotation(rotation);
      return null;
    }

    @Override
    public Object $setZoom(CameraChannelLibrary.$CameraParameters $instance, Integer value) {
      ((CameraParametersProxy) $instance).setZoom(value);
      return null;
    }

    @Override
    public Object $setPreviewSize(CameraChannelLibrary.$CameraParameters $instance, Integer width, Integer height) {
      ((CameraParametersProxy) $instance).setPreviewSize(width, height);
      return null;
    }

    @Override
    public Object $getExposureCompensation(CameraChannelLibrary.$CameraParameters $instance)  {
      return ((CameraParametersProxy) $instance).getExposureCompensation();
    }

    @Override
    public Object $getExposureCompensationStep(CameraChannelLibrary.$CameraParameters $instance)  {
      throw new UnsupportedOperationException();
    }
  }

  public static class CameraRectHandler extends CameraChannelLibrary.$CameraRectHandler {
    public final LibraryImplementations implementations;

    public CameraRectHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }
  }
}
