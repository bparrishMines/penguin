package dev.penguin.android_hardware;

import static org.junit.Assert.assertNotNull;

import android.graphics.Rect;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class RectTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();
  @Mock TypeChannelMessenger mockTypeChannelMessenger;
  @Mock TextureRegistry mockTextureRegistry;
  LibraryImplementations testImplementations;

  @Before
  public void setUp() {
    testImplementations = new LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
  }

  @Test
  public void createCameraRect() throws Exception {
    final Rect rect = testImplementations.handlerRect.$create$(12, 13, 15, 23);
    assertNotNull(rect);
  }
}
