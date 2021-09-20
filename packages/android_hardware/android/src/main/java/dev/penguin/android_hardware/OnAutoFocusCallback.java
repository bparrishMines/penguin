package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnAutoFocusCallback {
  Completable<Void> invoke(Boolean success, Camera camera);
}
