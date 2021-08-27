package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.AutoFocusMoveCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class AutoFocusMoveCallbackHandler extends CameraChannelLibrary.$AutoFocusMoveCallbackHandler {
  public AutoFocusMoveCallbackHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public AutoFocusMoveCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new AutoFocusMoveCallback() {
      @Override
      public void onAutoFocusMoving(boolean start, Camera camera) {
        implementations.channelAutoFocusMoveCallback.$invoke(this, start);
      }
    };
  }
}
