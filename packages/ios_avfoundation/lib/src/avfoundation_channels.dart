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
        captureInputChannel = CaptureInputChannel(messenger),
        captureOutputChannel = CaptureOutputChannel(messenger),
        capturePhotoCaptureDelegateChannel =
            CapturePhotoCaptureDelegateChannel(messenger),
        capturePhotoOutputChannel = CapturePhotoOutputChannel(messenger),
        capturePhotoChannel = CapturePhotoChannel(messenger),
        capturePhotoSettingsChannel = CapturePhotoSettingsChannel(messenger);

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

  @override
  final CaptureOutputChannel captureOutputChannel;

  @override
  final CaptureOutputHandler captureOutputHandler = CaptureOutputHandler();

  @override
  final CapturePhotoCaptureDelegateChannel capturePhotoCaptureDelegateChannel;

  @override
  final CapturePhotoCaptureDelegateHandler capturePhotoCaptureDelegateHandler =
      CapturePhotoCaptureDelegateHandler();

  @override
  final CapturePhotoChannel capturePhotoChannel;

  @override
  final CapturePhotoHandler capturePhotoHandler = CapturePhotoHandler();

  @override
  final CapturePhotoOutputChannel capturePhotoOutputChannel;

  @override
  final CapturePhotoOutputHandler capturePhotoOutputHandler =
      CapturePhotoOutputHandler();

  @override
  final CapturePhotoSettingsChannel capturePhotoSettingsChannel;

  @override
  final CapturePhotoSettingsHandler capturePhotoSettingsHandler =
      CapturePhotoSettingsHandler();
}

class CaptureOutputChannel extends $CaptureOutputChannel {
  CaptureOutputChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CapturePhotoOutputChannel extends $CapturePhotoOutputChannel {
  CapturePhotoOutputChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CapturePhotoSettingsChannel extends $CapturePhotoSettingsChannel {
  CapturePhotoSettingsChannel(TypeChannelMessenger messenger)
      : super(messenger);
}

class CapturePhotoCaptureDelegateChannel
    extends $CapturePhotoCaptureDelegateChannel {
  CapturePhotoCaptureDelegateChannel(TypeChannelMessenger messenger)
      : super(messenger);
}

class CapturePhotoChannel extends $CapturePhotoChannel {
  CapturePhotoChannel(TypeChannelMessenger messenger) : super(messenger);
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

class CaptureInputChannel extends $CaptureInputChannel {
  CaptureInputChannel(TypeChannelMessenger messenger) : super(messenger);
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

class CaptureInputHandler extends $CaptureInputHandler {}

class CaptureOutputHandler extends $CaptureOutputHandler {}

class CapturePhotoOutputHandler extends $CapturePhotoOutputHandler {}

class CapturePhotoSettingsHandler extends $CapturePhotoSettingsHandler {}

class CapturePhotoCaptureDelegateHandler
    extends $CapturePhotoCaptureDelegateHandler {}

class CapturePhotoHandler extends $CapturePhotoHandler {
  @override
  $CapturePhoto onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoCreationArgs args,
  ) {
    return CapturePhoto(args.fileDataRepresentation);
  }
}
