package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.PreviewCallback;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class PreviewCallbackHandler extends CameraChannelLibrary.$PreviewCallbackHandler {
  public PreviewCallbackHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public PreviewCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new PreviewCallback() {
      @Override
      public void onPreviewFrame(byte[] data, Camera camera) {
        implementations.channelPreviewCallback.$invoke(this, data);
      }
    };
  }
}
