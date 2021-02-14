package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import github.penguin.reference.reference.TypeChannelMessenger;

public class PictureCallbackProxy implements CameraChannelLibrary.$PictureCallback {
  private final Camera.PictureCallback pictureCallback;
  private final TypeChannelMessenger messenger;

  public PictureCallbackProxy(TypeChannelMessenger messenger) {
    this.messenger = messenger;
    this.pictureCallback = (data, camera) -> PictureCallbackProxy.this.onPictureTaken(data);
  }

  public PictureCallbackProxy(Camera.PictureCallback PictureCallback, TypeChannelMessenger messenger) {
    this.pictureCallback = PictureCallback;
    this.messenger = messenger;
  }

  public Camera.PictureCallback getPictureCallback() {
    return pictureCallback;
  }

  @Override
  public Void onPictureTaken(byte[] data) {
    final Channels.PictureCallbackChannel channel = new Channels.PictureCallbackChannel(messenger);
    channel.$invokeOnPictureTaken(this, data);
    channel.disposeInstancePair(this);
    return null;
  }
}
