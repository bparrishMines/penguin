package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraSizeProxy implements CameraChannelLibrary.$CameraSize {
  public final Camera.Size cameraSize;

  public static List<CameraSizeProxy> fromList(List<Camera.Size> sizes, ChannelRegistrar.LibraryImplementations implementations) {
    final List<CameraSizeProxy> proxyList = new ArrayList<>();
    for (Camera.Size size : sizes) {
      proxyList.add(new CameraSizeProxy(size, implementations));
    }
    return proxyList;
  }

  public CameraSizeProxy(Camera.Size cameraSize, ChannelRegistrar.LibraryImplementations implementations) {
    this.cameraSize = cameraSize;
    implementations.getCameraSizeChannel().createNewInstancePair(this, false);
  }

  @Override
  public Integer getWidth() {
    return cameraSize.width;
  }

  @Override
  public Integer getHeight() {
    return cameraSize.height;
  }
}
