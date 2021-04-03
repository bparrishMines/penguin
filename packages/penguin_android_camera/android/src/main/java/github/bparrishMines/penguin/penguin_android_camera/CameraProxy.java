package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class CameraProxy implements CameraChannelLibrary.$Camera {
  public final Camera camera;
  public final TextureRegistry textureRegistry;
  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public CameraProxy(Camera camera, TextureRegistry textureRegistry) {
    this.camera = camera;
    this.textureRegistry = textureRegistry;
  }

  public static CameraProxy open(TypeChannelMessenger messenger, TextureRegistry textureRegistry, int cameraId) {
    final CameraProxy cameraProxy = new CameraProxy(Camera.open(cameraId), textureRegistry);
    new Channels.CameraChannel(messenger).createNewInstancePair(cameraProxy, false);
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

  @Override
  public Void release() {
    camera.release();
    return null;
  }

  @Override
  public Void startPreview() {
    camera.startPreview();
    return null;
  }

  @Override
  public Void stopPreview() {
    camera.stopPreview();
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
    camera.takePicture(shutter != null ? shutter.shutterCallback : null,
        raw != null ? raw.pictureCallback : null,
        postView != null ? postView.pictureCallback : null,
        jpeg != null ? jpeg.pictureCallback : null);
    return null;
  }

  @Override
  public Long attachPreviewTexture() throws Exception {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = textureRegistry.createSurfaceTexture();
    camera.setPreviewTexture(currentTextureEntry.surfaceTexture());
    return currentTextureEntry.id();
  }

  @Override
  public Void releasePreviewTexture() throws Exception {
    if (currentTextureEntry == null) return null;
    camera.setPreviewTexture(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }

  @Override
  public Void unlock() {
    camera.unlock();
    return null;
  }
}
