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

  Future<void> reconnect();

  Future<void> takePicture($ShutterCallback? shutter, $PictureCallback? raw,
      $PictureCallback? postView, $PictureCallback? jpeg);

  Future<void> autoFocus($AutoFocusCallback callback);

  Future<void> cancelAutoFocus();

  Future<void> setDisplayOrientation(int degrees);

  Future<void> setErrorCallback($ErrorCallback callback);

  Future<void> startSmoothZoom(int value);

  Future<void> stopSmoothZoom();

  Future<$CameraParameters> getParameters();

  Future<void> setParameters($CameraParameters parameters);
}

mixin $CameraParameters {
  Future<bool> getAutoExposureLock();

  Future<List<$CameraArea>> getFocusAreas();

  Future<List<double>> getFocusDistances();

  Future<int> getMaxExposureCompensation();

  Future<int> getMaxNumFocusAreas();

  Future<int> getMinExposureCompensation();

  Future<List<String>> getSupportedFocusModes();

  Future<bool> isAutoExposureLockSupported();

  Future<bool> isZoomSupported();

  Future<void> setAutoExposureLock(bool toggle);

  Future<void> setExposureCompensation(int value);

  Future<void> setFocusAreas(List<$CameraArea>? focusAreas);

  Future<void> setFocusMode(String value);

  Future<String?> getFlashMode();

  Future<int> getMaxZoom();

  Future<$CameraSize> getPictureSize();

  Future<$CameraSize> getPreviewSize();

  Future<List<$CameraSize>> getSupportedPreviewSizes();

  Future<List<$CameraSize>> getSupportedPictureSizes();

  Future<List<String>> getSupportedFlashModes();

  Future<int> getZoom();

  Future<bool> isSmoothZoomSupported();

  Future<void> setFlashMode(String mode);

  Future<void> setPictureSize(int width, int height);

  Future<void> setRecordingHint(bool hint);

  Future<void> setRotation(int rotation);

  Future<void> setZoom(int value);

  Future<void> setPreviewSize(int width, int height);

  Future<int> getExposureCompensation();

  Future<double> getExposureCompensationStep();
}

mixin $CameraArea {
  $CameraRect get rect;
  int get weight;
}

mixin $CameraRect {
  int get top;
  int get bottom;
  int get right;
  int get left;
}

mixin $CameraSize {
  int get width;
  int get height;
  String toString();
}

mixin $ErrorCallback {
  void onError(int error);
}

mixin $AutoFocusCallback {
  void onAutoFocus(bool success);
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

  Future<void> pause();

  Future<void> resume();
}

class $CameraCreationArgs {}

class $CameraParametersCreationArgs {}

class $CameraAreaCreationArgs {
  late $CameraRect rect;
  late int weight;
  late bool createInstancePair;
}

class $CameraRectCreationArgs {
  late int top;
  late int bottom;
  late int right;
  late int left;
  late bool createInstancePair;
}

class $CameraSizeCreationArgs {
  late int width;
  late int height;
}

class $ErrorCallbackCreationArgs {}

class $AutoFocusCallbackCreationArgs {}

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

  Future<Object?> $invokeReconnect(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'reconnect',
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

  Future<Object?> $invokeAutoFocus(
      $Camera instance, $AutoFocusCallback callback) {
    return sendInvokeMethod(
      instance,
      'autoFocus',
      <Object?>[callback],
    );
  }

  Future<Object?> $invokeCancelAutoFocus(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'cancelAutoFocus',
      <Object?>[],
    );
  }

  Future<Object?> $invokeSetDisplayOrientation($Camera instance, int degrees) {
    return sendInvokeMethod(
      instance,
      'setDisplayOrientation',
      <Object?>[degrees],
    );
  }

  Future<Object?> $invokeSetErrorCallback(
      $Camera instance, $ErrorCallback callback) {
    return sendInvokeMethod(
      instance,
      'setErrorCallback',
      <Object?>[callback],
    );
  }

  Future<Object?> $invokeStartSmoothZoom($Camera instance, int value) {
    return sendInvokeMethod(
      instance,
      'startSmoothZoom',
      <Object?>[value],
    );
  }

  Future<Object?> $invokeStopSmoothZoom(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'stopSmoothZoom',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetParameters(
    $Camera instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getParameters',
      <Object?>[],
    );
  }

  Future<Object?> $invokeSetParameters(
      $Camera instance, $CameraParameters parameters) {
    return sendInvokeMethod(
      instance,
      'setParameters',
      <Object?>[parameters],
    );
  }
}

class $CameraParametersChannel extends TypeChannel<$CameraParameters> {
  $CameraParametersChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraParameters');

  Future<Object?> $invokeGetAutoExposureLock(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getAutoExposureLock',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetFocusAreas(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getFocusAreas',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetFocusDistances(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getFocusDistances',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetMaxExposureCompensation(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getMaxExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetMaxNumFocusAreas(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getMaxNumFocusAreas',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetMinExposureCompensation(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getMinExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetSupportedFocusModes(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getSupportedFocusModes',
      <Object?>[],
    );
  }

  Future<Object?> $invokeIsAutoExposureLockSupported(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'isAutoExposureLockSupported',
      <Object?>[],
    );
  }

  Future<Object?> $invokeIsZoomSupported(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'isZoomSupported',
      <Object?>[],
    );
  }

  Future<Object?> $invokeSetAutoExposureLock(
      $CameraParameters instance, bool toggle) {
    return sendInvokeMethod(
      instance,
      'setAutoExposureLock',
      <Object?>[toggle],
    );
  }

  Future<Object?> $invokeSetExposureCompensation(
      $CameraParameters instance, int value) {
    return sendInvokeMethod(
      instance,
      'setExposureCompensation',
      <Object?>[value],
    );
  }

  Future<Object?> $invokeSetFocusAreas(
      $CameraParameters instance, List<$CameraArea>? focusAreas) {
    return sendInvokeMethod(
      instance,
      'setFocusAreas',
      <Object?>[focusAreas],
    );
  }

  Future<Object?> $invokeSetFocusMode(
      $CameraParameters instance, String value) {
    return sendInvokeMethod(
      instance,
      'setFocusMode',
      <Object?>[value],
    );
  }

  Future<Object?> $invokeGetFlashMode(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getFlashMode',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetMaxZoom(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getMaxZoom',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetPictureSize(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getPictureSize',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetPreviewSize(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getPreviewSize',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetSupportedPreviewSizes(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getSupportedPreviewSizes',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetSupportedPictureSizes(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getSupportedPictureSizes',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetSupportedFlashModes(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getSupportedFlashModes',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetZoom(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getZoom',
      <Object?>[],
    );
  }

  Future<Object?> $invokeIsSmoothZoomSupported(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'isSmoothZoomSupported',
      <Object?>[],
    );
  }

  Future<Object?> $invokeSetFlashMode($CameraParameters instance, String mode) {
    return sendInvokeMethod(
      instance,
      'setFlashMode',
      <Object?>[mode],
    );
  }

  Future<Object?> $invokeSetPictureSize(
      $CameraParameters instance, int width, int height) {
    return sendInvokeMethod(
      instance,
      'setPictureSize',
      <Object?>[width, height],
    );
  }

  Future<Object?> $invokeSetRecordingHint(
      $CameraParameters instance, bool hint) {
    return sendInvokeMethod(
      instance,
      'setRecordingHint',
      <Object?>[hint],
    );
  }

  Future<Object?> $invokeSetRotation($CameraParameters instance, int rotation) {
    return sendInvokeMethod(
      instance,
      'setRotation',
      <Object?>[rotation],
    );
  }

  Future<Object?> $invokeSetZoom($CameraParameters instance, int value) {
    return sendInvokeMethod(
      instance,
      'setZoom',
      <Object?>[value],
    );
  }

  Future<Object?> $invokeSetPreviewSize(
      $CameraParameters instance, int width, int height) {
    return sendInvokeMethod(
      instance,
      'setPreviewSize',
      <Object?>[width, height],
    );
  }

  Future<Object?> $invokeGetExposureCompensation(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $invokeGetExposureCompensationStep(
    $CameraParameters instance,
  ) {
    return sendInvokeMethod(
      instance,
      'getExposureCompensationStep',
      <Object?>[],
    );
  }
}

class $CameraAreaChannel extends TypeChannel<$CameraArea> {
  $CameraAreaChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraArea');
}

class $CameraRectChannel extends TypeChannel<$CameraRect> {
  $CameraRectChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraArea');
}

class $CameraSizeChannel extends TypeChannel<$CameraSize> {
  $CameraSizeChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraSize');

  Future<Object?> $invokeToString(
    $CameraSize instance,
  ) {
    return sendInvokeMethod(
      instance,
      'toString',
      <Object?>[],
    );
  }
}

class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
  $ErrorCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ErrorCallback');

  Future<Object?> $invokeOnError($ErrorCallback instance, int error) {
    return sendInvokeMethod(
      instance,
      'onError',
      <Object?>[error],
    );
  }
}

class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
  $AutoFocusCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/AutoFocusCallback');

  Future<Object?> $invokeOnAutoFocus(
      $AutoFocusCallback instance, bool success) {
    return sendInvokeMethod(
      instance,
      'onAutoFocus',
      <Object?>[success],
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

  Future<Object?> $invokePause(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'pause',
      <Object?>[],
    );
  }

  Future<Object?> $invokeResume(
    $MediaRecorder instance,
  ) {
    return sendInvokeMethod(
      instance,
      'resume',
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
      case 'reconnect':
        method = () => instance.reconnect();
        break;
      case 'takePicture':
        method = () => instance.takePicture(
            arguments[0] as $ShutterCallback?,
            arguments[1] as $PictureCallback?,
            arguments[2] as $PictureCallback?,
            arguments[3] as $PictureCallback?);
        break;
      case 'autoFocus':
        method = () => instance.autoFocus(arguments[0] as $AutoFocusCallback);
        break;
      case 'cancelAutoFocus':
        method = () => instance.cancelAutoFocus();
        break;
      case 'setDisplayOrientation':
        method = () => instance.setDisplayOrientation(arguments[0] as int);
        break;
      case 'setErrorCallback':
        method =
            () => instance.setErrorCallback(arguments[0] as $ErrorCallback);
        break;
      case 'startSmoothZoom':
        method = () => instance.startSmoothZoom(arguments[0] as int);
        break;
      case 'stopSmoothZoom':
        method = () => instance.stopSmoothZoom();
        break;
      case 'getParameters':
        method = () => instance.getParameters();
        break;
      case 'setParameters':
        method =
            () => instance.setParameters(arguments[0] as $CameraParameters);
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

class $CameraParametersHandler
    implements TypeChannelHandler<$CameraParameters> {
  $CameraParameters onCreate(
    TypeChannelMessenger messenger,
    $CameraParametersCreationArgs args,
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
    $CameraParameters instance,
  ) {
    return <Object?>[];
  }

  @override
  $CameraParameters createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CameraParametersCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraParameters instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'getAutoExposureLock':
        method = () => instance.getAutoExposureLock();
        break;
      case 'getFocusAreas':
        method = () => instance.getFocusAreas();
        break;
      case 'getFocusDistances':
        method = () => instance.getFocusDistances();
        break;
      case 'getMaxExposureCompensation':
        method = () => instance.getMaxExposureCompensation();
        break;
      case 'getMaxNumFocusAreas':
        method = () => instance.getMaxNumFocusAreas();
        break;
      case 'getMinExposureCompensation':
        method = () => instance.getMinExposureCompensation();
        break;
      case 'getSupportedFocusModes':
        method = () => instance.getSupportedFocusModes();
        break;
      case 'isAutoExposureLockSupported':
        method = () => instance.isAutoExposureLockSupported();
        break;
      case 'isZoomSupported':
        method = () => instance.isZoomSupported();
        break;
      case 'setAutoExposureLock':
        method = () => instance.setAutoExposureLock(arguments[0] as bool);
        break;
      case 'setExposureCompensation':
        method = () => instance.setExposureCompensation(arguments[0] as int);
        break;
      case 'setFocusAreas':
        method =
            () => instance.setFocusAreas(arguments[0] as List<$CameraArea>?);
        break;
      case 'setFocusMode':
        method = () => instance.setFocusMode(arguments[0] as String);
        break;
      case 'getFlashMode':
        method = () => instance.getFlashMode();
        break;
      case 'getMaxZoom':
        method = () => instance.getMaxZoom();
        break;
      case 'getPictureSize':
        method = () => instance.getPictureSize();
        break;
      case 'getPreviewSize':
        method = () => instance.getPreviewSize();
        break;
      case 'getSupportedPreviewSizes':
        method = () => instance.getSupportedPreviewSizes();
        break;
      case 'getSupportedPictureSizes':
        method = () => instance.getSupportedPictureSizes();
        break;
      case 'getSupportedFlashModes':
        method = () => instance.getSupportedFlashModes();
        break;
      case 'getZoom':
        method = () => instance.getZoom();
        break;
      case 'isSmoothZoomSupported':
        method = () => instance.isSmoothZoomSupported();
        break;
      case 'setFlashMode':
        method = () => instance.setFlashMode(arguments[0] as String);
        break;
      case 'setPictureSize':
        method = () =>
            instance.setPictureSize(arguments[0] as int, arguments[1] as int);
        break;
      case 'setRecordingHint':
        method = () => instance.setRecordingHint(arguments[0] as bool);
        break;
      case 'setRotation':
        method = () => instance.setRotation(arguments[0] as int);
        break;
      case 'setZoom':
        method = () => instance.setZoom(arguments[0] as int);
        break;
      case 'setPreviewSize':
        method = () =>
            instance.setPreviewSize(arguments[0] as int, arguments[1] as int);
        break;
      case 'getExposureCompensation':
        method = () => instance.getExposureCompensation();
        break;
      case 'getExposureCompensationStep':
        method = () => instance.getExposureCompensationStep();
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

class $CameraAreaHandler implements TypeChannelHandler<$CameraArea> {
  $CameraArea onCreate(
    TypeChannelMessenger messenger,
    $CameraAreaCreationArgs args,
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
    $CameraArea instance,
  ) {
    return <Object?>[
      instance.rect,
      instance.weight,
      instance.createInstancePair
    ];
  }

  @override
  $CameraArea createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CameraAreaCreationArgs()
        ..rect = arguments[0] as $CameraRect
        ..weight = arguments[1] as int
        ..createInstancePair = arguments[2] as bool,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraArea instance,
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

class $CameraRectHandler implements TypeChannelHandler<$CameraRect> {
  $CameraRect onCreate(
    TypeChannelMessenger messenger,
    $CameraRectCreationArgs args,
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
    $CameraRect instance,
  ) {
    return <Object?>[
      instance.top,
      instance.bottom,
      instance.right,
      instance.left,
      instance.createInstancePair
    ];
  }

  @override
  $CameraRect createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CameraRectCreationArgs()
        ..top = arguments[0] as int
        ..bottom = arguments[1] as int
        ..right = arguments[2] as int
        ..left = arguments[3] as int
        ..createInstancePair = arguments[4] as bool,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraRect instance,
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

class $CameraSizeHandler implements TypeChannelHandler<$CameraSize> {
  $CameraSize onCreate(
    TypeChannelMessenger messenger,
    $CameraSizeCreationArgs args,
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
    $CameraSize instance,
  ) {
    return <Object?>[instance.width, instance.height];
  }

  @override
  $CameraSize createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CameraSizeCreationArgs()
        ..width = arguments[0] as int
        ..height = arguments[1] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraSize instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'toString':
        method = () => instance.toString();
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

class $ErrorCallbackHandler implements TypeChannelHandler<$ErrorCallback> {
  $ErrorCallback onCreate(
    TypeChannelMessenger messenger,
    $ErrorCallbackCreationArgs args,
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
    $ErrorCallback instance,
  ) {
    return <Object?>[];
  }

  @override
  $ErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $ErrorCallbackCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ErrorCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'onError':
        method = () => instance.onError(arguments[0] as int);
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

class $AutoFocusCallbackHandler
    implements TypeChannelHandler<$AutoFocusCallback> {
  $AutoFocusCallback onCreate(
    TypeChannelMessenger messenger,
    $AutoFocusCallbackCreationArgs args,
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
    $AutoFocusCallback instance,
  ) {
    return <Object?>[];
  }

  @override
  $AutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $AutoFocusCallbackCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $AutoFocusCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'onAutoFocus':
        method = () => instance.onAutoFocus(arguments[0] as bool);
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
      case 'pause':
        method = () => instance.pause();
        break;
      case 'resume':
        method = () => instance.resume();
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
  $CameraParametersChannel get cameraParametersChannel =>
      $CameraParametersChannel(messenger);
  $CameraAreaChannel get cameraAreaChannel => $CameraAreaChannel(messenger);
  $CameraRectChannel get cameraRectChannel => $CameraRectChannel(messenger);
  $CameraSizeChannel get cameraSizeChannel => $CameraSizeChannel(messenger);
  $ErrorCallbackChannel get errorCallbackChannel =>
      $ErrorCallbackChannel(messenger);
  $AutoFocusCallbackChannel get autoFocusCallbackChannel =>
      $AutoFocusCallbackChannel(messenger);
  $ShutterCallbackChannel get shutterCallbackChannel =>
      $ShutterCallbackChannel(messenger);
  $PictureCallbackChannel get pictureCallbackChannel =>
      $PictureCallbackChannel(messenger);
  $CameraInfoChannel get cameraInfoChannel => $CameraInfoChannel(messenger);
  $MediaRecorderChannel get mediaRecorderChannel =>
      $MediaRecorderChannel(messenger);
  $CameraHandler get cameraHandler => $CameraHandler();
  $CameraParametersHandler get cameraParametersHandler =>
      $CameraParametersHandler();
  $CameraAreaHandler get cameraAreaHandler => $CameraAreaHandler();
  $CameraRectHandler get cameraRectHandler => $CameraRectHandler();
  $CameraSizeHandler get cameraSizeHandler => $CameraSizeHandler();
  $ErrorCallbackHandler get errorCallbackHandler => $ErrorCallbackHandler();
  $AutoFocusCallbackHandler get autoFocusCallbackHandler =>
      $AutoFocusCallbackHandler();
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
    implementations.cameraParametersChannel.setHandler(
      implementations.cameraParametersHandler,
    );
    implementations.cameraAreaChannel.setHandler(
      implementations.cameraAreaHandler,
    );
    implementations.cameraRectChannel.setHandler(
      implementations.cameraRectHandler,
    );
    implementations.cameraSizeChannel.setHandler(
      implementations.cameraSizeHandler,
    );
    implementations.errorCallbackChannel.setHandler(
      implementations.errorCallbackHandler,
    );
    implementations.autoFocusCallbackChannel.setHandler(
      implementations.autoFocusCallbackHandler,
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
    implementations.cameraParametersChannel.removeHandler();
    implementations.cameraAreaChannel.removeHandler();
    implementations.cameraRectChannel.removeHandler();
    implementations.cameraSizeChannel.removeHandler();
    implementations.errorCallbackChannel.removeHandler();
    implementations.autoFocusCallbackChannel.removeHandler();
    implementations.shutterCallbackChannel.removeHandler();
    implementations.pictureCallbackChannel.removeHandler();
    implementations.cameraInfoChannel.removeHandler();
    implementations.mediaRecorderChannel.removeHandler();
  }
}
