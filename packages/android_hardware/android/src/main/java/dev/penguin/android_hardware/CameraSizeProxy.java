package dev.penguin.android_hardware;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraSizeProxy {
  public final LibraryImplementations implementations;
  public final Camera.Size cameraSize;

  public static List<CameraSizeProxy> fromList(LibraryImplementations implementations, List<Camera.Size> sizes) {
    final List<CameraSizeProxy> proxyList = new ArrayList<>();
    for (Camera.Size size : sizes) {
      proxyList.add(new CameraSizeProxy(implementations, true, size));
    }
    return proxyList;
  }

  public CameraSizeProxy(CameraChannelLibrary.$LibraryImplementations implementations, boolean create, Integer width, Integer height) {
    throw new UnsupportedOperationException();
  }

  public CameraSizeProxy(LibraryImplementations implementations, boolean create, Camera.Size cameraSize) {
    this.implementations = implementations;
    this.cameraSize = cameraSize;
    if (create) {
      implementations.channelCameraSizeProxy.$create$(this, false, cameraSize.width, cameraSize.height);
    }
  }
}
