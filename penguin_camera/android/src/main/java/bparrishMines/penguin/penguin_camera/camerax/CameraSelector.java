package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.reference.TypeChannelManager;

public class CameraSelector implements CameraXChannelLibrary.$CameraSelector {
  private final Integer lensFacing;
  private final androidx.camera.core.CameraSelector cameraSelector;

  public static void setupChannel(TypeChannelManager manager) {
    final CameraXChannelLibrary.$CameraSelectorChannel channel =
        new CameraXChannelLibrary.$CameraSelectorChannel (manager);
    channel.setHandler(new CameraXChannelLibrary.$CameraSelectorHandler() {
      @Override
      CameraXChannelLibrary.$CameraSelector onCreate(TypeChannelManager manager, CameraXChannelLibrary.$CameraSelectorCreationArgs args) {
        return new CameraSelector(args.lensFacing);
      }
    });
  }

  public CameraSelector(Integer lensFacing) {
    this.lensFacing = lensFacing;
    this.cameraSelector = new androidx.camera.core.CameraSelector.Builder()
        .requireLensFacing(lensFacing)
        .build();
  }

  public androidx.camera.core.CameraSelector getCameraSelector() {
    return cameraSelector;
  }

  @Override
  public Integer getLensFacing() {
    return lensFacing;
  }
}
