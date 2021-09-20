package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.OnZoomChangeListener;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnZoomChangeCallback {
  Completable<Void> invoke(int zoomValue, boolean stopped, Camera camera);
}
