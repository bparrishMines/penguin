// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import 'package:android_hardware/src/camera.dart';

import 'dart:core';

import 'dart:typed_data';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

class $OnErrorCallbackChannel extends TypeChannel<Object> {
  $OnErrorCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnErrorCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnErrorCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnErrorCallback $instance,
    int error,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        error,
        camera,
      ],
    );
  }
}

class $OnAutoFocusCallbackChannel extends TypeChannel<Object> {
  $OnAutoFocusCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnAutoFocusCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnAutoFocusCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnAutoFocusCallback $instance,
    bool success,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        success,
        camera,
      ],
    );
  }
}

class $OnShutterCallbackChannel extends TypeChannel<Object> {
  $OnShutterCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnShutterCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnShutterCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnShutterCallback $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[],
    );
  }
}

class $OnZoomChangeCallbackChannel extends TypeChannel<Object> {
  $OnZoomChangeCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnZoomChangeCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnZoomChangeCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnZoomChangeCallback $instance,
    int zoomValue,
    bool stopped,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        zoomValue,
        stopped,
        camera,
      ],
    );
  }
}

class $OnAutoFocusMovingCallbackChannel extends TypeChannel<Object> {
  $OnAutoFocusMovingCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnAutoFocusMovingCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnAutoFocusMovingCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnAutoFocusMovingCallback $instance,
    bool start,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        start,
        camera,
      ],
    );
  }
}

class $OnPictureTakenCallbackChannel extends TypeChannel<Object> {
  $OnPictureTakenCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnPictureTakenCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnPictureTakenCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnPictureTakenCallback $instance,
    Uint8List? data,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        data,
        camera,
      ],
    );
  }
}

class $OnPreviewFrameCallbackChannel extends TypeChannel<Object> {
  $OnPreviewFrameCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.OnPreviewFrameCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnPreviewFrameCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnPreviewFrameCallback $instance,
    Uint8List data,
    Camera camera,
  ) {
    implementations.channelCamera.$create$(camera, $owner: false);

    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        data,
        camera,
      ],
    );
  }
}

class $OnErrorCallbackHandler implements TypeChannelHandler<Object> {
  $OnErrorCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      int error,
      Camera camera,
    ) {
      implementations.channelOnErrorCallback._invoke(
        function,
        error,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnErrorCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as int,
          arguments[1] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnAutoFocusCallbackHandler implements TypeChannelHandler<Object> {
  $OnAutoFocusCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnAutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      bool success,
      Camera camera,
    ) {
      implementations.channelOnAutoFocusCallback._invoke(
        function,
        success,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnAutoFocusCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as bool,
          arguments[1] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnShutterCallbackHandler implements TypeChannelHandler<Object> {
  $OnShutterCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function() {
      implementations.channelOnShutterCallback._invoke(
        function,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnShutterCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance();
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnZoomChangeCallbackHandler implements TypeChannelHandler<Object> {
  $OnZoomChangeCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnZoomChangeCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      int zoomValue,
      bool stopped,
      Camera camera,
    ) {
      implementations.channelOnZoomChangeCallback._invoke(
        function,
        zoomValue,
        stopped,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnZoomChangeCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as int,
          arguments[1] as bool,
          arguments[2] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnAutoFocusMovingCallbackHandler implements TypeChannelHandler<Object> {
  $OnAutoFocusMovingCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnAutoFocusMovingCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      bool start,
      Camera camera,
    ) {
      implementations.channelOnAutoFocusMovingCallback._invoke(
        function,
        start,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnAutoFocusMovingCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as bool,
          arguments[1] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnPictureTakenCallbackHandler implements TypeChannelHandler<Object> {
  $OnPictureTakenCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnPictureTakenCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      Uint8List? data,
      Camera camera,
    ) {
      implementations.channelOnPictureTakenCallback._invoke(
        function,
        data,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnPictureTakenCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as Uint8List?,
          arguments[1] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $OnPreviewFrameCallbackHandler implements TypeChannelHandler<Object> {
  $OnPreviewFrameCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnPreviewFrameCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      Uint8List data,
      Camera camera,
    ) {
      implementations.channelOnPreviewFrameCallback._invoke(
        function,
        data,
        camera,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnPreviewFrameCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          arguments[0] as Uint8List,
          arguments[1] as Camera,
        );
    return function();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

class $ErrorCallbackChannel extends TypeChannel<ErrorCallback> {
  $ErrorCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.ErrorCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    ErrorCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnErrorCallback
        .$create$($instance.onError, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onError,
      ],
      owner: $owner,
    );
  }
}

class $AutoFocusCallbackChannel extends TypeChannel<AutoFocusCallback> {
  $AutoFocusCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.AutoFocusCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    AutoFocusCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnAutoFocusCallback
        .$create$($instance.onAutoFocus, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onAutoFocus,
      ],
      owner: $owner,
    );
  }
}

class $ShutterCallbackChannel extends TypeChannel<ShutterCallback> {
  $ShutterCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.ShutterCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    ShutterCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnShutterCallback
        .$create$($instance.onShutter, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onShutter,
      ],
      owner: $owner,
    );
  }
}

class $OnZoomChangeListenerChannel extends TypeChannel<OnZoomChangeListener> {
  $OnZoomChangeListenerChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.OnZoomChangeListener');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    OnZoomChangeListener $instance, {
    required bool $owner,
  }) {
    implementations.channelOnZoomChangeCallback
        .$create$($instance.onZoomChange, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onZoomChange,
      ],
      owner: $owner,
    );
  }
}

class $AutoFocusMoveCallbackChannel extends TypeChannel<AutoFocusMoveCallback> {
  $AutoFocusMoveCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.AutoFocusMoveCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    AutoFocusMoveCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnAutoFocusMovingCallback
        .$create$($instance.onAutoFocusMoving, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onAutoFocusMoving,
      ],
      owner: $owner,
    );
  }
}

class $PictureCallbackChannel extends TypeChannel<PictureCallback> {
  $PictureCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.PictureCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    PictureCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnPictureTakenCallback
        .$create$($instance.onPictureTaken, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onPictureTaken,
      ],
      owner: $owner,
    );
  }
}

class $PreviewCallbackChannel extends TypeChannel<PreviewCallback> {
  $PreviewCallbackChannel(this.implementations)
      : super(implementations.messenger,
            r'android.hardware.Camera.PreviewCallback');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    PreviewCallback $instance, {
    required bool $owner,
  }) {
    implementations.channelOnPreviewFrameCallback
        .$create$($instance.onPreviewFrame, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.onPreviewFrame,
      ],
      owner: $owner,
    );
  }
}

class $CameraChannel extends TypeChannel<Camera> {
  $CameraChannel(this.implementations)
      : super(implementations.messenger, r'android.hardware.Camera');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    Camera $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
      ],
      owner: $owner,
    );
  }

  Future<List<CameraInfo>> $getAllCameraInfo() async {
    return (await sendInvokeStaticMethod(
      r'getAllCameraInfo',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as CameraInfo)
        .toList();
  }

  Future<Camera> $open(
    int cameraId,
  ) async {
    return await sendInvokeStaticMethod(
      r'open',
      <Object?>[
        cameraId,
      ],
    ) as Camera;
  }

  Future<void> $release(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'release',
      <Object?>[],
    );
  }

  Future<void> $startPreview(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'startPreview',
      <Object?>[],
    );
  }

  Future<void> $stopPreview(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'stopPreview',
      <Object?>[],
    );
  }

  Future<int> $attachPreviewTexture(
    Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'attachPreviewTexture',
      <Object?>[],
    ) as int;
  }

  Future<void> $releasePreviewTexture(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'releasePreviewTexture',
      <Object?>[],
    );
  }

  Future<void> $unlock(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'unlock',
      <Object?>[],
    );
  }

  Future<void> $setOneShotPreviewCallback(
    Camera $instance,
    PreviewCallback callback,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setOneShotPreviewCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<void> $setPreviewCallback(
    Camera $instance,
    PreviewCallback? callback,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPreviewCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<void> $reconnect(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'reconnect',
      <Object?>[],
    );
  }

  Future<void> $takePicture(
    Camera $instance,
    ShutterCallback? shutter,
    PictureCallback? raw,
    PictureCallback? postView,
    PictureCallback? jpeg,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'takePicture',
      <Object?>[
        shutter,
        raw,
        postView,
        jpeg,
      ],
    );
  }

  Future<void> $autoFocus(
    Camera $instance,
    AutoFocusCallback callback,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'autoFocus',
      <Object?>[
        callback,
      ],
    );
  }

  Future<void> $cancelAutoFocus(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'cancelAutoFocus',
      <Object?>[],
    );
  }

  Future<void> $setDisplayOrientation(
    Camera $instance,
    int degrees,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setDisplayOrientation',
      <Object?>[
        degrees,
      ],
    );
  }

  Future<void> $setErrorCallback(
    Camera $instance,
    ErrorCallback callback,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setErrorCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<void> $startSmoothZoom(
    Camera $instance,
    int value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'startSmoothZoom',
      <Object?>[
        value,
      ],
    );
  }

  Future<void> $stopSmoothZoom(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'stopSmoothZoom',
      <Object?>[],
    );
  }

  Future<CameraParameters> $getParameters(
    Camera $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getParameters',
      <Object?>[],
    ) as CameraParameters;
  }

  Future<void> $setParameters(
    Camera $instance,
    CameraParameters parameters,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setParameters',
      <Object?>[
        parameters,
      ],
    );
  }

  Future<void> $setZoomChangeListener(
    Camera $instance,
    OnZoomChangeListener listener,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setZoomChangeListener',
      <Object?>[
        listener,
      ],
    );
  }

  Future<void> $setAutoFocusMoveCallback(
    Camera $instance,
    AutoFocusMoveCallback callback,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setAutoFocusMoveCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<void> $lock(
    Camera $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'lock',
      <Object?>[],
    );
  }

  Future<bool> $enableShutterSound(
    Camera $instance,
    bool enabled,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'enableShutterSound',
      <Object?>[
        enabled,
      ],
    ) as bool;
  }
}

class $CameraParametersChannel extends TypeChannel<CameraParameters> {
  $CameraParametersChannel(this.implementations)
      : super(implementations.messenger, r'android.hardware.Camera.Parameters');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    CameraParameters $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
      ],
      owner: $owner,
    );
  }

  Future<bool> $getAutoExposureLock(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getAutoExposureLock',
      <Object?>[],
    ) as bool;
  }

  Future<List<CameraArea>?> $getFocusAreas(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getFocusAreas',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as CameraArea)
        .toList();
  }

  Future<List<double>> $getFocusDistances(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getFocusDistances',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as double)
        .toList();
  }

  Future<int> $getMaxExposureCompensation(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getMaxExposureCompensation',
      <Object?>[],
    ) as int;
  }

  Future<int> $getMaxNumFocusAreas(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getMaxNumFocusAreas',
      <Object?>[],
    ) as int;
  }

  Future<int> $getMinExposureCompensation(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getMinExposureCompensation',
      <Object?>[],
    ) as int;
  }

  Future<List<String>> $getSupportedFocusModes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedFocusModes',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as String)
        .toList();
  }

  Future<bool> $isAutoExposureLockSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isAutoExposureLockSupported',
      <Object?>[],
    ) as bool;
  }

  Future<bool> $isZoomSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isZoomSupported',
      <Object?>[],
    ) as bool;
  }

  Future<void> $setAutoExposureLock(
    CameraParameters $instance,
    bool toggle,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setAutoExposureLock',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<void> $setExposureCompensation(
    CameraParameters $instance,
    int value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setExposureCompensation',
      <Object?>[
        value,
      ],
    );
  }

  Future<void> $setFocusAreas(
    CameraParameters $instance,
    List<CameraArea>? focusAreas,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setFocusAreas',
      <Object?>[
        focusAreas,
      ],
    );
  }

  Future<void> $setFocusMode(
    CameraParameters $instance,
    String value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setFocusMode',
      <Object?>[
        value,
      ],
    );
  }

  Future<String?> $getFlashMode(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getFlashMode',
      <Object?>[],
    ) as String?;
  }

  Future<int> $getMaxZoom(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getMaxZoom',
      <Object?>[],
    ) as int;
  }

  Future<CameraSize> $getPictureSize(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getPictureSize',
      <Object?>[],
    ) as CameraSize;
  }

  Future<CameraSize> $getPreviewSize(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getPreviewSize',
      <Object?>[],
    ) as CameraSize;
  }

  Future<List<CameraSize>> $getSupportedPreviewSizes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewSizes',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as CameraSize)
        .toList();
  }

  Future<List<CameraSize>> $getSupportedPictureSizes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedPictureSizes',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as CameraSize)
        .toList();
  }

  Future<List<String>> $getSupportedFlashModes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedFlashModes',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as String)
        .toList();
  }

  Future<int> $getZoom(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getZoom',
      <Object?>[],
    ) as int;
  }

  Future<bool> $isSmoothZoomSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isSmoothZoomSupported',
      <Object?>[],
    ) as bool;
  }

  Future<void> $setFlashMode(
    CameraParameters $instance,
    String mode,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setFlashMode',
      <Object?>[
        mode,
      ],
    );
  }

  Future<void> $setPictureSize(
    CameraParameters $instance,
    int width,
    int height,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPictureSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<void> $setRecordingHint(
    CameraParameters $instance,
    bool hint,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setRecordingHint',
      <Object?>[
        hint,
      ],
    );
  }

  Future<void> $setRotation(
    CameraParameters $instance,
    int rotation,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setRotation',
      <Object?>[
        rotation,
      ],
    );
  }

  Future<void> $setZoom(
    CameraParameters $instance,
    int value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setZoom',
      <Object?>[
        value,
      ],
    );
  }

  Future<void> $setPreviewSize(
    CameraParameters $instance,
    int width,
    int height,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPreviewSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<int> $getExposureCompensation(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getExposureCompensation',
      <Object?>[],
    ) as int;
  }

  Future<double> $getExposureCompensationStep(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getExposureCompensationStep',
      <Object?>[],
    ) as double;
  }

  Future<String> $flatten(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'flatten',
      <Object?>[],
    ) as String;
  }

  Future<String?> $get(
    CameraParameters $instance,
    String key,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'get',
      <Object?>[
        key,
      ],
    ) as String?;
  }

  Future<String> $getAntibanding(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getAntibanding',
      <Object?>[],
    ) as String;
  }

  Future<bool> $getAutoWhiteBalanceLock(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getAutoWhiteBalanceLock',
      <Object?>[],
    ) as bool;
  }

  Future<String> $getColorEffect(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getColorEffect',
      <Object?>[],
    ) as String;
  }

  Future<double> $getFocalLength(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getFocalLength',
      <Object?>[],
    ) as double;
  }

  Future<String> $getFocusMode(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getFocusMode',
      <Object?>[],
    ) as String;
  }

  Future<double> $getHorizontalViewAngle(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getHorizontalViewAngle',
      <Object?>[],
    ) as double;
  }

  Future<int> $getInt(
    CameraParameters $instance,
    String key,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getInt',
      <Object?>[
        key,
      ],
    ) as int;
  }

  Future<int> $getJpegQuality(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getJpegQuality',
      <Object?>[],
    ) as int;
  }

  Future<int> $getJpegThumbnailQuality(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getJpegThumbnailQuality',
      <Object?>[],
    ) as int;
  }

  Future<CameraSize> $getJpegThumbnailSize(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getJpegThumbnailSize',
      <Object?>[],
    ) as CameraSize;
  }

  Future<int> $getMaxNumMeteringAreas(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getMaxNumMeteringAreas',
      <Object?>[],
    ) as int;
  }

  Future<List<CameraArea>?> $getMeteringAreas(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getMeteringAreas',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as CameraArea)
        .toList();
  }

  Future<int> $getPictureFormat(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getPictureFormat',
      <Object?>[],
    ) as int;
  }

  Future<CameraSize?> $getPreferredPreviewSizeForVideo(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getPreferredPreviewSizeForVideo',
      <Object?>[],
    ) as CameraSize?;
  }

  Future<int> $getPreviewFormat(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getPreviewFormat',
      <Object?>[],
    ) as int;
  }

  Future<List<int>> $getPreviewFpsRange(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getPreviewFpsRange',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as int)
        .toList();
  }

  Future<String?> $getSceneMode(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getSceneMode',
      <Object?>[],
    ) as String?;
  }

  Future<List<String>?> $getSupportedAntibanding(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedAntibanding',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as String)
        .toList();
  }

  Future<List<String>?> $getSupportedColorEffects(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedColorEffects',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as String)
        .toList();
  }

  Future<List<CameraSize>> $getSupportedJpegThumbnailSizes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedJpegThumbnailSizes',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as CameraSize)
        .toList();
  }

  Future<List<int>> $getSupportedPictureFormats(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedPictureFormats',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as int)
        .toList();
  }

  Future<List<int>> $getSupportedPreviewFormats(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewFormats',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as int)
        .toList();
  }

  Future<List<List<int>>> $getSupportedPreviewFpsRange(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewFpsRange',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => (_ as List<dynamic>).map((_) => _ as int).toList())
        .toList();
  }

  Future<List<String>?> $getSupportedSceneModes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedSceneModes',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as String)
        .toList();
  }

  Future<List<CameraSize>?> $getSupportedVideoSizes(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedVideoSizes',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as CameraSize)
        .toList();
  }

  Future<List<String>?> $getSupportedWhiteBalance(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getSupportedWhiteBalance',
      <Object?>[],
    ) as List<dynamic>?)
        ?.map((_) => _ as String)
        .toList();
  }

  Future<double> $getVerticalViewAngle(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getVerticalViewAngle',
      <Object?>[],
    ) as double;
  }

  Future<bool> $getVideoStabilization(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getVideoStabilization',
      <Object?>[],
    ) as bool;
  }

  Future<String?> $getWhiteBalance(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'getWhiteBalance',
      <Object?>[],
    ) as String?;
  }

  Future<List<int>> $getZoomRatios(
    CameraParameters $instance,
  ) async {
    return (await sendInvokeMethod(
      $instance,
      r'getZoomRatios',
      <Object?>[],
    ) as List<dynamic>)
        .map((_) => _ as int)
        .toList();
  }

  Future<bool> $isAutoWhiteBalanceLockSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isAutoWhiteBalanceLockSupported',
      <Object?>[],
    ) as bool;
  }

  Future<bool> $isVideoSnapshotSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isVideoSnapshotSupported',
      <Object?>[],
    ) as bool;
  }

  Future<bool> $isVideoStabilizationSupported(
    CameraParameters $instance,
  ) async {
    return await sendInvokeMethod(
      $instance,
      r'isVideoStabilizationSupported',
      <Object?>[],
    ) as bool;
  }

  Future<void> $remove(
    CameraParameters $instance,
    String key,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'remove',
      <Object?>[
        key,
      ],
    );
  }

  Future<void> $removeGpsData(
    CameraParameters $instance,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'removeGpsData',
      <Object?>[],
    );
  }

  Future<void> $set(
    CameraParameters $instance,
    String key,
    Object value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'set',
      <Object?>[
        key,
        value,
      ],
    );
  }

  Future<void> $setAntibanding(
    CameraParameters $instance,
    String antibanding,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setAntibanding',
      <Object?>[
        antibanding,
      ],
    );
  }

  Future<void> $setAutoWhiteBalanceLock(
    CameraParameters $instance,
    bool toggle,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setAutoWhiteBalanceLock',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<void> $setColorEffect(
    CameraParameters $instance,
    String effect,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setColorEffect',
      <Object?>[
        effect,
      ],
    );
  }

  Future<void> $setGpsAltitude(
    CameraParameters $instance,
    double meters,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setGpsAltitude',
      <Object?>[
        meters,
      ],
    );
  }

  Future<void> $setGpsLatitude(
    CameraParameters $instance,
    double latitude,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setGpsLatitude',
      <Object?>[
        latitude,
      ],
    );
  }

  Future<void> $setGpsLongitude(
    CameraParameters $instance,
    double longitude,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setGpsLongitude',
      <Object?>[
        longitude,
      ],
    );
  }

  Future<void> $setGpsProcessingMethod(
    CameraParameters $instance,
    String processingMethod,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setGpsProcessingMethod',
      <Object?>[
        processingMethod,
      ],
    );
  }

  Future<void> $setGpsTimestamp(
    CameraParameters $instance,
    int timestamp,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setGpsTimestamp',
      <Object?>[
        timestamp,
      ],
    );
  }

  Future<void> $setJpegQuality(
    CameraParameters $instance,
    int quality,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setJpegQuality',
      <Object?>[
        quality,
      ],
    );
  }

  Future<void> $setJpegThumbnailQuality(
    CameraParameters $instance,
    int quality,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setJpegThumbnailQuality',
      <Object?>[
        quality,
      ],
    );
  }

  Future<void> $setJpegThumbnailSize(
    CameraParameters $instance,
    int width,
    int height,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setJpegThumbnailSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<void> $setMeteringAreas(
    CameraParameters $instance,
    List<CameraArea> meteringAreas,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setMeteringAreas',
      <Object?>[
        meteringAreas,
      ],
    );
  }

  Future<void> $setPictureFormat(
    CameraParameters $instance,
    int pixelFormat,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPictureFormat',
      <Object?>[
        pixelFormat,
      ],
    );
  }

  Future<void> $setPreviewFormat(
    CameraParameters $instance,
    int pixelFormat,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPreviewFormat',
      <Object?>[
        pixelFormat,
      ],
    );
  }

  Future<void> $setPreviewFpsRange(
    CameraParameters $instance,
    int min,
    int max,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setPreviewFpsRange',
      <Object?>[
        min,
        max,
      ],
    );
  }

  Future<void> $setSceneMode(
    CameraParameters $instance,
    String mode,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setSceneMode',
      <Object?>[
        mode,
      ],
    );
  }

  Future<void> $setVideoStabilization(
    CameraParameters $instance,
    bool toggle,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setVideoStabilization',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<void> $setWhiteBalance(
    CameraParameters $instance,
    String value,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'setWhiteBalance',
      <Object?>[
        value,
      ],
    );
  }

  Future<void> $unflatten(
    CameraParameters $instance,
    String flattened,
  ) async {
    await sendInvokeMethod(
      $instance,
      r'unflatten',
      <Object?>[
        flattened,
      ],
    );
  }
}

class $CameraAreaChannel extends TypeChannel<CameraArea> {
  $CameraAreaChannel(this.implementations)
      : super(implementations.messenger, r'android.hardware.Camera.Area');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    CameraArea $instance, {
    required bool $owner,
  }) {
    implementations.channelCameraRect.$create$($instance.rect, $owner: false);

    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.rect,
        $instance.weight,
      ],
      owner: $owner,
    );
  }
}

class $CameraRectChannel extends TypeChannel<CameraRect> {
  $CameraRectChannel(this.implementations)
      : super(implementations.messenger, r'android.graphics.Rect');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    CameraRect $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.top,
        $instance.bottom,
        $instance.right,
        $instance.left,
      ],
      owner: $owner,
    );
  }
}

class $CameraSizeChannel extends TypeChannel<CameraSize> {
  $CameraSizeChannel(this.implementations)
      : super(implementations.messenger, r'android.hardware.Camera.Size');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    CameraSize $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.width,
        $instance.height,
      ],
      owner: $owner,
    );
  }
}

class $CameraInfoChannel extends TypeChannel<CameraInfo> {
  $CameraInfoChannel(this.implementations)
      : super(implementations.messenger,
            r'dev.penguin.android_hardware.CameraInfoHandler.CameraInfoProxy');

  final $LibraryImplementations implementations;

  Future<PairedInstance?> $create$(
    CameraInfo $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
        $instance.cameraId,
        $instance.facing,
        $instance.orientation,
        $instance.canDisableShutterSound,
      ],
      owner: $owner,
    );
  }
}

class $ImageFormatChannel extends TypeChannel<ImageFormat> {
  $ImageFormatChannel(this.implementations)
      : super(implementations.messenger, r'android.graphics.ImageFormat');

  final $LibraryImplementations implementations;

  Future<int> $getBitsPerPixel(
    int format,
  ) async {
    return await sendInvokeStaticMethod(
      r'getBitsPerPixel',
      <Object?>[
        format,
      ],
    ) as int;
  }
}

class $ErrorCallbackHandler implements TypeChannelHandler<ErrorCallback> {
  ErrorCallback $create$(
    TypeChannelMessenger messenger,
    OnErrorCallback onError,
  ) {
    return ErrorCallback(
      onError,
      create: false,
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
  ErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnErrorCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    ErrorCallback instance,
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

class $AutoFocusCallbackHandler
    implements TypeChannelHandler<AutoFocusCallback> {
  AutoFocusCallback $create$(
    TypeChannelMessenger messenger,
    OnAutoFocusCallback onAutoFocus,
  ) {
    return AutoFocusCallback(
      onAutoFocus,
      create: false,
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
  AutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnAutoFocusCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    AutoFocusCallback instance,
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

class $ShutterCallbackHandler implements TypeChannelHandler<ShutterCallback> {
  ShutterCallback $create$(
    TypeChannelMessenger messenger,
    OnShutterCallback onShutter,
  ) {
    return ShutterCallback(
      onShutter,
      create: false,
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
  ShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnShutterCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    ShutterCallback instance,
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

class $OnZoomChangeListenerHandler
    implements TypeChannelHandler<OnZoomChangeListener> {
  OnZoomChangeListener $create$(
    TypeChannelMessenger messenger,
    OnZoomChangeCallback onZoomChange,
  ) {
    return OnZoomChangeListener(
      onZoomChange,
      create: false,
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
  OnZoomChangeListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnZoomChangeCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    OnZoomChangeListener instance,
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

class $AutoFocusMoveCallbackHandler
    implements TypeChannelHandler<AutoFocusMoveCallback> {
  AutoFocusMoveCallback $create$(
    TypeChannelMessenger messenger,
    OnAutoFocusMovingCallback onAutoFocusMoving,
  ) {
    return AutoFocusMoveCallback(
      onAutoFocusMoving,
      create: false,
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
  AutoFocusMoveCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnAutoFocusMovingCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    AutoFocusMoveCallback instance,
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

class $PictureCallbackHandler implements TypeChannelHandler<PictureCallback> {
  PictureCallback $create$(
    TypeChannelMessenger messenger,
    OnPictureTakenCallback onPictureTaken,
  ) {
    return PictureCallback(
      onPictureTaken,
      create: false,
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
  PictureCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnPictureTakenCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    PictureCallback instance,
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

class $PreviewCallbackHandler implements TypeChannelHandler<PreviewCallback> {
  PreviewCallback $create$(
    TypeChannelMessenger messenger,
    OnPreviewFrameCallback onPreviewFrame,
  ) {
    return PreviewCallback(
      onPreviewFrame,
      create: false,
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
  PreviewCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as OnPreviewFrameCallback,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    PreviewCallback instance,
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

class $CameraHandler implements TypeChannelHandler<Camera> {
  Camera $create$(
    TypeChannelMessenger messenger,
  ) {
    return Camera(
      create: false,
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
  Camera createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    Camera instance,
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

class $CameraParametersHandler implements TypeChannelHandler<CameraParameters> {
  CameraParameters $create$(
    TypeChannelMessenger messenger,
  ) {
    return CameraParameters(
      create: false,
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
  CameraParameters createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    CameraParameters instance,
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

class $CameraAreaHandler implements TypeChannelHandler<CameraArea> {
  CameraArea $create$(
    TypeChannelMessenger messenger,
    CameraRect rect,
    int weight,
  ) {
    return CameraArea(
      rect,
      weight,
      create: false,
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
  CameraArea createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as CameraRect,
          arguments[2] as int,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    CameraArea instance,
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

class $CameraRectHandler implements TypeChannelHandler<CameraRect> {
  CameraRect $create$(
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
      create: false,
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
  CameraRect createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as int,
          arguments[2] as int,
          arguments[3] as int,
          arguments[4] as int,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    CameraRect instance,
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

class $CameraSizeHandler implements TypeChannelHandler<CameraSize> {
  CameraSize $create$(
    TypeChannelMessenger messenger,
    int width,
    int height,
  ) {
    return CameraSize(
      width,
      height,
      create: false,
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
  CameraSize createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as int,
          arguments[2] as int,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    CameraSize instance,
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

class $CameraInfoHandler implements TypeChannelHandler<CameraInfo> {
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
      create: false,
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
  CameraInfo createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case r'':
        return $create$(
          messenger,
          arguments[1] as int,
          arguments[2] as int,
          arguments[3] as int,
          arguments[4] as bool?,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    CameraInfo instance,
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

class $ImageFormatHandler implements TypeChannelHandler<ImageFormat> {
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
  ImageFormat createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    ImageFormat instance,
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

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  late $ErrorCallbackChannel channelErrorCallback = $ErrorCallbackChannel(this);
  $ErrorCallbackHandler handlerErrorCallback = $ErrorCallbackHandler();

  late $AutoFocusCallbackChannel channelAutoFocusCallback =
      $AutoFocusCallbackChannel(this);
  $AutoFocusCallbackHandler handlerAutoFocusCallback =
      $AutoFocusCallbackHandler();

  late $ShutterCallbackChannel channelShutterCallback =
      $ShutterCallbackChannel(this);
  $ShutterCallbackHandler handlerShutterCallback = $ShutterCallbackHandler();

  late $OnZoomChangeListenerChannel channelOnZoomChangeListener =
      $OnZoomChangeListenerChannel(this);
  $OnZoomChangeListenerHandler handlerOnZoomChangeListener =
      $OnZoomChangeListenerHandler();

  late $AutoFocusMoveCallbackChannel channelAutoFocusMoveCallback =
      $AutoFocusMoveCallbackChannel(this);
  $AutoFocusMoveCallbackHandler handlerAutoFocusMoveCallback =
      $AutoFocusMoveCallbackHandler();

  late $PictureCallbackChannel channelPictureCallback =
      $PictureCallbackChannel(this);
  $PictureCallbackHandler handlerPictureCallback = $PictureCallbackHandler();

  late $PreviewCallbackChannel channelPreviewCallback =
      $PreviewCallbackChannel(this);
  $PreviewCallbackHandler handlerPreviewCallback = $PreviewCallbackHandler();

  late $CameraChannel channelCamera = $CameraChannel(this);
  $CameraHandler handlerCamera = $CameraHandler();

  late $CameraParametersChannel channelCameraParameters =
      $CameraParametersChannel(this);
  $CameraParametersHandler handlerCameraParameters = $CameraParametersHandler();

  late $CameraAreaChannel channelCameraArea = $CameraAreaChannel(this);
  $CameraAreaHandler handlerCameraArea = $CameraAreaHandler();

  late $CameraRectChannel channelCameraRect = $CameraRectChannel(this);
  $CameraRectHandler handlerCameraRect = $CameraRectHandler();

  late $CameraSizeChannel channelCameraSize = $CameraSizeChannel(this);
  $CameraSizeHandler handlerCameraSize = $CameraSizeHandler();

  late $CameraInfoChannel channelCameraInfo = $CameraInfoChannel(this);
  $CameraInfoHandler handlerCameraInfo = $CameraInfoHandler();

  late $ImageFormatChannel channelImageFormat = $ImageFormatChannel(this);
  $ImageFormatHandler handlerImageFormat = $ImageFormatHandler();

  late $OnErrorCallbackChannel channelOnErrorCallback =
      $OnErrorCallbackChannel(this);
  late $OnErrorCallbackHandler handlerOnErrorCallback =
      $OnErrorCallbackHandler(this);

  late $OnAutoFocusCallbackChannel channelOnAutoFocusCallback =
      $OnAutoFocusCallbackChannel(this);
  late $OnAutoFocusCallbackHandler handlerOnAutoFocusCallback =
      $OnAutoFocusCallbackHandler(this);

  late $OnShutterCallbackChannel channelOnShutterCallback =
      $OnShutterCallbackChannel(this);
  late $OnShutterCallbackHandler handlerOnShutterCallback =
      $OnShutterCallbackHandler(this);

  late $OnZoomChangeCallbackChannel channelOnZoomChangeCallback =
      $OnZoomChangeCallbackChannel(this);
  late $OnZoomChangeCallbackHandler handlerOnZoomChangeCallback =
      $OnZoomChangeCallbackHandler(this);

  late $OnAutoFocusMovingCallbackChannel channelOnAutoFocusMovingCallback =
      $OnAutoFocusMovingCallbackChannel(this);
  late $OnAutoFocusMovingCallbackHandler handlerOnAutoFocusMovingCallback =
      $OnAutoFocusMovingCallbackHandler(this);

  late $OnPictureTakenCallbackChannel channelOnPictureTakenCallback =
      $OnPictureTakenCallbackChannel(this);
  late $OnPictureTakenCallbackHandler handlerOnPictureTakenCallback =
      $OnPictureTakenCallbackHandler(this);

  late $OnPreviewFrameCallbackChannel channelOnPreviewFrameCallback =
      $OnPreviewFrameCallbackChannel(this);
  late $OnPreviewFrameCallbackHandler handlerOnPreviewFrameCallback =
      $OnPreviewFrameCallbackHandler(this);
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  static $ChannelRegistrar instance = $ChannelRegistrar(
      $LibraryImplementations(MethodChannelMessenger.instance))
    ..registerHandlers();

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.channelErrorCallback.setHandler(
      implementations.handlerErrorCallback,
    );

    implementations.channelAutoFocusCallback.setHandler(
      implementations.handlerAutoFocusCallback,
    );

    implementations.channelShutterCallback.setHandler(
      implementations.handlerShutterCallback,
    );

    implementations.channelOnZoomChangeListener.setHandler(
      implementations.handlerOnZoomChangeListener,
    );

    implementations.channelAutoFocusMoveCallback.setHandler(
      implementations.handlerAutoFocusMoveCallback,
    );

    implementations.channelPictureCallback.setHandler(
      implementations.handlerPictureCallback,
    );

    implementations.channelPreviewCallback.setHandler(
      implementations.handlerPreviewCallback,
    );

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

    implementations.channelCameraInfo.setHandler(
      implementations.handlerCameraInfo,
    );

    implementations.channelImageFormat.setHandler(
      implementations.handlerImageFormat,
    );

    implementations.channelOnErrorCallback.setHandler(
      implementations.handlerOnErrorCallback,
    );

    implementations.channelOnAutoFocusCallback.setHandler(
      implementations.handlerOnAutoFocusCallback,
    );

    implementations.channelOnShutterCallback.setHandler(
      implementations.handlerOnShutterCallback,
    );

    implementations.channelOnZoomChangeCallback.setHandler(
      implementations.handlerOnZoomChangeCallback,
    );

    implementations.channelOnAutoFocusMovingCallback.setHandler(
      implementations.handlerOnAutoFocusMovingCallback,
    );

    implementations.channelOnPictureTakenCallback.setHandler(
      implementations.handlerOnPictureTakenCallback,
    );

    implementations.channelOnPreviewFrameCallback.setHandler(
      implementations.handlerOnPreviewFrameCallback,
    );
  }

  void unregisterHandlers() {
    implementations.channelErrorCallback.removeHandler();

    implementations.channelAutoFocusCallback.removeHandler();

    implementations.channelShutterCallback.removeHandler();

    implementations.channelOnZoomChangeListener.removeHandler();

    implementations.channelAutoFocusMoveCallback.removeHandler();

    implementations.channelPictureCallback.removeHandler();

    implementations.channelPreviewCallback.removeHandler();

    implementations.channelCamera.removeHandler();

    implementations.channelCameraParameters.removeHandler();

    implementations.channelCameraArea.removeHandler();

    implementations.channelCameraRect.removeHandler();

    implementations.channelCameraSize.removeHandler();

    implementations.channelCameraInfo.removeHandler();

    implementations.channelImageFormat.removeHandler();

    implementations.channelOnErrorCallback.removeHandler();

    implementations.channelOnAutoFocusCallback.removeHandler();

    implementations.channelOnShutterCallback.removeHandler();

    implementations.channelOnZoomChangeCallback.removeHandler();

    implementations.channelOnAutoFocusMovingCallback.removeHandler();

    implementations.channelOnPictureTakenCallback.removeHandler();

    implementations.channelOnPreviewFrameCallback.removeHandler();
  }
}
