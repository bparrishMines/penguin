package dev.penguin.android_hardware;

import android.graphics.SurfaceTexture;
import android.hardware.Camera;
import android.os.Build;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.mockito.stubbing.Answer;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.io.IOException;
import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

import static dev.penguin.android_hardware.Utils.setFinalStatic;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.isA;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.doAnswer;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PowerMockIgnore("jdk.internal.reflect.*")
@PrepareForTest({android.hardware.Camera.class})
public class CameraTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Mock
  TextureRegistry mockTextureRegistry;

  LibraryImplementations testImplementations;

  @Mock
  CameraChannelLibrary.$CameraProxyChannel mockCameraChannel;

  @Mock
  android.hardware.Camera mockCamera;

  public CameraProxy testCameraProxy;

  @Before
  public void setUp() {
    testImplementations = new LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    testImplementations.channelCameraProxy = mockCameraChannel;
    testCameraProxy = new CameraProxy(this.testImplementations, true, mockCamera);
  }

  @Test
  public void cameraError() {
    assertEquals(Camera.CAMERA_ERROR_UNKNOWN, 0x00000001);
    assertEquals(Camera.CAMERA_ERROR_SERVER_DIED, 0x00000064);
    assertEquals(Camera.CAMERA_ERROR_EVICTED, 0x00000002);
  }

  @Test
  public void createCamera() {
    verify(mockCameraChannel).$create$(testCameraProxy, false);
  }

  @Test
  public void open() throws Exception {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    when(Camera.open(12)).thenReturn(mock(Camera.class));

    final CameraProxy camera = testImplementations.handlerCameraProxy.$open(12);
    assertNotNull(camera);
    assertNotNull(camera.camera);

    verifyStatic();
    Camera.open(12);
  }

  @Test
  public void getAllCameraInfo() throws Exception {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    when(android.hardware.Camera.getNumberOfCameras()).thenReturn(1);
    doAnswer((Answer<Void>) invocation -> {
      final android.hardware.Camera.CameraInfo cameraInfo = (android.hardware.Camera.CameraInfo) invocation.getArguments()[1];
      cameraInfo.facing = 11;
      cameraInfo.orientation = 12;
      return null;
    }).when(android.hardware.Camera.class);
    android.hardware.Camera.getCameraInfo(eq(0), any(android.hardware.Camera.CameraInfo.class));

    final List<CameraInfoProxy> allInfo = testImplementations.handlerCameraProxy.$getAllCameraInfo();

    assertEquals(allInfo.size(), 1);
    assertEquals(allInfo.get(0).cameraInfo.facing, 11);
    assertEquals(allInfo.get(0).cameraInfo.orientation, 12);
  }

  @Test
  public void release() {
    testCameraProxy.release();
    verify(mockCamera).release();
  }

  @Test
  public void startPreview() {
    testCameraProxy.startPreview();
    verify(mockCamera).startPreview();
  }

  @Test
  public void stopPreview() {
    testCameraProxy.stopPreview();
    verify(mockCamera).stopPreview();
  }

  @Test
  public void attachPreviewTexture() throws Exception {
    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(3L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    assertEquals(testCameraProxy.attachPreviewTexture(), (Long) 3L);
    verify(mockCamera).setPreviewTexture(mockTexture);
  }

  @Test
  public void releasePreviewTexture() throws Exception {
    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    testCameraProxy.attachPreviewTexture();
    testCameraProxy.releasePreviewTexture();

    verify(mockCamera).setPreviewTexture(null);
    verify(mockEntry).release();
  }

  // TODO: Test callback is called.
  @Test
  public void takePicture() {
    final ShutterCallback shutterCallback = () -> null;

    final PictureCallbackProxy pictureCallbackProxy = new PictureCallbackProxy(testImplementations, false, data -> null);

    testCameraProxy.takePicture(shutterCallback, pictureCallbackProxy, pictureCallbackProxy, pictureCallbackProxy);
    verify(mockCamera).takePicture(
        isA(Camera.ShutterCallback.class),
        isA(Camera.PictureCallback.class),
        isA(Camera.PictureCallback.class),
        isA(Camera.PictureCallback.class));
  }

  @Test
  public void unlock() {
    testCameraProxy.unlock();
    verify(mockCamera).unlock();
  }

  // TODO: Test callback is called.
  @Test
  public void autoFocus() {
    final AutoFocusCallbackHandler autoFocusCallback = success -> null;
    testCameraProxy.autoFocus(autoFocusCallback);
    verify(mockCamera).autoFocus(isA(Camera.AutoFocusCallback.class));
  }

  @Test
  public void cancelAutoFocus() {
    testCameraProxy.cancelAutoFocus();
    verify(mockCamera).cancelAutoFocus();
  }

  @Test
  public void setDisplayOrientation() {
    testCameraProxy.setDisplayOrientation(15);
    verify(mockCamera).setDisplayOrientation(15);
  }

  // TODO: Test callback is called.
  @Test
  public void setErrorCallback() {
    final ErrorCallback errorCallback = error -> null;
    testCameraProxy.setErrorCallback(errorCallback);
    verify(mockCamera).setErrorCallback(isA(Camera.ErrorCallback.class));
  }

  @Test
  public void startSmoothZoom() {
    testCameraProxy.startSmoothZoom(15);
    verify(mockCamera).startSmoothZoom(15);
  }

  @Test
  public void stopSmoothZoom() {
    testCameraProxy.stopSmoothZoom();
    verify(mockCamera).stopSmoothZoom();
  }

  @Test
  public void getParameters() {
    final ParametersHandler cameraParametersProxy = testCameraProxy.getParameters();
    verify(mockCamera).getParameters();
    assertNotNull(cameraParametersProxy);
  }
  
  @Test
  public void setOneShotPreviewCallback() {
    final DataCallback mockDataCallback = mock(DataCallback.class);
    final PreviewCallbackProxy previewCallbackProxy = new PreviewCallbackProxy(testImplementations, false, mockDataCallback);

    testCameraProxy.setOneShotPreviewCallback(previewCallbackProxy);

    final byte[] data = new byte[0];
    final ArgumentCaptor<Camera.PreviewCallback> callbackCaptor = ArgumentCaptor.forClass(Camera.PreviewCallback.class);
    verify(mockCamera).setOneShotPreviewCallback(callbackCaptor.capture());
    callbackCaptor.getValue().onPreviewFrame(data, mockCamera);
    verify(mockDataCallback).invoke(data);
  }
  
  @Test
  public void setPreviewCallback() {
    final DataCallback mockDataCallback = mock(DataCallback.class);
    final PreviewCallbackProxy previewCallbackProxy = new PreviewCallbackProxy(testImplementations, false, mockDataCallback);

    testCameraProxy.setPreviewCallback(previewCallbackProxy);

    final byte[] data = new byte[0];
    final ArgumentCaptor<Camera.PreviewCallback> callbackCaptor = ArgumentCaptor.forClass(Camera.PreviewCallback.class);
    verify(mockCamera).setPreviewCallback(callbackCaptor.capture());
    callbackCaptor.getValue().onPreviewFrame(data, mockCamera);
    verify(mockDataCallback).invoke(data);
  }

  @Test
  public void reconnect() throws IOException {
    testCameraProxy.reconnect();
    verify(mockCamera).reconnect();
  }
  
  // TODO: Test callback is called.
  @Test
  public void setZoomChangeListener() {
    final OnZoomChangeListener zoomChangeListener = (zoomValue, stopped) -> null;
    
    testCameraProxy.setZoomChangeListener(zoomChangeListener);
    verify(mockCamera).setZoomChangeListener(isA(Camera.OnZoomChangeListener.class));
  }

  // TODO: Test callback is called.
  @Test
  public void setAutoFocusMoveCallback() {
    final AutoFocusMoveCallback autoFocusMoveCallback = start -> null;

    testCameraProxy.setAutoFocusMoveCallback(autoFocusMoveCallback);
    verify(mockCamera).setAutoFocusMoveCallback(isA(Camera.AutoFocusMoveCallback.class));
  }

  @Test
  public void lock() {
    testCameraProxy.lock();
    verify(mockCamera).lock();
  }

  @Test
  public void enableShutterSound() throws Exception {
    setFinalStatic(Build.VERSION.class.getField("SDK_INT"), Build.VERSION_CODES.JELLY_BEAN_MR1);
    
    testCameraProxy.enableShutterSound(true);
    verify(mockCamera).enableShutterSound(true);
  }
}
