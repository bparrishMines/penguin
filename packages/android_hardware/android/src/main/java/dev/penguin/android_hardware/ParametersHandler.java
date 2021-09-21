package dev.penguin.android_hardware;

import android.hardware.Camera.Area;
import android.hardware.Camera.Parameters;
import android.hardware.Camera.Size;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ParametersHandler extends CameraChannelLibrary.$ParametersHandler {
  public ParametersHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public List<Area> $getFocusAreas(Parameters $instance) {
    final List<Area> areas = $instance.getFocusAreas();
    for (Area area : areas) {
      implementations.channelArea.$create$(area, false);
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
  public Size $getPictureSize(Parameters $instance) {
    final Size size = $instance.getPictureSize();
    implementations.channelSize.$create$(size, false);
    return size;
  }

  @Override
  public Size $getPreviewSize(Parameters $instance) {
    final Size size = $instance.getPreviewSize();
    implementations.channelSize.$create$(size, false);
    return size;
  }

  @Override
  public List<Size> $getSupportedPreviewSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedPreviewSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false);
    }
    return sizes;
  }

  @Override
  public List<Size> $getSupportedPictureSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedPictureSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false);
    }
    return sizes;
  }

  @Override
  public Size $getJpegThumbnailSize(Parameters $instance) {
    final Size size = $instance.getJpegThumbnailSize();
    if (size != null) {
      implementations.channelSize.$create$(size, false);
    }
    return size;
  }

  @Override
  public List<Area> $getMeteringAreas(Parameters $instance) {
    final List<Area> areas = $instance.getMeteringAreas();
    if (areas != null) {
      for (Area area : areas) {
        implementations.channelArea.$create$(area, false);
      }
    }
    return areas;
  }

  @Override
  public Size $getPreferredPreviewSizeForVideo(Parameters $instance) {
    final Size size = $instance.getPreferredPreviewSizeForVideo();
    if (size != null) {
      implementations.channelSize.$create$(size, false);
    }
    return size;
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
  public List<Size> $getSupportedJpegThumbnailSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedJpegThumbnailSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false);
    }
    return sizes;
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
  @Nullable
  public List<Size> $getSupportedVideoSizes(Parameters $instance) {
    final List<Size> sizes = $instance.getSupportedVideoSizes();
    for (Size size : sizes) {
      implementations.channelSize.$create$(size, false);
    }
    return sizes;
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
}
