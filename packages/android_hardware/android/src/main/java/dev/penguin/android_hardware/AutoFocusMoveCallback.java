package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface AutoFocusMoveCallback {
  Completable<Void> invoke(Boolean start);
}
