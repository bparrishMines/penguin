package dev.penguin.android_hardware;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.doAnswer;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;
import static dev.penguin.android_hardware.Utils.setFinalStatic;

import android.graphics.SurfaceTexture;
import android.hardware.Camera;
import android.os.Build;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.mockito.stubbing.Answer;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

@RunWith(PowerMockRunner.class)
@PowerMockIgnore("jdk.internal.reflect.*")
@PrepareForTest({android.hardware.Camera.class})
public class CameraTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();
  public CameraProxyHandler.CameraProxy testCameraProxy;
  @Mock TypeChannelMessenger mockTypeChannelMessenger;
  @Mock TextureRegistry mockTextureRegistry;
  LibraryImplementations testImplementations;
  @Mock CameraChannelLibrary.$CameraProxyChannel mockCameraChannel;
  @Mock CameraChannelLibrary.$ParametersChannel mockParametersChannel;
  @Mock android.hardware.Camera mockCamera;

  @Before
  public void setUp() {
    testImplementations = new LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    testImplementations.channelCameraProxy = mockCameraChannel;
    testImplementations.channelParameters = mockParametersChannel;
    testCameraProxy = new CameraProxyHandler.CameraProxy(this.testImplementations, mockCamera);
  }

  @Test
  public void cameraError() {
    assertEquals(Camera.CAMERA_ERROR_UNKNOWN, 0x00000001);
    assertEquals(Camera.CAMERA_ERROR_SERVER_DIED, 0x00000064);
    assertEquals(Camera.CAMERA_ERROR_EVICTED, 0x00000002);
  }

  @Test
  public void open() throws Exception {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    when(Camera.open(12)).thenReturn(mock(Camera.class));

    final CameraProxyHandler.CameraProxy cameraProxy =
        testImplementations.handlerCameraProxy.$open(12);
    assertNotNull(cameraProxy);
    assertNotNull(cameraProxy.camera);
    verify(mockCameraChannel).$create$(cameraProxy, false);

    verifyStatic();
    Camera.open(12);
  }

  @Test
  public void getAllCameraInfo() throws Exception {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    when(android.hardware.Camera.getNumberOfCameras()).thenReturn(1);
    doAnswer(
            (Answer<Void>)
                invocation -> {
                  final android.hardware.Camera.CameraInfo cameraInfo =
                      (android.hardware.Camera.CameraInfo) invocation.getArguments()[1];
                  cameraInfo.facing = 11;
                  cameraInfo.orientation = 12;
                  return null;
                })
        .when(android.hardware.Camera.class);
    android.hardware.Camera.getCameraInfo(eq(0), any(android.hardware.Camera.CameraInfo.class));

    final List<CameraInfoProxyHandler.CameraInfoProxy> allInfo =
        testImplementations.handlerCameraProxy.$getAllCameraInfo();

    assertEquals(allInfo.size(), 1);
    assertEquals(allInfo.get(0).facing, 11);
    assertEquals(allInfo.get(0).orientation, 12);
  }

  @Test
  public void release() throws Exception {
    testImplementations.handlerCameraProxy.$release(testCameraProxy);
    verify(mockCamera).release();
  }

  @Test
  public void startPreview() throws Exception {
    testImplementations.handlerCameraProxy.$startPreview(testCameraProxy);
    verify(mockCamera).startPreview();
  }

  @Test
  public void stopPreview() throws Exception {
    testImplementations.handlerCameraProxy.$stopPreview(testCameraProxy);
    verify(mockCamera).stopPreview();
  }

  @Test
  public void attachPreviewTexture() throws Exception {
    final TextureRegistry.SurfaceTextureEntry mockEntry =
        mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(3L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    assertEquals(testCameraProxy.attachPreviewTexture(), (Long) 3L);
    verify(mockCamera).setPreviewTexture(mockTexture);
  }

  @Test
  public void releasePreviewTexture() throws Exception {
    final TextureRegistry.SurfaceTextureEntry mockEntry =
        mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    testCameraProxy.attachPreviewTexture();
    testCameraProxy.releasePreviewTexture();

    verify(mockCamera).setPreviewTexture(null);
    verify(mockEntry).release();
  }

  @Test
  public void takePicture() throws Exception {
    final Camera.ShutterCallback shutterCallback = mock(Camera.ShutterCallback.class);
    final Camera.PictureCallback rawCallback = mock(Camera.PictureCallback.class);
    final Camera.PictureCallback postViewCallback = mock(Camera.PictureCallback.class);
    final Camera.PictureCallback jpegCallback = mock(Camera.PictureCallback.class);

    testImplementations.handlerCameraProxy.$takePicture(
        testCameraProxy, shutterCallback, rawCallback, postViewCallback, jpegCallback);
    verify(mockCamera).takePicture(shutterCallback, rawCallback, postViewCallback, jpegCallback);
  }

  @Test
  public void unlock() throws Exception {
    testImplementations.handlerCameraProxy.$unlock(testCameraProxy);
    verify(mockCamera).unlock();
  }

  @Test
  public void autoFocus() throws Exception {
    final Camera.AutoFocusCallback autoFocusCallback = mock(Camera.AutoFocusCallback.class);
    testImplementations.handlerCameraProxy.$autoFocus(testCameraProxy, autoFocusCallback);
    verify(mockCamera).autoFocus(autoFocusCallback);
  }

  @Test
  public void cancelAutoFocus() throws Exception {
    testImplementations.handlerCameraProxy.$cancelAutoFocus(testCameraProxy);
    verify(mockCamera).cancelAutoFocus();
  }

  @Test
  public void setDisplayOrientation() throws Exception {
    testImplementations.handlerCameraProxy.$setDisplayOrientation(testCameraProxy, 15);
    verify(mockCamera).setDisplayOrientation(15);
  }

  @Test
  public void setErrorCallback() throws Exception {
    final Camera.ErrorCallback errorCallback = mock(Camera.ErrorCallback.class);
    testImplementations.handlerCameraProxy.$setErrorCallback(testCameraProxy, errorCallback);
    verify(mockCamera).setErrorCallback(errorCallback);
  }

  @Test
  public void startSmoothZoom() throws Exception {
    testImplementations.handlerCameraProxy.$startSmoothZoom(testCameraProxy, 15);
    verify(mockCamera).startSmoothZoom(15);
  }

  @Test
  public void stopSmoothZoom() throws Exception {
    testImplementations.handlerCameraProxy.$stopSmoothZoom(testCameraProxy);
    verify(mockCamera).stopSmoothZoom();
  }

  @Test
  public void getParameters() throws Exception {
    final Camera.Parameters mockParameters = mock(Camera.Parameters.class);
    when(mockCamera.getParameters()).thenReturn(mockParameters);

    final Camera.Parameters cameraParameters =
        testImplementations.handlerCameraProxy.$getParameters(testCameraProxy);
    verify(mockCamera).getParameters();
    assertEquals(cameraParameters, mockParameters);
    verify(mockParametersChannel).$create$(mockParameters, false);
  }

  @Test
  public void setOneShotPreviewCallback() throws Exception {
    final Camera.PreviewCallback previewCallback = mock(Camera.PreviewCallback.class);
    testImplementations.handlerCameraProxy.$setOneShotPreviewCallback(
        testCameraProxy, previewCallback);
    verify(mockCamera).setOneShotPreviewCallback(previewCallback);
  }

  @Test
  public void setPreviewCallback() throws Exception {
    final Camera.PreviewCallback previewCallback = mock(Camera.PreviewCallback.class);
    testImplementations.handlerCameraProxy.$setPreviewCallback(testCameraProxy, previewCallback);
    verify(mockCamera).setPreviewCallback(previewCallback);
  }

  @Test
  public void reconnect() throws Exception {
    testImplementations.handlerCameraProxy.$reconnect(testCameraProxy);
    verify(mockCamera).reconnect();
  }

  @Test
  public void setZoomChangeListener() throws Exception {
    final Camera.OnZoomChangeListener zoomChangeListener = mock(Camera.OnZoomChangeListener.class);
    testImplementations.handlerCameraProxy.$setZoomChangeListener(
        testCameraProxy, zoomChangeListener);
    verify(mockCamera).setZoomChangeListener(zoomChangeListener);
  }

  @Test
  public void setAutoFocusMoveCallback() throws Exception {
    final Camera.AutoFocusMoveCallback autoFocusMoveCallback =
        mock(Camera.AutoFocusMoveCallback.class);
    testImplementations.handlerCameraProxy.$setAutoFocusMoveCallback(
        testCameraProxy, autoFocusMoveCallback);
    verify(mockCamera).setAutoFocusMoveCallback(autoFocusMoveCallback);
  }

  @Test
  public void lock() throws Exception {
    testImplementations.handlerCameraProxy.$lock(testCameraProxy);
    verify(mockCamera).lock();
  }

  @Test
  public void enableShutterSound() throws Exception {
    setFinalStatic(Build.VERSION.class.getField("SDK_INT"), Build.VERSION_CODES.JELLY_BEAN_MR1);

    testImplementations.handlerCameraProxy.$enableShutterSound(testCameraProxy, true);
    verify(mockCamera).enableShutterSound(true);
  }
}
