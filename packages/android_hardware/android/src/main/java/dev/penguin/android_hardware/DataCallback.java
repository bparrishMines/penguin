package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface DataCallback {
  Completable<Void> invoke(byte[] data);
}
