package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.media.MediaRecorder;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.api.mockito.PowerMockito;

import io.flutter.view.TextureRegistry;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class MediaRecorderProxyTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  public MediaRecorder mockMediaRecorder;

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  public MediaRecorderProxy testMediaRecorderProxy;

  @Before
  public void setUp() {
    testMediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder);
  }

  @Test
  public void setCamera() {
    final Camera mockCamera = mock(Camera.class);
    final CameraChannelLibrary.$CameraChannel mockCameraChannel = mock(CameraChannelLibrary.$CameraChannel.class);
    when(mockImplementations.getChannelCamera()).thenReturn(mockCameraChannel);
    final CameraProxy cameraProxy = new CameraProxy(mockCamera, mock(TextureRegistry.class), mockImplementations);

    testMediaRecorderProxy.setCamera(cameraProxy);
    verify(mockMediaRecorder).setCamera(mockCamera);
  }

  @Test
  public void setVideoSource() {
    testMediaRecorderProxy.setVideoSource(12);
    verify(mockMediaRecorder).setVideoSource(12);
  }

  @Test
  public void setAudioSource() {
    testMediaRecorderProxy.setAudioSource(12);
    verify(mockMediaRecorder).setAudioSource(12);
  }

  @Test
  public void setAudioEncoder() {
    testMediaRecorderProxy.setAudioEncoder(12);
    verify(mockMediaRecorder).setAudioEncoder(12);
  }

  @Test
  public void setVideoEncoder() {
    testMediaRecorderProxy.setVideoEncoder(12);
    verify(mockMediaRecorder).setVideoEncoder(12);
  }


  @Test
  public void setOutputFormat() {
    testMediaRecorderProxy.setOutputFormat(12);
    verify(mockMediaRecorder).setOutputFormat(12);
  }

  @Test
  public void setOutputFile() {
    testMediaRecorderProxy.setOutputFilePath("apple");
    verify(mockMediaRecorder).setOutputFile("apple");
  }

  @Test
  public void prepare() throws Exception {
    testMediaRecorderProxy.prepare();
    verify(mockMediaRecorder).prepare();
  }

  @Test
  public void start() {
    testMediaRecorderProxy.start();
    verify(mockMediaRecorder).start();
  }

  @Test
  public void stop() {
    testMediaRecorderProxy.stop();
    verify(mockMediaRecorder).stop();
  }

  @Test
  public void release() {
    testMediaRecorderProxy.release();
    verify(mockMediaRecorder).release();
  }
}
