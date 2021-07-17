package dev.penguin.android_hardware;

import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;

public class PictureCallbackTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Test
  public void createPictureCallback() {
    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mock(TextureRegistry.class));

    final CameraChannelLibrary.$DataCallback mockDataCallback = mock(CameraChannelLibrary.$DataCallback.class);

    final PictureCallbackProxy pictureCallbackProxy = libraryImplementations
        .getHandlerPictureCallback()
        .$create$(mockTypeChannelMessenger, mockDataCallback);

    assertNotNull(pictureCallbackProxy);
  }
}
