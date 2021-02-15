package github.bparrishMines.penguin.penguin_android_camera;

import android.media.MediaRecorder;

public class MediaRecorderProxy implements CameraChannelLibrary.$MediaRecorder {
  public final MediaRecorder mediaRecorder;
  private final CameraProxy camera;
  private final String outputFilePath;

  public MediaRecorderProxy(CameraProxy camera, String outputFilePath) {
    this(new MediaRecorder(), camera, outputFilePath);
  }

  public MediaRecorderProxy(MediaRecorder mediaRecorder, CameraProxy camera, String outputFilePath) {
    this.mediaRecorder = mediaRecorder;
    this.camera = camera;
    this.outputFilePath = outputFilePath;

    mediaRecorder.setOutputFile(outputFilePath);
    mediaRecorder.setCamera(camera.camera);
  }

  @Override
  public CameraProxy getCamera() {
    return camera;
  }

  @Override
  public String getOutputFilePath() {
    return outputFilePath;
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
}
