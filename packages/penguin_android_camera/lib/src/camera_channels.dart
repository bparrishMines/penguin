import 'dart:typed_data';

import 'package:reference/reference.dart';

import 'camera.dart';
import 'camera.g.dart';

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
  final CameraHandler handlerCamera = CameraHandler();

  @override
  final CameraInfoHandler handlerCameraInfo = CameraInfoHandler();

  @override
  final CameraParametersHandler handlerCameraParameters =
      CameraParametersHandler();

  @override
  final CameraSizeHandler handlerCameraSize = CameraSizeHandler();

  @override
  final CameraAreaHandler handlerCameraArea = CameraAreaHandler();

  @override
  final CameraRectHandler handlerCameraRect = CameraRectHandler();
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
    // ignore: invalid_use_of_visible_for_testing_member
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
