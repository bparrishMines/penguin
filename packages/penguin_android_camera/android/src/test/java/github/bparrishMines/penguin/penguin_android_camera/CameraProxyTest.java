package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.SurfaceTexture;
import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.mockito.stubbing.Answer;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.isA;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.doAnswer;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PrepareForTest({android.hardware.Camera.class})
public class CameraProxyTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Mock
  TextureRegistry mockTextureRegistry;

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraChannel mockCameraChannel;

  @Mock
  android.hardware.Camera mockCamera;

  public CameraProxy testCameraProxy;

  @Before
  public void setUp() {
    Mockito.when(mockImplementations.getChannelCamera()).thenReturn(mockCameraChannel);
    testCameraProxy = new CameraProxy(mockCamera, mockTextureRegistry, mockImplementations);
  }

  @Test
  public void createCamera() {
    verify(mockCameraChannel).$$create(testCameraProxy, false);
  }

  @Test
  public void open() {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    libraryImplementations.getHandlerCamera().$open(mockTypeChannelMessenger, 12);

    verifyStatic();
    android.hardware.Camera.open(12);
  }

  @Test
  public void getAllCameraInfo() {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    when(android.hardware.Camera.getNumberOfCameras()).thenReturn(1);
    doAnswer((Answer<Void>) invocation -> {
      final android.hardware.Camera.CameraInfo cameraInfo = (android.hardware.Camera.CameraInfo) invocation.getArguments()[1];
      cameraInfo.facing = 11;
      cameraInfo.orientation = 12;
      return null;
    }).when(android.hardware.Camera.class);
    android.hardware.Camera.getCameraInfo(eq(0), any(android.hardware.Camera.CameraInfo.class));

    final CameraChannelLibrary.$CameraInfoChannel mockCameraInfoChannel = mock(CameraChannelLibrary.$CameraInfoChannel.class);

    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    final List<CameraInfoProxy> allInfo = libraryImplementations.getHandlerCamera().$getAllCameraInfo(mockTypeChannelMessenger);

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

  @Test
  public void takePicture() {
    final CameraChannelLibrary.$ShutterCallback shutterCallback = new CameraChannelLibrary.$ShutterCallback() {

      @Override
      public Object invoke() {
        return null;
      }
    };

    final CameraChannelLibrary.$PictureCallback pictureCallback = new CameraChannelLibrary.$PictureCallback() {
      @Override
      public Object invoke(byte[] data) {
        return null;
      }
    };

    testCameraProxy.takePicture(shutterCallback, pictureCallback, pictureCallback, pictureCallback);
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
}
