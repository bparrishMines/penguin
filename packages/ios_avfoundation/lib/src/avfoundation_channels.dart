import 'package:reference/reference.dart';

import 'avfoundation.dart';
import 'avfoundation.g.dart';

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
