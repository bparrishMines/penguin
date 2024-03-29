package dev.penguin.android_hardware;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraSizeProxy implements CameraChannelLibrary.$CameraSize {
  public final Camera.Size cameraSize;

  public static List<CameraSizeProxy> fromList(List<Camera.Size> sizes, ChannelRegistrar.LibraryImplementations implementations) {
    final List<CameraSizeProxy> proxyList = new ArrayList<>();
    for (Camera.Size size : sizes) {
      proxyList.add(new CameraSizeProxy(size, implementations, true));
    }
    return proxyList;
  }

  public CameraSizeProxy(Camera.Size cameraSize, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this.cameraSize = cameraSize;
    if (create) {
      implementations.getChannelCameraSize().$create$(this, false, cameraSize.width, cameraSize.height);
    }
  }
}
