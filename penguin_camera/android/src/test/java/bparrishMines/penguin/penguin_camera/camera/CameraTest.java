package bparrishMines.penguin.penguin_camera.camera;

import android.graphics.SurfaceTexture;
import android.hardware.Camera;

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
@PrepareForTest( { android.hardware.Camera.class })
public class CameraTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TextureRegistry mockTextureRegistry;

  @Mock
  CameraChannelLibrary.$CameraChannel mockChannel;

  @Mock
  Camera mockCamera;

  @Test
  public void open() {
    PowerMockito.mockStatic(Camera.class);

    bparrishMines.penguin.penguin_camera.camera.Camera.open(mockTextureRegistry, mockChannel, 12);

    verifyStatic();
    Camera.open(12);
  }

  @Test
  public void getAllCameraInfo() {
    PowerMockito.mockStatic(Camera.class);

    when(Camera.getNumberOfCameras()).thenReturn(1);
    doAnswer((Answer<Void>) invocation -> {
      final Camera.CameraInfo cameraInfo = (Camera.CameraInfo) invocation.getArguments()[1];
      cameraInfo.facing = 11;
      cameraInfo.orientation = 12;
      return null;
    }).when(Camera.class);
    Camera.getCameraInfo(eq(0), any(Camera.CameraInfo.class));

    final List<CameraInfo> allInfo =
        bparrishMines.penguin.penguin_camera.camera.Camera.getAllCameraInfo(null);

    assertEquals(allInfo.size(), 1);
    assertEquals(allInfo.get(0).getFacing(), (Integer) 11);
    assertEquals(allInfo.get(0).getOrientation(), (Integer) 12);
  }

  @Test
  public void release() {
    final bparrishMines.penguin.penguin_camera.camera.Camera camera =
        new bparrishMines.penguin.penguin_camera.camera.Camera(mockCamera, mockTextureRegistry);

    camera.release();
    verify(mockCamera).release();
  }

  @Test
  public void startPreview() {
    final bparrishMines.penguin.penguin_camera.camera.Camera camera =
        new bparrishMines.penguin.penguin_camera.camera.Camera(mockCamera, mockTextureRegistry);

    camera.startPreview();
    verify(mockCamera).startPreview();
  }

  @Test
  public void stopPreview() {
    final bparrishMines.penguin.penguin_camera.camera.Camera camera =
        new bparrishMines.penguin.penguin_camera.camera.Camera(mockCamera, mockTextureRegistry);

    camera.stopPreview();
    verify(mockCamera).stopPreview();
  }

  @Test
  public void attachPreviewToTexture() throws Exception {
    final bparrishMines.penguin.penguin_camera.camera.Camera camera =
        new bparrishMines.penguin.penguin_camera.camera.Camera(mockCamera, mockTextureRegistry);

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    assertEquals(camera.attachPreviewToTexture(), (Long) 0L);
    verify(mockCamera).setPreviewTexture(mockTexture);
  }

  @Test
  public void releaseTexture() throws Exception {
    final bparrishMines.penguin.penguin_camera.camera.Camera camera =
        new bparrishMines.penguin.penguin_camera.camera.Camera(mockCamera, mockTextureRegistry);

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    camera.attachPreviewToTexture();
    camera.releaseTexture();
    verify(mockCamera).setPreviewTexture(null);
  }
}
