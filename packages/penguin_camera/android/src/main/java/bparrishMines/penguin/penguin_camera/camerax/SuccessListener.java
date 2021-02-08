package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public class SuccessListener implements CameraXChannelLibrary.$SuccessListener {
  private final CameraXChannelLibrary.$SuccessListenerChannel channel;

  public SuccessListener(TypeChannelMessenger messenger) {
    this.channel = new CameraXChannelLibrary.$SuccessListenerChannel(messenger);
  }

  public static void setupChannel(TypeChannelMessenger messenger) {
    final CameraXChannelLibrary.$SuccessListenerChannel channel =
        new CameraXChannelLibrary.$SuccessListenerChannel(messenger);
    channel.setHandler(new CameraXChannelLibrary.$SuccessListenerHandler() {
      @Override
      CameraXChannelLibrary.$SuccessListener onCreate(TypeChannelMessenger messenger, CameraXChannelLibrary.$SuccessListenerCreationArgs args) {
        return new SuccessListener(messenger);
      }
    });
  }

  @Override
  public Completable<Void> onSuccess() {
    channel.$invokeOnSuccess(this);
    return channel.disposeInstancePair(this);
  }

  @Override
  public Completable<Void> onError(String code, String message) {
    channel.$invokeOnError(this, code, message);
    return channel.disposeInstancePair(this);
  }
}
