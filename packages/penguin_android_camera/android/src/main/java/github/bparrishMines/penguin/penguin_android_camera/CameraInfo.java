package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.reference.ReferenceType;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelMessenger;

public class CameraInfo implements CameraChannelLibrary.$CameraInfo,
    ReferenceType<CameraChannelLibrary.$CameraInfo> {
  private final CameraChannelLibrary.$CameraInfoChannel channel;
  private final int cameraId;
  private final Camera.CameraInfo cameraInfo;

  CameraInfo(Camera.CameraInfo cameraInfo, TypeChannelMessenger messenger, int cameraId) {
    this.channel = new CameraChannelLibrary.$CameraInfoChannel(messenger);
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
  }

  public Camera.CameraInfo getCameraInfo() {
    return cameraInfo;
  }

  @Override
  public Integer getCameraId() {
    return cameraId;
  }

  @Override
  public Integer getFacing() {
    return getCameraInfo().facing;
  }

  @Override
  public Integer getOrientation() {
    return getCameraInfo().orientation;
  }

  @Override
  public TypeChannel<CameraChannelLibrary.$CameraInfo> getTypeChannel() {
    return channel;
  }
}
