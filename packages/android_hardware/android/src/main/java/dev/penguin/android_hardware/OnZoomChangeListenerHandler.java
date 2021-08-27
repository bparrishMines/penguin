package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.OnZoomChangeListener;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class OnZoomChangeListenerHandler extends CameraChannelLibrary.$OnZoomChangeListenerHandler {
  public OnZoomChangeListenerHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public OnZoomChangeListener createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new OnZoomChangeListener() {
      @Override
      public void onZoomChange(int zoomValue, boolean stopped, Camera camera) {
        implementations.channelOnZoomChangeListener.$invoke(this, zoomValue, stopped);
      }
    };
  }
}
