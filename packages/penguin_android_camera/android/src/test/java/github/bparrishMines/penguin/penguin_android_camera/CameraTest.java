package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.SurfaceTexture;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
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
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.doAnswer;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PrepareForTest({android.hardware.Camera.class})
public class CameraTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TextureRegistry mockTextureRegistry;

  @Mock
  TypeChannelMessenger mockTypeMessenger;

  @Mock
  android.hardware.Camera mockCamera;

  @Test
  public void open() {
    PowerMockito.mockStatic(android.hardware.Camera.class);

    Camera.open(mockTypeMessenger, mockTextureRegistry, 12);

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

    final List<CameraInfo> allInfo = Camera.getAllCameraInfo(null);

    assertEquals(allInfo.size(), 1);
    assertEquals(allInfo.get(0).getFacing(), (Integer) 11);
    assertEquals(allInfo.get(0).getOrientation(), (Integer) 12);
  }

  @Test
  public void release() {
    final Camera camera = new Camera(mockCamera, mockTextureRegistry);

    camera.release();
    verify(mockCamera).release();
  }

  @Test
  public void startPreview() {
    final Camera camera = new Camera(mockCamera, mockTextureRegistry);

    camera.startPreview();
    verify(mockCamera).startPreview();
  }

  @Test
  public void stopPreview() {
    final Camera camera = new Camera(mockCamera, mockTextureRegistry);

    camera.stopPreview();
    verify(mockCamera).stopPreview();
  }

  @Test
  public void attachPreviewToTexture() throws Exception {
    final Camera camera = new Camera(mockCamera, mockTextureRegistry);

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(3L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    assertEquals(camera.attachPreviewToTexture(), (Long) 3L);
    verify(mockCamera).setPreviewTexture(mockTexture);
  }

  @Test
  public void releaseTexture() throws Exception {
    final Camera camera = new Camera(mockCamera, mockTextureRegistry);

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    camera.attachPreviewToTexture();
    camera.releaseTexture();

    verify(mockCamera).setPreviewTexture(null);
    verify(mockEntry).release();
  }
}
