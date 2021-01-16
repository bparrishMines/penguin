package bparrishMines.penguin.penguin_camera.camerax;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.ReferenceChannelManager;

public class SuccessListener implements CameraXChannelLibrary.$SuccessListener {
  private final CameraXChannelLibrary.$SuccessListenerChannel channel;

  public static void setupChannel(ReferenceChannelManager manager) {
    final CameraXChannelLibrary.$SuccessListenerChannel channel =
        new CameraXChannelLibrary.$SuccessListenerChannel (manager);
    channel.registerHandler(new CameraXChannelLibrary.$SuccessListenerHandler() {
      @Override
      CameraXChannelLibrary.$SuccessListener onCreate(ReferenceChannelManager manager, CameraXChannelLibrary.$SuccessListenerCreationArgs args) throws Exception {
        return new SuccessListener(channel);
      }
    });
  }

  public SuccessListener(CameraXChannelLibrary.$SuccessListenerChannel channel) {
    this.channel = channel;
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
