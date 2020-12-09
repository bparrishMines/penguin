package bparrishMines.penguin.penguin_camera.camera;

import android.hardware.Camera;

import github.penguin.reference.reference.ReferenceChannelManager;
import github.penguin.reference.reference.UnpairedReferenceParameter;

public class CameraInfo implements CameraChannelLibrary.$CameraInfo, UnpairedReferenceParameter {
  private int cameraId;
  private final Camera.CameraInfo cameraInfo;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraChannelLibrary.$CameraInfoChannel channel =
        new CameraChannelLibrary.$CameraInfoChannel(manager);
    channel.registerHandler(new CameraChannelLibrary.$CameraInfoHandler());
  }

  CameraInfo(int cameraId, Camera.CameraInfo cameraInfo) {
    this.cameraId = cameraId;
    this.cameraInfo = cameraInfo;
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

  @Override
  public String getReferenceChannelName() {
    return "penguin_camera/android/camera/CameraInfo";
  }
}
