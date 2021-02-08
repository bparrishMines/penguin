package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.TypeChannelMessenger;

public class CameraSelector implements CameraXChannelLibrary.$CameraSelector {
  private final Integer lensFacing;
  private final androidx.camera.core.CameraSelector cameraSelector;

  public CameraSelector(Integer lensFacing) {
    this.lensFacing = lensFacing;
    this.cameraSelector = new androidx.camera.core.CameraSelector.Builder()
        .requireLensFacing(lensFacing)
        .build();
  }

  public static void setupChannel(TypeChannelMessenger messenger) {
    final CameraXChannelLibrary.$CameraSelectorChannel channel =
        new CameraXChannelLibrary.$CameraSelectorChannel(messenger);
    channel.setHandler(new CameraXChannelLibrary.$CameraSelectorHandler() {
      @Override
      CameraXChannelLibrary.$CameraSelector onCreate(TypeChannelMessenger messenger, CameraXChannelLibrary.$CameraSelectorCreationArgs args) {
        return new CameraSelector(args.lensFacing);
      }
    });
  }

  public androidx.camera.core.CameraSelector getCameraSelector() {
    return cameraSelector;
  }

  @Override
  public Integer getLensFacing() {
    return lensFacing;
  }
}
