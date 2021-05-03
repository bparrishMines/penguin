package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraParametersProxy implements CameraChannelLibrary.$CameraParameters {
  public final Camera.Parameters cameraParameters;
  public final ChannelRegistrar.LibraryImplementations implementations;

  public CameraParametersProxy(Camera.Parameters cameraParameters, ChannelRegistrar.LibraryImplementations implementations) {
    this.cameraParameters = cameraParameters;
    this.implementations = implementations;
    implementations.getCameraParametersChannel().createNewInstancePair(this, false);
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

  @Override
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
    return new CameraSizeProxy(cameraParameters.getPictureSize(), implementations);
  }

  @Override
  public CameraSizeProxy getPreviewSize() {
    return new CameraSizeProxy(cameraParameters.getPreviewSize(), implementations);
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
}
