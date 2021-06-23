package github.bparrishMines.penguin.penguin_android_camera;

import android.graphics.ImageFormat;

public class ImageFormatProxy implements CameraChannelLibrary.$ImageFormat {
  public static Integer getBitsPerPixel(Integer format) {
    return ImageFormat.getBitsPerPixel(format);
  }
}
