import 'dart:typed_data';

import 'package:reference/reference.dart';

import 'av_foundation.dart';
import 'av_foundation.g.dart';

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

  @override
  CaptureInputPortHandler get handlerCaptureInputPort =>
      CaptureInputPortHandler();

  @override
  CaptureConnectionHandler get handlerCaptureConnection =>
      CaptureConnectionHandler();

  @override
  CaptureOutputHandler get handlerCaptureOutput => CaptureOutputHandler();
}

/// [TypeChannelHandler] implementation for [CaptureDevice].
class CaptureDeviceHandler extends $CaptureDeviceHandler {
  @override
  $CaptureDevice $create$(
    TypeChannelMessenger messenger,
    String uniqueId,
    int position,
    bool isSmoothAutoFocusSupported,
    bool hasFlash,
    bool hasTorch,
    double maxAvailableTorchLevel,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureDevice(
      uniqueId: uniqueId,
      position: position,
      isSmoothAutoFocusSupported: isSmoothAutoFocusSupported,
      hasFlash: hasFlash,
      hasTorch: hasTorch,
      maxAvailableTorchLevel: maxAvailableTorchLevel,
    );
  }
}

/// [TypeChannelHandler] implementation for [CapturePhoto].
class CapturePhotoHandler extends $CapturePhotoHandler {
  @override
  CapturePhoto $create$(
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
  CaptureDeviceDiscoverySession $create$(
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

/// [TypeChannelHandler] implementation for [CaptureInputPort].
class CaptureInputPortHandler extends $CaptureInputPortHandler {
  @override
  CaptureInputPort $create$(
    TypeChannelMessenger messenger,
    String mediaType,
    String? sourceDeviceType,
    int sourceDevicePosition,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureInputPort(
      mediaType: mediaType,
      sourceDeviceType: sourceDeviceType,
      sourceDevicePosition: sourceDevicePosition,
    );
  }
}

/// [TypeChannelHandler] implementation for [CaptureConnection].
class CaptureConnectionHandler extends $CaptureConnectionHandler {
  @override
  $CaptureConnection $create$(
    TypeChannelMessenger messenger,
    List<$CaptureInputPort> inputPorts,
    covariant CaptureOutput output,
  ) {
    return CaptureConnection.withoutCreate(
      inputPorts.cast<CaptureInputPort>(),
      output,
    );
  }
}

/// [TypeChannelHandler] implementation for [CaptureOutput].
class CaptureOutputHandler extends $CaptureOutputHandler {
  @override
  CaptureOutput $create$(TypeChannelMessenger messenger) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureOutput();
  }
}
