package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.os.Build;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import static github.bparrishMines.penguin.penguin_android_camera.Utils.setFinalStatic;
import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraInfoProxyTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraInfoChannel mockCameraInfoChannel;

  @Before
  public void setup() {
    when(mockImplementations.getChannelCameraInfo()).thenReturn(mockCameraInfoChannel);
  }

  @Test
  public void createCameraInfo() throws Exception {
    setFinalStatic(Build.VERSION.class.getField("SDK_INT"), Build.VERSION_CODES.JELLY_BEAN_MR1);
    
    final Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
    cameraInfo.facing = 2;
    cameraInfo.orientation = 180;
    cameraInfo.canDisableShutterSound = true;
    final CameraInfoProxy cameraInfoProxy = new CameraInfoProxy(cameraInfo, mockImplementations, 15);

    verify(mockCameraInfoChannel).$$create(cameraInfoProxy, false, 15, 2, 180, true);
  }

  @Test
  public void facing() {
    assertEquals(Camera.CameraInfo.CAMERA_FACING_BACK, 0);
    assertEquals(Camera.CameraInfo.CAMERA_FACING_FRONT, 1);
  }
}
