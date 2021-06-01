package github.bparrishMines.penguin.penguin_android_camera;

import android.media.MediaRecorder;
import android.os.Build;

public class MediaRecorderProxy implements CameraChannelLibrary.$MediaRecorder {
  public final MediaRecorder mediaRecorder;

  public MediaRecorderProxy() {
    this(new MediaRecorder());
  }

  public MediaRecorderProxy(MediaRecorder mediaRecorder) {
    this.mediaRecorder = mediaRecorder;
  }

  @Override
  public Void setCamera(CameraChannelLibrary.$Camera camera) {
    final CameraProxy cameraProxy = (CameraProxy) camera;
    mediaRecorder.setCamera(cameraProxy.camera);
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
}
