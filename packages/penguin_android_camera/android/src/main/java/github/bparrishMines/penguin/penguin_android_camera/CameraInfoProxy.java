package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class CameraInfoProxy implements CameraChannelLibrary.$CameraInfo {
  public final Camera.CameraInfo cameraInfo;
  private final int cameraId;

  public CameraInfoProxy(Camera.CameraInfo cameraInfo, ChannelRegistrar.LibraryImplementations libraryImplementations, int cameraId) {
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
    libraryImplementations.getCameraInfoChannel().createNewInstancePair(this, false);
  }

  @Override
  public Integer getCameraId() {
    return cameraId;
  }

  @Override
  public Integer getFacing() {
    return cameraInfo.facing;
  }

  @Override
  public Integer getOrientation() {
    return cameraInfo.orientation;
  }
}
