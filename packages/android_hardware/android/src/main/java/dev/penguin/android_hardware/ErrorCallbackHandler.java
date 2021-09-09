package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.ErrorCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ErrorCallbackHandler extends CameraChannelLibrary.$ErrorCallbackHandler {
  public ErrorCallbackHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new ErrorCallback() {
      @Override
      public void onError(int error, Camera camera) {
        implementations.channelErrorCallback.$invoke(this, error);
      }
    };
  }
}
