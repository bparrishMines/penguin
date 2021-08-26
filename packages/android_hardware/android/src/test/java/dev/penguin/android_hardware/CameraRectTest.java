package dev.penguin.android_hardware;

import android.graphics.Rect;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import static org.mockito.Mockito.verify;

public class CameraRectTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraRectProxyChannel mockCameraRectChannel;

  @Before
  public void setup() {
    mockImplementations.channelCameraRectProxy = mockCameraRectChannel;
  }

  @Test
  public void createCameraRect() {
    final RectHandler cameraRectProxy = new RectHandler(mockImplementations, true, new Rect());

    // Rect always returns 0 values for some reason?
    verify(mockCameraRectChannel).$create$(cameraRectProxy, false, 0, 0, 0, 0);
  }
}
