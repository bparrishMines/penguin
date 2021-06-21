package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.ImageFormat;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ImageFormatTest {
  @Test
  public void imageFormats() {
    assertEquals(ImageFormat.DEPTH16, 0x44363159);
  }
}
