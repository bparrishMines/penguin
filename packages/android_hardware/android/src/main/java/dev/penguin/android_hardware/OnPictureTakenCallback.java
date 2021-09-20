package dev.penguin.android_hardware;

import android.hardware.Camera;
import android.hardware.Camera.PictureCallback;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public interface OnPictureTakenCallback {
  Completable<Void> invoke(byte[] data, Camera camera);
}
