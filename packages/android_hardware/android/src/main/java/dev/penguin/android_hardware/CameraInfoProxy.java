package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.os.Build;

public class CameraInfoProxy extends Camera.CameraInfo {
  public final int cameraId;

  CameraInfoProxy(int cameraId, int facing, int orientation, boolean canDisableShutterSound) {
    this.cameraId = cameraId;
    this.facing = facing;
    this.orientation = orientation;

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      this.canDisableShutterSound = canDisableShutterSound;
    }
  }
}
