package bparrishMines.penguin.penguin_camera.camera;

import java.util.ArrayList;
import java.util.List;
import github.penguin.reference.reference.ReferenceChannelManager;
import io.flutter.view.TextureRegistry;

public class Camera implements CameraChannelLibrary.$Camera {
  private final TextureRegistry textureRegistry;
  private final android.hardware.Camera camera;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public static void setupChannel(ReferenceChannelManager manager,  TextureRegistry textureRegistry) {
    final CameraChannelLibrary.$CameraChannel channel =
        new CameraChannelLibrary.$CameraChannel(manager);
    channel.registerHandler(new CameraChannelLibrary.$CameraHandler() {
      @Override
      public Object $onGetAllCameraInfo(ReferenceChannelManager manager) {
        return Camera.getAllCameraInfo(manager);
      }

      @Override
      public Object $onOpen(ReferenceChannelManager manager, Integer cameraId) {
        return Camera.open(textureRegistry, channel, cameraId);
      }
    });
  }

  public static Camera open(TextureRegistry textureRegistry, CameraChannelLibrary.$CameraChannel channel, int cameraId) {
    final Camera camera = new Camera(android.hardware.Camera.open(cameraId), textureRegistry);
    channel.createNewPair(camera);
    return camera;
  }

  public static List<CameraInfo> getAllCameraInfo(ReferenceChannelManager manager) {
    final List<CameraInfo> allCameraInfo = new ArrayList<>();

    int numOfCameras = android.hardware.Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final android.hardware.Camera.CameraInfo info = new android.hardware.Camera.CameraInfo();
      android.hardware.Camera.getCameraInfo(i, info);
      allCameraInfo.add(new CameraInfo(manager, i, info));
    }

    return allCameraInfo;
  }

  public Camera(android.hardware.Camera camera, TextureRegistry textureRegistry) {
    this.camera = camera;
    this.textureRegistry = textureRegistry;
  }

  public android.hardware.Camera getCamera() {
    return camera;
  }


  public TextureRegistry getTextureRegistry() {
    return textureRegistry;
  }

  @Override
  public Void release() {
    getCamera().release();
    return null;
  }

  @Override
  public Void startPreview() {
    getCamera().startPreview();
    return null;
  }

  @Override
  public Void stopPreview() {
    getCamera().stopPreview();
    return null;
  }

  @Override
  public Long attachPreviewToTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = getTextureRegistry().createSurfaceTexture();
    getCamera().setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  @Override
  public Void releaseTexture() throws Exception {
    if (currentTextureEntry == null) return null;
    getCamera().setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }
}
