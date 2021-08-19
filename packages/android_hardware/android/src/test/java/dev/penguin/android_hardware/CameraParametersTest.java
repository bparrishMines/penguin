package dev.penguin.android_hardware;

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
import static org.mockito.Matchers.anyListOf;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CameraParametersTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  LibraryImplementations.LibraryImplementations mockImplementations;

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
    testCameraParametersProxy = new CameraParametersProxy(mockParameters, mockImplementations, true);
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
  public void sceneMode() {
    assertEquals(Camera.Parameters.SCENE_MODE_AUTO, "auto");
    assertEquals(Camera.Parameters.SCENE_MODE_ACTION, "action");
    assertEquals(Camera.Parameters.SCENE_MODE_PORTRAIT, "portrait");
    assertEquals(Camera.Parameters.SCENE_MODE_LANDSCAPE, "landscape");
    assertEquals(Camera.Parameters.SCENE_MODE_NIGHT, "night");
    assertEquals(Camera.Parameters.SCENE_MODE_NIGHT_PORTRAIT, "night-portrait");
    assertEquals(Camera.Parameters.SCENE_MODE_THEATRE, "theatre");
    assertEquals(Camera.Parameters.SCENE_MODE_BEACH, "beach");
    assertEquals(Camera.Parameters.SCENE_MODE_SNOW, "snow");
    assertEquals(Camera.Parameters.SCENE_MODE_SUNSET, "sunset");
    assertEquals(Camera.Parameters.SCENE_MODE_STEADYPHOTO, "steadyphoto");
    assertEquals(Camera.Parameters.SCENE_MODE_FIREWORKS, "fireworks");
    assertEquals(Camera.Parameters.SCENE_MODE_SPORTS, "sports");
    assertEquals(Camera.Parameters.SCENE_MODE_PARTY, "party");
    assertEquals(Camera.Parameters.SCENE_MODE_HDR, "hdr");
    assertEquals(Camera.Parameters.SCENE_MODE_CANDLELIGHT, "candlelight");
    assertEquals(Camera.Parameters.SCENE_MODE_BARCODE, "barcode");
  }

  @Test
  public void previewFpsIndex() {
    assertEquals(Camera.Parameters.PREVIEW_FPS_MAX_INDEX, 0x00000001);
    assertEquals(Camera.Parameters.PREVIEW_FPS_MIN_INDEX, 0x00000000);
  }

  @Test
  public void whiteBalance() {
    assertEquals(Camera.Parameters.WHITE_BALANCE_AUTO, "auto");
    assertEquals(Camera.Parameters.WHITE_BALANCE_INCANDESCENT, "incandescent");
    assertEquals(Camera.Parameters.WHITE_BALANCE_FLUORESCENT, "fluorescent");
    assertEquals(Camera.Parameters.WHITE_BALANCE_WARM_FLUORESCENT, "warm-fluorescent");
    assertEquals(Camera.Parameters.WHITE_BALANCE_DAYLIGHT, "daylight");
    assertEquals(Camera.Parameters.WHITE_BALANCE_CLOUDY_DAYLIGHT, "cloudy-daylight");
    assertEquals(Camera.Parameters.WHITE_BALANCE_TWILIGHT, "twilight");
    assertEquals(Camera.Parameters.WHITE_BALANCE_SHADE, "shade");
  }

  @Test
  public void createCameraParameters() {
    verify(mockCameraParametersChannel).$create$(testCameraParametersProxy, false);
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

  @Test
  public void flatten() {
    when(mockParameters.flatten()).thenReturn("hola");
    assertEquals(testCameraParametersProxy.flatten(), "hola");
  }

  @Test
  public void get() {
    when(mockParameters.get("apple")).thenReturn("hola");
    assertEquals(testCameraParametersProxy.get("apple"), "hola");
  }

  @Test
  public void getAntibanding() {
    when(mockParameters.getAntibanding()).thenReturn("hola");
    assertEquals(testCameraParametersProxy.getAntibanding(), "hola");
  }

  @Test
  public void getAutoWhiteBalanceLock() {
    when(mockParameters.getAutoWhiteBalanceLock()).thenReturn(false);
    assertEquals(testCameraParametersProxy.getAutoWhiteBalanceLock(), false);
  }

  @Test
  public void getColorEffect() {
    when(mockParameters.getColorEffect()).thenReturn("wo");
    assertEquals(testCameraParametersProxy.getColorEffect(), "wo");
  }

  @Test
  public void getFocalLength() {
    when(mockParameters.getFocalLength()).thenReturn(12F);
    assertEquals(testCameraParametersProxy.getFocalLength(), (Float) 12F);
  }

  @Test
  public void getFocusMode() {
    when(mockParameters.getFocusMode()).thenReturn("wo");
    assertEquals(testCameraParametersProxy.getFocusMode(), "wo");
  }

  @Test
  public void getHorizontalViewAngle() {
    when(mockParameters.getHorizontalViewAngle()).thenReturn(12F);
    assertEquals(testCameraParametersProxy.getHorizontalViewAngle(), (Float) 12F);
  }

  @Test
  public void getInt() {
    when(mockParameters.getInt("tine")).thenReturn(12);
    assertEquals(testCameraParametersProxy.getInt("tine"), (Integer) 12);
  }

  @Test
  public void getJpegQuality() {
    when(mockParameters.getJpegQuality()).thenReturn(12);
    assertEquals(testCameraParametersProxy.getJpegQuality(), (Integer) 12);
  }

  @Test
  public void getJpegThumbnailQuality() {
    when(mockParameters.getJpegThumbnailQuality()).thenReturn(12);
    assertEquals(testCameraParametersProxy.getJpegThumbnailQuality(), (Integer) 12);
  }

  @Test
  public void getJpegThumbnailSize() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getJpegThumbnailSize()).thenReturn(size);
    assertEquals(testCameraParametersProxy.getJpegThumbnailSize().cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getJpegThumbnailSize().cameraSize.height, 54);
  }

  @Test
  public void getMaxNumMeteringAreas() {
    when(mockParameters.getMaxNumMeteringAreas()).thenReturn(12);
    assertEquals(testCameraParametersProxy.getMaxNumMeteringAreas(), (Integer) 12);
  }

  @Test
  public void getMeteringAreas() {
    // Not possible to test since Camera.Area doesn't set values.
  }

  @Test
  public void getPictureFormat() {
    when(mockParameters.getPictureFormat()).thenReturn(12);
    assertEquals(testCameraParametersProxy.getPictureFormat(), (Integer) 12);
  }

  @Test
  public void getPreferredPreviewSizeForVideo() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getPreferredPreviewSizeForVideo()).thenReturn(size);
    assertEquals(testCameraParametersProxy.getPreferredPreviewSizeForVideo().cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getPreferredPreviewSizeForVideo().cameraSize.height, 54);
  }

  @Test
  public void getPreviewFormat() {
    when(mockParameters.getPreviewFormat()).thenReturn(12);
    assertEquals(testCameraParametersProxy.getPreviewFormat(), (Integer) 12);
  }

  @Test
  public void getPreviewFpsRange() {
    doAnswer(invocation -> {
      final int[] ranges = (int[]) invocation.getArguments()[0];
      assertEquals(ranges.length, 2);
      ranges[0] = 1;
      ranges[1] = 2;
      return null;
    }).when(mockParameters).getPreviewFpsRange(any(int[].class));
    assertEquals(testCameraParametersProxy.getPreviewFpsRange(), Arrays.asList(1, 2));
  }

  @Test
  public void getSceneMode() {
    when(mockParameters.getSceneMode()).thenReturn("wo");
    assertEquals(testCameraParametersProxy.getSceneMode(), "wo");
  }

  @Test
  public void getSupportedAntibanding() {
    when(mockParameters.getSupportedAntibanding()).thenReturn(Arrays.asList("a", "b"));
    assertEquals(testCameraParametersProxy.getSupportedAntibanding(), Arrays.asList("a", "b"));
  }

  @Test
  public void getSupportedColorEffects() {
    when(mockParameters.getSupportedColorEffects()).thenReturn(Arrays.asList("a", "b"));
    assertEquals(testCameraParametersProxy.getSupportedColorEffects(), Arrays.asList("a", "b"));
  }

  @Test
  public void getSupportedJpegThumbnailSizes() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getSupportedJpegThumbnailSizes()).thenReturn(Collections.singletonList(size));
    assertEquals(testCameraParametersProxy.getSupportedJpegThumbnailSizes().get(0).cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getSupportedJpegThumbnailSizes().get(0).cameraSize.height, 54);
  }

  @Test
  public void getSupportedPictureFormats() {
    when(mockParameters.getSupportedPictureFormats()).thenReturn(Arrays.asList(3, 4));
    assertEquals(testCameraParametersProxy.getSupportedPictureFormats(), Arrays.asList(3, 4));
  }

  @Test
  public void getSupportedPreviewFormats() {
    when(mockParameters.getSupportedPreviewFormats()).thenReturn(Arrays.asList(3, 4));
    assertEquals(testCameraParametersProxy.getSupportedPreviewFormats(), Arrays.asList(3, 4));
  }

  @Test
  public void getSupportedPreviewFpsRange() {
    when(mockParameters.getSupportedPreviewFpsRange()).thenReturn(Collections.singletonList(new int[]{1, 2}));
    assertEquals(testCameraParametersProxy.getSupportedPreviewFpsRange(), Collections.singletonList(Arrays.asList(1, 2)));
  }

  @Test
  public void getSupportedSceneModes() {
    when(mockParameters.getSupportedSceneModes()).thenReturn(Arrays.asList("a", "b"));
    assertEquals(testCameraParametersProxy.getSupportedSceneModes(), Arrays.asList("a", "b"));
  }

  @Test
  public void getSupportedVideoSizes() {
    final Camera.Size size = mock(Camera.Size.class);
    size.width = 12;
    size.height = 54;

    when(mockParameters.getSupportedVideoSizes()).thenReturn(Collections.singletonList(size));
    //noinspection ConstantConditions
    assertEquals(testCameraParametersProxy.getSupportedVideoSizes().get(0).cameraSize.width, 12);
    assertEquals(testCameraParametersProxy.getSupportedVideoSizes().get(0).cameraSize.height, 54);
  }

  @Test
  public void getSupportedWhiteBalance() {
    when(mockParameters.getSupportedWhiteBalance()).thenReturn(Arrays.asList("a", "b"));
    assertEquals(testCameraParametersProxy.getSupportedWhiteBalance(), Arrays.asList("a", "b"));
  }

  @Test
  public void getVerticalViewAngle() {
    when(mockParameters.getVerticalViewAngle()).thenReturn(12F);
    assertEquals(testCameraParametersProxy.getVerticalViewAngle(), (Float) 12F);
  }

  @Test
  public void getVideoStabilization() {
    when(mockParameters.getVideoStabilization()).thenReturn(false);
    assertEquals(testCameraParametersProxy.getVideoStabilization(), false);
  }

  @Test
  public void getWhiteBalance() {
    when(mockParameters.getWhiteBalance()).thenReturn("woiefj");
    assertEquals(testCameraParametersProxy.getWhiteBalance(), "woiefj");
  }

  @Test
  public void getZoomRatios() {
    when(mockParameters.getZoomRatios()).thenReturn(Arrays.asList(3, 4));
    assertEquals(testCameraParametersProxy.getZoomRatios(), Arrays.asList(3, 4));
  }

  @Test
  public void isAutoWhiteBalanceLockSupported() {
    when(mockParameters.isAutoWhiteBalanceLockSupported()).thenReturn(false);
    assertEquals(testCameraParametersProxy.isAutoWhiteBalanceLockSupported(), false);
  }

  @Test
  public void isVideoSnapshotSupported() {
    when(mockParameters.isVideoSnapshotSupported()).thenReturn(false);
    assertEquals(testCameraParametersProxy.isVideoSnapshotSupported(), false);
  }

  @Test
  public void isVideoStabilizationSupported() {
    when(mockParameters.isVideoStabilizationSupported()).thenReturn(false);
    assertEquals(testCameraParametersProxy.isVideoStabilizationSupported(), false);
  }

  @Test
  public void remove() {
    testCameraParametersProxy.remove("wfe");
    verify(mockParameters).remove("wfe");
  }

  @Test
  public void removeGpsData() {
    testCameraParametersProxy.removeGpsData();
    verify(mockParameters).removeGpsData();
  }

  @Test
  public void set() {
    testCameraParametersProxy.set("hieel", 23);
    verify(mockParameters).set("hieel", 23);
  }

  @Test
  public void setAntibanding() {
    testCameraParametersProxy.setAntibanding("hieel");
    verify(mockParameters).setAntibanding("hieel");
  }

  @Test
  public void setAutoWhiteBalanceLock() {
    testCameraParametersProxy.setAutoWhiteBalanceLock(true);
    verify(mockParameters).setAutoWhiteBalanceLock(true);
  }

  @Test
  public void setColorEffect() {
    testCameraParametersProxy.setColorEffect("hieel");
    verify(mockParameters).setColorEffect("hieel");
  }

  @Test
  public void setGpsAltitude() {
    testCameraParametersProxy.setGpsAltitude(44.4);
    verify(mockParameters).setGpsAltitude(44.4);
  }

  @Test
  public void setGpsLatitude() {
    testCameraParametersProxy.setGpsLatitude(44.4);
    verify(mockParameters).setGpsLatitude(44.4);
  }

  @Test
  public void setGpsLongitude() {
    testCameraParametersProxy.setGpsLongitude(44.4);
    verify(mockParameters).setGpsLongitude(44.4);
  }

  @Test
  public void setGpsProcessingMethod() {
    testCameraParametersProxy.setGpsProcessingMethod("hieel");
    verify(mockParameters).setGpsProcessingMethod("hieel");
  }

  @Test
  public void setGpsTimestamp() {
    testCameraParametersProxy.setGpsTimestamp(44);
    verify(mockParameters).setGpsTimestamp(44);
  }

  @Test
  public void setJpegQuality() {
    testCameraParametersProxy.setJpegQuality(44);
    verify(mockParameters).setJpegQuality(44);
  }

  @Test
  public void setJpegThumbnailQuality() {
    testCameraParametersProxy.setJpegThumbnailQuality(44);
    verify(mockParameters).setJpegThumbnailQuality(44);
  }

  @Test
  public void setJpegThumbnailSize() {
    testCameraParametersProxy.setJpegThumbnailSize(44, 22);
    verify(mockParameters).setJpegThumbnailSize(44, 22);
  }

  @Test
  public void setMeteringAreas() {
    final CameraAreaProxy cameraAreaProxy = new CameraAreaProxy(new CameraRectProxy(0, 1, 2, 3, mockImplementations), 23, mockImplementations, false);
    testCameraParametersProxy.setMeteringAreas(Collections.singletonList(cameraAreaProxy));
    verify(mockParameters).setMeteringAreas(anyListOf(Camera.Area.class));
  }

  @Test
  public void setPictureFormat() {
    testCameraParametersProxy.setPictureFormat(44);
    verify(mockParameters).setPictureFormat(44);
  }

  @Test
  public void setPreviewFormat() {
    testCameraParametersProxy.setPreviewFormat(44);
    verify(mockParameters).setPreviewFormat(44);
  }

  @Test
  public void setPreviewFpsRange() {
    testCameraParametersProxy.setPreviewFpsRange(44, 22);
    verify(mockParameters).setPreviewFpsRange(44, 22);
  }

  @Test
  public void setSceneMode() {
    testCameraParametersProxy.setSceneMode("hieel");
    verify(mockParameters).setSceneMode("hieel");
  }

  @Test
  public void setVideoStabilization() {
    testCameraParametersProxy.setVideoStabilization(true);
    verify(mockParameters).setVideoStabilization(true);
  }

  @Test
  public void setWhiteBalance() {
    testCameraParametersProxy.setWhiteBalance("hieel");
    verify(mockParameters).setWhiteBalance("hieel");
  }

  @Test
  public void unflatten() {
    testCameraParametersProxy.unflatten("hieel");
    verify(mockParameters).unflatten("hieel");
  }
}
