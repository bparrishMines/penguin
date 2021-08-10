package dev.penguin.android_media;

import android.media.CamcorderProfile;

public class CamcorderProfileProxy implements MediaRecorderChannelLibrary.$CamcorderProfile {
  public final CamcorderProfile camcorderProfile;

  public static CamcorderProfileProxy get(Integer cameraId, Integer quality, ChannelRegistrar.LibraryImplementations implementations) {
    return new CamcorderProfileProxy(CamcorderProfile.get(cameraId, quality), implementations, false);
  }

  public static Boolean hasProfile(Integer cameraId, Integer quality) {
    return CamcorderProfile.hasProfile(cameraId, quality);
  }

  public CamcorderProfileProxy(CamcorderProfile camcorderProfile, ChannelRegistrar.LibraryImplementations implementations, boolean create) {
    this.camcorderProfile = camcorderProfile;
    if (create) {
      implementations
          .getChannelCamcorderProfile()
          .$create$(
              this,
              false,
              camcorderProfile.audioBitRate,
              camcorderProfile.audioChannels,
              camcorderProfile.audioCodec,
              camcorderProfile.audioSampleRate,
              camcorderProfile.duration,
              camcorderProfile.fileFormat,
              camcorderProfile.quality,
              camcorderProfile.videoBitRate,
              camcorderProfile.videoCodec,
              camcorderProfile.videoFrameHeight,
              camcorderProfile.videoFrameRate,
              camcorderProfile.videoFrameWidth);
    }
  }
}
