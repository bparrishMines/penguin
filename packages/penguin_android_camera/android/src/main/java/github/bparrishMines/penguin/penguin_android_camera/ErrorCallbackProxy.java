package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.async.Completable;

public class ErrorCallbackProxy implements CameraChannelLibrary.$ErrorCallback, Camera.ErrorCallback {
  public final ChannelRegistrar.LibraryImplementations implementations;

  public ErrorCallbackProxy(ChannelRegistrar.LibraryImplementations implementations) {
    this.implementations = implementations;
  }

  @Override
  public Completable<Object> onError(Integer error) {
    return implementations.getErrorCallbackChannel().$invokeOnError(this, error);
  }

  @Override
  public void onError(int error, Camera camera) {
    onError(error);
  }
}
