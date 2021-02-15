package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.media.MediaRecorder;

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
  MediaRecorder mockMediaRecorder;

  @Test
  public void constructorParameters() {
    final Camera mockCamera = mock(Camera.class);
    final CameraProxy cameraProxy = new CameraProxy(mockCamera, mock(TextureRegistry.class));

    new MediaRecorderProxy(mockMediaRecorder, cameraProxy, "output_file");
    verify(mockMediaRecorder).setOutputFile("output_file");
    verify(mockMediaRecorder).setCamera(mockCamera);
  }

  @Test
  public void prepare() throws Exception {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        mock(CameraProxy.class),
        "output_file");

    mediaRecorderProxy.prepare();
    verify(mockMediaRecorder).prepare();
  }

  @Test
  public void start() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        mock(CameraProxy.class),
        "output_file");

    mediaRecorderProxy.start();
    verify(mockMediaRecorder).start();
  }

  @Test
  public void stop() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        mock(CameraProxy.class),
        "output_file");

    mediaRecorderProxy.stop();
    verify(mockMediaRecorder).stop();
  }

  @Test
  public void release() {
    final MediaRecorderProxy mediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder,
        mock(CameraProxy.class),
        "output_file");

    mediaRecorderProxy.release();
    verify(mockMediaRecorder).release();
  }
}
