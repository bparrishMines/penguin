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

class LibraryImplementations extends $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);

  @override
  final CameraHandler cameraHandler = CameraHandler();

  @override
  final CameraInfoHandler cameraInfoHandler = CameraInfoHandler();

  @override
  final CameraParametersHandler cameraParametersHandler =
      CameraParametersHandler();

  @override
  final CameraSizeHandler cameraSizeHandler = CameraSizeHandler();
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

class CameraParametersHandler extends $CameraParametersHandler {
  @override
  CameraParameters onCreate(
    TypeChannelMessenger messenger,
    $CameraParametersCreationArgs args,
  ) {
    // ignore: invalid_use_of_visible_for_testing_member
    return CameraParameters();
  }
}

class CameraSizeHandler extends $CameraSizeHandler {
  @override
  $CameraSize onCreate(
    TypeChannelMessenger messenger,
    $CameraSizeCreationArgs args,
  ) {
    return CameraSize(args.width, args.height);
  }
}

class CameraRectHandler extends $CameraRectHandler {
  @override
  CameraRect onCreate(
    TypeChannelMessenger messenger,
    $CameraRectCreationArgs args,
  ) {
    return CameraRect(
      top: args.top,
      bottom: args.bottom,
      right: args.right,
      left: args.left,
      createInstancePair: false,
    );
  }
}

class CameraAreaHandler extends $CameraAreaHandler {
  @override
  CameraArea onCreate(
      TypeChannelMessenger messenger, $CameraAreaCreationArgs args) {
    return CameraArea(
      args.rect as CameraRect,
      args.weight,
      createInstancePair: false,
    );
  }
}
