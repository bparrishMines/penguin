package dev.penguin.android_hardware;

import android.graphics.Rect;
import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class AreaHandler extends CameraChannelLibrary.$AreaHandler {
  public AreaHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  //  public final LibraryImplementations implementations;
//  public final Camera.Area area;
//
//  public AreaHandler(
//      CameraChannelLibrary.$LibraryImplementations implementations,
//      boolean create,
//      RectHandler rect,
//      Integer weight) {
//    this((LibraryImplementations) implementations, create, new Camera.Area(rect.rect, weight));
//  }
//
//  public AreaHandler(LibraryImplementations implementations, boolean create, Camera.Area area) {
//    this.implementations = implementations;
//    this.area = area;
//    if (create) {
//      implementations.channelCameraAreaProxy.$create$(
//          this, false, new RectHandler(implementations, true, area.rect), area.weight);
//    }
//  }
//
//  public static List<AreaHandler> fromList(
//      LibraryImplementations implementations, List<Camera.Area> areas) {
//    final List<AreaHandler> proxyList = new ArrayList<>();
//    if (areas == null) return proxyList;
//    for (Camera.Area area : areas) {
//      proxyList.add(new AreaHandler(implementations, true, area));
//    }
//    return proxyList;
//  }
//
//  public static List<Camera.Area> toAreaList(List<AreaHandler> proxies) {
//    final List<Camera.Area> areaList = new ArrayList<>();
//    for (AreaHandler proxy : proxies) {
//      areaList.add(proxy.area);
//    }
//    return areaList;
//  }
}
