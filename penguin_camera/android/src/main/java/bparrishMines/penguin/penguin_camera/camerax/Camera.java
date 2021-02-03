package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.ReferenceType;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelMessenger;

public class Camera implements CameraXChannelLibrary.$Camera, ReferenceType<CameraXChannelLibrary.$Camera> {
  private final TypeChannel<CameraXChannelLibrary.$Camera> channel;
  private final androidx.camera.core.Camera camera;

  public Camera(TypeChannelMessenger messenger, androidx.camera.core.Camera camera) {
    this.channel = new CameraXChannelLibrary.$CameraChannel(messenger);
    this.camera = camera;
  }

  public static void setupChannel(TypeChannelMessenger messenger) {
    final CameraXChannelLibrary.$CameraChannel channel =
        new CameraXChannelLibrary.$CameraChannel(messenger);
    channel.setHandler(new CameraXChannelLibrary.$CameraHandler());
  }

  public androidx.camera.core.Camera getCamera() {
    return camera;
  }

  @Override
  public TypeChannel<CameraXChannelLibrary.$Camera> getTypeChannel() {
    return channel;
  }
}
