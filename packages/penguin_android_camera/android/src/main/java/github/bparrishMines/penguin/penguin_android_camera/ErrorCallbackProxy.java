package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class ErrorCallbackProxy implements CameraChannelLibrary.$ErrorCallback, Camera.ErrorCallback {
  public final ChannelRegistrar.LibraryImplementations implementations;

  public ErrorCallbackProxy(ChannelRegistrar.LibraryImplementations implementations) {
    this.implementations = implementations;
  }

  @Override
  public void onError(int error, Camera camera) {
    implementations.getChannelErrorCallback().$onError(this, error);
  }
}
