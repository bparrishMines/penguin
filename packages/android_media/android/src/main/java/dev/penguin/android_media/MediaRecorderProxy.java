package dev.penguin.android_media;

import android.media.MediaRecorder;
import android.os.Build;

import dev.penguin.android_hardware.CameraProxy;

public class MediaRecorderProxy implements MediaRecorderChannelLibrary.$MediaRecorder {
  public final MediaRecorder mediaRecorder;

  public MediaRecorderProxy() {
    this(new MediaRecorder());
  }

  public MediaRecorderProxy(MediaRecorder mediaRecorder) {
    this.mediaRecorder = mediaRecorder;
  }

  @Override
  public Void setCamera(CameraProxy camera) {
    mediaRecorder.setCamera(camera.camera);
    return null;
  }

  @Override
  public Void setVideoSource(Integer source) {
    mediaRecorder.setVideoSource(source);
    return null;
  }

  @Override
  public Void setOutputFilePath(String path) {
    mediaRecorder.setOutputFile(path);
    return null;
  }

  @Override
  public Void setOutputFormat(Integer format) {
    mediaRecorder.setOutputFormat(format);
    return null;
  }

  @Override
  public Void setVideoEncoder(Integer encoder) {
    mediaRecorder.setVideoEncoder(encoder);
    return null;
  }

  @Override
  public Void setAudioSource(Integer source) {
    mediaRecorder.setAudioSource(source);
    return null;
  }

  @Override
  public Void setAudioEncoder(Integer encoder) {
    mediaRecorder.setAudioEncoder(encoder);
    return null;
  }

  @Override
  public Void prepare() throws Exception {
    mediaRecorder.prepare();
    return null;
  }

  @Override
  public Void start() {
    mediaRecorder.start();
    return null;
  }

  @Override
  public Void stop() {
    mediaRecorder.stop();
    return null;
  }

  @Override
  public Void release() {
    mediaRecorder.release();
    return null;
  }

  @Override
  public Void pause() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      mediaRecorder.pause();
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.N.");
    }
    return null;
  }

  @Override
  public Void resume() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      mediaRecorder.resume();
    } else {
      throw new UnsupportedOperationException("Requires version >= Build.VERSION_CODES.N.");
    }
    return null;
  }

  @Override
  public Integer getMaxAmplitude() {
    return mediaRecorder.getMaxAmplitude();
  }

  @Override
  public Void reset() {
    mediaRecorder.reset();
    return null;
  }

  @Override
  public Void setAudioChannels(Integer numChannels) {
    mediaRecorder.setAudioChannels(numChannels);
    return null;
  }

  @Override
  public Void setAudioEncodingBitRate(Integer bitRate) {
    mediaRecorder.setAudioEncodingBitRate(bitRate);
    return null;
  }

  @Override
  public Void setAudioSamplingRate(Integer samplingRate) {
    mediaRecorder.setAudioSamplingRate(samplingRate);
    return null;
  }

  @Override
  public Void setCaptureRate(Double fps) {
    mediaRecorder.setCaptureRate(fps);
    return null;
  }

  @Override
  public Void setLocation(Double latitude, Double longitude) {
    mediaRecorder.setLocation(latitude.floatValue(), longitude.floatValue());
    return null;
  }

  @Override
  public Void setMaxDuration(Integer maxDurationMs) {
    mediaRecorder.setMaxDuration(maxDurationMs);
    return null;
  }

  @Override
  public Void setMaxFileSize(Integer maxFilesizeBytes) {
    mediaRecorder.setMaxFileSize(maxFilesizeBytes);
    return null;
  }

  @Override
  public Void setOnErrorListener(MediaRecorderChannelLibrary.$OnErrorListener onError) {
    mediaRecorder.setOnErrorListener((mr, what, extra) -> onError.invoke(what, extra));
    return null;
  }

  @Override
  public Void setOnInfoListener(MediaRecorderChannelLibrary.$OnInfoListener onInfo) {
    mediaRecorder.setOnInfoListener((mr, what, extra) -> onInfo.invoke(what, extra));
    return null;
  }

  @Override
  public Void setOrientationHint(Integer degrees) {
    mediaRecorder.setOrientationHint(degrees);
    return null;
  }

  @Override
  public Void setVideoEncodingBitRate(Integer bitRate) {
    mediaRecorder.setVideoEncodingBitRate(bitRate);
    return null;
  }

  @Override
  public Void setVideoFrameRate(Integer rate) {
    mediaRecorder.setVideoFrameRate(rate);
    return null;
  }

  @Override
  public Void setVideoSize(Integer width, Integer height) {
    mediaRecorder.setVideoSize(width, height);
    return null;
  }

  @Override
  public Void setProfile(MediaRecorderChannelLibrary.$CamcorderProfile profile) {
    mediaRecorder.setProfile(((CamcorderProfileProxy)profile).camcorderProfile);
    return null;
  }
}
