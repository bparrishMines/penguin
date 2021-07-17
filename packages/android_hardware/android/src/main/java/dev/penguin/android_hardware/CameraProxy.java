package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.os.Build;

import java.io.IOException;
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
    implementations.getChannelCamera().$create$(this, false);
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
  public Void autoFocus(CameraChannelLibrary.$AutoFocusCallback callback) {
    camera.autoFocus((success, camera) -> callback.invoke(success));
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
    camera.setErrorCallback((error, camera) -> callback.invoke(error));
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

  @Override
  public Void setZoomChangeListener(CameraChannelLibrary.$OnZoomChangeListener listener) {
    camera.setZoomChangeListener((zoomValue, stopped, camera) -> listener.invoke(zoomValue, stopped));
    return null;
  }

  @Override
  public Void setAutoFocusMoveCallback(CameraChannelLibrary.$AutoFocusMoveCallback callback) {
    camera.setAutoFocusMoveCallback((start, camera) -> callback.invoke(start));
    return null;
  }

  @Override
  public Void lock() {
    camera.lock();
    return null;
  }

  @Override
  public Boolean enableShutterSound(Boolean enabled) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      //noinspection deprecation
      return camera.enableShutterSound(enabled);
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.JELLY_BEAN_MR1.");
    }
  }

  @Override
  public Void takePicture(CameraChannelLibrary.$ShutterCallback shutter,
                            CameraChannelLibrary.$PictureCallback raw,
                            CameraChannelLibrary.$PictureCallback postView,
                            CameraChannelLibrary.$PictureCallback jpeg) {
    camera.takePicture(() -> {
      if (shutter != null) shutter.invoke();
    },
        raw != null ? ((PictureCallbackProxy)raw).pictureCallback : null,
        postView != null ? ((PictureCallbackProxy)postView).pictureCallback : null,
        jpeg != null ? ((PictureCallbackProxy)jpeg).pictureCallback : null);
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

  @Override
  public Void setOneShotPreviewCallback(CameraChannelLibrary.$PreviewCallback callback) {
    camera.setOneShotPreviewCallback(((PreviewCallbackProxy)callback).previewCallback);
    return null;
  }

  @Override
  public Void setPreviewCallback(CameraChannelLibrary.$PreviewCallback callback) {
    camera.setPreviewCallback(((PreviewCallbackProxy)callback).previewCallback);
    return null;
  }

  @Override
  public Void reconnect() throws IOException {
    camera.reconnect();
    return null;
  }
}
