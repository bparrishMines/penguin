package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.async.Completable;

public class AutoFocusCallbackProxy implements CameraChannelLibrary.$AutoFocusCallback, Camera.AutoFocusCallback {
  public final ChannelRegistrar.LibraryImplementations implementations;

  public AutoFocusCallbackProxy(ChannelRegistrar.LibraryImplementations implementations) {
    this.implementations = implementations;
  }

  @Override
  public void onAutoFocus(boolean success, Camera camera) {
    onAutoFocus(success);
  }

  public Completable<Object> onAutoFocus(Boolean success) {
    return implementations.getChannelAutoFocusCallback().$onAutoFocus(this, success);
  }
}
