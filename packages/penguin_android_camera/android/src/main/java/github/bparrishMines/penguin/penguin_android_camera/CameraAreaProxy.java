package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraAreaProxy implements CameraChannelLibrary.$CameraArea {
  public final Camera.Area area;
  private final CameraRectProxy rect;

  public static List<CameraAreaProxy> fromList(List<Camera.Area> areas, ChannelRegistrar.LibraryImplementations implementations) {
    final List<CameraAreaProxy> proxyList = new ArrayList<>();
    if (areas == null) return proxyList;
    for (Camera.Area area : areas) {
      proxyList.add(new CameraAreaProxy(new CameraRectProxy(area.rect, implementations), area.weight, implementations));
    }
    return proxyList;
  }

  public static List<Camera.Area> toAreaList(List<? extends CameraChannelLibrary.$CameraArea> proxies) {
    final List<Camera.Area> areaList = new ArrayList<>();
    for (CameraChannelLibrary.$CameraArea proxy : proxies) {
      areaList.add(((CameraAreaProxy)proxy).area);
    }
    return areaList;
  }

  public CameraAreaProxy(CameraRectProxy rect, Integer weight, ChannelRegistrar.LibraryImplementations implementations) {
    this(new Camera.Area(rect.rect, weight), rect, implementations);
  }

  public CameraAreaProxy(Camera.Area area, CameraRectProxy rect, ChannelRegistrar.LibraryImplementations implementations) {
    this.area = area;
    this.rect = rect;
    implementations.getCameraAreaChannel().createNewInstancePair(this, false);
  }

  @Override
  public CameraRectProxy getRect() {
    return rect;
  }

  @Override
  public Integer getWeight() {
    return area.weight;
  }
}
