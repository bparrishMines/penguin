import 'dart:async';

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
