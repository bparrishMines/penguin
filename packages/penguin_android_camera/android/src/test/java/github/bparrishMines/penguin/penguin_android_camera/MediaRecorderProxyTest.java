package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;
import android.media.CamcorderProfile;
import android.media.MediaRecorder;
import android.os.Build;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
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
  CameraChannelLibrary.$CamcorderProfileChannel mockCamcorderProfileChannel;

  @Mock
  public MediaRecorder mockMediaRecorder;

  public MediaRecorderProxy testMediaRecorderProxy;

  @Before
  public void setUp() {
    when(mockImplementations.getChannelCamcorderProfile()).thenReturn(mockCamcorderProfileChannel);
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
    assertEquals(MediaRecorder.VideoEncoder.H263, 0x00000001);
    assertEquals(MediaRecorder.VideoEncoder.H264, 0x00000002);
    assertEquals(MediaRecorder.VideoEncoder.HEVC, 0x00000005);
    assertEquals(MediaRecorder.VideoEncoder.VP8, 0x00000004);
    assertEquals(MediaRecorder.VideoEncoder.DEFAULT, 0x00000000);
  }

  @Test
  public void audioSource() {
    assertEquals(MediaRecorder.AudioSource.CAMCORDER, 0x00000005);
    assertEquals(MediaRecorder.AudioSource.DEFAULT, 0x00000000);
    assertEquals(MediaRecorder.AudioSource.MIC, 0x00000001);
    assertEquals(MediaRecorder.AudioSource.REMOTE_SUBMIX, 0x00000008);
    assertEquals(MediaRecorder.AudioSource.UNPROCESSED, 0x00000009);
    assertEquals(MediaRecorder.AudioSource.VOICE_CALL, 0x00000004);
    assertEquals(MediaRecorder.AudioSource.VOICE_COMMUNICATION, 0x00000007);
    assertEquals(MediaRecorder.AudioSource.VOICE_DOWNLINK, 0x00000003);
    assertEquals(MediaRecorder.AudioSource.VOICE_PERFORMANCE, 0x0000000a);
    assertEquals(MediaRecorder.AudioSource.VOICE_RECOGNITION, 0x00000006);
    assertEquals(MediaRecorder.AudioSource.VOICE_UPLINK, 0x00000002);
  }

  @Test
  public void audioEncoder() {
    assertEquals(MediaRecorder.AudioEncoder.AAC, 0x00000003);
    assertEquals(MediaRecorder.AudioEncoder.AAC_ELD, 0x00000005);
    assertEquals(MediaRecorder.AudioEncoder.AMR_NB, 0x00000001);
    assertEquals(MediaRecorder.AudioEncoder.AMR_WB, 0x00000002);
    assertEquals(MediaRecorder.AudioEncoder.DEFAULT, 0x00000000);
    assertEquals(MediaRecorder.AudioEncoder.HE_AAC, 0x00000004);
    assertEquals(MediaRecorder.AudioEncoder.OPUS, 0x00000007);
    assertEquals(MediaRecorder.AudioEncoder.VORBIS, 0x00000006);
  }

  @Test
  public void videoSource() {
    assertEquals(MediaRecorder.VideoSource.CAMERA, 0x00000001);
    assertEquals(MediaRecorder.VideoSource.DEFAULT, 0x00000000);
  }

  @Test
  public void error() {
    assertEquals(MediaRecorder.MEDIA_ERROR_SERVER_DIED, 0x00000064);
    assertEquals(MediaRecorder.MEDIA_RECORDER_ERROR_UNKNOWN, 0x00000001);
  }

  @Test
  public void info() {
    assertEquals(MediaRecorder.MEDIA_RECORDER_INFO_MAX_DURATION_REACHED, 0x00000320);
    assertEquals(MediaRecorder.MEDIA_RECORDER_INFO_MAX_FILESIZE_REACHED, 0x00000321);
    assertEquals(MediaRecorder.MEDIA_RECORDER_INFO_UNKNOWN, 0x00000001);
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

  @Test
  public void getMaxAmplitude() {
    when(mockMediaRecorder.getMaxAmplitude()).thenReturn(12);
    assertEquals(testMediaRecorderProxy.getMaxAmplitude(), (Integer) 12);
  }

  @Test
  public void reset() {
    testMediaRecorderProxy.reset();
    verify(mockMediaRecorder).reset();
  }

  @Test
  public void setAudioChannels() {
    testMediaRecorderProxy.setAudioChannels(12);
    verify(mockMediaRecorder).setAudioChannels(12);
  }

  @Test
  public void setAudioEncodingBitRate() {
    testMediaRecorderProxy.setAudioEncodingBitRate(12);
    verify(mockMediaRecorder).setAudioEncodingBitRate(12);
  }

  @Test
  public void setAudioSamplingRate() {
    testMediaRecorderProxy.setAudioSamplingRate(12);
    verify(mockMediaRecorder).setAudioSamplingRate(12);
  }

  @Test
  public void setCaptureRate() {
    testMediaRecorderProxy.setCaptureRate(12.0);
    verify(mockMediaRecorder).setCaptureRate(12.0);
  }

  @Test
  public void setLocation() {
    testMediaRecorderProxy.setLocation(12.0, 13.0);
    verify(mockMediaRecorder).setLocation(12F, 13F);
  }

  @Test
  public void setMaxDuration() {
    testMediaRecorderProxy.setMaxDuration(12);
    verify(mockMediaRecorder).setMaxDuration(12);
  }

  @Test
  public void setMaxFileSize() {
    testMediaRecorderProxy.setMaxFileSize(12);
    verify(mockMediaRecorder).setMaxFileSize(12);
  }

  @Test
  public void setOnErrorListener() {
    final CameraChannelLibrary.$OnErrorListener mockListener = mock(CameraChannelLibrary.$OnErrorListener.class);

    testMediaRecorderProxy.setOnErrorListener(mockListener);

    final ArgumentCaptor<MediaRecorder.OnErrorListener> callbackCaptor = ArgumentCaptor.forClass(MediaRecorder.OnErrorListener.class);
    verify(mockMediaRecorder).setOnErrorListener(callbackCaptor.capture());
    callbackCaptor.getValue().onError(mockMediaRecorder, 2, 3);
    verify(mockListener).invoke(2, 3);
  }

  @Test
  public void setOnInfoListener() {
    final CameraChannelLibrary.$OnInfoListener mockListener = mock(CameraChannelLibrary.$OnInfoListener.class);

    testMediaRecorderProxy.setOnInfoListener(mockListener);

    final ArgumentCaptor<MediaRecorder.OnInfoListener> callbackCaptor = ArgumentCaptor.forClass(MediaRecorder.OnInfoListener.class);
    verify(mockMediaRecorder).setOnInfoListener(callbackCaptor.capture());
    callbackCaptor.getValue().onInfo(mockMediaRecorder, 2, 3);
    verify(mockListener).invoke(2, 3);
  }

  @Test
  public void setOrientationHint() {
    testMediaRecorderProxy.setOrientationHint(12);
    verify(mockMediaRecorder).setOrientationHint(12);
  }

  @Test
  public void setVideoEncodingBitRate() {
    testMediaRecorderProxy.setVideoEncodingBitRate(12);
    verify(mockMediaRecorder).setVideoEncodingBitRate(12);
  }

  @Test
  public void setVideoFrameRate() {
    testMediaRecorderProxy.setVideoFrameRate(12);
    verify(mockMediaRecorder).setVideoFrameRate(12);
  }

  @Test
  public void setVideoSize() {
    testMediaRecorderProxy.setVideoSize(12, 15);
    verify(mockMediaRecorder).setVideoSize(12, 15);
  }

  @Test
  public void setProfile() {
    final CamcorderProfileProxy camcorderProfileProxy = new CamcorderProfileProxy(
        mock(CamcorderProfile.class),
        mockImplementations);

    testMediaRecorderProxy.setProfile(camcorderProfileProxy);
    verify(mockMediaRecorder).setProfile(camcorderProfileProxy.camcorderProfile);
  }
}
