package dev.penguin.android_hardware;

import android.hardware.Camera;

public class PreviewCallbackProxy {
  public final LibraryImplementations implementations;
  public final Camera.PreviewCallback previewCallback;

  public PreviewCallbackProxy(CameraChannelLibrary.$LibraryImplementations implementations, boolean create, DataCallback onPreviewFrame) {
    this((LibraryImplementations) implementations, create, (data, camera) -> onPreviewFrame.invoke(data));
  }

  public PreviewCallbackProxy(LibraryImplementations implementations, boolean create, Camera.PreviewCallback onPictureTaken) {
    this.implementations = implementations;
    this.previewCallback = onPictureTaken;
  }
}
