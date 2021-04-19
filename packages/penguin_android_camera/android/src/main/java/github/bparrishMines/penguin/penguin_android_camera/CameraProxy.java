package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

import io.flutter.view.TextureRegistry;

public class CameraProxy implements CameraChannelLibrary.$Camera {
  public final Camera camera;
  public final TextureRegistry textureRegistry;
  public final ChannelRegistrar.LibraryImplementations implementations;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public CameraProxy(Camera camera, TextureRegistry textureRegistry, ChannelRegistrar.LibraryImplementations implementations) {
    this.camera = camera;
    this.textureRegistry = textureRegistry;
    this.implementations = implementations;
    implementations.getCameraChannel().createNewInstancePair(this, false);
  }

  public static CameraProxy open(ChannelRegistrar.LibraryImplementations implementations, TextureRegistry textureRegistry, int cameraId) {
    return new CameraProxy(Camera.open(cameraId), textureRegistry, implementations);
  }

  public static List<CameraInfoProxy> getAllCameraInfo(ChannelRegistrar.LibraryImplementations libraryImplementations) {
    final List<CameraInfoProxy> allCameraInfoProxy = new ArrayList<>();

    int numOfCameras = Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final Camera.CameraInfo info = new Camera.CameraInfo();
      Camera.getCameraInfo(i, info);
      allCameraInfoProxy.add(new CameraInfoProxy(info, libraryImplementations, i));
    }

    return allCameraInfoProxy;
  }

  @Override
  public Void release() {
    camera.release();
    return null;
  }

  @Override
  public Void startPreview() {
    camera.startPreview();
    return null;
  }

  @Override
  public Void stopPreview() {
    camera.stopPreview();
    return null;
  }

  @Override
  public Void takePicture(CameraChannelLibrary.$ShutterCallback shutter,
                          CameraChannelLibrary.$PictureCallback raw,
                          CameraChannelLibrary.$PictureCallback postView,
                          CameraChannelLibrary.$PictureCallback jpeg) {
    takePicture((ShutterCallbackProxy) shutter, (PictureCallbackProxy) raw, (PictureCallbackProxy) postView, (PictureCallbackProxy) jpeg);
    return null;
  }

  @Override
  public Void autoFocus(CameraChannelLibrary.$AutoFocusCallback callback) {
    camera.autoFocus((AutoFocusCallbackProxy) callback);
    return null;
  }

  @Override
  public Void cancelAutoFocus() {
    camera.cancelAutoFocus();
    return null;
  }

  @Override
  public Void setDisplayOrientation(Integer degrees) {
    camera.setDisplayOrientation(degrees);
    return null;
  }

  @Override
  public Void setErrorCallback(CameraChannelLibrary.$ErrorCallback callback) {
    camera.setErrorCallback((ErrorCallbackProxy) callback);
    return null;
  }

  @Override
  public Void startSmoothZoom(Integer value) {
    camera.startSmoothZoom(value);
    return null;
  }

  @Override
  public Void stopSmoothZoom() {
    camera.stopSmoothZoom();
    return null;
  }

  @Override
  public CameraParametersProxy getParameters() {
    return new CameraParametersProxy(camera.getParameters(), implementations);
  }

  @Override
  public Void setParameters(CameraChannelLibrary.$CameraParameters parameters) {
    camera.setParameters(((CameraParametersProxy) parameters).cameraParameters);
    return null;
  }

  private Void takePicture(ShutterCallbackProxy shutter,
                           PictureCallbackProxy raw,
                           PictureCallbackProxy postView,
                           PictureCallbackProxy jpeg) {
    camera.takePicture(shutter != null ? shutter.shutterCallback : null,
        raw != null ? raw.pictureCallback : null,
        postView != null ? postView.pictureCallback : null,
        jpeg != null ? jpeg.pictureCallback : null);
    return null;
  }

  @Override
  public Long attachPreviewTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = textureRegistry.createSurfaceTexture();
    camera.setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  @Override
  public Void releasePreviewTexture() throws Exception {
    if (currentTextureEntry == null) return null;
    camera.setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }

  @Override
  public Void unlock() {
    camera.unlock();
    return null;
  }
}
