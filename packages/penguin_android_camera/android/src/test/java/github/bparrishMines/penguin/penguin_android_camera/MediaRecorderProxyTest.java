package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.media.MediaRecorder;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import io.flutter.view.TextureRegistry;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class MediaRecorderProxyTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  public MediaRecorder mockMediaRecorder;

  public MediaRecorderProxy.Builder testBuilder = new MediaRecorderProxy.Builder();

  @Before
  public void setUp() {
    testBuilder.outputFilePath = "output_file";
    testBuilder.videoEncoder = 12;
    testBuilder.outputFormat = 13;
    testBuilder.camera = mock(CameraProxy.class);
  }

  @Test
  public void constructorParameters() {
    final Camera mockCamera = mock(Camera.class);
    testBuilder.camera = new CameraProxy(mockCamera, mock(TextureRegistry.class));

    new MediaRecorderProxy(mockMediaRecorder, testBuilder);
    verify(mockMediaRecorder).setOutputFile("output_file");
    verify(mockMediaRecorder).setCamera(mockCamera);
    verify(mockMediaRecorder).setVideoEncoder(12);
    verify(mockMediaRecorder).setOutputFormat(13);
  }

  @Test
  public void prepare() throws Exception {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        testBuilder);

    mediaRecorderProxy.prepare();
    verify(mockMediaRecorder).prepare();
  }

  @Test
  public void start() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        testBuilder);

    mediaRecorderProxy.start();
    verify(mockMediaRecorder).start();
  }

  @Test
  public void stop() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        testBuilder);

    mediaRecorderProxy.stop();
    verify(mockMediaRecorder).stop();
  }

  @Test
  public void release() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        testBuilder);

    mediaRecorderProxy.release();
    verify(mockMediaRecorder).release();
  }
}
