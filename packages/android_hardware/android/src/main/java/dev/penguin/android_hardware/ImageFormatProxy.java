package dev.penguin.android_hardware;

import android.graphics.ImageFormat;

public class ImageFormatProxy implements CameraChannelLibrary.$ImageFormat {
  public static Integer getBitsPerPixel(Integer format) {
    return ImageFormat.getBitsPerPixel(format);
  }
}
