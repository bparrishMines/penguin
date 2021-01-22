package bparrishMines.penguin.penguin_camera.camera;

import android.hardware.Camera;

import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelManager;

public class CameraInfo implements CameraChannelLibrary.$CameraInfo,
    PairableInstance<CameraChannelLibrary.$CameraInfo> {
  private final CameraChannelLibrary.$CameraInfoChannel channel;
  private final int cameraId;
  private final Camera.CameraInfo cameraInfo;

  public static void setupChannel(TypeChannelManager manager) {
    final CameraChannelLibrary.$CameraInfoChannel channel =
        new CameraChannelLibrary.$CameraInfoChannel(manager);
    channel.setHandler(new CameraChannelLibrary.$CameraInfoHandler());
  }

  CameraInfo(TypeChannelManager manager, int cameraId, Camera.CameraInfo cameraInfo) {
    this.channel = new CameraChannelLibrary.$CameraInfoChannel(manager);
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
