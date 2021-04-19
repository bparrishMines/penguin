package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import java.util.List;

public class CameraParametersProxy implements CameraChannelLibrary.$CameraParameters {
  public final Camera.Parameters cameraParameters;
  public final ChannelRegistrar.LibraryImplementations implementations;

  public CameraParametersProxy(Camera.Parameters cameraParameters, ChannelRegistrar.LibraryImplementations implementations) {
    this.cameraParameters = cameraParameters;
    this.implementations = implementations;
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
    return cameraParameters.getSupportedFlashModes();
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
}
