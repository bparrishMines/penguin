import 'package:reference/reference.dart';

import 'avfoundation.dart';
import 'avfoundation.g.dart';

class ChannelRegistrar extends $ChannelRegistrar {
  ChannelRegistrar($LibraryImplementations implementations)
      : super(implementations);

  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

class LibraryImplementations with $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger)
      : captureDeviceChannel = CaptureDeviceChannel(messenger),
        captureDeviceInputChannel = CaptureDeviceInputChannel(messenger),
        captureSessionChannel = CaptureSessionChannel(messenger),
        previewControllerChannel = PreviewControllerChannel(messenger),
        captureInputChannel = CaptureInputChannel(messenger);

  @override
  final CaptureDeviceChannel captureDeviceChannel;

  @override
  final CaptureDeviceHandler captureDeviceHandler = CaptureDeviceHandler();

  @override
  final CaptureDeviceInputChannel captureDeviceInputChannel;

  @override
  final CaptureDeviceInputHandler captureDeviceInputHandler =
      CaptureDeviceInputHandler();

  @override
  final CaptureSessionChannel captureSessionChannel;

  @override
  final CaptureSessionHandler captureSessionHandler = CaptureSessionHandler();

  @override
  final PreviewControllerChannel previewControllerChannel;

  @override
  final PreviewControllerHandler previewControllerHandler =
      PreviewControllerHandler();

  @override
  final CaptureInputChannel captureInputChannel;

  @override
  final CaptureInputHandler captureInputHandler = CaptureInputHandler();
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

class CaptureSessionHandler extends $CaptureSessionHandler {}

class CaptureDeviceHandler extends $CaptureDeviceHandler {
  @override
  $CaptureDevice onCreate(
    TypeChannelMessenger messenger,
    $CaptureDeviceCreationArgs args,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureDevice(uniqueId: args.uniqueId, position: args.position);
  }
}

class PreviewControllerHandler extends $PreviewControllerHandler {}

class CaptureInputChannel extends $CaptureInputChannel {
  CaptureInputChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CaptureInputHandler extends $CaptureInputHandler {}
