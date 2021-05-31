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
  Camera $$create(TypeChannelMessenger messenger) {
    // ignore: invalid_use_of_visible_for_testing_member
    return Camera();
  }
}

class CameraInfoHandler extends $CameraInfoHandler {
  @override
  CameraInfo $$create(
    TypeChannelMessenger messenger,
    int cameraId,
    int facing,
    int orientation,
  ) {
    return CameraInfo(
      cameraId: cameraId,
      facing: facing,
      orientation: orientation,
    );
  }
}

class CameraParametersHandler extends $CameraParametersHandler {
  @override
  CameraParameters $$create(TypeChannelMessenger messenger) {
    return CameraParameters();
  }
}

class CameraSizeHandler extends $CameraSizeHandler {
  @override
  CameraSize $$create(TypeChannelMessenger messenger, int width, int height) {
    return CameraSize(width, height);
  }
}

class CameraRectHandler extends $CameraRectHandler {
  @override
  CameraRect $$create(
    TypeChannelMessenger messenger,
    int top,
    int bottom,
    int right,
    int left,
  ) {
    return CameraRect(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      createInstancePair: false,
    );
  }
}

class CameraAreaHandler extends $CameraAreaHandler {
  @override
  CameraArea $$create(
    TypeChannelMessenger messenger,
    $CameraRect rect,
    int weight,
  ) {
    return CameraArea(
      rect as CameraRect,
      weight,
      createInstancePair: false,
    );
  }
}
