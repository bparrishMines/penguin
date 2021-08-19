package dev.penguin.android_hardware;

import android.hardware.Camera;

public class PictureCallbackProxy {
  public final LibraryImplementations implementations;
  public final Camera.PictureCallback pictureCallback;

  public PictureCallbackProxy(CameraChannelLibrary.$LibraryImplementations implementations, boolean create, CameraChannelLibrary.DataCallback onPictureTaken) {
    this((LibraryImplementations) implementations, create, (data, camera) -> onPictureTaken.invoke(data));
  }

  public PictureCallbackProxy(LibraryImplementations implementations, boolean create, Camera.PictureCallback onPictureTaken) {
    this.implementations = implementations;
    this.pictureCallback = onPictureTaken;
  }
}
