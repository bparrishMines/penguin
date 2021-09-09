package dev.penguin.android_hardware;

import android.hardware.Camera.ShutterCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ShutterCallbackHandler extends CameraChannelLibrary.$ShutterCallbackHandler {
  public ShutterCallbackHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new ShutterCallback() {
      @Override
      public void onShutter() {
        implementations.channelShutterCallback.$invoke(this);
      }
    };
  }
}
