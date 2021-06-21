package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.media.MediaRecorder;
import android.os.Build;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

import static github.bparrishMines.penguin.penguin_android_camera.Utils.setFinalStatic;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class MediaRecorderProxyTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  public MediaRecorder mockMediaRecorder;

  public MediaRecorderProxy testMediaRecorderProxy;

  @Before
  public void setUp() {
    testMediaRecorderProxy = new MediaRecorderProxy(mockMediaRecorder);
  }

  @Test
  public void outputFormat() {
    assertEquals(MediaRecorder.OutputFormat.AAC_ADTS, 0x00000006);
    assertEquals(MediaRecorder.OutputFormat.AMR_NB, 0x00000003);
    assertEquals(MediaRecorder.OutputFormat.AMR_WB, 0x00000004);
    assertEquals(MediaRecorder.OutputFormat.DEFAULT, 0x00000000);
    assertEquals(MediaRecorder.OutputFormat.MPEG_2_TS, 0x00000008);
    assertEquals(MediaRecorder.OutputFormat.MPEG_4, 0x00000002);
    assertEquals(MediaRecorder.OutputFormat.OGG, 0x0000000b);
    //noinspection deprecation
    assertEquals(MediaRecorder.OutputFormat.RAW_AMR, 0x00000003);
    assertEquals(MediaRecorder.OutputFormat.THREE_GPP, 0x00000001);
    assertEquals(MediaRecorder.OutputFormat.WEBM, 0x00000009);
  }

  @Test
  public void videoEncoder() {
    assertEquals(MediaRecorder.VideoEncoder.MPEG_4_SP, 0x00000003);
  }

  @Test
  public void audioSource() {
    assertEquals(MediaRecorder.AudioSource.DEFAULT, 0x00000000);
  }

  @Test
  public void audioEncoder() {
    assertEquals(MediaRecorder.AudioEncoder.AMR_NB, 0x00000001);
  }

  @Test
  public void videoSource() {
    assertEquals(MediaRecorder.VideoSource.CAMERA, 0x00000001);
  }

  @Test
  public void createMediaRecorder() {
    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mock(TextureRegistry.class));

    final MediaRecorderProxy mediaRecorderProxy = libraryImplementations.getHandlerMediaRecorder().$$create(mockTypeChannelMessenger);

    assertNotNull(mediaRecorderProxy);
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
  public void setOutputFilePath() {
    testMediaRecorderProxy.setOutputFilePath("apple");
    verify(mockMediaRecorder).setOutputFile("apple");
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

  @Test
  public void pause() throws Exception {
    setFinalStatic(Build.VERSION.class.getField("SDK_INT"), Build.VERSION_CODES.N);

    testMediaRecorderProxy.pause();
    verify(mockMediaRecorder).pause();
  }

  @Test
  public void resume() throws Exception {
    setFinalStatic(Build.VERSION.class.getField("SDK_INT"), Build.VERSION_CODES.N);

    testMediaRecorderProxy.resume();
    verify(mockMediaRecorder).resume();
  }
}
