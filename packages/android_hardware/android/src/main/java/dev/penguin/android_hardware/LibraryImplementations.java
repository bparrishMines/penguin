package dev.penguin.android_hardware;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class LibraryImplementations extends CameraChannelLibrary.$LibraryImplementations {
  public final TextureRegistry textureRegistry;

  public LibraryImplementations(TypeChannelMessenger messenger, TextureRegistry textureRegistry) {
    super(messenger);
    this.textureRegistry = textureRegistry;
  }
}
