package dev.penguin.android_hardware;

import android.hardware.Camera.ShutterCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnShutterCallback {
  Completable<Void> invoke();
}
