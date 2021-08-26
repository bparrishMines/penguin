package dev.penguin.android_hardware;

import android.hardware.Camera;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class AutoFocusCallbackHandler extends CameraChannelLibrary.$AutoFocusCallbackHandler {
  public AutoFocusCallbackHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public Camera.AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new Camera.AutoFocusCallback() {
      @Override
      public void onAutoFocus(boolean success, Camera camera) {
        implementations.channelAutoFocusCallback.$invoke(this, success);
      }
    };
  }
}
