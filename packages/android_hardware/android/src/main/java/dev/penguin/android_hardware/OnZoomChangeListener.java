package dev.penguin.android_hardware;

import github.penguin.reference.async.Completable;

public interface OnZoomChangeListener {
  Completable<Void> invoke(Integer zoomValue, Boolean stopped);
}
