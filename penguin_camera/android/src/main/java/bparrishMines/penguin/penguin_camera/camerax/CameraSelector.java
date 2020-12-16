package bparrishMines.penguin.penguin_camera.camerax;

import android.annotation.SuppressLint;

import github.penguin.reference.reference.ReferenceChannelManager;

public class CameraSelector implements CameraXChannelLibrary.$CameraSelector {
  private final Integer lensFacing;
  private final androidx.camera.core.CameraSelector cameraSelector;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraXChannelLibrary.$CameraSelectorChannel channel =
        new CameraXChannelLibrary.$CameraSelectorChannel (manager);
    channel.registerHandler(new CameraXChannelLibrary.$CameraSelectorHandler() {
      @Override
      CameraXChannelLibrary.$CameraSelector onCreate(ReferenceChannelManager manager, CameraXChannelLibrary.$CameraSelectorCreationArgs args) {
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
