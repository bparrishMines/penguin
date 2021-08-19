package dev.penguin.android_hardware;

import android.hardware.Camera;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CameraParametersProxy {
  public final LibraryImplementations implementations;
  public final Camera.Parameters cameraParameters;

  public CameraParametersProxy(LibraryImplementations implementations, boolean create) {
    remove this
    throw new UnsupportedOperationException();
  }

  public CameraParametersProxy(LibraryImplementations implementations, boolean create, Camera.Parameters cameraParameters) {
    this.implementations = implementations;
    this.cameraParameters = cameraParameters;
    if (create) {
      implementations.channelCameraParametersProxy.$create$(this, false);
    }
  }

  public Boolean getAutoExposureLock() {
    return cameraParameters.getAutoExposureLock();
  }

  public List<CameraAreaProxy> getFocusAreas() {
    return CameraAreaProxy.fromList(implementations, cameraParameters.getFocusAreas());
  }

  public List<Float> getFocusDistances() {
    final float[] distances = new float[3];
    cameraParameters.getFocusDistances(distances);
    final List<Float> floatList = new ArrayList<>(distances.length);
    for (float distance : distances) {
      floatList.add(distance);
    }
    return floatList;
  }

  public Integer getMaxExposureCompensation() {
    return cameraParameters.getMaxExposureCompensation();
  }

  public Integer getMaxNumFocusAreas() {
    return cameraParameters.getMaxNumFocusAreas();
  }

  public Integer getMinExposureCompensation() {
    return cameraParameters.getMinExposureCompensation();
  }

  public List<String> getSupportedFocusModes()  {
    return cameraParameters.getSupportedFocusModes();
  }

  public Boolean isAutoExposureLockSupported()  {
    return cameraParameters.isAutoExposureLockSupported();
  }

  public Boolean isZoomSupported() {
    return cameraParameters.isZoomSupported();
  }

  public void setAutoExposureLock(Boolean toggle)  {
    cameraParameters.setAutoExposureLock(toggle);
  }

  public void setExposureCompensation(Integer value)  {
    cameraParameters.setExposureCompensation(value);
  }

  public void setFocusAreas(List<CameraAreaProxy> focusAreas)  {
    cameraParameters.setFocusAreas(CameraAreaProxy.toAreaList(focusAreas));
  }

  public void setFocusMode(String value)  {
    cameraParameters.setFocusMode(value);
  }

  public String getFlashMode() {
    return cameraParameters.getFlashMode();
  }

  public Integer getMaxZoom() {
    return cameraParameters.getMaxZoom();
  }

  public CameraSizeProxy getPictureSize() {
    return new CameraSizeProxy(implementations, true, cameraParameters.getPictureSize());
  }

  public CameraSizeProxy getPreviewSize() {
    return new CameraSizeProxy(implementations, true, cameraParameters.getPreviewSize());
  }

  public List<CameraSizeProxy> getSupportedPreviewSizes() {
    return CameraSizeProxy.fromList(implementations, cameraParameters.getSupportedPreviewSizes());
  }

  public List<CameraSizeProxy> getSupportedPictureSizes() {
    return CameraSizeProxy.fromList(implementations, cameraParameters.getSupportedPictureSizes());
  }

  public List<String> getSupportedFlashModes() {
    final List<String> modes = cameraParameters.getSupportedFlashModes();
    if (modes != null) return modes;
    return new ArrayList<>();
  }

  public Integer getZoom() {
    return cameraParameters.getZoom();
  }

  public Boolean isSmoothZoomSupported() {
    return cameraParameters.isSmoothZoomSupported();
  }

  public void setFlashMode(String mode) {
    cameraParameters.setFlashMode(mode);
  }

  public void setPictureSize(Integer width, Integer height) {
    cameraParameters.setPictureSize(width, height);
  }

  public void setRecordingHint(Boolean hint) {
    cameraParameters.setRecordingHint(hint);
  }

  public void setRotation(Integer rotation) {
    cameraParameters.setRotation(rotation);
  }

  public void setZoom(Integer value) {
    cameraParameters.setZoom(value);
  }

  public void setPreviewSize(Integer width, Integer height) {
    cameraParameters.setPreviewSize(width, height);
  }

  public Integer getExposureCompensation() {
    return cameraParameters.getExposureCompensation();
  }

  public Float getExposureCompensationStep() {
    return cameraParameters.getExposureCompensationStep();
  }

  // TODO: Test starts here to below
  public String flatten() {
    return cameraParameters.flatten();
  }

  public String get(String key) {
    return cameraParameters.get(key);
  }

  public String getAntibanding() {
    return cameraParameters.getAntibanding();
  }

  public Boolean getAutoWhiteBalanceLock() {
    return cameraParameters.getAutoWhiteBalanceLock();
  }

  public String getColorEffect() {
    return cameraParameters.getColorEffect();
  }

  public Float getFocalLength() {
    return cameraParameters.getFocalLength();
  }

  public String getFocusMode() {
    return cameraParameters.getFocusMode();
  }

  public Float getHorizontalViewAngle() {
    return cameraParameters.getHorizontalViewAngle();
  }

  public Integer getInt(String key) {
    return cameraParameters.getInt(key);
  }

  public Integer getJpegQuality() {
    return cameraParameters.getJpegQuality();
  }

  public Integer getJpegThumbnailQuality() {
    return cameraParameters.getJpegThumbnailQuality();
  }

  public CameraSizeProxy getJpegThumbnailSize() {
    final Camera.Size size = cameraParameters.getJpegThumbnailSize();
    if (size == null) return null;
    return new CameraSizeProxy(implementations, true, size);
  }

  public Integer getMaxNumMeteringAreas() {
    return cameraParameters.getMaxNumMeteringAreas();
  }

  public List<CameraAreaProxy> getMeteringAreas() {
    final List<Camera.Area> areas = cameraParameters.getMeteringAreas();
    if (areas == null) return null;
    return CameraAreaProxy.fromList(implementations, areas);
  }

  public Integer getPictureFormat() {
    return cameraParameters.getPictureFormat();
  }

  public CameraSizeProxy getPreferredPreviewSizeForVideo() {
    final Camera.Size size = cameraParameters.getPreferredPreviewSizeForVideo();
    if (size == null) return null;
    return new CameraSizeProxy(implementations, true, size);
  }

  public Integer getPreviewFormat() {
    return cameraParameters.getPreviewFormat();
  }

  public List<Integer> getPreviewFpsRange() {
    final int[] range = new int[2];
    cameraParameters.getPreviewFpsRange(range);
    final List<Integer> intList = new ArrayList<>(range.length);
    for (int value : range) {
      intList.add(value);
    }
    return intList;
  }

  public String getSceneMode() {
    return cameraParameters.getSceneMode();
  }

  public List<String> getSupportedAntibanding() {
    return cameraParameters.getSupportedAntibanding();
  }

  public List<String> getSupportedColorEffects() {
    return cameraParameters.getSupportedColorEffects();
  }

  public List<CameraSizeProxy> getSupportedJpegThumbnailSizes() {
    return CameraSizeProxy.fromList(implementations, cameraParameters.getSupportedJpegThumbnailSizes());
  }

  public List<Integer> getSupportedPictureFormats() {
    return cameraParameters.getSupportedPictureFormats();
  }

  public List<Integer> getSupportedPreviewFormats() {
    return cameraParameters.getSupportedPreviewFormats();
  }

  public List<List<Integer>> getSupportedPreviewFpsRange() {
    final List<List<Integer>> ranges = new ArrayList<>();
    for (int[] range : cameraParameters.getSupportedPreviewFpsRange()) {
      ranges.add(Arrays.asList(range[0], range[1]));
    }
    return ranges;
  }

  public List<String> getSupportedSceneModes() {
    return cameraParameters.getSupportedSceneModes();
  }

  @Nullable
  public List<CameraSizeProxy> getSupportedVideoSizes() {
    final List<Camera.Size> sizes = cameraParameters.getSupportedVideoSizes();
    if (sizes == null) return null;
    return CameraSizeProxy.fromList(implementations, sizes);
  }

  public List<String> getSupportedWhiteBalance() {
    return cameraParameters.getSupportedWhiteBalance();
  }

  public Float getVerticalViewAngle() {
    return cameraParameters.getVerticalViewAngle();
  }

  public Boolean getVideoStabilization() {
    return cameraParameters.getVideoStabilization();
  }

  public String getWhiteBalance() {
    return cameraParameters.getWhiteBalance();
  }

  public List<Integer> getZoomRatios() {
    return cameraParameters.getZoomRatios();
  }

  public Boolean isAutoWhiteBalanceLockSupported() {
    return cameraParameters.isAutoWhiteBalanceLockSupported();
  }

  public Boolean isVideoSnapshotSupported() {
    return cameraParameters.isVideoSnapshotSupported();
  }

  public Boolean isVideoStabilizationSupported() {
    return cameraParameters.isVideoStabilizationSupported();
  }

  public void remove(String key) {
    cameraParameters.remove(key);
  }

  public void removeGpsData() {
    cameraParameters.removeGpsData();
  }

  public void set(String key, Object value) {
    if (value instanceof Integer) {
      cameraParameters.set(key, (Integer) value);
    } else if (value instanceof String) {
      cameraParameters.set(key, (String) value);
    } else {
      throw new IllegalArgumentException();
    }
  }

  public void setAntibanding(String antibanding) {
    cameraParameters.setAntibanding(antibanding);
  }

  public void setAutoWhiteBalanceLock(Boolean toggle) {
    cameraParameters.setAutoWhiteBalanceLock(toggle);
  }

  public void setColorEffect(String effect) {
    cameraParameters.setColorEffect(effect);
  }

  public void setGpsAltitude(Double meters) {
    cameraParameters.setGpsAltitude(meters);
  }

  public void setGpsLatitude(Double latitude) {
    cameraParameters.setGpsLatitude(latitude);
  }

  public void setGpsLongitude(Double longitude) {
    cameraParameters.setGpsLongitude(longitude);
  }

  public void setGpsProcessingMethod(String processingMethod) {
    cameraParameters.setGpsProcessingMethod(processingMethod);
  }

  public void setGpsTimestamp(Integer timestamp) {
    cameraParameters.setGpsTimestamp(timestamp);
  }

  public void setJpegQuality(Integer quality) {
    cameraParameters.setJpegQuality(quality);
  }

  public void setJpegThumbnailQuality(Integer quality) {
    cameraParameters.setJpegThumbnailQuality(quality);
  }

  public void setJpegThumbnailSize(Integer width, Integer height) {
    cameraParameters.setJpegThumbnailSize(width, height);
  }

  public void setMeteringAreas(List<CameraAreaProxy> meteringAreas) {
    if (meteringAreas == null) {
      cameraParameters.setMeteringAreas(null);
    } else {
      cameraParameters.setMeteringAreas(CameraAreaProxy.toAreaList(meteringAreas));
    }
  }

  public void setPictureFormat(Integer pixelFormat) {
    cameraParameters.setPictureFormat(pixelFormat);
  }

  public void setPreviewFormat(Integer pixelFormat) {
    cameraParameters.setPreviewFormat(pixelFormat);
  }

  public void setPreviewFpsRange(Integer min, Integer max) {
    cameraParameters.setPreviewFpsRange(min, max);
  }

  public void setSceneMode(String mode) {
    cameraParameters.setSceneMode(mode);
  }

  public void setVideoStabilization(Boolean toggle) {
    cameraParameters.setVideoStabilization(toggle);
  }

  public void setWhiteBalance(String value) {
    cameraParameters.setWhiteBalance(value);
  }

  public void unflatten(String flattened) {
    cameraParameters.unflatten(flattened);
  }
}
