package bparrishMines.penguin.penguin_camera.camera;

import android.hardware.Camera;

import github.penguin.reference.reference.Referencable;
import github.penguin.reference.reference.ReferenceChannel;
import github.penguin.reference.reference.ReferenceChannelManager;

public class CameraInfo implements CameraChannelLibrary.$CameraInfo,
    Referencable<CameraChannelLibrary.$CameraInfo> {
  private final CameraChannelLibrary.$CameraInfoChannel channel;
  private final int cameraId;
  private final Camera.CameraInfo cameraInfo;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraChannelLibrary.$CameraInfoChannel channel =
        new CameraChannelLibrary.$CameraInfoChannel(manager);
    channel.registerHandler(new CameraChannelLibrary.$CameraInfoHandler());
  }

  CameraInfo(ReferenceChannelManager manager, int cameraId, Camera.CameraInfo cameraInfo) {
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
  public ReferenceChannel<CameraChannelLibrary.$CameraInfo> getReferenceChannel() {
    return channel;
  }
}
