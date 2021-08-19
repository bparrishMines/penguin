package dev.penguin.android_hardware;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraAreaProxy {
  public final LibraryImplementations implementations;
  public final Camera.Area area;

  public CameraAreaProxy(
      CameraChannelLibrary.$LibraryImplementations implementations,
      boolean create,
      CameraRectProxy rect,
      Integer weight) {
    this((LibraryImplementations) implementations, create, new Camera.Area(rect.rect, weight));
  }

  public CameraAreaProxy(LibraryImplementations implementations, boolean create, Camera.Area area) {
    this.implementations = implementations;
    this.area = area;
    if (create) {
      implementations.channelCameraAreaProxy.$create$(
          this, false, new CameraRectProxy(implementations, true, area.rect), area.weight);
    }
  }

  public static List<CameraAreaProxy> fromList(
      LibraryImplementations implementations, List<Camera.Area> areas) {
    final List<CameraAreaProxy> proxyList = new ArrayList<>();
    if (areas == null) return proxyList;
    for (Camera.Area area : areas) {
      proxyList.add(new CameraAreaProxy(implementations, true, area));
    }
    return proxyList;
  }

  public static List<Camera.Area> toAreaList(List<CameraAreaProxy> proxies) {
    final List<Camera.Area> areaList = new ArrayList<>();
    for (CameraAreaProxy proxy : proxies) {
      areaList.add(proxy.area);
    }
    return areaList;
  }
}
