package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelManager;

public class Camera implements CameraXChannelLibrary.$Camera, PairableInstance<CameraXChannelLibrary.$Camera> {
  private final TypeChannel<CameraXChannelLibrary.$Camera> channel;
  private final androidx.camera.core.Camera camera;

  public static void setupChannel(TypeChannelManager manager) {
    final CameraXChannelLibrary.$CameraChannel channel =
        new CameraXChannelLibrary.$CameraChannel(manager);
    channel.setHandler(new CameraXChannelLibrary.$CameraHandler());
  }

  public Camera(TypeChannelManager manager, androidx.camera.core.Camera camera) {
    this.channel = new CameraXChannelLibrary.$CameraChannel(manager);;
    this.camera = camera;
  }

  public androidx.camera.core.Camera getCamera() {
    return camera;
  }

  @Override
  public TypeChannel<CameraXChannelLibrary.$Camera> getTypeChannel() {
    return channel;
  }
}
