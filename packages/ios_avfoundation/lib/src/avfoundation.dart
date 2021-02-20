import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'avfoundation.g.dart';

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
class CaptureDeviceInput with $CaptureDeviceInput {
  const CaptureDeviceInput(this.device);

  @override
  final CaptureDevice device;
}

@Reference('captureSession')
class CaptureSession with $CaptureSession {
  CaptureSession(this.inputs);

  @override
  final List<CaptureDeviceInput> inputs;

  @override
  Future<void> startRunning() async {
    Channels.captureSessionChannel.createNewInstancePair(this);
    await Channels.captureSessionChannel.$invokeStartRunning(this);
  }

  @override
  Future<void> stopRunning() async {
    if (!Channels.captureSessionChannel.messenger.isPaired(this)) return;
    Channels.captureSessionChannel.$invokeStopRunning(this);
    return Channels.captureSessionChannel.disposeInstancePair(this);
  }
}

@Reference('captureDevice')
class CaptureDevice with $CaptureDevice, ReferenceType {
  CaptureDevice({required this.uniqueId, required this.position});

  @override
  final String uniqueId;

  @override
  final int position;

  static Future<List<CaptureDevice>> devicesWithMediaType(
    String mediaType,
  ) async {
    assert(mediaType == MediaType.video);
    final List<Object?> result = await Channels.captureDeviceChannel
        .$invokeDevicesWithMediaType(mediaType) as List<Object?>;
    return result.cast<CaptureDevice>().toList();
  }

  @override
  TypeChannel<Object> get typeChannel => Channels.captureDeviceChannel;
}

class Preview extends StatefulWidget {
  const Preview({
    Key? key,
    required this.captureSession,
    this.onPreviewReady,
  }) : super(key: key);

  final CaptureSession captureSession;
  final void Function(PreviewController controller)? onPreviewReady;

  @override
  State<StatefulWidget> createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  late final PreviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PreviewController(widget.captureSession);
    Channels.previewControllerInputChannel.createNewInstancePair(_controller);

    final void Function(PreviewController controller)? onPreviewReady =
        widget.onPreviewReady;
    if (onPreviewReady != null) onPreviewReady(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    Channels.previewControllerInputChannel.disposeInstancePair(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final PairedInstance? pairedInstance = Channels
        .previewControllerInputChannel.messenger
        .getPairedPairedInstance(_controller);
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
  PreviewController(this.captureSession);

  @override
  final CaptureSession captureSession;
}

abstract class Channels {
  Channels._();

  static CaptureDeviceInputChannel captureDeviceInputChannel =
      CaptureDeviceInputChannel(MethodChannelMessenger.instance)
        ..setHandler(CaptureDeviceInputHandler());

  static CaptureSessionChannel captureSessionChannel =
      CaptureSessionChannel(MethodChannelMessenger.instance)
        ..setHandler(CaptureSessionHandler());

  static CaptureDeviceChannel captureDeviceChannel =
      CaptureDeviceChannel(MethodChannelMessenger.instance)
        ..setHandler(CaptureDeviceHandler());

  static PreviewControllerChannel previewControllerInputChannel =
      PreviewControllerChannel(MethodChannelMessenger.instance)
        ..setHandler(PreviewControllerHandler());
}

class CaptureDeviceInputChannel extends $CaptureDeviceInputChannel {
  CaptureDeviceInputChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CaptureSessionChannel extends $CaptureSessionChannel {
  CaptureSessionChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CaptureDeviceChannel extends $CaptureDeviceChannel {
  CaptureDeviceChannel(TypeChannelMessenger messenger) : super(messenger);
}

class PreviewControllerChannel extends $PreviewControllerChannel {
  PreviewControllerChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CaptureDeviceInputHandler extends $CaptureDeviceInputHandler {}

class CaptureSessionHandler extends $CaptureSessionHandler {
  CaptureSessionHandler()
      : super(
          onAdded: (manager, instance) {
            final CaptureSession session = instance as CaptureSession;
            for (final CaptureDeviceInput input in session.inputs) {
              Channels.captureDeviceInputChannel
                  .createNewInstancePair(input, owner: session);
            }
          },
          onRemoved: (manager, instance) {
            final CaptureSession session = instance as CaptureSession;
            for (final CaptureDeviceInput input in session.inputs) {
              Channels.captureDeviceInputChannel
                  .disposeInstancePair(input, owner: session);
            }
          },
        );
}

class CaptureDeviceHandler extends $CaptureDeviceHandler {
  CaptureDeviceHandler()
      : super(
          onCreate: (_, args) {
            return CaptureDevice(
              uniqueId: args.uniqueId,
              position: args.position,
            );
          },
        );
}

class PreviewControllerHandler extends $PreviewControllerHandler {
  PreviewControllerHandler()
      : super(
          onAdded: (manager, instance) {
            final CaptureSession session =
                instance.captureSession as CaptureSession;
            Channels.captureSessionChannel.createNewInstancePair(
              session,
              owner: instance,
            );
          },
          onRemoved: (manager, instance) {
            final CaptureSession session =
                instance.captureSession as CaptureSession;
            Channels.captureSessionChannel.disposeInstancePair(
              session,
              owner: instance,
            );
          },
        );
}
