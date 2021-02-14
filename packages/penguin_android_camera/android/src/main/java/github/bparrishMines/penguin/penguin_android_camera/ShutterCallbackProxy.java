package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ShutterCallbackProxy implements CameraChannelLibrary.$ShutterCallback {
  private final Camera.ShutterCallback shutterCallback;
  private final TypeChannelMessenger messenger;

  public ShutterCallbackProxy(TypeChannelMessenger messenger) {
    this.messenger = messenger;
    this.shutterCallback = ShutterCallbackProxy.this::onShutter;
  }

  public ShutterCallbackProxy(Camera.ShutterCallback shutterCallback, TypeChannelMessenger messenger) {
    this.shutterCallback = shutterCallback;
    this.messenger = messenger;
  }

  public Camera.ShutterCallback getShutterCallback() {
    return shutterCallback;
  }

  @Override
  public Void onShutter() {
    final Channels.ShutterCallbackChannel channel = new Channels.ShutterCallbackChannel(messenger);
    channel.$invokeOnShutter(this);
    channel.disposeInstancePair(this);
    return null;
  }
}
