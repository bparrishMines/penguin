package dev.penguin.android_hardware;

import android.hardware.Camera;

public class PreviewCallbackProxy {
  public final Camera.PreviewCallback previewCallback;

  public PreviewCallbackProxy(CameraChannelLibrary.$DataCallback onPreviewFrame) {
    this((data, camera) -> onPreviewFrame.invoke(data));
  }

  public PreviewCallbackProxy(Camera.PreviewCallback onPictureTaken) {
    this.previewCallback = onPictureTaken;
  }
}
