import 'dart:typed_data';

import 'package:reference/reference.dart';

import 'avfoundation.dart';
import 'avfoundation.g.dart';

class ChannelRegistrar extends $ChannelRegistrar {
  ChannelRegistrar(this.implementations) : super(implementations);

  @override
  final LibraryImplementations implementations;

  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

class LibraryImplementations extends $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);

  @override
  CaptureDeviceHandler get handlerCaptureDevice => CaptureDeviceHandler();

  @override
  CapturePhotoHandler get handlerCapturePhoto => CapturePhotoHandler();
}

class CaptureDeviceHandler extends $CaptureDeviceHandler {
  @override
  CaptureDevice $$create(
      TypeChannelMessenger messenger, String uniqueId, int position) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CaptureDevice(uniqueId: uniqueId, position: position);
  }
}

class CapturePhotoHandler extends $CapturePhotoHandler {
  @override
  CapturePhoto $$create(
    TypeChannelMessenger messenger,
    Uint8List? fileDataRepresentation,
  ) {
    return CapturePhoto(fileDataRepresentation);
  }
}
