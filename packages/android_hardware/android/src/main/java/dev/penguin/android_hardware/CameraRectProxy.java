package dev.penguin.android_hardware;

import android.graphics.Rect;

public class CameraRectProxy {
  public final LibraryImplementations implementations;
  public final Rect rect;

  public CameraRectProxy(
      CameraChannelLibrary.$LibraryImplementations implementations,
      boolean create,
      Integer top,
      Integer bottom,
      Integer right,
      Integer left) {
    this((LibraryImplementations) implementations, create, new Rect(left, top, right, bottom));
  }

  public CameraRectProxy(LibraryImplementations implementations, boolean create, Rect rect) {
    this.implementations = implementations;
    this.rect = rect;
    if (create) {
      implementations.channelCameraRectProxy.$create$(
          this, false, rect.top, rect.bottom, rect.right, rect.left);
    }
  }
}
