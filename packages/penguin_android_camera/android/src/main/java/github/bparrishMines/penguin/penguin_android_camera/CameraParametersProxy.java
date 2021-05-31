package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.ArrayList;
import java.util.List;

public class CameraParametersProxy implements CameraChannelLibrary.$CameraParameters {
  public final Camera.Parameters cameraParameters;
  private final ChannelRegistrar.LibraryImplementations implementations;

  public CameraParametersProxy(Camera.Parameters cameraParameters, ChannelRegistrar.LibraryImplementations implementations) {
    this.cameraParameters = cameraParameters;
    this.implementations = implementations;
    implementations.getChannelCameraParameters().$$create(this, false);
  }

  public Boolean getAutoExposureLock() {
    return cameraParameters.getAutoExposureLock();
  }

  public List<CameraAreaProxy> getFocusAreas() {
    return CameraAreaProxy.fromList(cameraParameters.getFocusAreas(), implementations);
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

  public void setFocusAreas(List<CameraChannelLibrary.$CameraArea> focusAreas)  {
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
    return new CameraSizeProxy(cameraParameters.getPictureSize(), implementations);
  }

  public CameraSizeProxy getPreviewSize() {
    return new CameraSizeProxy(cameraParameters.getPreviewSize(), implementations);
  }

  public List<CameraSizeProxy> getSupportedPreviewSizes() {
    return CameraSizeProxy.fromList(cameraParameters.getSupportedPreviewSizes(), implementations);
  }

  public List<CameraSizeProxy> getSupportedPictureSizes() {
    return CameraSizeProxy.fromList(cameraParameters.getSupportedPictureSizes(), implementations);
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
}
