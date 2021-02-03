package bparrishMines.penguin.penguin_camera.camera;

import android.hardware.Camera;

import github.penguin.reference.reference.ReferenceType;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelMessenger;

public class CameraInfo implements CameraChannelLibrary.$CameraInfo,
    ReferenceType<CameraChannelLibrary.$CameraInfo> {
  private final CameraChannelLibrary.$CameraInfoChannel channel;
  private final int cameraId;
  private final Camera.CameraInfo cameraInfo;

  public static void setupChannel(TypeChannelMessenger messenger) {
    final CameraChannelLibrary.$CameraInfoChannel channel =
        new CameraChannelLibrary.$CameraInfoChannel(messenger);
    channel.setHandler(new CameraChannelLibrary.$CameraInfoHandler());
  }

  CameraInfo(TypeChannelMessenger messenger, int cameraId, Camera.CameraInfo cameraInfo) {
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
