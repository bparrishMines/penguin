package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public class ShutterCallbackProxy implements CameraChannelLibrary.$ShutterCallback {
  public final Camera.ShutterCallback shutterCallback;
  private final TypeChannelMessenger messenger;

  public ShutterCallbackProxy(TypeChannelMessenger messenger) {
    this.messenger = messenger;
    this.shutterCallback = ShutterCallbackProxy.this::onShutter;
  }

  public ShutterCallbackProxy(Camera.ShutterCallback shutterCallback, TypeChannelMessenger messenger) {
    this.shutterCallback = shutterCallback;
    this.messenger = messenger;
  }

  @Override
  public Void onShutter() {
    final Channels.ShutterCallbackChannel channel = new Channels.ShutterCallbackChannel(messenger);
    channel.$invokeOnShutter(this).setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        messenger.getInstancePairManager().releaseDartHandle(this);
      }

      @Override
      public void onError(Throwable throwable) {
        messenger.getInstancePairManager().releaseDartHandle(this);
      }
    });

    return null;
  }
}
