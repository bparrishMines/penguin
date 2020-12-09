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
  int cameraId;
  int facing;
  int orientation;
}

class $CameraChannel extends ReferenceChannel<$Camera> {
  $CameraChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/android/camera/Camera');

  Future<Object> $invokeGetAllCameraInfo() {
    return invokeStaticMethod(
      'getAllCameraInfo',
      <Object>[],
    );
  }

  Future<Object> $invokeOpen(int cameraId) {
    return invokeStaticMethod(
      'open',
      <Object>[cameraId],
    );
  }

  Future<Object> $invokeRelease(
    $Camera instance,
  ) {
    final String $methodName = 'release';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeStartPreview(
    $Camera instance,
  ) {
    final String $methodName = 'startPreview';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeStopPreview(
    $Camera instance,
  ) {
    final String $methodName = 'stopPreview';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeAttachPreviewToTexture(
    $Camera instance,
  ) {
    final String $methodName = 'attachPreviewToTexture';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeReleaseTexture(
    $Camera instance,
  ) {
    final String $methodName = 'releaseTexture';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $CameraInfoChannel extends ReferenceChannel<$CameraInfo> {
  $CameraInfoChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/android/camera/CameraInfo');
}

class $CameraHandler implements ReferenceChannelHandler<$Camera> {
  $CameraHandler(
      {this.onCreate, this.onDispose, this.$onGetAllCameraInfo, this.$onOpen});

  final $Camera Function(
      ReferenceChannelManager manager, $CameraCreationArgs args) onCreate;

  final void Function(ReferenceChannelManager manager, $Camera instance)
      onDispose;

  final Future<List<$CameraInfo>> Function(
    ReferenceChannelManager manager,
  ) $onGetAllCameraInfo;
  final Future<$Camera> Function(ReferenceChannelManager manager, int cameraId)
      $onOpen;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'getAllCameraInfo':
        method = () => $onGetAllCameraInfo(
              manager,
            );
        break;
      case 'open':
        method = () => $onOpen(manager, arguments[0]);
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $Camera instance,
  ) {
    return <Object>[];
  }

  @override
  $Camera createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $CameraCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $Camera instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
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
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $Camera instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $CameraInfoHandler implements ReferenceChannelHandler<$CameraInfo> {
  $CameraInfoHandler({
    this.onCreate,
    this.onDispose,
  });

  final $CameraInfo Function(
      ReferenceChannelManager manager, $CameraInfoCreationArgs args) onCreate;

  final void Function(ReferenceChannelManager manager, $CameraInfo instance)
      onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $CameraInfo instance,
  ) {
    return <Object>[instance.cameraId, instance.facing, instance.orientation];
  }

  @override
  $CameraInfo createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $CameraInfoCreationArgs()
        ..cameraId = arguments[0]
        ..facing = arguments[1]
        ..orientation = arguments[2],
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $CameraInfo instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $CameraInfo instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}
