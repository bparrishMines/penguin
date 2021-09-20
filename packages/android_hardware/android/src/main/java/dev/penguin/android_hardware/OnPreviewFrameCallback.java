package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.PreviewCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnPreviewFrameCallback {
  Completable<Void> invoke(byte[] data, Camera camera);
}
