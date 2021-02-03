// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $Camera {
  Future<void> release();

  Future<void> startPreview();

  Future<void> stopPreview();

  Future<int> attachPreviewToTexture();

  Future<void> releaseTexture();
}

mixin $CameraInfo {
  int get cameraId;
  int get facing;
  int get orientation;
}

class $CameraCreationArgs {}

class $CameraInfoCreationArgs {
  late int cameraId;
  late int facing;
  late int orientation;
}

class $CameraChannel extends TypeChannel<$Camera> {
  $CameraChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camera/Camera');

  Future<Object?> $invokeGetAllCameraInfo() {
    return invokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[],
    );
  }

  Future<Object?> $invokeOpen(int cameraId) {
    return invokeStaticMethod(
      'open',
      <Object?>[cameraId],
    );
  }

  Future<Object?> $invokeRelease(
    $Camera instance,
  ) {
    return invokeMethod(
      instance,
      'release',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStartPreview(
    $Camera instance,
  ) {
    return invokeMethod(
      instance,
      'startPreview',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStopPreview(
    $Camera instance,
  ) {
    return invokeMethod(
      instance,
      'stopPreview',
      <Object?>[],
    );
  }

  Future<Object?> $invokeAttachPreviewToTexture(
    $Camera instance,
  ) {
    return invokeMethod(
      instance,
      'attachPreviewToTexture',
      <Object?>[],
    );
  }

  Future<Object?> $invokeReleaseTexture(
    $Camera instance,
  ) {
    return invokeMethod(
      instance,
      'releaseTexture',
      <Object?>[],
    );
  }
}

class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
  $CameraInfoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camera/CameraInfo');
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $CameraHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
    this.$onGetAllCameraInfo,
    this.$onOpen,
  });

  final $Camera Function(
    TypeChannelMessenger messenger,
    $CameraCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $Camera instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $Camera instance)?
      onRemoved;

  final Future<List<$CameraInfo>> Function(
    TypeChannelMessenger messenger,
  )? $onGetAllCameraInfo;
  final Future<$Camera> Function(TypeChannelMessenger messenger, int cameraId)?
      $onOpen;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'getAllCameraInfo':
        method = () => $onGetAllCameraInfo!(
              messenger,
            );
        break;
      case 'open':
        method = () => $onOpen!(messenger, arguments[0] as int);
        break;
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    return <Object?>[];
  }

  @override
  $Camera createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CameraCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $Camera instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'release':
        method = () => instance.release();
        break;
      case 'startPreview':
        method = () => instance.startPreview();
        break;
      case 'stopPreview':
        method = () => instance.stopPreview();
        break;
      case 'attachPreviewToTexture':
        method = () => instance.attachPreviewToTexture();
        break;
      case 'releaseTexture':
        method = () => instance.releaseTexture();
        break;
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
  $CameraInfoHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $CameraInfo Function(
    TypeChannelMessenger messenger,
    $CameraInfoCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $CameraInfo instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $CameraInfo instance)?
      onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelMessenger messenger,
    $CameraInfo instance,
  ) {
    return <Object?>[instance.cameraId, instance.facing, instance.orientation];
  }

  @override
  $CameraInfo createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CameraInfoCreationArgs()
        ..cameraId = arguments[0] as int
        ..facing = arguments[1] as int
        ..orientation = arguments[2] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraInfo instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $CameraInfo instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $CameraInfo instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}
