// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import 'dart:typed_data';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $Camera {
  Future<void> $release();

  Future<void> $startPreview();

  Future<void> $stopPreview();

  Future<int> $attachPreviewTexture();

  Future<void> $releasePreviewTexture();

  Future<void> $unlock();

  Future<void> $reconnect();

  Future<void> $takePicture(
    $ShutterCallback? shutter,
    $PictureCallback? raw,
    $PictureCallback? postView,
    $PictureCallback? jpeg,
  );

  Future<void> $autoFocus(
    $AutoFocusCallback callback,
  );

  Future<void> $cancelAutoFocus();

  Future<void> $setDisplayOrientation(
    int degrees,
  );

  Future<void> $setErrorCallback(
    $ErrorCallback callback,
  );

  Future<void> $startSmoothZoom(
    int value,
  );

  Future<void> $stopSmoothZoom();

  Future<$CameraParameters> $getParameters();

  Future<void> $setParameters(
    $CameraParameters parameters,
  );
}

mixin $CameraParameters {
  Future<bool> $getAutoExposureLock();

  Future<List<$CameraArea>?> $getFocusAreas();

  Future<List<double>> $getFocusDistances();

  Future<int> $getMaxExposureCompensation();

  Future<int> $getMaxNumFocusAreas();

  Future<int> $getMinExposureCompensation();

  Future<List<String>> $getSupportedFocusModes();

  Future<bool> $isAutoExposureLockSupported();

  Future<bool> $isZoomSupported();

  Future<void> $setAutoExposureLock(
    bool toggle,
  );

  Future<void> $setExposureCompensation(
    int value,
  );

  Future<void> $setFocusAreas(
    List<$CameraArea>? focusAreas,
  );

  Future<void> $setFocusMode(
    String value,
  );

  Future<String?> $getFlashMode();

  Future<int> $getMaxZoom();

  Future<$CameraSize> $getPictureSize();

  Future<$CameraSize> $getPreviewSize();

  Future<List<$CameraSize>> $getSupportedPreviewSizes();

  Future<List<$CameraSize>> $getSupportedPictureSizes();

  Future<List<String>> $getSupportedFlashModes();

  Future<int> $getZoom();

  Future<bool> $isSmoothZoomSupported();

  Future<void> $setFlashMode(
    String mode,
  );

  Future<void> $setPictureSize(
    int width,
    int height,
  );

  Future<void> $setRecordingHint(
    bool hint,
  );

  Future<void> $setRotation(
    int rotation,
  );

  Future<void> $setZoom(
    int value,
  );

  Future<void> $setPreviewSize(
    int width,
    int height,
  );

  Future<int> $getExposureCompensation();

  Future<double> $getExposureCompensationStep();
}

mixin $CameraArea {}

mixin $CameraRect {}

mixin $CameraSize {}

mixin $ErrorCallback {
  void $onError(
    int error,
  );
}

mixin $AutoFocusCallback {
  void $onAutoFocus(
    bool success,
  );
}

mixin $ShutterCallback {
  void $onShutter();
}

mixin $PictureCallback {
  void $onPictureTaken(
    Uint8List data,
  );
}

mixin $CameraInfo {}

mixin $MediaRecorder {
  Future<void> $setCamera(
    $Camera camera,
  );

  Future<void> $setVideoSource(
    int source,
  );

  Future<void> $setOutputFilePath(
    String path,
  );

  Future<void> $setOutputFormat(
    int format,
  );

  Future<void> $setVideoEncoder(
    int encoder,
  );

  Future<void> $setAudioSource(
    int source,
  );

  Future<void> $setAudioEncoder(
    int encoder,
  );

  Future<void> $prepare();

  Future<void> $start();

  Future<void> $stop();

  Future<void> $release();

  Future<void> $pause();

  Future<void> $resume();
}

class $CameraChannel extends TypeChannel<$Camera> {
  $CameraChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/Camera');

  Future<PairedInstance?> $$create(
    $Camera $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<List<$CameraInfo>> $getAllCameraInfo() async {
    return await sendInvokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[],
    ) as Future<List<$CameraInfo>>;
  }

  Future<$Camera> $open(
    int cameraId,
  ) async {
    return await sendInvokeStaticMethod(
      'open',
      <Object?>[
        cameraId,
      ],
    ) as Future<$Camera>;
  }

  Future<void> $release(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'release',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $startPreview(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'startPreview',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $stopPreview(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'stopPreview',
      <Object?>[],
    ) as Future<void>;
  }

  Future<int> $attachPreviewTexture(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'attachPreviewTexture',
      <Object?>[],
    ) as Future<int>;
  }

  Future<void> $releasePreviewTexture(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'releasePreviewTexture',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $unlock(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'unlock',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $reconnect(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'reconnect',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $takePicture(
    $Camera $instance,
    $ShutterCallback? shutter,
    $PictureCallback? raw,
    $PictureCallback? postView,
    $PictureCallback? jpeg,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'takePicture',
      <Object?>[
        shutter,
        raw,
        postView,
        jpeg,
      ],
    ) as Future<void>;
  }

  Future<void> $autoFocus(
    $Camera $instance,
    $AutoFocusCallback callback,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'autoFocus',
      <Object?>[
        callback,
      ],
    ) as Future<void>;
  }

  Future<void> $cancelAutoFocus(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'cancelAutoFocus',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $setDisplayOrientation(
    $Camera $instance,
    int degrees,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setDisplayOrientation',
      <Object?>[
        degrees,
      ],
    ) as Future<void>;
  }

  Future<void> $setErrorCallback(
    $Camera $instance,
    $ErrorCallback callback,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setErrorCallback',
      <Object?>[
        callback,
      ],
    ) as Future<void>;
  }

  Future<void> $startSmoothZoom(
    $Camera $instance,
    int value,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'startSmoothZoom',
      <Object?>[
        value,
      ],
    ) as Future<void>;
  }

  Future<void> $stopSmoothZoom(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'stopSmoothZoom',
      <Object?>[],
    ) as Future<void>;
  }

  Future<$CameraParameters> $getParameters(
    $Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getParameters',
      <Object?>[],
    ) as Future<$CameraParameters>;
  }

  Future<void> $setParameters(
    $Camera $instance,
    $CameraParameters parameters,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setParameters',
      <Object?>[
        parameters,
      ],
    ) as Future<void>;
  }
}

class $CameraParametersChannel extends TypeChannel<$CameraParameters> {
  $CameraParametersChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraParameters');

  Future<PairedInstance?> $$create(
    $CameraParameters $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<bool> $getAutoExposureLock(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getAutoExposureLock',
      <Object?>[],
    ) as Future<bool>;
  }

  Future<List<$CameraArea>?> $getFocusAreas(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getFocusAreas',
      <Object?>[],
    ) as Future<List<$CameraArea>?>;
  }

  Future<List<double>> $getFocusDistances(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getFocusDistances',
      <Object?>[],
    ) as Future<List<double>>;
  }

  Future<int> $getMaxExposureCompensation(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getMaxExposureCompensation',
      <Object?>[],
    ) as Future<int>;
  }

  Future<int> $getMaxNumFocusAreas(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getMaxNumFocusAreas',
      <Object?>[],
    ) as Future<int>;
  }

  Future<int> $getMinExposureCompensation(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getMinExposureCompensation',
      <Object?>[],
    ) as Future<int>;
  }

  Future<List<String>> $getSupportedFocusModes(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getSupportedFocusModes',
      <Object?>[],
    ) as Future<List<String>>;
  }

  Future<bool> $isAutoExposureLockSupported(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'isAutoExposureLockSupported',
      <Object?>[],
    ) as Future<bool>;
  }

  Future<bool> $isZoomSupported(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'isZoomSupported',
      <Object?>[],
    ) as Future<bool>;
  }

  Future<void> $setAutoExposureLock(
    $CameraParameters $instance,
    bool toggle,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setAutoExposureLock',
      <Object?>[
        toggle,
      ],
    ) as Future<void>;
  }

  Future<void> $setExposureCompensation(
    $CameraParameters $instance,
    int value,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setExposureCompensation',
      <Object?>[
        value,
      ],
    ) as Future<void>;
  }

  Future<void> $setFocusAreas(
    $CameraParameters $instance,
    List<$CameraArea>? focusAreas,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setFocusAreas',
      <Object?>[
        focusAreas,
      ],
    ) as Future<void>;
  }

  Future<void> $setFocusMode(
    $CameraParameters $instance,
    String value,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setFocusMode',
      <Object?>[
        value,
      ],
    ) as Future<void>;
  }

  Future<String?> $getFlashMode(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getFlashMode',
      <Object?>[],
    ) as Future<String?>;
  }

  Future<int> $getMaxZoom(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getMaxZoom',
      <Object?>[],
    ) as Future<int>;
  }

  Future<$CameraSize> $getPictureSize(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getPictureSize',
      <Object?>[],
    ) as Future<$CameraSize>;
  }

  Future<$CameraSize> $getPreviewSize(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getPreviewSize',
      <Object?>[],
    ) as Future<$CameraSize>;
  }

  Future<List<$CameraSize>> $getSupportedPreviewSizes(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getSupportedPreviewSizes',
      <Object?>[],
    ) as Future<List<$CameraSize>>;
  }

  Future<List<$CameraSize>> $getSupportedPictureSizes(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getSupportedPictureSizes',
      <Object?>[],
    ) as Future<List<$CameraSize>>;
  }

  Future<List<String>> $getSupportedFlashModes(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getSupportedFlashModes',
      <Object?>[],
    ) as Future<List<String>>;
  }

  Future<int> $getZoom(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getZoom',
      <Object?>[],
    ) as Future<int>;
  }

  Future<bool> $isSmoothZoomSupported(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'isSmoothZoomSupported',
      <Object?>[],
    ) as Future<bool>;
  }

  Future<void> $setFlashMode(
    $CameraParameters $instance,
    String mode,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setFlashMode',
      <Object?>[
        mode,
      ],
    ) as Future<void>;
  }

  Future<void> $setPictureSize(
    $CameraParameters $instance,
    int width,
    int height,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setPictureSize',
      <Object?>[
        width,
        height,
      ],
    ) as Future<void>;
  }

  Future<void> $setRecordingHint(
    $CameraParameters $instance,
    bool hint,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setRecordingHint',
      <Object?>[
        hint,
      ],
    ) as Future<void>;
  }

  Future<void> $setRotation(
    $CameraParameters $instance,
    int rotation,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setRotation',
      <Object?>[
        rotation,
      ],
    ) as Future<void>;
  }

  Future<void> $setZoom(
    $CameraParameters $instance,
    int value,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setZoom',
      <Object?>[
        value,
      ],
    ) as Future<void>;
  }

  Future<void> $setPreviewSize(
    $CameraParameters $instance,
    int width,
    int height,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setPreviewSize',
      <Object?>[
        width,
        height,
      ],
    ) as Future<void>;
  }

  Future<int> $getExposureCompensation(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getExposureCompensation',
      <Object?>[],
    ) as Future<int>;
  }

  Future<double> $getExposureCompensationStep(
    $CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'getExposureCompensationStep',
      <Object?>[],
    ) as Future<double>;
  }
}

class $CameraAreaChannel extends TypeChannel<$CameraArea> {
  $CameraAreaChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraArea');

  Future<PairedInstance?> $$create(
    $CameraArea $instance, {
    required bool $owner,
    required $CameraRect rect,
    required int weight,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        rect,
        weight,
      ],
      owner: $owner,
    );
  }
}

class $CameraRectChannel extends TypeChannel<$CameraRect> {
  $CameraRectChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraArea');

  Future<PairedInstance?> $$create(
    $CameraRect $instance, {
    required bool $owner,
    required int top,
    required int bottom,
    required int right,
    required int left,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        top,
        bottom,
        right,
        left,
      ],
      owner: $owner,
    );
  }
}

class $CameraSizeChannel extends TypeChannel<$CameraSize> {
  $CameraSizeChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraSize');

  Future<PairedInstance?> $$create(
    $CameraSize $instance, {
    required bool $owner,
    required int width,
    required int height,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        width,
        height,
      ],
      owner: $owner,
    );
  }
}

class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
  $ErrorCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ErrorCallback');

  Future<PairedInstance?> $$create(
    $ErrorCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
  $AutoFocusCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/AutoFocusCallback');

  Future<PairedInstance?> $$create(
    $AutoFocusCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
  $ShutterCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ShutterCallback');

  Future<PairedInstance?> $$create(
    $ShutterCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
  $PictureCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/PictureCallback');

  Future<PairedInstance?> $$create(
    $PictureCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
  $CameraInfoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraInfo');

  Future<PairedInstance?> $$create(
    $CameraInfo $instance, {
    required bool $owner,
    required int cameraId,
    required int facing,
    required int orientation,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        cameraId,
        facing,
        orientation,
      ],
      owner: $owner,
    );
  }
}

class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
  $MediaRecorderChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/MediaRecorder');

  Future<PairedInstance?> $$create(
    $MediaRecorder $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> $setCamera(
    $MediaRecorder $instance,
    $Camera camera,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setCamera',
      <Object?>[
        camera,
      ],
    ) as Future<void>;
  }

  Future<void> $setVideoSource(
    $MediaRecorder $instance,
    int source,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setVideoSource',
      <Object?>[
        source,
      ],
    ) as Future<void>;
  }

  Future<void> $setOutputFilePath(
    $MediaRecorder $instance,
    String path,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setOutputFilePath',
      <Object?>[
        path,
      ],
    ) as Future<void>;
  }

  Future<void> $setOutputFormat(
    $MediaRecorder $instance,
    int format,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setOutputFormat',
      <Object?>[
        format,
      ],
    ) as Future<void>;
  }

  Future<void> $setVideoEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setVideoEncoder',
      <Object?>[
        encoder,
      ],
    ) as Future<void>;
  }

  Future<void> $setAudioSource(
    $MediaRecorder $instance,
    int source,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setAudioSource',
      <Object?>[
        source,
      ],
    ) as Future<void>;
  }

  Future<void> $setAudioEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'setAudioEncoder',
      <Object?>[
        encoder,
      ],
    ) as Future<void>;
  }

  Future<void> $prepare(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'prepare',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $start(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'start',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $stop(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'stop',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $release(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'release',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $pause(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'pause',
      <Object?>[],
    ) as Future<void>;
  }

  Future<void> $resume(
    $MediaRecorder $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      'resume',
      <Object?>[],
    ) as Future<void>;
  }
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $Camera $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'getAllCameraInfo':
        return $getAllCameraInfo(
          messenger,
        );

      case 'open':
        return $open(
          messenger,
          arguments[0] as int,
        );
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $Camera createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $Camera instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'release':
        return $release(
          instance,
        );

      case 'startPreview':
        return $startPreview(
          instance,
        );

      case 'stopPreview':
        return $stopPreview(
          instance,
        );

      case 'attachPreviewTexture':
        return $attachPreviewTexture(
          instance,
        );

      case 'releasePreviewTexture':
        return $releasePreviewTexture(
          instance,
        );

      case 'unlock':
        return $unlock(
          instance,
        );

      case 'reconnect':
        return $reconnect(
          instance,
        );

      case 'takePicture':
        return $takePicture(
          instance,
          arguments[0] as $ShutterCallback?,
          arguments[1] as $PictureCallback?,
          arguments[2] as $PictureCallback?,
          arguments[3] as $PictureCallback?,
        );

      case 'autoFocus':
        return $autoFocus(
          instance,
          arguments[0] as $AutoFocusCallback,
        );

      case 'cancelAutoFocus':
        return $cancelAutoFocus(
          instance,
        );

      case 'setDisplayOrientation':
        return $setDisplayOrientation(
          instance,
          arguments[0] as int,
        );

      case 'setErrorCallback':
        return $setErrorCallback(
          instance,
          arguments[0] as $ErrorCallback,
        );

      case 'startSmoothZoom':
        return $startSmoothZoom(
          instance,
          arguments[0] as int,
        );

      case 'stopSmoothZoom':
        return $stopSmoothZoom(
          instance,
        );

      case 'getParameters':
        return $getParameters(
          instance,
        );

      case 'setParameters':
        return $setParameters(
          instance,
          arguments[0] as $CameraParameters,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraParametersHandler
    implements TypeChannelHandler<$CameraParameters> {
  $CameraParameters $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CameraParameters createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraParameters instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'getAutoExposureLock':
        return $getAutoExposureLock(
          instance,
        );

      case 'getFocusAreas':
        return $getFocusAreas(
          instance,
        );

      case 'getFocusDistances':
        return $getFocusDistances(
          instance,
        );

      case 'getMaxExposureCompensation':
        return $getMaxExposureCompensation(
          instance,
        );

      case 'getMaxNumFocusAreas':
        return $getMaxNumFocusAreas(
          instance,
        );

      case 'getMinExposureCompensation':
        return $getMinExposureCompensation(
          instance,
        );

      case 'getSupportedFocusModes':
        return $getSupportedFocusModes(
          instance,
        );

      case 'isAutoExposureLockSupported':
        return $isAutoExposureLockSupported(
          instance,
        );

      case 'isZoomSupported':
        return $isZoomSupported(
          instance,
        );

      case 'setAutoExposureLock':
        return $setAutoExposureLock(
          instance,
          arguments[0] as bool,
        );

      case 'setExposureCompensation':
        return $setExposureCompensation(
          instance,
          arguments[0] as int,
        );

      case 'setFocusAreas':
        return $setFocusAreas(
          instance,
          arguments[0] as List<$CameraArea>?,
        );

      case 'setFocusMode':
        return $setFocusMode(
          instance,
          arguments[0] as String,
        );

      case 'getFlashMode':
        return $getFlashMode(
          instance,
        );

      case 'getMaxZoom':
        return $getMaxZoom(
          instance,
        );

      case 'getPictureSize':
        return $getPictureSize(
          instance,
        );

      case 'getPreviewSize':
        return $getPreviewSize(
          instance,
        );

      case 'getSupportedPreviewSizes':
        return $getSupportedPreviewSizes(
          instance,
        );

      case 'getSupportedPictureSizes':
        return $getSupportedPictureSizes(
          instance,
        );

      case 'getSupportedFlashModes':
        return $getSupportedFlashModes(
          instance,
        );

      case 'getZoom':
        return $getZoom(
          instance,
        );

      case 'isSmoothZoomSupported':
        return $isSmoothZoomSupported(
          instance,
        );

      case 'setFlashMode':
        return $setFlashMode(
          instance,
          arguments[0] as String,
        );

      case 'setPictureSize':
        return $setPictureSize(
          instance,
          arguments[0] as int,
          arguments[1] as int,
        );

      case 'setRecordingHint':
        return $setRecordingHint(
          instance,
          arguments[0] as bool,
        );

      case 'setRotation':
        return $setRotation(
          instance,
          arguments[0] as int,
        );

      case 'setZoom':
        return $setZoom(
          instance,
          arguments[0] as int,
        );

      case 'setPreviewSize':
        return $setPreviewSize(
          instance,
          arguments[0] as int,
          arguments[1] as int,
        );

      case 'getExposureCompensation':
        return $getExposureCompensation(
          instance,
        );

      case 'getExposureCompensationStep':
        return $getExposureCompensationStep(
          instance,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraAreaHandler implements TypeChannelHandler<$CameraArea> {
  $CameraArea $$create(
    TypeChannelMessenger messenger,
    $CameraRect rect,
    int weight,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CameraArea createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $CameraRect,
      arguments[1] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraArea instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraRectHandler implements TypeChannelHandler<$CameraRect> {
  $CameraRect $$create(
    TypeChannelMessenger messenger,
    int top,
    int bottom,
    int right,
    int left,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CameraRect createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as int,
      arguments[1] as int,
      arguments[2] as int,
      arguments[3] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraRect instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraSizeHandler implements TypeChannelHandler<$CameraSize> {
  $CameraSize $$create(
    TypeChannelMessenger messenger,
    int width,
    int height,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CameraSize createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as int,
      arguments[1] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraSize instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $ErrorCallbackHandler implements TypeChannelHandler<$ErrorCallback> {
  $ErrorCallback $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  void $onError(
    $ErrorCallback $instance,
    int error,
  ) {
    $instance.$onError(
      error,
    );
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $ErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ErrorCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'onError':
        return $onError(
          instance,
          arguments[0] as int,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $AutoFocusCallbackHandler
    implements TypeChannelHandler<$AutoFocusCallback> {
  $AutoFocusCallback $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  void $onAutoFocus(
    $AutoFocusCallback $instance,
    bool success,
  ) {
    $instance.$onAutoFocus(
      success,
    );
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $AutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $AutoFocusCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'onAutoFocus':
        return $onAutoFocus(
          instance,
          arguments[0] as bool,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
  $ShutterCallback $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  void $onShutter(
    $ShutterCallback $instance,
  ) {
    $instance.$onShutter();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $ShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ShutterCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'onShutter':
        return $onShutter(
          instance,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
  $PictureCallback $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  void $onPictureTaken(
    $PictureCallback $instance,
    Uint8List data,
  ) {
    $instance.$onPictureTaken(
      data,
    );
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $PictureCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $PictureCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'onPictureTaken':
        return $onPictureTaken(
          instance,
          arguments[0] as Uint8List,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
  $CameraInfo $$create(
    TypeChannelMessenger messenger,
    int cameraId,
    int facing,
    int orientation,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CameraInfo createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as int,
      arguments[1] as int,
      arguments[2] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CameraInfo instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
  $MediaRecorder $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $MediaRecorder createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $MediaRecorder instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'setCamera':
        return $setCamera(
          instance,
          arguments[0] as $Camera,
        );

      case 'setVideoSource':
        return $setVideoSource(
          instance,
          arguments[0] as int,
        );

      case 'setOutputFilePath':
        return $setOutputFilePath(
          instance,
          arguments[0] as String,
        );

      case 'setOutputFormat':
        return $setOutputFormat(
          instance,
          arguments[0] as int,
        );

      case 'setVideoEncoder':
        return $setVideoEncoder(
          instance,
          arguments[0] as int,
        );

      case 'setAudioSource':
        return $setAudioSource(
          instance,
          arguments[0] as int,
        );

      case 'setAudioEncoder':
        return $setAudioEncoder(
          instance,
          arguments[0] as int,
        );

      case 'prepare':
        return $prepare(
          instance,
        );

      case 'start':
        return $start(
          instance,
        );

      case 'stop':
        return $stop(
          instance,
        );

      case 'release':
        return $release(
          instance,
        );

      case 'pause':
        return $pause(
          instance,
        );

      case 'resume':
        return $resume(
          instance,
        );
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  $CameraChannel get channelCamera => $CameraChannel(messenger);
  $CameraHandler get handlerCamera => $CameraHandler();

  $CameraParametersChannel get channelCameraParameters =>
      $CameraParametersChannel(messenger);
  $CameraParametersHandler get handlerCameraParameters =>
      $CameraParametersHandler();

  $CameraAreaChannel get channelCameraArea => $CameraAreaChannel(messenger);
  $CameraAreaHandler get handlerCameraArea => $CameraAreaHandler();

  $CameraRectChannel get channelCameraRect => $CameraRectChannel(messenger);
  $CameraRectHandler get handlerCameraRect => $CameraRectHandler();

  $CameraSizeChannel get channelCameraSize => $CameraSizeChannel(messenger);
  $CameraSizeHandler get handlerCameraSize => $CameraSizeHandler();

  $ErrorCallbackChannel get channelErrorCallback =>
      $ErrorCallbackChannel(messenger);
  $ErrorCallbackHandler get handlerErrorCallback => $ErrorCallbackHandler();

  $AutoFocusCallbackChannel get channelAutoFocusCallback =>
      $AutoFocusCallbackChannel(messenger);
  $AutoFocusCallbackHandler get handlerAutoFocusCallback =>
      $AutoFocusCallbackHandler();

  $ShutterCallbackChannel get channelShutterCallback =>
      $ShutterCallbackChannel(messenger);
  $ShutterCallbackHandler get handlerShutterCallback =>
      $ShutterCallbackHandler();

  $PictureCallbackChannel get channelPictureCallback =>
      $PictureCallbackChannel(messenger);
  $PictureCallbackHandler get handlerPictureCallback =>
      $PictureCallbackHandler();

  $CameraInfoChannel get channelCameraInfo => $CameraInfoChannel(messenger);
  $CameraInfoHandler get handlerCameraInfo => $CameraInfoHandler();

  $MediaRecorderChannel get channelMediaRecorder =>
      $MediaRecorderChannel(messenger);
  $MediaRecorderHandler get handlerMediaRecorder => $MediaRecorderHandler();
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.channelCamera.setHandler(
      implementations.handlerCamera,
    );

    implementations.channelCameraParameters.setHandler(
      implementations.handlerCameraParameters,
    );

    implementations.channelCameraArea.setHandler(
      implementations.handlerCameraArea,
    );

    implementations.channelCameraRect.setHandler(
      implementations.handlerCameraRect,
    );

    implementations.channelCameraSize.setHandler(
      implementations.handlerCameraSize,
    );

    implementations.channelErrorCallback.setHandler(
      implementations.handlerErrorCallback,
    );

    implementations.channelAutoFocusCallback.setHandler(
      implementations.handlerAutoFocusCallback,
    );

    implementations.channelShutterCallback.setHandler(
      implementations.handlerShutterCallback,
    );

    implementations.channelPictureCallback.setHandler(
      implementations.handlerPictureCallback,
    );

    implementations.channelCameraInfo.setHandler(
      implementations.handlerCameraInfo,
    );

    implementations.channelMediaRecorder.setHandler(
      implementations.handlerMediaRecorder,
    );
  }

  void unregisterHandlers() {
    implementations.channelCamera.removeHandler();

    implementations.channelCameraParameters.removeHandler();

    implementations.channelCameraArea.removeHandler();

    implementations.channelCameraRect.removeHandler();

    implementations.channelCameraSize.removeHandler();

    implementations.channelErrorCallback.removeHandler();

    implementations.channelAutoFocusCallback.removeHandler();

    implementations.channelShutterCallback.removeHandler();

    implementations.channelPictureCallback.removeHandler();

    implementations.channelCameraInfo.removeHandler();

    implementations.channelMediaRecorder.removeHandler();
  }
}
