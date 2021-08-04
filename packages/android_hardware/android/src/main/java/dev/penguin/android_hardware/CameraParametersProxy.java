package dev.penguin.android_hardware;

import android.hardware.Camera;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CameraParametersProxy implements CameraChannelLibrary.$CameraParameters {
  public final Camera.Parameters cameraParameters;
  public final ChannelRegistrar.LibraryImplementations implementations;

  public CameraParametersProxy(Camera.Parameters cameraParameters, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this.cameraParameters = cameraParameters;
    this.implementations = implementations;
    if (create) {
      implementations.getChannelCameraParameters().$create$(this, false);
    }
  }

  @Override
  public Boolean getAutoExposureLock() {
    return cameraParameters.getAutoExposureLock();
  }

  @Override
  public List<CameraAreaProxy> getFocusAreas() {
    return CameraAreaProxy.fromList(cameraParameters.getFocusAreas(), implementations);
  }

  @Override
  public List<Float> getFocusDistances() {
    final float[] distances = new float[3];
    cameraParameters.getFocusDistances(distances);
    final List<Float> floatList = new ArrayList<>(distances.length);
    for (float distance : distances) {
      floatList.add(distance);
    }
    return floatList;
  }

  @Override
  public Integer getMaxExposureCompensation() {
    return cameraParameters.getMaxExposureCompensation();
  }

  @Override
  public Integer getMaxNumFocusAreas() {
    return cameraParameters.getMaxNumFocusAreas();
  }

  @Override
  public Integer getMinExposureCompensation() {
    return cameraParameters.getMinExposureCompensation();
  }

  @Override
  public List<String> getSupportedFocusModes()  {
    return cameraParameters.getSupportedFocusModes();
  }

  @Override
  public Boolean isAutoExposureLockSupported()  {
    return cameraParameters.isAutoExposureLockSupported();
  }

  @Override
  public Boolean isZoomSupported() {
    return cameraParameters.isZoomSupported();
  }

  @Override
  public Void setAutoExposureLock(Boolean toggle)  {
    cameraParameters.setAutoExposureLock(toggle);
    return null;
  }

  @Override
  public Void setExposureCompensation(Integer value)  {
    cameraParameters.setExposureCompensation(value);
    return null;
  }

  @Override
  public Void setFocusAreas(List<CameraChannelLibrary.$CameraArea> focusAreas)  {
    cameraParameters.setFocusAreas(CameraAreaProxy.toAreaList(focusAreas));
    return null;
  }

  public Void setFocusMode(String value)  {
    cameraParameters.setFocusMode(value);
    return null;
  }

  @Override
  public String getFlashMode() {
    return cameraParameters.getFlashMode();
  }

  @Override
  public Integer getMaxZoom() {
    return cameraParameters.getMaxZoom();
  }

  @Override
  public CameraSizeProxy getPictureSize() {
    return new CameraSizeProxy(cameraParameters.getPictureSize(), implementations, true);
  }

  @Override
  public CameraSizeProxy getPreviewSize() {
    return new CameraSizeProxy(cameraParameters.getPreviewSize(), implementations, true);
  }

  @Override
  public List<CameraSizeProxy> getSupportedPreviewSizes() {
    return CameraSizeProxy.fromList(cameraParameters.getSupportedPreviewSizes(), implementations);
  }

  @Override
  public List<CameraSizeProxy> getSupportedPictureSizes() {
    return CameraSizeProxy.fromList(cameraParameters.getSupportedPictureSizes(), implementations);
  }

  @Override
  public List<String> getSupportedFlashModes() {
    final List<String> modes = cameraParameters.getSupportedFlashModes();
    if (modes != null) return modes;
    return new ArrayList<>();
  }

  @Override
  public Integer getZoom() {
    return cameraParameters.getZoom();
  }

  @Override
  public Boolean isSmoothZoomSupported() {
    return cameraParameters.isSmoothZoomSupported();
  }

  @Override
  public Void setFlashMode(String mode) {
    cameraParameters.setFlashMode(mode);
    return null;
  }

  @Override
  public Void setPictureSize(Integer width, Integer height) {
    cameraParameters.setPictureSize(width, height);
    return null;
  }

  @Override
  public Void setRecordingHint(Boolean hint) {
    cameraParameters.setRecordingHint(hint);
    return null;
  }

  @Override
  public Void setRotation(Integer rotation) {
    cameraParameters.setRotation(rotation);
    return null;
  }

  @Override
  public Void setZoom(Integer value) {
    cameraParameters.setZoom(value);
    return null;
  }

  @Override
  public Void setPreviewSize(Integer width, Integer height) {
    cameraParameters.setPreviewSize(width, height);
    return null;
  }

  @Override
  public Integer getExposureCompensation() {
    return cameraParameters.getExposureCompensation();
  }

  @Override
  public Float getExposureCompensationStep() {
    return cameraParameters.getExposureCompensationStep();
  }

  // TODO: Test starts here to below
  @Override
  public String flatten() {
    return cameraParameters.flatten();
  }

  @Override
  public String get(String key) {
    return cameraParameters.get(key);
  }

  @Override
  public String getAntibanding() {
    return cameraParameters.getAntibanding();
  }

  @Override
  public Boolean getAutoWhiteBalanceLock() {
    return cameraParameters.getAutoWhiteBalanceLock();
  }

  @Override
  public String getColorEffect() {
    return cameraParameters.getColorEffect();
  }

  @Override
  public Float getFocalLength() {
    return cameraParameters.getFocalLength();
  }

  @Override
  public String getFocusMode() {
    return cameraParameters.getFocusMode();
  }

  @Override
  public Float getHorizontalViewAngle() {
    return cameraParameters.getHorizontalViewAngle();
  }

  @Override
  public Integer getInt(String key) {
    return cameraParameters.getInt(key);
  }

  @Override
  public Integer getJpegQuality() {
    return cameraParameters.getJpegQuality();
  }

  @Override
  public Integer getJpegThumbnailQuality() {
    return cameraParameters.getJpegThumbnailQuality();
  }

  @Override
  public CameraSizeProxy getJpegThumbnailSize() {
    final Camera.Size size = cameraParameters.getJpegThumbnailSize();
    if (size == null) return null;
    return new CameraSizeProxy(size, implementations, true);
  }

  @Override
  public Integer getMaxNumMeteringAreas() {
    return cameraParameters.getMaxNumMeteringAreas();
  }

  @Override
  public List<CameraAreaProxy> getMeteringAreas() {
    final List<Camera.Area> areas = cameraParameters.getMeteringAreas();
    if (areas == null) return null;
    return CameraAreaProxy.fromList(areas, implementations);
  }

  @Override
  public Integer getPictureFormat() {
    return cameraParameters.getPictureFormat();
  }

  @Override
  public CameraSizeProxy getPreferredPreviewSizeForVideo() {
    final Camera.Size size = cameraParameters.getPreferredPreviewSizeForVideo();
    if (size == null) return null;
    return new CameraSizeProxy(size, implementations, true);
  }

  @Override
  public Integer getPreviewFormat() {
    return cameraParameters.getPreviewFormat();
  }

  @Override
  public List<Integer> getPreviewFpsRange() {
    final int[] range = new int[2];
    cameraParameters.getPreviewFpsRange(range);
    final List<Integer> intList = new ArrayList<>(range.length);
    for (int value : range) {
      intList.add(value);
    }
    return intList;
  }

  @Override
  public String getSceneMode() {
    return cameraParameters.getSceneMode();
  }

  @Override
  public List<String> getSupportedAntibanding() {
    return cameraParameters.getSupportedAntibanding();
  }

  @Override
  public List<String> getSupportedColorEffects() {
    return cameraParameters.getSupportedColorEffects();
  }

  @Override
  public List<CameraSizeProxy> getSupportedJpegThumbnailSizes() {
    return CameraSizeProxy.fromList(cameraParameters.getSupportedJpegThumbnailSizes(), implementations);
  }

  @Override
  public List<Integer> getSupportedPictureFormats() {
    return cameraParameters.getSupportedPictureFormats();
  }

  @Override
  public List<Integer> getSupportedPreviewFormats() {
    return cameraParameters.getSupportedPreviewFormats();
  }

  @Override
  public List<List<Integer>> getSupportedPreviewFpsRange() {
    final List<List<Integer>> ranges = new ArrayList<>();
    for (int[] range : cameraParameters.getSupportedPreviewFpsRange()) {
      ranges.add(Arrays.asList(range[0], range[1]));
    }
    return ranges;
  }

  @Override
  public List<String> getSupportedSceneModes() {
    return cameraParameters.getSupportedSceneModes();
  }

  @Nullable
  @Override
  public List<CameraSizeProxy> getSupportedVideoSizes() {
    final List<Camera.Size> sizes = cameraParameters.getSupportedVideoSizes();
    if (sizes == null) return null;
    return CameraSizeProxy.fromList(sizes, implementations);
  }

  @Override
  public List<String> getSupportedWhiteBalance() {
    return cameraParameters.getSupportedWhiteBalance();
  }

  @Override
  public Float getVerticalViewAngle() {
    return cameraParameters.getVerticalViewAngle();
  }

  @Override
  public Boolean getVideoStabilization() {
    return cameraParameters.getVideoStabilization();
  }

  @Override
  public String getWhiteBalance() {
    return cameraParameters.getWhiteBalance();
  }

  @Override
  public List<Integer> getZoomRatios() {
    return cameraParameters.getZoomRatios();
  }

  @Override
  public Boolean isAutoWhiteBalanceLockSupported() {
    return cameraParameters.isAutoWhiteBalanceLockSupported();
  }

  @Override
  public Boolean isVideoSnapshotSupported() {
    return cameraParameters.isVideoSnapshotSupported();
  }

  @Override
  public Boolean isVideoStabilizationSupported() {
    return cameraParameters.isVideoStabilizationSupported();
  }

  @Override
  public Void remove(String key) {
    cameraParameters.remove(key);
    return null;
  }

  @Override
  public Void removeGpsData() {
    cameraParameters.removeGpsData();
    return null;
  }

  @Override
  public Void set(String key, Object value) {
    if (value instanceof Integer) {
      cameraParameters.set(key, (Integer) value);
    } else if (value instanceof String) {
      cameraParameters.set(key, (String) value);
    } else {
      throw new IllegalArgumentException();
    }
    return null;
  }

  @Override
  public Void setAntibanding(String antibanding) {
    cameraParameters.setAntibanding(antibanding);
    return null;
  }

  @Override
  public Void setAutoWhiteBalanceLock(Boolean toggle) {
    cameraParameters.setAutoWhiteBalanceLock(toggle);
    return null;
  }

  @Override
  public Void setColorEffect(String effect) {
    cameraParameters.setColorEffect(effect);
    return null;
  }

  @Override
  public Void setGpsAltitude(Double meters) {
    cameraParameters.setGpsAltitude(meters);
    return null;
  }

  @Override
  public Void setGpsLatitude(Double latitude) {
    cameraParameters.setGpsLatitude(latitude);
    return null;
  }

  @Override
  public Void setGpsLongitude(Double longitude) {
    cameraParameters.setGpsLongitude(longitude);
    return null;
  }

  @Override
  public Void setGpsProcessingMethod(String processingMethod) {
    cameraParameters.setGpsProcessingMethod(processingMethod);
    return null;
  }

  @Override
  public Void setGpsTimestamp(Integer timestamp) {
    cameraParameters.setGpsTimestamp(timestamp);
    return null;
  }

  @Override
  public Void setJpegQuality(Integer quality) {
    cameraParameters.setJpegQuality(quality);
    return null;
  }

  @Override
  public Void setJpegThumbnailQuality(Integer quality) {
    cameraParameters.setJpegThumbnailQuality(quality);
    return null;
  }

  @Override
  public Void setJpegThumbnailSize(Integer width, Integer height) {
    cameraParameters.setJpegThumbnailSize(width, height);
    return null;
  }

  @Override
  public Void setMeteringAreas(List<CameraChannelLibrary.$CameraArea> meteringAreas) {
    if (meteringAreas == null) {
      cameraParameters.setMeteringAreas(null);
    } else {
      cameraParameters.setMeteringAreas(CameraAreaProxy.toAreaList(meteringAreas));
    }
    return null;
  }

  @Override
  public Void setPictureFormat(Integer pixelFormat) {
    cameraParameters.setPictureFormat(pixelFormat);
    return null;
  }

  @Override
  public Void setPreviewFormat(Integer pixelFormat) {
    cameraParameters.setPreviewFormat(pixelFormat);
    return null;
  }

  @Override
  public Void setPreviewFpsRange(Integer min, Integer max) {
    cameraParameters.setPreviewFpsRange(min, max);
    return null;
  }

  @Override
  public Void setSceneMode(String mode) {
    cameraParameters.setSceneMode(mode);
    return null;
  }

  @Override
  public Void setVideoStabilization(Boolean toggle) {
    cameraParameters.setVideoStabilization(toggle);
    return null;
  }

  @Override
  public Void setWhiteBalance(String value) {
    cameraParameters.setWhiteBalance(value);
    return null;
  }

  @Override
  public Void unflatten(String flattened) {
    cameraParameters.unflatten(flattened);
    return null;
  }
}
