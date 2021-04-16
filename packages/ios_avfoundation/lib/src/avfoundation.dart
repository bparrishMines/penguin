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

@Reference('capturePhotoOutput')
class CapturePhotoOutput extends CaptureOutput with $CapturePhotoOutput {
  CapturePhotoOutput() {
    _channel.createNewInstancePair(this, owner: true);
  }

  static CapturePhotoOutputChannel get _channel =>
      ChannelRegistrar.instance.implementations.capturePhotoOutputChannel
          as CapturePhotoOutputChannel;

  @override
  Future<void> capturePhoto(
    covariant CapturePhotoSettings settings,
    covariant CapturePhotoCaptureDelegate delegate,
  ) {
    return _channel.$invokeCapturePhoto(this, settings, delegate);
  }
}

@Reference('CapturePhotoSettings')
class CapturePhotoSettings with $CapturePhotoSettings {
  CapturePhotoSettings(this.processedFormat) {
    _channel.createNewInstancePair(this, owner: true);
  }

  static CapturePhotoSettingsChannel get _channel =>
      ChannelRegistrar.instance.implementations.capturePhotoSettingsChannel
          as CapturePhotoSettingsChannel;

  @override
  final Map<String, Object> processedFormat;
}

@Reference('CapturePhotoCaptureDelegate')
abstract class CapturePhotoCaptureDelegate with $CapturePhotoCaptureDelegate {
  // TODO: Create AvFoundationError
  @override
  void didFinishProcessingPhoto(covariant CapturePhoto photo);
}

@Reference('CaptureOutput')
abstract class CaptureOutput with $CaptureOutput {}

@Reference('CapturePhoto')
class CapturePhoto with $CapturePhoto {
  @visibleForTesting
  CapturePhoto(this.fileDataRepresentation);

  @override
  final Uint8List? fileDataRepresentation;
}

@Reference('captureDeviceInput')
class CaptureDeviceInput extends CaptureInput with $CaptureDeviceInput {
  CaptureDeviceInput(this.device) {
    _channel.createNewInstancePair(this, owner: true);
  }

  static CaptureDeviceInputChannel get _channel =>
      ChannelRegistrar.instance.implementations.captureDeviceInputChannel
          as CaptureDeviceInputChannel;

  @override
  final CaptureDevice device;
}

@Reference('captureInput')
abstract class CaptureInput with $CaptureInput {}

@Reference('captureSession')
class CaptureSession with $CaptureSession {
  CaptureSession() {
    _channel.createNewInstancePair(this, owner: true);
  }

  static CaptureSessionChannel get _channel =>
      ChannelRegistrar.instance.implementations.captureSessionChannel
          as CaptureSessionChannel;

  @override
  Future<void> addInput(covariant CaptureInput input) {
    return _channel.$invokeAddInput(this, input);
  }

  @override
  Future<void> addOutput(covariant CaptureOutput output) {
    return _channel.$invokeAddOutput(this, output);
  }

  @override
  Future<void> startRunning() => _channel.$invokeStartRunning(this);

  @override
  Future<void> stopRunning() => _channel.$invokeStopRunning(this);
}

@Reference('captureDevice')
class CaptureDevice with $CaptureDevice {
  @visibleForTesting
  CaptureDevice({required this.uniqueId, required this.position});

  static CaptureDeviceChannel get _channel =>
      ChannelRegistrar.instance.implementations.captureDeviceChannel
          as CaptureDeviceChannel;

  @override
  final String uniqueId;

  @override
  final int position;

  static Future<List<CaptureDevice>> devicesWithMediaType(
    String mediaType,
  ) async {
    assert(mediaType == MediaType.video);
    final List<Object?> result =
        await _channel.$invokeDevicesWithMediaType(mediaType) as List<Object?>;
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

@Reference('previewController')
class PreviewController with $PreviewController {
  PreviewController(this.captureSession) {
    _channel.createNewInstancePair(this, owner: true);
  }

  static PreviewControllerChannel get _channel =>
      ChannelRegistrar.instance.implementations.previewControllerChannel
          as PreviewControllerChannel;

  @override
  final CaptureSession captureSession;
}
