package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface ErrorCallback {
  Completable<Void> invoke(Integer error);
}
