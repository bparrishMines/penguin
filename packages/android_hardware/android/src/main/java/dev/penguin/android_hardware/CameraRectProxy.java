package dev.penguin.android_hardware;

import android.graphics.Rect;

public class CameraRectProxy implements CameraChannelLibrary.$CameraRect {
  public final Rect rect;

  public CameraRectProxy(Integer left, Integer top, Integer right, Integer bottom, ChannelRegistrar.LibraryImplementations implementations) {
    this(new Rect(left, top, right, bottom), implementations, false);
  }

  public CameraRectProxy(Rect rect, ChannelRegistrar.LibraryImplementations implementations) {
    this(rect, implementations, true);
  }

  public CameraRectProxy(Rect rect, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this.rect = rect;
    if (create) {
      implementations.getChannelCameraRect().$create$(this, false, rect.top, rect.bottom, rect.right, rect.left);
    }
  }
}
