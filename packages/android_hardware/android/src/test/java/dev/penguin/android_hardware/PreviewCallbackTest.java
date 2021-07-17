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

public class PreviewCallbackTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Test
  public void createPictureCallback() {
    final ChannelRegistrar.LibraryImplementations implementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mock(TextureRegistry.class));

    final CameraChannelLibrary.$DataCallback mockDataCallback = mock(CameraChannelLibrary.$DataCallback.class);

    final PreviewCallbackProxy previewCallbackProxy = implementations
        .getHandlerPreviewCallback()
        .$create$(mockTypeChannelMessenger, mockDataCallback);

    assertNotNull(previewCallbackProxy);
  }
}
