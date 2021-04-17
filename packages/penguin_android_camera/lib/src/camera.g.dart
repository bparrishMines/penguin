// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:typed_data';

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $Camera {
  Future<void> release();

  Future<void> startPreview();

  Future<void> stopPreview();

  Future<int> attachPreviewTexture();

  Future<void> releasePreviewTexture();

  Future<void> unlock();

  Future<void> takePicture($ShutterCallback? shutter, $PictureCallback? raw,
      $PictureCallback? postView, $PictureCallback? jpeg);
}

mixin $ShutterCallback {
  void onShutter();
}

mixin $PictureCallback {
  void onPictureTaken(Uint8List data);
}

mixin $CameraInfo {
  int get cameraId;
  int get facing;
  int get orientation;
}

mixin $MediaRecorder {
  Future<void> setCamera($Camera camera);

  Future<void> setVideoSource(int source);

  Future<void> setOutputFilePath(String path);

  Future<void> setOutputFormat(int format);

  Future<void> setVideoEncoder(int encoder);

  Future<void> setAudioSource(int source);

  Future<void> setAudioEncoder(int encoder);

  Future<void> prepare();

  Future<void> start();

  Future<void> stop();

  Future<void> release();
}

class $CameraCreationArgs {}

class $ShutterCallbackCreationArgs {}

class $PictureCallbackCreationArgs {}

class $CameraInfoCreationArgs {
  late int cameraId;
  late int facing;
  late int orientation;
}

class $MediaRecorderCreationArgs {}

class $CameraChannel extends TypeChannel<$Camera> {
  $CameraChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/Camera');

  Future<Object?> $invokeGetAllCameraInfo() {
    return sendInvokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[],
    );
  }

  Future<Object?> $invokeOpen(int cameraId) {
    return sendInvokeStaticMethod(
      'open',
      <Object?>[cameraId],
    );
  }

  Future<Object?> $invokeRelease(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'release',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStartPreview(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'startPreview',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStopPreview(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'stopPreview',
      <Object?>[],
    );
  }

  Future<Object?> $invokeAttachPreviewTexture(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'attachPreviewTexture',
      <Object?>[],
    );
  }

  Future<Object?> $invokeReleasePreviewTexture(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'releasePreviewTexture',
      <Object?>[],
    );
  }

  Future<Object?> $invokeUnlock(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'unlock',
      <Object?>[],
    );
  }

  Future<Object?> $invokeTakePicture(
      $Camera instance,
      $ShutterCallback? shutter,
      $PictureCallback? raw,
      $PictureCallback? postView,
      $PictureCallback? jpeg) {
    return sendInvokeMethod(
      instance,
      'takePicture',
      <Object?>[shutter, raw, postView, jpeg],
    );
  }
}

class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
  $ShutterCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ShutterCallback');

  Future<Object?> $invokeOnShutter(
    $ShutterCallback instance,
  ) {
    return sendInvokeMethod(
      instance,
      'onShutter',
      <Object?>[],
    );
  }
}

class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
  $PictureCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/PictureCallback');

  Future<Object?> $invokeOnPictureTaken(
      $PictureCallback instance, Uint8List data) {
    return sendInvokeMethod(
      instance,
      'onPictureTaken',
      <Object?>[data],
    );
  }
}

class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
  $CameraInfoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraInfo');
}

class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
  $MediaRecorderChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/MediaRecorder');

  Future<Object?> $invokeSetCamera($MediaRecorder instance, $Camera camera) {
    return sendInvokeMethod(
      instance,
      'setCamera',
      <Object?>[camera],
    );
  }

  Future<Object?> $invokeSetVideoSource($MediaRecorder instance, int source) {
    return sendInvokeMethod(
      instance,
      'setVideoSource',
      <Object?>[source],
    );
  }

  Future<Object?> $invokeSetOutputFilePath(
      $MediaRecorder instance, String path) {
    return sendInvokeMethod(
      instance,
      'setOutputFilePath',
      <Object?>[path],
    );
  }

  Future<Object?> $invokeSetOutputFormat($MediaRecorder instance, int format) {
    return sendInvokeMethod(
      instance,
      'setOutputFormat',
      <Object?>[format],
    );
  }

  Future<Object?> $invokeSetVideoEncoder($MediaRecorder instance, int encoder) {
    return sendInvokeMethod(
      instance,
      'setVideoEncoder',
      <Object?>[encoder],
    );
  }

  Future<Object?> $invokeSetAudioSource($MediaRecorder instance, int source) {
    return sendInvokeMethod(
      instance,
      'setAudioSource',
      <Object?>[source],
    );
  }

  Future<Object?> $invokeSetAudioEncoder($MediaRecorder instance, int encoder) {
    return sendInvokeMethod(
      instance,
      'setAudioEncoder',
      <Object?>[encoder],
    );
  }

  Future<Object?> $invokePrepare(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'prepare',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStart(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'start',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStop(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'stop',
      <Object?>[],
    );
  }

  Future<Object?> $invokeRelease(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'release',
      <Object?>[],
    );
  }
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $Camera onCreate(
    TypeChannelMessenger messenger,
    $CameraCreationArgs args,
  ) {
    throw UnimplementedError();
  }

  double $onGetAllCameraInfo(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  double $onOpen(TypeChannelMessenger messenger, int cameraId) {
    throw UnimplementedError();
  }

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
        method = () => $onGetAllCameraInfo(
              messenger,
            );
        break;
      case 'open':
        method = () => $onOpen(messenger, arguments[0] as int);
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
    return onCreate(
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
      case 'attachPreviewTexture':
        method = () => instance.attachPreviewTexture();
        break;
      case 'releasePreviewTexture':
        method = () => instance.releasePreviewTexture();
        break;
      case 'unlock':
        method = () => instance.unlock();
        break;
      case 'takePicture':
        method = () => instance.takePicture(
            arguments[0] as $ShutterCallback?,
            arguments[1] as $PictureCallback?,
            arguments[2] as $PictureCallback?,
            arguments[3] as $PictureCallback?);
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
}

class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
  $ShutterCallback onCreate(
    TypeChannelMessenger messenger,
    $ShutterCallbackCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    $ShutterCallback instance,
  ) {
    return <Object?>[];
  }

  @override
  $ShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $ShutterCallbackCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ShutterCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'onShutter':
        method = () => instance.onShutter();
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
}

class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
  $PictureCallback onCreate(
    TypeChannelMessenger messenger,
    $PictureCallbackCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    $PictureCallback instance,
  ) {
    return <Object?>[];
  }

  @override
  $PictureCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $PictureCallbackCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $PictureCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'onPictureTaken':
        method = () => instance.onPictureTaken(arguments[0] as Uint8List);
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
}

class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
  $CameraInfo onCreate(
    TypeChannelMessenger messenger,
    $CameraInfoCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    return onCreate(
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
}

class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
  $MediaRecorder onCreate(
    TypeChannelMessenger messenger,
    $MediaRecorderCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    $MediaRecorder instance,
  ) {
    return <Object?>[];
  }

  @override
  $MediaRecorder createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $MediaRecorderCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $MediaRecorder instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'setCamera':
        method = () => instance.setCamera(arguments[0] as $Camera);
        break;
      case 'setVideoSource':
        method = () => instance.setVideoSource(arguments[0] as int);
        break;
      case 'setOutputFilePath':
        method = () => instance.setOutputFilePath(arguments[0] as String);
        break;
      case 'setOutputFormat':
        method = () => instance.setOutputFormat(arguments[0] as int);
        break;
      case 'setVideoEncoder':
        method = () => instance.setVideoEncoder(arguments[0] as int);
        break;
      case 'setAudioSource':
        method = () => instance.setAudioSource(arguments[0] as int);
        break;
      case 'setAudioEncoder':
        method = () => instance.setAudioEncoder(arguments[0] as int);
        break;
      case 'prepare':
        method = () => instance.prepare();
        break;
      case 'start':
        method = () => instance.start();
        break;
      case 'stop':
        method = () => instance.stop();
        break;
      case 'release':
        method = () => instance.release();
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
}

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  $CameraChannel get cameraChannel => $CameraChannel(messenger);
  $ShutterCallbackChannel get shutterCallbackChannel =>
      $ShutterCallbackChannel(messenger);
  $PictureCallbackChannel get pictureCallbackChannel =>
      $PictureCallbackChannel(messenger);
  $CameraInfoChannel get cameraInfoChannel => $CameraInfoChannel(messenger);
  $MediaRecorderChannel get mediaRecorderChannel =>
      $MediaRecorderChannel(messenger);
  $CameraHandler get cameraHandler => $CameraHandler();
  $ShutterCallbackHandler get shutterCallbackHandler =>
      $ShutterCallbackHandler();
  $PictureCallbackHandler get pictureCallbackHandler =>
      $PictureCallbackHandler();
  $CameraInfoHandler get cameraInfoHandler => $CameraInfoHandler();
  $MediaRecorderHandler get mediaRecorderHandler => $MediaRecorderHandler();
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.cameraChannel.setHandler(
      implementations.cameraHandler,
    );
    implementations.shutterCallbackChannel.setHandler(
      implementations.shutterCallbackHandler,
    );
    implementations.pictureCallbackChannel.setHandler(
      implementations.pictureCallbackHandler,
    );
    implementations.cameraInfoChannel.setHandler(
      implementations.cameraInfoHandler,
    );
    implementations.mediaRecorderChannel.setHandler(
      implementations.mediaRecorderHandler,
    );
  }

  void unregisterHandlers() {
    implementations.cameraChannel.removeHandler();
    implementations.shutterCallbackChannel.removeHandler();
    implementations.pictureCallbackChannel.removeHandler();
    implementations.cameraInfoChannel.removeHandler();
    implementations.mediaRecorderChannel.removeHandler();
  }
}
