package dev.penguin.android_hardware;

import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class CameraSizeTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraSizeProxyChannel mockCameraSizeChannel;

  @Before
  public void setup() {
    mockImplementations.channelCameraSizeProxy = mockCameraSizeChannel;
  }

  @Test
  public void createCameraRect() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    final CameraSizeProxy cameraSizeProxy = new CameraSizeProxy(mockImplementations, true, size);
    verify(mockCameraSizeChannel).$create$(cameraSizeProxy, false, 12, 54);
  }
}
