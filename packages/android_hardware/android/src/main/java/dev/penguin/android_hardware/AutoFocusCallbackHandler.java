package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class AutoFocusCallbackHandler extends CameraChannelLibrary.$AutoFocusCallbackHandler {
  public AutoFocusCallbackHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new AutoFocusCallback() {
      @Override
      public void onAutoFocus(boolean success, Camera camera) {
        implementations.channelAutoFocusCallback.$invoke(this, success);
      }
    };
  }
}
