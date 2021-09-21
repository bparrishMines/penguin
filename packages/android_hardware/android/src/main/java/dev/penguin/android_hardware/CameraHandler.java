package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.Parameters;
import android.os.Build;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.view.TextureRegistry;

public class CameraHandler extends CameraChannelLibrary.$CameraHandler {
  final Map<Camera, TextureRegistry.SurfaceTextureEntry> attachedTextureEntries = new HashMap<>();

  public CameraHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public List<CameraInfoProxy> $getAllCameraInfo() {
    final List<CameraInfoProxy> cameraInfoProxies = new ArrayList<>();

    int numOfCameras = Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final CameraInfoProxy infoProxy = new CameraInfoProxy(-1, -1,-1, false);
      Camera.getCameraInfo(i, infoProxy);

      final Boolean canDisableShutterSound;
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        canDisableShutterSound = infoProxy.canDisableShutterSound;
      } else {
        canDisableShutterSound = null;
      }

      implementations.channelCameraInfoProxy.$create$(infoProxy, false);
      cameraInfoProxies.add(infoProxy);
    }

    return cameraInfoProxies;
  }

  @Override
  public Camera $open(int cameraId) throws Exception {
    final Camera camera = Camera.open(cameraId);
    implementations.channelCamera.$create$(camera, false);
    return camera;
  }

  @Override
  public Long $attachPreviewTexture(Camera $instance) throws Exception {
    TextureRegistry.SurfaceTextureEntry currentTextureEntry = attachedTextureEntries.get($instance);
    if (currentTextureEntry != null) return currentTextureEntry.id();

      currentTextureEntry = ((LibraryImplementations)implementations).textureRegistry.createSurfaceTexture();
    $instance.setPreviewTexture(currentTextureEntry.surfaceTexture());
      return currentTextureEntry.id();
  }

  @Override
  public void $releasePreviewTexture(Camera $instance) throws Exception {
    TextureRegistry.SurfaceTextureEntry currentTextureEntry = attachedTextureEntries.get($instance);
          if (currentTextureEntry == null) return;
    $instance.setPreviewTexture(null);
      currentTextureEntry.release();
      attachedTextureEntries.remove($instance);
  }

  @Override
  public Parameters $getParameters(Camera $instance) {
    final Parameters parameters = $instance.getParameters();
    implementations.channelParameters.$create$(parameters, false);
    return parameters;
  }

  @Override
  public Boolean $enableShutterSound(Camera $instance, Boolean enabled) throws Exception {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      return $instance.enableShutterSound(enabled);
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.JELLY_BEAN_MR1.");
    }
  }
}
