package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.Rect;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraRectTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraRectChannel mockCameraRectChannel;

  @Before
  public void setup() {
    when(mockImplementations.getChannelCameraRect()).thenReturn(mockCameraRectChannel);
  }

  @Test
  public void createCameraRect() {
    final CameraRectProxy cameraRectProxy = new CameraRectProxy(new Rect(), mockImplementations);

    // Rect always returns 0 values for some reason?
    verify(mockCameraRectChannel).$$create(cameraRectProxy, false, 0, 0, 0, 0);
  }
}
