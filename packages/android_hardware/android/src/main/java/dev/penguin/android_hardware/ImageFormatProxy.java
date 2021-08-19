package dev.penguin.android_hardware;

import android.graphics.ImageFormat;

public class ImageFormatProxy {
  public static Integer getBitsPerPixel(CameraChannelLibrary.$LibraryImplementations implementations, Integer format) {
    return ImageFormat.getBitsPerPixel(format);
  }
}
