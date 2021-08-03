import 'package:reference/reference.dart';

import 'camera.dart';
import 'camera.g.dart';

/// Register channels for camera classes.
class ChannelRegistrar extends $ChannelRegistrar {
  /// Default constructor for [ChannelRegistrar].
  ChannelRegistrar(LibraryImplementations implementations)
      : super(implementations);

  /// Default [ChannelRegistrar] instance.
  ///
  /// Replace this for custom usability.
  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

/// Type channel implementation for camera classes.
///
/// Most implementations are generated.
class LibraryImplementations extends $LibraryImplementations {
  /// Default constructor for [LibraryImplementations].
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

/// [TypeChannelHandler] implementation for [Camera].
class CameraHandler extends $CameraHandler {
  @override
  Camera $create$(TypeChannelMessenger messenger) {
    return Camera();
  }
}

/// [TypeChannelHandler] implementation for [CameraInfo].
class CameraInfoHandler extends $CameraInfoHandler {
  @override
  CameraInfo $create$(
    TypeChannelMessenger messenger,
    int cameraId,
    int facing,
    int orientation,
    bool? canDisableShutterSound,
  ) {
    return CameraInfo(
      cameraId: cameraId,
      facing: facing,
      orientation: orientation,
      canDisableShutterSound: canDisableShutterSound,
    );
  }
}

/// [TypeChannelHandler] implementation for [CameraParametersHandler].
class CameraParametersHandler extends $CameraParametersHandler {
  @override
  CameraParameters $create$(TypeChannelMessenger messenger) {
    return CameraParameters();
  }
}

/// [TypeChannelHandler] implementation for [CameraSize].
class CameraSizeHandler extends $CameraSizeHandler {
  @override
  CameraSize $create$(TypeChannelMessenger messenger, int width, int height) {
    return CameraSize(width, height);
  }
}

/// [TypeChannelHandler] implementation for [CameraRect].
class CameraRectHandler extends $CameraRectHandler {
  @override
  CameraRect $create$(
    TypeChannelMessenger messenger,
    int top,
    int bottom,
    int right,
    int left,
  ) {
    return CameraRect.withoutCreate(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
    );
  }
}

/// [TypeChannelHandler] implementation for [CameraArea].
class CameraAreaHandler extends $CameraAreaHandler {
  @override
  CameraArea $create$(
    TypeChannelMessenger messenger,
    $CameraRect rect,
    int weight,
  ) {
    return CameraArea.withoutCreate(rect as CameraRect, weight);
  }
}
