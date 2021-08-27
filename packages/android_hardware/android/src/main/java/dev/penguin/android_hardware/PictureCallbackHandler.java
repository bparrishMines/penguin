package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.PictureCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class PictureCallbackHandler extends CameraChannelLibrary.$PictureCallbackHandler {
  public PictureCallbackHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public PictureCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new PictureCallback() {
      @Override
      public void onPictureTaken(byte[] data, Camera camera) {
        implementations.channelPictureCallback.$invoke(this, data);
      }
    };
  }
}
