package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.Rect;

public class CameraRectProxy implements CameraChannelLibrary.$CameraRect {
  public final Rect rect;

  public CameraRectProxy(Integer left, Integer top, Integer right, Integer bottom, ChannelRegistrar.LibraryImplementations implementations) {
    this(new Rect(left, top, right, bottom), implementations);
  }

  public CameraRectProxy(Rect rect, ChannelRegistrar.LibraryImplementations implementations) {
    this.rect = rect;
    implementations.getCameraRectChannel().createNewInstancePair(this, false);
  }

  @Override
  public Integer getTop() {
    return rect.top;
  }

  @Override
  public Integer getBottom() {
    return rect.bottom;
  }

  @Override
  public Integer getRight() {
    return rect.right;
  }

  @Override
  public Integer getLeft() {
    return rect.left;
  }
}
