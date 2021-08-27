package dev.penguin.android_hardware;

import android.graphics.Rect;
import android.hardware.Camera.Area;

public class AreaHandler extends CameraChannelLibrary.$AreaHandler {
  public AreaHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public Area $create$(Rect rect, Integer weight) throws Exception {
    return new Area(rect, weight);
  }
}
