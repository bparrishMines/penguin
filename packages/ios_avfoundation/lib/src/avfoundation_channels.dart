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

class LibraryImplementations extends $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);

  @override
  CaptureDeviceHandler get captureDeviceHandler => CaptureDeviceHandler();

  @override
  CapturePhotoHandler get capturePhotoHandler => CapturePhotoHandler();
}

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

class CapturePhotoHandler extends $CapturePhotoHandler {
  @override
  $CapturePhoto onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoCreationArgs args,
  ) {
    return CapturePhoto(args.fileDataRepresentation);
  }
}
