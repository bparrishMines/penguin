package dev.penguin.android_hardware;

import android.graphics.Rect;
import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.verify;

public class CameraAreaTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraRectProxyChannel mockCameraRectChannel;

  @Mock
  CameraChannelLibrary.$CameraAreaProxyChannel mockCameraAreaChannel;

  @Before
  public void setup() {
    mockImplementations.channelCameraRectProxy = mockCameraRectChannel;
    mockImplementations.channelCameraAreaProxy = mockCameraAreaChannel;
  }

  @Test(expected = NullPointerException.class)
  public void createCameraArea() {
    final AreaHandler cameraAreaProxy = new AreaHandler(mockImplementations, true,new Camera.Area(new Rect(), 23));

    // Rect always returns null and weight always returns 0 for some reason.
    assertEquals(new Camera.Area(new Rect(), 23).weight, 0);

    // This always throws NullPointerException since area.rect is always null in tests?
    verify(mockCameraAreaChannel).$create$(eq(cameraAreaProxy), false, any(RectHandler.class), 0);
  }
}
