import 'dart:typed_data';

import 'package:reference/reference.dart';

import 'avfoundation.dart';
import 'avfoundation.g.dart';

/// Registers type channels for AVFoundation classes.
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

/// Type channel implementation for AVFoundation classes.
///
/// Most implementations are generated.
class LibraryImplementations extends $LibraryImplementations {
  /// Default constructor for [LibraryImplementations].
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);

  @override
  CaptureDeviceHandler get handlerCaptureDevice => CaptureDeviceHandler();

  @override
  CapturePhotoHandler get handlerCapturePhoto => CapturePhotoHandler();

  @override
  CaptureDeviceDiscoverySessionHandler
      get handlerCaptureDeviceDiscoverySession =>
          CaptureDeviceDiscoverySessionHandler();
}

/// [TypeChannelHandler] implementation for [CaptureDevice].
class CaptureDeviceHandler extends $CaptureDeviceHandler {
  @override
  $CaptureDevice $$create(TypeChannelMessenger messenger, String uniqueId,
      int position, bool isSmoothAutoFocusSupported, bool hasFlash) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureDevice(
      uniqueId: uniqueId,
      position: position,
      isSmoothAutoFocusSupported: isSmoothAutoFocusSupported,
      hasFlash: hasFlash,
    );
  }
}

/// [TypeChannelHandler] implementation for [CapturePhoto].
class CapturePhotoHandler extends $CapturePhotoHandler {
  @override
  CapturePhoto $$create(
    TypeChannelMessenger messenger,
    Uint8List? fileDataRepresentation,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CapturePhoto(fileDataRepresentation);
  }
}

/// [TypeChannelHandler] implementation for [CaptureDeviceDiscoverySession].
class CaptureDeviceDiscoverySessionHandler
    extends $CaptureDeviceDiscoverySessionHandler {
  @override
  CaptureDeviceDiscoverySession $$create(
    TypeChannelMessenger messenger,
    List<$CaptureDevice> devices,
    List<List<$CaptureDevice>> supportedMultiCamDeviceSets,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureDeviceDiscoverySession(
      devices: devices.cast<CaptureDevice>(),
      supportedMultiCamDeviceSets: supportedMultiCamDeviceSets
          .map((_) => _.map((_) => _ as CaptureDevice).toSet())
          .toList(),
    );
  }
}
