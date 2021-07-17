package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.os.Build;

public class CameraInfoProxy implements CameraChannelLibrary.$CameraInfo {
  public final Camera.CameraInfo cameraInfo;
  public final int cameraId;

  public CameraInfoProxy(Camera.CameraInfo cameraInfo, ChannelRegistrar.LibraryImplementations libraryImplementations, int cameraId) {
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
    
    final Boolean canDisableShutterSound;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      canDisableShutterSound = cameraInfo.canDisableShutterSound;
    } else {
      canDisableShutterSound = null;
    }
    libraryImplementations.getChannelCameraInfo().$create$(this, false,
        cameraId,
        cameraInfo.facing,
        cameraInfo.orientation,
        canDisableShutterSound);
  }
}
