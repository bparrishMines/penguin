package dev.penguin.android_hardware;

import android.hardware.Camera.Area;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.Size;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ParametersHandler extends CameraChannelLibrary.$ParametersHandler {
  public ParametersHandler(CameraChannelLibrary.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public Boolean $getAutoExposureLock(Parameters $instance) {
    return $instance.getAutoExposureLock();
  }

  @Override
  public List<Area> $getFocusAreas(Parameters $instance) {
    final List<Area> areas = $instance.getFocusAreas();
    for (Area area : areas) {
      implementations.channelArea.$create$(area, false, area.rect, area.weight);
    }
    return areas;
  }

  @Override
  public List<Double> $getFocusDistances(Parameters $instance) {
    final float[] distances = new float[3];
    $instance.getFocusDistances(distances);
    final List<Double> doubleList = new ArrayList<>(distances.length);
    for (float distance : distances) {
      doubleList.add((double) distance);
    }
    return doubleList;
  }

  @Override
  public Integer $getMaxExposureCompensation(Parameters $instance) {
    return $instance.getMaxExposureCompensation();
  }

  @Override
  public Integer $getMaxNumFocusAreas(Parameters $instance) {
    return $instance.getMaxNumFocusAreas();
  }

  @Override
  public Integer $getMinExposureCompensation(Parameters $instance) {
    return $instance.getMinExposureCompensation();
  }

  @Override
  public List<String> $getSupportedFocusModes(Parameters $instance) {
    return $instance.getSupportedFocusModes();
  }

  @Override
  public Boolean $isAutoExposureLockSupported(Parameters $instance) {
    return $instance.isAutoExposureLockSupported();
  }

  @Override
  public Boolean $isZoomSupported(Parameters $instance) {
    return $instance.isZoomSupported();
  }

  @Override
  public void $setAutoExposureLock(Parameters $instance, Boolean toggle) {
    $instance.setAutoExposureLock(toggle);
  }

  @Override
  public void $setExposureCompensation(Parameters $instance, Integer value) {
    $instance.setExposureCompensation(value);
  }

  @Override
  public void $setFocusAreas(Parameters $instance, List<Area> focusAreas) {
    $instance.setFocusAreas(focusAreas);
  }

  @Override
  public void $setFocusMode(Parameters $instance, String value) {
    $instance.setFocusMode(value);
  }

  @Override
  public String $getFlashMode(Parameters $instance) {
    return $instance.getFlashMode();
  }

  @Override
  public Integer $getMaxZoom(Parameters $instance) {
    return $instance.getMaxZoom();
  }

  @Override
  public Size $getPictureSize(Parameters $instance) {
    final Size size = $instance.getPictureSize();
    implementations.channelSize.$create$(size, false, size.width, size.height);
    return size;
  }

  @Override
  public Size $getPreviewSize(Parameters $instance) {
    final Size size = $instance.getPreviewSize();
    implementations.channelSize.$create$(size, false, size.width, size.height);
    return size;
  }

  @Override
  public List<Size> $getSupportedPreviewSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedPreviewSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return sizes;
  }

  @Override
  public List<Size> $getSupportedPictureSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedPictureSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return sizes;
  }

  @Override
  public List<String> $getSupportedFlashModes(Parameters $instance) {
    final List<String> modes = $instance.getSupportedFlashModes();
    if (modes != null) return modes;
    return new ArrayList<>();
  }

  @Override
  public Integer $getZoom(Parameters $instance) {
    return $instance.getZoom();
  }

  @Override
  public Boolean $isSmoothZoomSupported(Parameters $instance) {
    return $instance.isSmoothZoomSupported();
  }

  @Override
  public void $setFlashMode(Parameters $instance, String mode) {
    $instance.setFlashMode(mode);
  }

  @Override
  public void $setPictureSize(Parameters $instance, Integer width, Integer height) {
    $instance.setPictureSize(width, height);
  }

  @Override
  public void $setRecordingHint(Parameters $instance, Boolean hint) {
    $instance.setRecordingHint(hint);
  }

  @Override
  public void $setRotation(Parameters $instance, Integer rotation) {
    $instance.setRotation(rotation);
  }

  @Override
  public void $setZoom(Parameters $instance, Integer value) {
    $instance.setZoom(value);
  }

  @Override
  public void $setPreviewSize(Parameters $instance, Integer width, Integer height) {
    $instance.setPreviewSize(width, height);
  }

  @Override
  public Integer $getExposureCompensation(Parameters $instance) {
    return $instance.getExposureCompensation();
  }

  @Override
  public Double $getExposureCompensationStep(Parameters $instance) {
    return (double) $instance.getExposureCompensationStep();
  }

  @Override
  public String $flatten(Parameters $instance) {
    return $instance.flatten();
  }

  @Override
  public String $get(Parameters $instance, String key) {
    return $instance.get(key);
  }

  @Override
  public String $getAntibanding(Parameters $instance) {
    return $instance.getAntibanding();
  }

  @Override
  public Boolean $getAutoWhiteBalanceLock(Parameters $instance) {
    return $instance.getAutoWhiteBalanceLock();
  }

  @Override
  public String $getColorEffect(Parameters $instance) {
    return $instance.getColorEffect();
  }

  @Override
  public Double $getFocalLength(Parameters $instance) {
    return (double) $instance.getFocalLength();
  }

  @Override
  public String $getFocusMode(Parameters $instance) {
    return $instance.getFocusMode();
  }

  @Override
  public Double $getHorizontalViewAngle(Parameters $instance) {
    return (double) $instance.getHorizontalViewAngle();
  }

  @Override
  public Integer $getInt(Parameters $instance, String key) {
    return $instance.getInt(key);
  }

  @Override
  public Integer $getJpegQuality(Parameters $instance) {
    return $instance.getJpegQuality();
  }

  @Override
  public Integer $getJpegThumbnailQuality(Parameters $instance) {
    return $instance.getJpegThumbnailQuality();
  }

  @Override
  public Size $getJpegThumbnailSize(Parameters $instance) {
    final Size size = $instance.getJpegThumbnailSize();
    if (size != null) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return size;
  }

  @Override
  public Integer $getMaxNumMeteringAreas(Parameters $instance) {
    return $instance.getMaxNumMeteringAreas();
  }

  @Override
  public List<Area> $getMeteringAreas(Parameters $instance) {
    final List<Area> areas = $instance.getMeteringAreas();
    if (areas != null) {
      for (Area area : areas) {
        implementations.channelArea.$create$(area, false, area.rect, area.weight);
      }
    }
    return areas;
  }

  @Override
  public Integer $getPictureFormat(Parameters $instance) {
    return $instance.getPictureFormat();
  }

  @Override
  public Size $getPreferredPreviewSizeForVideo(Parameters $instance) {
    final Size size = $instance.getPreferredPreviewSizeForVideo();
    if (size != null) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return size;
  }

  @Override
  public Integer $getPreviewFormat(Parameters $instance) {
    return $instance.getPreviewFormat();
  }

  @Override
  public List<Integer> $getPreviewFpsRange(Parameters $instance) {
    final int[] range = new int[2];
    $instance.getPreviewFpsRange(range);
    final List<Integer> intList = new ArrayList<>(range.length);
    for (int value : range) {
      intList.add(value);
    }
    return intList;
  }

  @Override
  public String $getSceneMode(Parameters $instance) {
    return $instance.getSceneMode();
  }

  @Override
  public List<String> $getSupportedAntibanding(Parameters $instance) {
    return $instance.getSupportedAntibanding();
  }

  @Override
  public List<String> $getSupportedColorEffects(Parameters $instance) {
    return $instance.getSupportedColorEffects();
  }

  @Override
  public List<Size> $getSupportedJpegThumbnailSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedJpegThumbnailSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return sizes;
  }

  @Override
  public List<Integer> $getSupportedPictureFormats(Parameters $instance) {
    return $instance.getSupportedPictureFormats();
  }

  @Override
  public List<Integer> $getSupportedPreviewFormats(Parameters $instance) {
    return $instance.getSupportedPreviewFormats();
  }

  @Override
  public List<List<Integer>> $getSupportedPreviewFpsRange(Parameters $instance) {
    final List<List<Integer>> ranges = new ArrayList<>();
    for (int[] range : $instance.getSupportedPreviewFpsRange()) {
      ranges.add(Arrays.asList(range[0], range[1]));
    }
    return ranges;
  }

  @Override
  public List<String> $getSupportedSceneModes(Parameters $instance) {
    return $instance.getSupportedSceneModes();
  }

  @Override
  @Nullable
  public List<Size> $getSupportedVideoSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedVideoSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false, size.width, size.height);
    }
    return sizes;
  }

  @Override
  public List<String> $getSupportedWhiteBalance(Parameters $instance) {
    return $instance.getSupportedWhiteBalance();
  }

  @Override
  public Double $getVerticalViewAngle(Parameters $instance) {
    return (double) $instance.getVerticalViewAngle();
  }

  @Override
  public Boolean $getVideoStabilization(Parameters $instance) {
    return $instance.getVideoStabilization();
  }

  @Override
  public String $getWhiteBalance(Parameters $instance) {
    return $instance.getWhiteBalance();
  }

  @Override
  public List<Integer> $getZoomRatios(Parameters $instance) {
    return $instance.getZoomRatios();
  }

  @Override
  public Boolean $isAutoWhiteBalanceLockSupported(Parameters $instance) {
    return $instance.isAutoWhiteBalanceLockSupported();
  }

  @Override
  public Boolean $isVideoSnapshotSupported(Parameters $instance) {
    return $instance.isVideoSnapshotSupported();
  }

  @Override
  public Boolean $isVideoStabilizationSupported(Parameters $instance) {
    return $instance.isVideoStabilizationSupported();
  }

  @Override
  public void $remove(Parameters $instance, String key) {
    $instance.remove(key);
  }

  @Override
  public void $removeGpsData(Parameters $instance) {
    $instance.removeGpsData();
  }

  @Override
  public void $set(Parameters $instance, String key, Object value) {
    if (value instanceof Integer) {
      $instance.set(key, (Integer) value);
    } else if (value instanceof String) {
      $instance.set(key, (String) value);
    } else {
      throw new IllegalArgumentException();
    }
  }

  @Override
  public void $setAntibanding(Parameters $instance, String antibanding) {
    $instance.setAntibanding(antibanding);
  }

  @Override
  public void $setAutoWhiteBalanceLock(Parameters $instance, Boolean toggle) {
    $instance.setAutoWhiteBalanceLock(toggle);
  }

  @Override
  public void $setColorEffect(Parameters $instance, String effect) {
    $instance.setColorEffect(effect);
  }

  @Override
  public void $setGpsAltitude(Parameters $instance, Double meters) {
    $instance.setGpsAltitude(meters);
  }

  @Override
  public void $setGpsLatitude(Parameters $instance, Double latitude) {
    $instance.setGpsLatitude(latitude);
  }

  @Override
  public void $setGpsLongitude(Parameters $instance, Double longitude) {
    $instance.setGpsLongitude(longitude);
  }

  @Override
  public void $setGpsProcessingMethod(Parameters $instance, String processingMethod) {
    $instance.setGpsProcessingMethod(processingMethod);
  }

  @Override
  public void $setGpsTimestamp(Parameters $instance, Integer timestamp) {
    $instance.setGpsTimestamp(timestamp);
  }

  @Override
  public void $setJpegQuality(Parameters $instance, Integer quality) {
    $instance.setJpegQuality(quality);
  }

  @Override
  public void $setJpegThumbnailQuality(Parameters $instance, Integer quality) {
    $instance.setJpegThumbnailQuality(quality);
  }

  @Override
  public void $setJpegThumbnailSize(Parameters $instance, Integer width, Integer height) {
    $instance.setJpegThumbnailSize(width, height);
  }

  @Override
  public void $setMeteringAreas(Parameters $instance, List<Area> meteringAreas) {
    $instance.setMeteringAreas(meteringAreas);
  }

  @Override
  public void $setPictureFormat(Parameters $instance, Integer pixelFormat) {
    $instance.setPictureFormat(pixelFormat);
  }

  @Override
  public void $setPreviewFormat(Parameters $instance, Integer pixelFormat) {
    $instance.setPreviewFormat(pixelFormat);
  }

  @Override
  public void $setPreviewFpsRange(Parameters $instance, Integer min, Integer max) {
    $instance.setPreviewFpsRange(min, max);
  }

  @Override
  public void $setSceneMode(Parameters $instance, String mode) {
    $instance.setSceneMode(mode);
  }

  @Override
  public void $setVideoStabilization(Parameters $instance, Boolean toggle) {
    $instance.setVideoStabilization(toggle);
  }

  @Override
  public void $setWhiteBalance(Parameters $instance, String value) {
    $instance.setWhiteBalance(value);
  }

  @Override
  public void $unflatten(Parameters $instance, String flattened) {
    $instance.unflatten(flattened);
  }
}
