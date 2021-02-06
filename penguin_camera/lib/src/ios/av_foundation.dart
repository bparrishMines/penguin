import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:penguin_camera/src/ios/av_foundation.g.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

void initializeChannels() {
  CaptureDeviceInput._channel; // ignore: unnecessary_statements
  CaptureSession._channel; // ignore: unnecessary_statements
  CaptureDevice._channel; // ignore: unnecessary_statements
  PreviewController._channel; // ignore: unnecessary_statements
}

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
class CaptureDeviceInput
    with $CaptureDeviceInput, ReferenceType<$CaptureDeviceInput> {
  const CaptureDeviceInput(this.device);

  static final $CaptureDeviceInputChannel _channel =
      $CaptureDeviceInputChannel(MethodChannelMessenger.instance)
        ..setHandler($CaptureDeviceInputHandler());

  final CaptureDevice device;

  @override
  TypeChannel<$CaptureDeviceInput> get typeChannel => _channel;
}


@Reference('captureSession')
class CaptureSession with $CaptureSession, ReferenceType<$CaptureSession> {
  CaptureSession(this.inputs);

  static final $CaptureSessionChannel _channel =
      $CaptureSessionChannel(MethodChannelMessenger.instance)
        ..setHandler(
          $CaptureSessionHandler(
            onAdded: (manager, instance) {
              final CaptureSession session = instance as CaptureSession;
              for (CaptureDeviceInput input in session.inputs) {
                input.typeChannel.createNewInstancePair(input);
              }
            },
            onRemoved: (manager, instance) {
              final CaptureSession session = instance as CaptureSession;
              for (CaptureDeviceInput input in session.inputs) {
                input.typeChannel.disposeInstancePair(input);
              }
            },
          ),
        );

  @override
  final List<CaptureDeviceInput> inputs;

  // TODO: Pattern of returning CaptureSessionController here and preview controller pass function to return controller after init
  Future<void> startRunning() async {
    _channel.createNewInstancePair(this);
    await _channel.$invokeStartRunning(this);
  }

  Future<void> stopRunning() async {
    if (!_channel.messenger.isPaired(this)) return;
    _channel.$invokeStopRunning(this);
    return _channel.disposeInstancePair(this);
  }

  @override
  TypeChannel<$CaptureSession> get typeChannel => _channel;
}

@Reference('captureDevice')
class CaptureDevice with $CaptureDevice, ReferenceType<$CaptureDevice> {
  CaptureDevice({required this.uniqueId, required this.position});

  static final $CaptureDeviceChannel _channel =
      $CaptureDeviceChannel(MethodChannelMessenger.instance)
        ..setHandler($CaptureDeviceHandler(onCreate: (_, args) {
          return CaptureDevice(
              uniqueId: args.uniqueId, position: args.position);
        }));

  final String uniqueId;
  final int position;

  static Future<List<CaptureDevice>> devicesWithMediaType(
    String mediaType,
  ) async {
    assert(mediaType == MediaType.video);
    final List<Object?> result =
        await _channel.$invokeDevicesWithMediaType(mediaType) as List<Object?>;
    return result.cast<CaptureDevice>().toList();
  }

  @override
  TypeChannel<$CaptureDevice> get typeChannel => _channel;
}

class Preview extends StatefulWidget {
  const Preview({Key? key, required this.controller}) : super(key: key);

  final PreviewController controller;

  @override
  State<StatefulWidget> createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  @override
  void initState() {
    super.initState();
    widget.controller.typeChannel.createNewInstancePair(widget.controller);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.typeChannel.disposeInstancePair(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final PairedInstance? pairedInstance = widget
        .controller.typeChannel.messenger
        .getPairedPairedInstance(widget.controller);
    if (pairedInstance == null) {
      throw StateError("PreviewController isn't paired");
    }

    return UiKitView(
      viewType: 'penguin_camera/ios/Preview',
      creationParams: pairedInstance,
      creationParamsCodec: ReferenceMessageCodec(),
    );
  }
}

@Reference('previewController')
class PreviewController
    with $PreviewController, ReferenceType<$PreviewController> {
  PreviewController(this.captureSession);

  static final $PreviewControllerChannel _channel =
      $PreviewControllerChannel(MethodChannelMessenger.instance)
        ..setHandler(
          $PreviewControllerHandler(
            onAdded: (manager, instance) {
              final CaptureSession session =
                  instance.captureSession as CaptureSession;
              session.typeChannel.createNewInstancePair(
                session,
                owner: instance,
              );
            },
            onRemoved: (manager, instance) {
              final CaptureSession session =
                  instance.captureSession as CaptureSession;
              session.typeChannel.disposeInstancePair(session, owner: instance);
            },
          ),
        );

  final CaptureSession captureSession;

  @override
  TypeChannel<$PreviewController> get typeChannel => _channel;
}
