package bparrishMines.penguin.penguin_camera.camera;

import java.util.ArrayList;
import java.util.List;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.ReferenceChannelManager;
import io.flutter.view.TextureRegistry;

public class Camera implements CameraChannelLibrary.$Camera {
  private final CameraChannel channel;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;
  private final android.hardware.Camera camera;

  private static class CameraChannel extends CameraChannelLibrary.$CameraChannel {
    final TextureRegistry textureRegistry;

    CameraChannel(@NonNull ReferenceChannelManager manager, TextureRegistry textureRegistry) {
      super(manager);
      this.textureRegistry = textureRegistry;
    }
  }

  public static void setupChannel(ReferenceChannelManager manager, TextureRegistry textureRegistry) {
    final CameraChannel channel = new CameraChannel(manager, textureRegistry);
    channel.registerHandler(new CameraChannelLibrary.$CameraHandler() {
      @Override
      public Object $onGetAllCameraInfo(ReferenceChannelManager manager) throws Exception {
        return Camera.getAllCameraInfo();
      }

      @Override
      public Object $onOpen(ReferenceChannelManager manager, Integer cameraId) {
        return Camera.open(channel, cameraId);
      }
    });
  }

  static Camera open(CameraChannel channel, int cameraId) {
    final Camera camera = new Camera(channel, android.hardware.Camera.open(cameraId));
    channel.createNewPair(camera);
    return camera;
  }

  static List<CameraInfo> getAllCameraInfo() {
    final List<CameraInfo> allCameraInfo = new ArrayList<>();

    int numOfCameras = android.hardware.Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final android.hardware.Camera.CameraInfo info = new android.hardware.Camera.CameraInfo();
      android.hardware.Camera.getCameraInfo(i, info);
      allCameraInfo.add(new CameraInfo(i, info));
    }

    return allCameraInfo;
  }

  private Camera(CameraChannel channel, android.hardware.Camera camera) {
    this.channel = channel;
    this.camera = camera;
  }

  @Override
  public Object release() throws Exception {
    camera.release();
    return null;
  }

  @Override
  public Object startPreview() throws Exception {
    camera.startPreview();
    return null;
  }

  @Override
  public Object stopPreview() throws Exception {
    camera.stopPreview();
    return null;
  }

  @Override
  public Long attachPreviewToTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = channel.textureRegistry.createSurfaceTexture();
    camera.setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  @Override
  public Object releaseTexture() throws Exception {
    if (currentTextureEntry == null) return null;
    camera.setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }
}
