package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.Referencable;
import github.penguin.reference.reference.ReferenceChannel;
import github.penguin.reference.reference.ReferenceChannelManager;

public class Camera implements CameraXChannelLibrary.$Camera, Referencable<CameraXChannelLibrary.$Camera> {
  private final ReferenceChannelManager manager;
  private final androidx.camera.core.Camera camera;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraXChannelLibrary.$CameraChannel channel =
        new CameraXChannelLibrary.$CameraChannel(manager);
    channel.registerHandler(new CameraXChannelLibrary.$CameraHandler());
  }

  public Camera(ReferenceChannelManager manager, androidx.camera.core.Camera camera) {
    this.manager = manager;
    this.camera = camera;
  }

  public androidx.camera.core.Camera getCamera() {
    return camera;
  }

  @Override
  public ReferenceChannel<CameraXChannelLibrary.$Camera> getReferenceChannel() {
    return new CameraXChannelLibrary.$CameraChannel(manager);
  }
}
