package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface AutoFocusCallback {
  Completable<Void> invoke(Boolean success);
}
