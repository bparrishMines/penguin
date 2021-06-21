package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import java.util.Arrays;
import java.util.Collections;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraParametersTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CameraParametersChannel mockCameraParametersChannel;

  @Mock
  CameraChannelLibrary.$CameraAreaChannel mockCameraAreaChannel;

  @Mock
  CameraChannelLibrary.$CameraRectChannel mockCameraRectChannel;

  @Mock
  CameraChannelLibrary.$CameraSizeChannel mockCameraSizeChannel;

  @Mock
  Camera.Parameters mockParameters;

  public CameraParametersProxy testCameraParametersProxy;

  @Before
  public void setUp() {
    when(mockImplementations.getChannelCameraParameters()).thenReturn(mockCameraParametersChannel);
    when(mockImplementations.getChannelCameraRect()).thenReturn(mockCameraRectChannel);
    when(mockImplementations.getChannelCameraArea()).thenReturn(mockCameraAreaChannel);
    when(mockImplementations.getChannelCameraSize()).thenReturn(mockCameraSizeChannel);
    testCameraParametersProxy = new CameraParametersProxy(mockParameters, mockImplementations);
  }

  @Test
  public void flashModes() {
    assertEquals(Camera.Parameters.FLASH_MODE_AUTO, "auto");
    assertEquals(Camera.Parameters.FLASH_MODE_OFF, "off");
    assertEquals(Camera.Parameters.FLASH_MODE_ON, "on");
    assertEquals(Camera.Parameters.FLASH_MODE_RED_EYE, "red-eye");
    assertEquals(Camera.Parameters.FLASH_MODE_TORCH, "torch");
  }

  @Test
  public void focusDistances() {
    assertEquals(Camera.Parameters.FOCUS_DISTANCE_NEAR_INDEX, 0x00000000);
    assertEquals(Camera.Parameters.FOCUS_DISTANCE_FAR_INDEX, 0x00000002);
    assertEquals(Camera.Parameters.FOCUS_DISTANCE_OPTIMAL_INDEX, 0x00000001);
  }

  @Test
  public void focusModes() {
    assertEquals(Camera.Parameters.FOCUS_MODE_AUTO, "auto");
    assertEquals(Camera.Parameters.FOCUS_MODE_CONTINUOUS_PICTURE, "continuous-picture");
    assertEquals(Camera.Parameters.FOCUS_MODE_CONTINUOUS_VIDEO, "continuous-video");
    assertEquals(Camera.Parameters.FOCUS_MODE_EDOF, "edof");
    assertEquals(Camera.Parameters.FOCUS_MODE_FIXED, "fixed");
    assertEquals(Camera.Parameters.FOCUS_MODE_INFINITY, "infinity");
    assertEquals(Camera.Parameters.FOCUS_MODE_MACRO, "macro");
  }

  @Test
  public void antibanding() {
    assertEquals(Camera.Parameters.ANTIBANDING_50HZ, "50hz");
    assertEquals(Camera.Parameters.ANTIBANDING_60HZ, "60hz");
    assertEquals(Camera.Parameters.ANTIBANDING_AUTO, "auto");
    assertEquals(Camera.Parameters.ANTIBANDING_OFF, "off");
  }

  @Test
  public void effect() {
    assertEquals(Camera.Parameters.EFFECT_NONE, "none");
    assertEquals(Camera.Parameters.EFFECT_MONO, "mono");
    assertEquals(Camera.Parameters.EFFECT_NEGATIVE, "negative");
    assertEquals(Camera.Parameters.EFFECT_SOLARIZE, "solarize");
    assertEquals(Camera.Parameters.EFFECT_SEPIA, "sepia");
    assertEquals(Camera.Parameters.EFFECT_POSTERIZE, "posterize");
    assertEquals(Camera.Parameters.EFFECT_WHITEBOARD, "whiteboard");
    assertEquals(Camera.Parameters.EFFECT_BLACKBOARD, "blackboard");
    assertEquals(Camera.Parameters.EFFECT_AQUA, "aqua");
  }

  @Test
  public void createCameraParameters() {
    verify(mockCameraParametersChannel).$$create(testCameraParametersProxy, false);
  }

  @Test
  public void getAutoExposureLock() {
    when(mockParameters.getAutoExposureLock()).thenReturn(true);
    assertEquals(testCameraParametersProxy.getAutoExposureLock(), true);
  }

  @Test
  public void getFocusAreas() {
    // Not possible to test since Camera.Area doesn't set values.
  }

  @Test
  public void getFocusDistances() {
    doAnswer(invocation -> {
      final float[] distances = (float[]) invocation.getArguments()[0];
      assertEquals(distances.length, 3);
      distances[0] = 1;
      distances[1] = 2;
      distances[2] = 3;
      return null;
    }).when(mockParameters).getFocusDistances(any(float[].class));
    assertEquals(testCameraParametersProxy.getFocusDistances(), Arrays.asList(1f, 2f, 3f));
  }

  @Test
  public void getMaxExposureCompensation() {
    when(mockParameters.getMaxExposureCompensation()).thenReturn(23);
    assertEquals(testCameraParametersProxy.getMaxExposureCompensation(), (Integer) 23);
  }

  @Test
  public void getSupportedFocusModes() {
    when(mockParameters.getSupportedFocusModes()).thenReturn(Arrays.asList("hello", "goodbye"));
    assertEquals(testCameraParametersProxy.getSupportedFocusModes(), Arrays.asList("hello", "goodbye"));
  }

  @Test
  public void isAutoExposureLockSupported() {
    when(mockParameters.isAutoExposureLockSupported()).thenReturn(true);
    assertEquals(testCameraParametersProxy.isAutoExposureLockSupported(), true);
  }

  @Test
  public void isZoomSupported() {
    when(mockParameters.isZoomSupported()).thenReturn(false);
    assertEquals(testCameraParametersProxy.isZoomSupported(), false);
  }

  @Test
  public void setAutoExposureLock() {
    testCameraParametersProxy.setAutoExposureLock(true);
    verify(mockParameters).setAutoExposureLock(true);
  }

  @Test
  public void setExposureCompensation() {
    testCameraParametersProxy.setExposureCompensation(24);
    verify(mockParameters).setExposureCompensation(24);
  }

  @Test
  public void setFocusAreas() {
    // Camera.Area always returns a null rect and 0 weight.
  }

  @Test
  public void setFocusMode() {
    testCameraParametersProxy.setFocusMode("hola amigo");
    verify(mockParameters).setFocusMode("hola amigo");
  }

  @Test
  public void getFlashMode() {
    when(mockParameters.getFlashMode()).thenReturn("flashy flash");
    assertEquals(testCameraParametersProxy.getFlashMode(), "flashy flash");
  }

  @Test
  public void getMaxZoom() {
    when(mockParameters.getMaxZoom()).thenReturn(11);
    assertEquals(testCameraParametersProxy.getMaxZoom(), (Integer) 11);
  }

  @Test
  public void getPictureSize() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getPictureSize()).thenReturn(size);
    assertEquals(testCameraParametersProxy.getPictureSize().cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getPictureSize().cameraSize.height, 54);
  }

  @Test
  public void getPreviewSize() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getPreviewSize()).thenReturn(size);
    assertEquals(testCameraParametersProxy.getPreviewSize().cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getPreviewSize().cameraSize.height, 54);
  }

  @Test
  public void getSupportedPreviewSizes() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getSupportedPreviewSizes()).thenReturn(Collections.singletonList(size));
    assertEquals(testCameraParametersProxy.getSupportedPreviewSizes().get(0).cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getSupportedPreviewSizes().get(0).cameraSize.height, 54);
  }

  @Test
  public void getSupportedPictureSizes() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getSupportedPictureSizes()).thenReturn(Collections.singletonList(size));
    assertEquals(testCameraParametersProxy.getSupportedPictureSizes().get(0).cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getSupportedPictureSizes().get(0).cameraSize.height, 54);
  }

  @Test
  public void getSupportedFlashModes() {
    when(mockParameters.getSupportedFlashModes()).thenReturn(Arrays.asList("hello", "goodbye"));
    assertEquals(testCameraParametersProxy.getSupportedFlashModes(), Arrays.asList("hello", "goodbye"));
  }

  @Test
  public void getZoom() {
    when(mockParameters.getZoom()).thenReturn(11);
    assertEquals(testCameraParametersProxy.getZoom(), (Integer) 11);
  }

  @Test
  public void isSmoothZoomSupported() {
    when(mockParameters.isSmoothZoomSupported()).thenReturn(true);
    assertEquals(testCameraParametersProxy.isSmoothZoomSupported(), true);
  }

  @Test
  public void setFlashMode() {
    testCameraParametersProxy.setFlashMode("hola amigo");
    verify(mockParameters).setFlashMode("hola amigo");
  }

  @Test
  public void setPictureSize() {
    testCameraParametersProxy.setPictureSize(100, 100);
    verify(mockParameters).setPictureSize(100, 100);
  }

  @Test
  public void setRecordingHint() {
    testCameraParametersProxy.setRecordingHint(false);
    verify(mockParameters).setRecordingHint(false);
  }

  @Test
  public void setRotation() {
    testCameraParametersProxy.setRotation(23);
    verify(mockParameters).setRotation(23);
  }

  @Test
  public void setZoom() {
    testCameraParametersProxy.setZoom(14);
    verify(mockParameters).setZoom(14);
  }

  @Test
  public void setPreviewSize() {
    testCameraParametersProxy.setPreviewSize(100, 100);
    verify(mockParameters).setPreviewSize(100, 100);
  }

  @Test
  public void getExposureCompensation() {
    when(mockParameters.getExposureCompensation()).thenReturn(11);
    assertEquals(testCameraParametersProxy.getExposureCompensation(), (Integer) 11);
  }

  @Test
  public void getExposureCompensationStep() {
    when(mockParameters.getExposureCompensationStep()).thenReturn(11.2F);
    assertEquals(testCameraParametersProxy.getExposureCompensationStep(), (Float) 11.2F);
  }
}
