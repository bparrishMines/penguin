package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraSizeTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraSizeChannel mockCameraSizeChannel;

  @Before
  public void setup() {
    when(mockImplementations.getChannelCameraSize()).thenReturn(mockCameraSizeChannel);
  }

  @Test
  public void createCameraRect() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    final CameraSizeProxy cameraSizeProxy = new CameraSizeProxy(size, mockImplementations);
    verify(mockCameraSizeChannel).$$create(cameraSizeProxy, false, 12, 54);
  }
}
