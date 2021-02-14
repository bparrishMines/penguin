package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class CameraProxy implements CameraChannelLibrary.$Camera {
  private final TextureRegistry textureRegistry;
  private final Camera camera;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public CameraProxy(Camera camera, TextureRegistry textureRegistry) {
    this.camera = camera;
    this.textureRegistry = textureRegistry;
  }

  public static CameraProxy open(TypeChannelMessenger messenger, TextureRegistry textureRegistry, int cameraId) {
    final CameraProxy cameraProxy = new CameraProxy(Camera.open(cameraId), textureRegistry);
    new Channels.CameraChannel(messenger).createNewInstancePair(cameraProxy);
    return cameraProxy;
  }

  public static List<CameraInfoProxy> getAllCameraInfo(TypeChannelMessenger messenger) {
    final List<CameraInfoProxy> allCameraInfoProxy = new ArrayList<>();

    int numOfCameras = Camera.getNumberOfCameras();
    for (int i = 0; i < numOfCameras; i++) {
      final Camera.CameraInfo info = new Camera.CameraInfo();
      Camera.getCameraInfo(i, info);
      allCameraInfoProxy.add(new CameraInfoProxy(info, messenger, i));
    }

    return allCameraInfoProxy;
  }

  public Camera getCamera() {
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
  public Void takePicture(CameraChannelLibrary.$ShutterCallback shutter,
                          CameraChannelLibrary.$PictureCallback raw,
                          CameraChannelLibrary.$PictureCallback postView,
                          CameraChannelLibrary.$PictureCallback jpeg) {
    takePicture((ShutterCallbackProxy) shutter, (PictureCallbackProxy) raw, (PictureCallbackProxy) postView, (PictureCallbackProxy) jpeg);
    return null;
  }

  private Void takePicture(ShutterCallbackProxy shutter,
                           PictureCallbackProxy raw,
                           PictureCallbackProxy postView,
                           PictureCallbackProxy jpeg) {
    getCamera().takePicture(shutter != null ? shutter.getShutterCallback() : null,
        raw != null ? raw.getPictureCallback() : null,
        postView != null ? postView.getPictureCallback() : null,
        jpeg != null ? jpeg.getPictureCallback() : null);
    return null;
  }

  @Override
  public Long attachPreviewTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = getTextureRegistry().createSurfaceTexture();
    getCamera().setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  @Override
  public Void releasePreviewTexture() throws Exception {
    if (currentTextureEntry == null) return null;
    getCamera().setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }
}
