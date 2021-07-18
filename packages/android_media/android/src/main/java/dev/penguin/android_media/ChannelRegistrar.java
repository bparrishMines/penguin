package dev.penguin.android_media;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends MediaRecorderChannelLibrary.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }

  public static class LibraryImplementations extends MediaRecorderChannelLibrary.$LibraryImplementations {
    public LibraryImplementations(TypeChannelMessenger messenger) {
      super(messenger);
    }

    @Override
    public MediaRecorderHandler getHandlerMediaRecorder() {
      return new MediaRecorderHandler();
    }

    @Override
    public CamcorderProfileHandler getHandlerCamcorderProfile() {
      return new CamcorderProfileHandler(this);
    }
  }

  public static class MediaRecorderHandler extends MediaRecorderChannelLibrary.$MediaRecorderHandler {
    @Override
    public MediaRecorderProxy $create$(TypeChannelMessenger messenger) {
      return new MediaRecorderProxy();
    }
  }

  public static class CamcorderProfileHandler extends MediaRecorderChannelLibrary.$CamcorderProfileHandler {
    public final LibraryImplementations implementations;

    public CamcorderProfileHandler(LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public CamcorderProfileProxy $get(TypeChannelMessenger messenger, Integer cameraId, Integer quality) {
      return CamcorderProfileProxy.get(cameraId, quality, implementations);
    }

    @Override
    public Boolean $hasProfile(TypeChannelMessenger messenger, Integer cameraId, Integer quality){
      return CamcorderProfileProxy.hasProfile(cameraId, quality);
    }
  }
}
