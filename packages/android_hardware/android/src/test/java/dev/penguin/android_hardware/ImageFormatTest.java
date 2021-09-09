package dev.penguin.android_hardware;

import android.graphics.ImageFormat;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

import static org.junit.Assert.assertEquals;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PowerMockIgnore("jdk.internal.reflect.*")
@PrepareForTest({ImageFormat.class})
public class ImageFormatTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();
  @Mock TypeChannelMessenger mockTypeChannelMessenger;
  @Mock TextureRegistry mockTextureRegistry;
  LibraryImplementations testImplementations;

  @Before
  public void setUp() {
    testImplementations = new LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
  }

  @Test
  public void imageFormats() {
    assertEquals(ImageFormat.DEPTH16, 0x44363159);
    assertEquals(ImageFormat.DEPTH_JPEG, 0x69656963);
    assertEquals(ImageFormat.HEIC, 0x48454946);
    assertEquals(ImageFormat.JPEG, 0x00000100);
    assertEquals(ImageFormat.NV16, 0x00000010);
    assertEquals(ImageFormat.NV21, 0x00000011);
    assertEquals(ImageFormat.RAW_PRIVATE, 0x00000024);
    assertEquals(ImageFormat.RGB_565, 0x00000004);
    assertEquals(ImageFormat.UNKNOWN, 0x00000000);
    assertEquals(ImageFormat.YUY2, 0x00000014);
    assertEquals(ImageFormat.YV12, 0x32315659);
  }

  @Test
  public void getBitsPerPixel() throws Exception {
    PowerMockito.mockStatic(ImageFormat.class);

    when(ImageFormat.getBitsPerPixel(23)).thenReturn(13);
    final int bits = testImplementations.handlerImageFormat.$getBitsPerPixel(23);
    assertEquals(bits, 13);

    verifyStatic();
    ImageFormat.getBitsPerPixel(23);
  }
}
