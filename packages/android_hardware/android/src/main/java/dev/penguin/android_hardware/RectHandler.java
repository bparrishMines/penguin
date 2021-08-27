package dev.penguin.android_hardware;

import android.graphics.Rect;

public class RectHandler extends CameraChannelLibrary.$RectHandler {
  public RectHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public Rect $create$(Integer top, Integer bottom, Integer right, Integer left) throws Exception {
    return new Rect(left, top, right, bottom);
  }
}
