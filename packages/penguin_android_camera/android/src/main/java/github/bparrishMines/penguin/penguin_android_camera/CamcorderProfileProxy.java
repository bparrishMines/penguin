package github.bparrishMines.penguin.penguin_android_camera;

import android.media.CamcorderProfile;

public class CamcorderProfileProxy implements CameraChannelLibrary.$CamcorderProfile {
  public final CamcorderProfile camcorderProfile;

  public static CamcorderProfileProxy get(Integer cameraId, Integer quality, ChannelRegistrar.LibraryImplementations implementations) {
    return new CamcorderProfileProxy(CamcorderProfile.get(cameraId, quality), implementations);
  }

  public static Boolean hasProfile(Integer cameraId, Integer quality) {
    return CamcorderProfile.hasProfile(cameraId, quality);
  }

  public CamcorderProfileProxy(CamcorderProfile camcorderProfile, ChannelRegistrar.LibraryImplementations implementations) {
    this.camcorderProfile = camcorderProfile;
    implementations.getChannelCamcorderProfile().$$create(
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
