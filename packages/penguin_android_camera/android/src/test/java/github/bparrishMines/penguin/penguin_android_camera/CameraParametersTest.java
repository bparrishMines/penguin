package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.Rect;
import android.hardware.Camera;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class CameraParametersTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  Camera.Parameters mockParameters;

  public CameraParametersProxy testCameraParametersProxy;

  @Before
  public void setUp() {
    final CameraChannelLibrary.$CameraParametersChannel mockParametersChannel = mock(CameraChannelLibrary.$CameraParametersChannel.class);
    final CameraChannelLibrary.$CameraRectChannel mockRectChannel = mock(CameraChannelLibrary.$CameraRectChannel.class);
    final CameraChannelLibrary.$CameraAreaChannel mockAreaChannel = mock(CameraChannelLibrary.$CameraAreaChannel.class);

    when(mockImplementations.getChannelCameraParameters()).thenReturn(mockParametersChannel);
    when(mockImplementations.getChannelCameraRect()).thenReturn(mockRectChannel);
    when(mockImplementations.getChannelCameraArea()).thenReturn(mockAreaChannel);
    testCameraParametersProxy = new CameraParametersProxy(mockParameters, mockImplementations);
  }

  @Test
  public void getAutoExposureLock() {
    when(mockParameters.getAutoExposureLock()).thenReturn(true);
    assertEquals(testCameraParametersProxy.getAutoExposureLock(), true);
  }

  @Test
  public void getFocusAreas() {
    final Rect testRect = new Rect(null);
    final Camera.Area testArea = new Camera.Area(testRect, 23);
    testArea.rect = testRect;
    testArea.weight = 23;
    //when(mockParameters.getFocusAreas()).thenReturn(Collections.singletonList(testArea));

    final List<CameraAreaProxy> areaProxies = CameraAreaProxy.fromList(Collections.singletonList(testArea), mockImplementations);
    //assertEquals(areaProxies.size(), 1);
    //assertEquals(areaProxies.get(0).area.rect, mockRect);
    //assertEquals(areaProxies.get(0).area.weight, 23);

    final Camera.Area testAreaa = new Camera.Area(new Rect(null), 23);
    //testAreaa.weight = 23;
    assertEquals(testAreaa.weight, 23);
  }

  public static class A {
    final int weight;

    public A(int weight) {
      this.weight = weight;
    }
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

  public Object getMaxExposureCompensation() {
    return null;
  }

  public Object getMaxNumFocusAreas() throws Exception {
    return null;
  }

  public Object getMinExposureCompensation() throws Exception {
    return null;
  }

  public Object getSupportedFocusModes() throws Exception {
    return null;
  }

  public Object isAutoExposureLockSupported() throws Exception {
    return null;
  }

  public Object isZoomSupported() throws Exception {
    return null;
  }

  public Object setAutoExposureLock(Boolean toggle) throws Exception {
    return null;
  }

  public Object setExposureCompensation(Integer value) throws Exception {
    return null;
  }

  public Object setFocusAreas(List<CameraChannelLibrary.$CameraArea> focusAreas) throws Exception {
    return null;
  }

  public Object setFocusMode(String value) throws Exception {
    return null;
  }

  public Object getFlashMode() throws Exception {
    return null;
  }

  public Object getMaxZoom() throws Exception {
    return null;
  }

  public Object getPictureSize() throws Exception {
    return null;
  }

  public Object getPreviewSize() throws Exception {
    return null;
  }

  public Object getSupportedPreviewSizes() throws Exception {
    return null;
  }

  public Object getSupportedPictureSizes() throws Exception {
    return null;
  }

  public Object getSupportedFlashModes() throws Exception {
    return null;
  }

  public Object getZoom() throws Exception {
    return null;
  }

  public Object isSmoothZoomSupported() throws Exception {
    return null;
  }

  public Object setFlashMode(String mode) throws Exception {
    return null;
  }

  public Object setPictureSize(Integer width, Integer height) throws Exception {
    return null;
  }

  public Object setRecordingHint(Boolean hint) throws Exception {
    return null;
  }

  public Object setRotation(Integer rotation) throws Exception {
    return null;
  }

  public Object setZoom(Integer value) throws Exception {
    return null;
  }

  public Object setPreviewSize(Integer width, Integer height) throws Exception {
    return null;
  }

  public Object getExposureCompensation() throws Exception {
    return null;
  }

  public Object getExposureCompensationStep() throws Exception {
    return null;
  }
}
