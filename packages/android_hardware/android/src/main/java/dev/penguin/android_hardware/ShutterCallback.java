package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface ShutterCallback {
  Completable<Void> invoke();
}
