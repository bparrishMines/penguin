package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.Rect;
import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraAreaTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraRectChannel mockCameraRectChannel;

  @Mock
  CameraChannelLibrary.$CameraAreaChannel mockCameraAreaChannel;

  @Before
  public void setup() {
    when(mockImplementations.getChannelCameraRect()).thenReturn(mockCameraRectChannel);
    when(mockImplementations.getChannelCameraArea()).thenReturn(mockCameraAreaChannel);
  }

  @Test
  public void createCameraArea() {
    final CameraRectProxy cameraRectProxy = new CameraRectProxy(0, 1, 2, 3, mockImplementations);
    final CameraAreaProxy cameraAreaProxy = new CameraAreaProxy(cameraRectProxy, 23, mockImplementations);

    // Rect always returns null and weight always returns 0 for some reason.
    assertEquals(new Camera.Area(new Rect(), 23).weight, 0);
    verify(mockCameraAreaChannel).$$create(cameraAreaProxy, false, cameraRectProxy, 0);
  }
}
