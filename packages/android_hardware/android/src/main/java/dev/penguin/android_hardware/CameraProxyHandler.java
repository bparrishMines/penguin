package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.ShutterCallback;
import android.hardware.Camera.AutoFocusMoveCallback;
import android.hardware.Camera.PictureCallback;
import android.hardware.Camera.PreviewCallback;
import android.hardware.Camera.OnZoomChangeListener;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.ErrorCallback;
import android.os.Build;

import androidx.annotation.Nullable;

import dev.penguin.android_hardware.CameraInfoHandler.CameraInfoProxy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.view.TextureRegistry;

public class CameraProxyHandler extends CameraChannelLibrary.$CameraProxyHandler {
  public static class CameraProxy {
    public final LibraryImplementations implementations;
    public final Camera camera;
    @Nullable
    private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

    public CameraProxy(LibraryImplementations implementations, Camera camera) {
      this.implementations = implementations;
      this.camera = camera;
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

    @Override
    public boolean equals(Object o) {
      if (this == o) return true;
      if (o == null || getClass() != o.getClass()) return false;
      CameraProxy that = (CameraProxy) o;
      return implementations.equals(that.implementations) && camera.equals(that.camera);
    }

    @Override
    public int hashCode() {
      return Arrays.hashCode(new Object[]{implementations, camera});
    }
  }

  public CameraProxyHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public CameraProxy $open(Integer cameraId) {
    final CameraProxy cameraProxy = new CameraProxy((LibraryImplementations) implementations, Camera.open(cameraId));
    implementations.channelCameraProxy.$create$(cameraProxy, false);
    return cameraProxy;
  }

  @Override
  public List<CameraInfoProxy> $getAllCameraInfo() {
    final List<CameraInfoProxy> cameraInfoProxies = new ArrayList<>();

    int numOfCameras = Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final CameraInfoProxy infoProxy = new CameraInfoProxy();
      Camera.getCameraInfo(i, infoProxy);

      final Boolean canDisableShutterSound;
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        canDisableShutterSound = infoProxy.canDisableShutterSound;
      } else {
        canDisableShutterSound = null;
      }

      implementations.channelCameraInfoProxy.$create$(infoProxy, false, infoProxy.cameraId, infoProxy.facing, infoProxy.orientation, canDisableShutterSound);
      cameraInfoProxies.add(infoProxy);
    }

    return cameraInfoProxies;
  }

  @Override
  public void $release(CameraProxy $instance) {
    $instance.camera.release();
  }

  @Override
  public void $startPreview(CameraProxy $instance) {
    $instance.camera.startPreview();
  }
  @Override
  public void $stopPreview(CameraProxy $instance) {
    $instance.camera.stopPreview();
  }
  @Override
  public void $autoFocus(CameraProxy $instance, AutoFocusCallback callback) {
    $instance.camera.autoFocus(callback);
  }
  @Override
  public void $cancelAutoFocus(CameraProxy $instance) {
    $instance.camera.cancelAutoFocus();
  }
  @Override
  public void $setDisplayOrientation(CameraProxy $instance, Integer degrees) {
    $instance.camera.setDisplayOrientation(degrees);
  }

  @Override
  public void $setErrorCallback(CameraProxy $instance, ErrorCallback callback) {
    $instance.camera.setErrorCallback(callback);
  }
  @Override
  public void $startSmoothZoom(CameraProxy $instance, Integer value) {
    $instance.camera.startSmoothZoom(value);
  }
  @Override
  public void $stopSmoothZoom(CameraProxy $instance) {
    $instance.camera.stopSmoothZoom();
  }
  @Override
  public Parameters $getParameters(CameraProxy $instance) {
    final Parameters parameters = $instance.camera.getParameters();
    implementations.channelParameters.$create$(parameters, false);
    return parameters;
  }
  @Override
  public void $setParameters(CameraProxy $instance, Parameters parameters) {
    $instance.camera.setParameters(parameters);
  }
  @Override
  public void $setZoomChangeListener(CameraProxy $instance, OnZoomChangeListener listener) {
    $instance.camera.setZoomChangeListener(listener);
  }
  @Override
  public void $setAutoFocusMoveCallback(CameraProxy $instance, AutoFocusMoveCallback callback) {
    $instance.camera.setAutoFocusMoveCallback(callback);
  }
  @Override
  public void $lock(CameraProxy $instance) {
    $instance.camera.lock();
  }
  @Override
  public Boolean $enableShutterSound(CameraProxy $instance, Boolean enabled) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      //noinspection deprecation
      return $instance.camera.enableShutterSound(enabled);
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.JELLY_BEAN_MR1.");
    }
  }
  @Override
  public void $takePicture(CameraProxy $instance,
                           ShutterCallback shutter,
                          PictureCallback raw,
                          PictureCallback postView,
                          PictureCallback jpeg) {
    $instance.camera.takePicture(shutter, raw, postView, jpeg);
  }
  @Override
  public Long $attachPreviewTexture(CameraProxy $instance) throws Exception {
    return $instance.attachPreviewTexture();
  }
  @Override
  public void $releasePreviewTexture(CameraProxy $instance) throws Exception {
    $instance.releasePreviewTexture();
  }
  @Override
  public void $unlock(CameraProxy $instance) {
    $instance.camera.unlock();
  }

  @Override
  public void $setOneShotPreviewCallback(CameraProxy $instance, PreviewCallback callback) {
    $instance.camera.setOneShotPreviewCallback(callback);
  }

  @Override
  public void $setPreviewCallback(CameraProxy $instance, PreviewCallback callback) {
    $instance.camera.setPreviewCallback(callback);
  }
  @Override
  public void $reconnect(CameraProxy $instance) throws IOException {
    $instance.camera.reconnect();
  }
}
