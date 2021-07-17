package dev.penguin.android_hardware;

import android.hardware.Camera;

public class PictureCallbackProxy implements CameraChannelLibrary.$PictureCallback {
  public final Camera.PictureCallback pictureCallback;

  public PictureCallbackProxy(CameraChannelLibrary.$DataCallback onPictureTaken) {
    this((data, camera) -> onPictureTaken.invoke(data));
  }

  public PictureCallbackProxy(Camera.PictureCallback onPictureTaken) {
    this.pictureCallback = onPictureTaken;
  }
}
