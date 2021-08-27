package dev.penguin.android_hardware;

import android.hardware.Camera.CameraInfo;
import android.os.Build;

public class CameraInfoProxyHandler extends CameraChannelLibrary.$CameraInfoProxyHandler {
  @SuppressWarnings("deprecation")
  public static class CameraInfoProxy extends CameraInfo {
    public int cameraId;
  }

  public CameraInfoProxyHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public CameraInfoProxy $create$(Integer cameraId, Integer facing, Integer orientation, Boolean canDisableShutterSound) throws Exception {
    final CameraInfoProxy cameraInfo = new CameraInfoProxy();
    cameraInfo.cameraId = cameraId;
    cameraInfo.facing = facing;
    cameraInfo.orientation = orientation;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      cameraInfo.canDisableShutterSound = canDisableShutterSound;
    }
    return cameraInfo;
  }
}
