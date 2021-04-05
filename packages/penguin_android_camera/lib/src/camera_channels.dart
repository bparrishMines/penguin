import 'package:penguin_android_camera/src/camera.g.dart';
import 'package:reference/reference.dart';

import 'camera.dart';

class ChannelRegistrar extends $ChannelRegistrar {
  ChannelRegistrar(LibraryImplementations implementations)
      : super(implementations);

  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

class LibraryImplementations with $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger)
      : cameraChannel = CameraChannel(messenger),
        cameraInfoChannel = CameraInfoChannel(messenger),
        mediaRecorderChannel = MediaRecorderChannel(messenger),
        pictureCallbackChannel = PictureCallbackChannel(messenger),
        shutterCallbackChannel = ShutterCallbackChannel(messenger);

  @override
  final CameraChannel cameraChannel;

  @override
  final CameraHandler cameraHandler = CameraHandler();

  @override
  final CameraInfoChannel cameraInfoChannel;

  @override
  final CameraInfoHandler cameraInfoHandler = CameraInfoHandler();

  @override
  final MediaRecorderChannel mediaRecorderChannel;

  @override
  final MediaRecorderHandler mediaRecorderHandler = MediaRecorderHandler();

  @override
  final PictureCallbackChannel pictureCallbackChannel;

  @override
  final PictureCallbackHandler pictureCallbackHandler =
      PictureCallbackHandler();

  @override
  final ShutterCallbackChannel shutterCallbackChannel;

  @override
  final ShutterCallbackHandler shutterCallbackHandler =
      ShutterCallbackHandler();
}

class CameraChannel extends $CameraChannel {
  CameraChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CameraInfoChannel extends $CameraInfoChannel {
  CameraInfoChannel(TypeChannelMessenger messenger) : super(messenger);
}

class ShutterCallbackChannel extends $ShutterCallbackChannel {
  ShutterCallbackChannel(TypeChannelMessenger messenger) : super(messenger);
}

class PictureCallbackChannel extends $PictureCallbackChannel {
  PictureCallbackChannel(TypeChannelMessenger messenger) : super(messenger);
}

class MediaRecorderChannel extends $MediaRecorderChannel {
  MediaRecorderChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CameraHandler extends $CameraHandler {
  @override
  Camera onCreate(TypeChannelMessenger messenger, $CameraCreationArgs args) {
    // ignore: invalid_use_of_visible_for_testing_member
    return Camera();
  }
}

class CameraInfoHandler extends $CameraInfoHandler {
  @override
  CameraInfo onCreate(
    TypeChannelMessenger messenger,
    $CameraInfoCreationArgs args,
  ) {
    return CameraInfo(
      cameraId: args.cameraId,
      facing: args.facing,
      orientation: args.orientation,
    );
  }
}

class ShutterCallbackHandler extends $ShutterCallbackHandler {}

class PictureCallbackHandler extends $PictureCallbackHandler {}

class MediaRecorderHandler extends $MediaRecorderHandler {}
