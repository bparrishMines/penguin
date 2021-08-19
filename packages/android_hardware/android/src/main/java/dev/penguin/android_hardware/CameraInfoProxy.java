package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.os.Build;

public class CameraInfoProxy {
  public final LibraryImplementations implementations;
  public final int cameraId;
  public final Camera.CameraInfo cameraInfo;

  public CameraInfoProxy(
      CameraChannelLibrary.$LibraryImplementations implementations,
      boolean create,
      Integer cameraId,
      Integer facing,
      Integer orientation,
      Boolean canDisableShutterSound) {
    this(
        (LibraryImplementations) implementations,
        create,
        cameraId,
        buildCameraInfo(facing, orientation, canDisableShutterSound));
  }

  public CameraInfoProxy(
      LibraryImplementations implementations,
      boolean create,
      int cameraId,
      Camera.CameraInfo cameraInfo) {
    this.implementations = implementations;
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;

    final Boolean canDisableShutterSound;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      canDisableShutterSound = cameraInfo.canDisableShutterSound;
    } else {
      canDisableShutterSound = null;
    }
    if (create) {
      implementations.channelCameraInfoProxy.$create$(
          this, false, cameraId, cameraInfo.facing, cameraInfo.orientation, canDisableShutterSound);
    }
  }

  private static Camera.CameraInfo buildCameraInfo(
      Integer facing, Integer orientation, Boolean canDisableShutterSound) {
    final Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
    cameraInfo.facing = facing;
    cameraInfo.orientation = orientation;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      cameraInfo.canDisableShutterSound = canDisableShutterSound;
    }
    return cameraInfo;
  }
}
