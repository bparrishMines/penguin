package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelManager;

public class SuccessListener implements CameraXChannelLibrary.$SuccessListener {
  private final CameraXChannelLibrary.$SuccessListenerChannel channel;

  public static void setupChannel(TypeChannelManager manager) {
    final CameraXChannelLibrary.$SuccessListenerChannel channel =
        new CameraXChannelLibrary.$SuccessListenerChannel (manager);
    channel.setHandler(new CameraXChannelLibrary.$SuccessListenerHandler() {
      @Override
      CameraXChannelLibrary.$SuccessListener onCreate(TypeChannelManager manager, CameraXChannelLibrary.$SuccessListenerCreationArgs args) {
        return new SuccessListener(manager);
      }
    });
  }

  public SuccessListener(TypeChannelManager manager) {
    this.channel = new CameraXChannelLibrary.$SuccessListenerChannel(manager);
  }

  @Override
  public Completable<Void> onSuccess() {
    channel.$invokeOnSuccess(this);
    return channel.disposePair(this);
  }

  @Override
  public Completable<Void> onError(String code, String message) {
    channel.$invokeOnError(this, code, message);
    return channel.disposePair(this);
  }
}
