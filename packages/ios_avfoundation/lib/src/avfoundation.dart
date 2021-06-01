import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'avfoundation.g.dart';
import 'avfoundation_channels.dart';

abstract class MediaType {
  const MediaType._();

  static const String video = 'vide';
}

abstract class CaptureDevicePosition {
  const CaptureDevicePosition._();

  static const int unspecified = 0;

  static const int back = 1;

  static const int front = 2;
}

@Reference('ios_avfoundatoin/avfoundation/CapturePhotoOutput')
class CapturePhotoOutput extends CaptureOutput with $CapturePhotoOutput {
  CapturePhotoOutput() {
    _channel.$$create(this, $owner: true);
  }

  static $CapturePhotoOutputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCapturePhotoOutput;

  Future<void> capturePhoto(
    covariant CapturePhotoSettings settings,
    covariant CapturePhotoCaptureDelegate delegate,
  ) {
    return _channel.$capturePhoto(this, settings, delegate);
  }
}

@Reference('ios_avfoundatoin/avfoundation/CapturePhotoSettings')
class CapturePhotoSettings with $CapturePhotoSettings {
  CapturePhotoSettings(this.processedFormat) {
    _channel.$$create(this, $owner: true, processedFormat: processedFormat);
  }

  static $CapturePhotoSettingsChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCapturePhotoSettings;

  final Map<String, Object> processedFormat;
}

@Reference('ios_avfoundatoin/avfoundation/CapturePhotoCaptureDelegate')
abstract class CapturePhotoCaptureDelegate with $CapturePhotoCaptureDelegate {
  // TODO: Mention this needs to be kept in memory on this side. Maybe didFinishProcessingPhoto can release pair.
  CapturePhotoCaptureDelegate() {
    _channel.$$create(this, $owner: true);
  }

  static $CapturePhotoCaptureDelegateChannel get _channel => ChannelRegistrar
      .instance.implementations.channelCapturePhotoCaptureDelegate;

  // TODO: Create AvFoundationError?
  @override
  void didFinishProcessingPhoto(covariant CapturePhoto photo);
}

@Reference('ios_avfoundatoin/avfoundation/CaptureOutput')
abstract class CaptureOutput with $CaptureOutput {}

@Reference('ios_avfoundatoin/avfoundation/CapturePhoto')
class CapturePhoto with $CapturePhoto {
  CapturePhoto(this.fileDataRepresentation);

  final Uint8List? fileDataRepresentation;
}

@Reference('ios_avfoundatoin/avfoundation/CaptureDeviceInput')
class CaptureDeviceInput extends CaptureInput with $CaptureDeviceInput {
  CaptureDeviceInput(this.device) {
    _channel.$$create(this, $owner: true, device: device);
  }

  static $CaptureDeviceInputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureDeviceInput;

  final CaptureDevice device;
}

@Reference('ios_avfoundatoin/avfoundation/CaptureInput')
abstract class CaptureInput with $CaptureInput {}

@Reference('ios_avfoundatoin/avfoundation/CaptureSession')
class CaptureSession with $CaptureSession {
  CaptureSession() {
    _channel.$$create(this, $owner: true);
  }

  static $CaptureSessionChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureSession;

  Future<void> addInput(covariant CaptureInput input) {
    return _channel.$addInput(this, input);
  }

  Future<void> addOutput(covariant CaptureOutput output) {
    return _channel.$addOutput(this, output);
  }

  Future<void> startRunning() => _channel.$startRunning(this);

  Future<void> stopRunning() => _channel.$stopRunning(this);
}

@Reference('ios_avfoundatoin/avfoundation/CaptureDevice')
class CaptureDevice with $CaptureDevice {
  @visibleForTesting
  CaptureDevice({required this.uniqueId, required this.position});

  static $CaptureDeviceChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureDevice;

  final String uniqueId;

  final int position;

  static Future<List<CaptureDevice>> devicesWithMediaType(
    String mediaType,
  ) async {
    assert(mediaType == MediaType.video);
    final List<Object?> result =
        await _channel.$devicesWithMediaType(mediaType) as List<Object?>;
    return result.cast<CaptureDevice>();
  }
}

class Preview extends StatelessWidget {
  const Preview({Key? key, required this.controller}) : super(key: key);

  final PreviewController controller;

  @override
  Widget build(BuildContext context) {
    final PairedInstance? pairedInstance = PreviewController._channel.messenger
        .getPairedPairedInstance(controller);
    if (pairedInstance == null) {
      throw StateError("PreviewController isn't paired.");
    }

    return UiKitView(
      viewType: 'ios_avfoundation/Preview',
      creationParams: pairedInstance,
      creationParamsCodec: const ReferenceMessageCodec(),
    );
  }
}

@Reference('ios_avfoundatoin/avfoundation/PreviewController')
class PreviewController with $PreviewController {
  PreviewController(this.captureSession) {
    _channel.$$create(this, $owner: true, captureSession: captureSession);
  }

  static $PreviewControllerChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelPreviewController;

  final CaptureSession captureSession;
}
