package dev.penguin.android_hardware;

import android.graphics.Rect;
import android.hardware.Camera;

import androidx.annotation.NonNull;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelMessenger;

public class AreaChannel extends CameraChannelLibrary.$AreaChannel {
  public AreaChannel(@NonNull TypeChannelMessenger messenger) {
    super(messenger);
  }

  @Override
  public Completable<PairedInstance> $create$(Camera.Area $instance, boolean $owner, Rect rect, Integer weight) {
    if (!implementations.messenger.getInstanceManager().containsInstance(rect)) {
      implementations.channelRect.$create$(rect,
          false, rect.top, rect.bottom, rect.right, rect.left);
    }
    return super.$create$($instance, $owner, rect, weight);
  }
}
