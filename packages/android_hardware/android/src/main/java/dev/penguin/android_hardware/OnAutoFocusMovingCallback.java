package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.AutoFocusMoveCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnAutoFocusMovingCallback {
  Completable<Void> invoke(boolean start, Camera camera);
}
