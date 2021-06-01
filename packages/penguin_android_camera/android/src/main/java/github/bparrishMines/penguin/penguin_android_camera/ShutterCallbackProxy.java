package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class ShutterCallbackProxy implements CameraChannelLibrary.$ShutterCallback {
  public final Camera.ShutterCallback shutterCallback;
  private final ChannelRegistrar.LibraryImplementations libraryImplementations;

  public ShutterCallbackProxy(ChannelRegistrar.LibraryImplementations libraryImplementations) {
    this.libraryImplementations = libraryImplementations;
    this.shutterCallback = ShutterCallbackProxy.this::onShutter;
  }

  public ShutterCallbackProxy(Camera.ShutterCallback shutterCallback, ChannelRegistrar.LibraryImplementations libraryImplementations) {
    this.shutterCallback = shutterCallback;
    this.libraryImplementations = libraryImplementations;
  }

  public void onShutter() {
    libraryImplementations.getChannelShutterCallback().$onShutter(this);
  }

  @Override
  protected void finalize() throws Throwable {
    libraryImplementations.getChannelShutterCallback().disposeInstancePair(this);
    super.finalize();
  }
}
