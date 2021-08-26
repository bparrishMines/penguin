package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.os.Build;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.view.TextureRegistry;

public class CameraProxy {
  public final LibraryImplementations implementations;
  public final Camera camera;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public CameraProxy(CameraChannelLibrary.$LibraryImplementations implementations, boolean create) {
    throw new UnsupportedOperationException();
  }

  public CameraProxy(LibraryImplementations implementations, boolean create, Camera camera) {
    this.implementations = implementations;
    this.camera = camera;
    if (create) {
      implementations.channelCameraProxy.$create$(this, false);
    }
  }

  public static CameraProxy open(CameraChannelLibrary.$LibraryImplementations implementations, int cameraId) {
    return new CameraProxy((LibraryImplementations) implementations, true, Camera.open(cameraId));
  }

  public static List<CameraInfoProxy> getAllCameraInfo(CameraChannelLibrary.$LibraryImplementations implementations) {
    final List<CameraInfoProxy> allCameraInfoProxy = new ArrayList<>();

    int numOfCameras = Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final Camera.CameraInfo info = new Camera.CameraInfo();
      Camera.getCameraInfo(i, info);
      allCameraInfoProxy.add(new CameraInfoProxy((LibraryImplementations) implementations, true, i, info));
    }

    return allCameraInfoProxy;
  }

  public void release() {
    camera.release();
  }

  public void startPreview() {
    camera.startPreview();
  }

  public void stopPreview() {
    camera.stopPreview();
  }

  public void autoFocus(AutoFocusCallbackHandler callback) {
    camera.autoFocus((success, camera) -> callback.invoke(success));
  }

  public void cancelAutoFocus() {
    camera.cancelAutoFocus();
  }

  public void setDisplayOrientation(Integer degrees) {
    camera.setDisplayOrientation(degrees);
  }

  public void setErrorCallback(ErrorCallback callback) {
    camera.setErrorCallback((error, camera) -> callback.invoke(error));
  }

  public void startSmoothZoom(Integer value) {
    camera.startSmoothZoom(value);
  }

  public void stopSmoothZoom() {
    camera.stopSmoothZoom();
  }

  public ParametersHandler getParameters() {
    return new ParametersHandler(implementations, true, camera.getParameters());
  }

  public void setParameters(ParametersHandler parameters) {
    camera.setParameters(parameters.cameraParameters);
  }

  public void setZoomChangeListener(OnZoomChangeListener listener) {
    camera.setZoomChangeListener((zoomValue, stopped, camera) -> listener.invoke(zoomValue, stopped));
  }

  public void setAutoFocusMoveCallback(AutoFocusMoveCallback callback) {
    camera.setAutoFocusMoveCallback((start, camera) -> callback.invoke(start));
  }

  public void lock() {
    camera.lock();
  }

  public Boolean enableShutterSound(Boolean enabled) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      //noinspection deprecation
      return camera.enableShutterSound(enabled);
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.JELLY_BEAN_MR1.");
    }
  }

  public void takePicture(ShutterCallback shutter,
                            PictureCallbackProxy raw,
                          PictureCallbackProxy postView,
                          PictureCallbackProxy jpeg) {
    camera.takePicture(() -> {
      if (shutter != null) shutter.invoke();
    },
        raw != null ? raw.pictureCallback : null,
        postView != null ? postView.pictureCallback : null,
        jpeg != null ? jpeg.pictureCallback : null);
  }

  public Long attachPreviewTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = implementations.textureRegistry.createSurfaceTexture();
    camera.setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  public void releasePreviewTexture() throws Exception {
    if (currentTextureEntry == null) return;
    camera.setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
  }

  public void unlock() {
    camera.unlock();
  }

  public void setOneShotPreviewCallback(PreviewCallbackProxy callback) {
    camera.setOneShotPreviewCallback(callback.previewCallback);
  }

  public void setPreviewCallback(PreviewCallbackProxy callback) {
    camera.setPreviewCallback(callback.previewCallback);
  }

  public void reconnect() throws IOException {
    camera.reconnect();
  }
}
