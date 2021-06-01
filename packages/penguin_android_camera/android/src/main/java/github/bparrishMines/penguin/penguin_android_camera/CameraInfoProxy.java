package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class CameraInfoProxy implements CameraChannelLibrary.$CameraInfo {
  public final Camera.CameraInfo cameraInfo;
  public final int cameraId;

  public CameraInfoProxy(Camera.CameraInfo cameraInfo, ChannelRegistrar.LibraryImplementations libraryImplementations, int cameraId) {
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
    libraryImplementations.getChannelCameraInfo().$$create(this, false, cameraId, cameraInfo.facing, cameraInfo.orientation);
  }
}
