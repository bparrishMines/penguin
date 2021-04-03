package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.reference.TypeChannelMessenger;

public class CameraInfoProxy implements CameraChannelLibrary.$CameraInfo {
  public final Camera.CameraInfo cameraInfo;
  private final CameraChannelLibrary.$CameraInfoChannel channel;
  private final int cameraId;

  public CameraInfoProxy(Camera.CameraInfo cameraInfo, TypeChannelMessenger messenger, int cameraId) {
    this.channel = new CameraChannelLibrary.$CameraInfoChannel(messenger);
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
    channel.createNewInstancePair(this, false);
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
