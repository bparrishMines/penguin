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
  $CameraChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camera/Camera');

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
  $CameraInfoChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camera/CameraInfo');
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $CameraHandler(
      {this.onCreate, this.onDispose, this.$onGetAllCameraInfo, this.$onOpen});

  final $Camera Function(TypeChannelManager manager, $CameraCreationArgs args)?
      onCreate;

  final void Function(TypeChannelManager manager, $Camera instance)? onDispose;

  final Future<List<$CameraInfo>> Function(
    TypeChannelManager manager,
  )? $onGetAllCameraInfo;
  final Future<$Camera> Function(TypeChannelManager manager, int cameraId)?
      $onOpen;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'getAllCameraInfo':
        method = () => $onGetAllCameraInfo!(
              manager,
            );
        break;
      case 'open':
        method = () => $onOpen!(manager, arguments[0] as int);
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
    TypeChannelManager manager,
    $Camera instance,
  ) {
    return <Object?>[];
  }

  @override
  $Camera createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $CameraCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
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
  void onInstanceDisposed(TypeChannelManager manager, $Camera instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
  $CameraInfoHandler({
    this.onCreate,
    this.onDispose,
  });

  final $CameraInfo Function(
      TypeChannelManager manager, $CameraInfoCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $CameraInfo instance)?
      onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
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
    TypeChannelManager manager,
    $CameraInfo instance,
  ) {
    return <Object?>[instance.cameraId, instance.facing, instance.orientation];
  }

  @override
  $CameraInfo createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $CameraInfoCreationArgs()
        ..cameraId = arguments[0] as int
        ..facing = arguments[1] as int
        ..orientation = arguments[2] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
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
  void onInstanceDisposed(TypeChannelManager manager, $CameraInfo instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}
