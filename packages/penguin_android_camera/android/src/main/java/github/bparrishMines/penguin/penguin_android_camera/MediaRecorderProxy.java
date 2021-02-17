package github.bparrishMines.penguin.penguin_android_camera;

import android.media.MediaRecorder;

public class MediaRecorderProxy implements CameraChannelLibrary.$MediaRecorder {
  public final MediaRecorder mediaRecorder;
  private final Builder builder;

  public MediaRecorderProxy(Builder builder) {
    this(new MediaRecorder(), builder);
  }

  public MediaRecorderProxy(MediaRecorder mediaRecorder, Builder builder) {
    this.mediaRecorder = mediaRecorder;
    this.builder = builder;

    mediaRecorder.setCamera(builder.camera.camera);
    mediaRecorder.setVideoSource(MediaRecorder.VideoSource.CAMERA);
    mediaRecorder.setAudioSource(builder.audioSource);
    mediaRecorder.setOutputFormat(builder.outputFormat);
    mediaRecorder.setVideoEncoder(builder.videoEncoder);
    mediaRecorder.setAudioEncoder(builder.audioEncoder);
    mediaRecorder.setOutputFile(builder.outputFilePath);
  }

  @Override
  public CameraProxy getCamera() {
    return builder.camera;
  }

  @Override
  public Integer getOutputFormat() {
    return builder.outputFormat;
  }

  @Override
  public String getOutputFilePath() {
    return builder.outputFilePath;
  }

  @Override
  public Integer getVideoEncoder() {
    return builder.videoEncoder;
  }

  @Override
  public Integer getAudioSource() {
    return builder.audioSource;
  }

  @Override
  public Integer getAudioEncoder() {
    return builder.audioEncoder;
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

  public static class Builder {
    public CameraProxy camera;
    public Integer outputFormat;
    public String outputFilePath;
    public Integer videoEncoder;
    public Integer audioSource;
    public Integer audioEncoder;
  }
}
