package dev.penguin.android_hardware;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraAreaProxy implements CameraChannelLibrary.$CameraArea {
  public final Camera.Area area;
  public final CameraRectProxy rect;

  public static List<CameraAreaProxy> fromList(List<Camera.Area> areas, ChannelRegistrar.LibraryImplementations implementations) {
    final List<CameraAreaProxy> proxyList = new ArrayList<>();
    if (areas == null) return proxyList;
    for (Camera.Area area : areas) {
      proxyList.add(new CameraAreaProxy(area, implementations, true));
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

  public CameraAreaProxy(CameraRectProxy rect, Integer weight, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this(new Camera.Area(rect.rect, weight), rect, implementations, create);
  }

  public CameraAreaProxy(Camera.Area area, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this(area, new CameraRectProxy(area.rect, implementations), implementations, create);
  }

  public CameraAreaProxy(Camera.Area area, CameraRectProxy rect, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this.area = area;
    this.rect = rect;
    if (create) {
      implementations.getChannelCameraArea().$create$(this, false, rect, area.weight);
    }
  }
}
