package dev.penguin.android_hardware;

import android.graphics.ImageFormat;

public class ImageFormatHandler extends CameraChannelLibrary.$ImageFormatHandler {
  public ImageFormatHandler(LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public Integer $getBitsPerPixel(Integer format) {
    return ImageFormat.getBitsPerPixel(format);
  }
}
