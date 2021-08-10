import 'package:reference/reference.dart';

import 'media_recorder.dart';
import 'media_recorder.g.dart';

/// Register channels for camera classes.
class ChannelRegistrar extends $ChannelRegistrar {
  /// Default constructor for [ChannelRegistrar].
  ChannelRegistrar(LibraryImplementations implementations)
      : super(implementations);

  /// Default [ChannelRegistrar] instance.
  ///
  /// Replace this for custom usability.
  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

/// Type channel implementation for camera classes.
///
/// Most implementations are generated.
class LibraryImplementations extends $LibraryImplementations {
  /// Default constructor for [LibraryImplementations].
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);
}

/// [TypeChannelHandler] implementation for [CamcorderProfile].
class CamcorderProfileHandler extends $CamcorderProfileHandler {
  @override
  CamcorderProfile $create$(
    TypeChannelMessenger messenger,
    int audioBitRate,
    int audioChannels,
    int audioCodec,
    int audioSampleRate,
    int duration,
    int fileFormat,
    int quality,
    int videoBitRate,
    int videoCodec,
    int videoFrameHeight,
    int videoFrameRate,
    int videoFrameWidth,
  ) {
    return CamcorderProfile.withoutCreate(
      audioBitRate: audioBitRate,
      audioChannels: audioChannels,
      audioCodec: audioCodec,
      audioSampleRate: audioSampleRate,
      duration: duration,
      fileFormat: fileFormat,
      quality: quality,
      videoBitRate: videoBitRate,
      videoCodec: videoCodec,
      videoFrameHeight: videoFrameHeight,
      videoFrameRate: videoFrameRate,
      videoFrameWidth: videoFrameWidth,
    );
  }
}
