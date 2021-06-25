package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class PreviewCallbackProxy implements CameraChannelLibrary.$PreviewCallback {
  public final Camera.PreviewCallback previewCallback;

  public PreviewCallbackProxy(CameraChannelLibrary.$DataCallback onPreviewFrame) {
    this((data, camera) -> onPreviewFrame.invoke(data));
  }

  public PreviewCallbackProxy(Camera.PreviewCallback onPictureTaken) {
    this.previewCallback = onPictureTaken;
  }
}
