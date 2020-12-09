package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.ReferenceChannelManager;
import github.penguin.reference.reference.UnpairedReferenceParameter;

public class Camera implements CameraXChannelLibrary.$Camera, UnpairedReferenceParameter {
  final androidx.camera.core.Camera camera;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraXChannelLibrary.$CameraChannel channel =
        new CameraXChannelLibrary.$CameraChannel(manager);
    channel.registerHandler(new CameraXChannelLibrary.$CameraHandler());
  }

  public Camera(androidx.camera.core.Camera camera) {
    this.camera = camera;
  }

  @Override
  public String getReferenceChannelName() {
    return "penguin_camera/camera";
  }
}
