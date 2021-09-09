package dev.penguin.android_hardware;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import android.hardware.Camera;

public class PictureCallbackTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();
  @Mock TypeChannelMessenger mockTypeChannelMessenger;
  @Mock TextureRegistry mockTextureRegistry;
  LibraryImplementations testImplementations;
  @Mock
  CameraChannelLibrary.$PictureCallbackChannel mockPictureCallbackChannel;

  @Before
  public void setUp() {
    testImplementations = new LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    testImplementations.channelPictureCallback = mockPictureCallbackChannel;
  }

  @Test
  public void createPictureCallback() {
    final Camera.PictureCallback pictureCallback = testImplementations.handlerPictureCallback.createInstance(null, null);
    assertNotNull(pictureCallback);
  }

  @Test
  public void invoke() {
    final Camera.PictureCallback pictureCallback = testImplementations.handlerPictureCallback.createInstance(null, null);

    final byte[] data = new byte[0];
    final Camera mockCamera = mock(Camera.class);
    pictureCallback.onPictureTaken(data, mockCamera);
    verify(mockPictureCallbackChannel).$invoke(pictureCallback, data);
  }
}
