package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.ErrorCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnErrorCallback {
  Completable<Void> invoke(int error, Camera camera);
}
