// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import 'dart:typed_data';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

typedef $ErrorCallback = dynamic Function(
  int error,
);

typedef $AutoFocusCallback = dynamic Function(
  bool success,
);

typedef $ShutterCallback = dynamic Function();

typedef $DataCallback = dynamic Function(
  Uint8List data,
);

typedef $OnZoomChangeListener = dynamic Function(
  int zoomValue,
  bool stopped,
);

typedef $AutoFocusMoveCallback = dynamic Function(
  bool start,
);

typedef $OnErrorListener = dynamic Function(
  int what,
  int extra,
);

typedef $OnInfoListener = dynamic Function(
  int what,
  int extra,
);

class $ErrorCallbackChannel extends TypeChannel<Object> {
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

  Future<Object?> _invoke(
    $ErrorCallback $instance,
    int error,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        error,
      ],
    );
  }
}

class $AutoFocusCallbackChannel extends TypeChannel<Object> {
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

  Future<Object?> _invoke(
    $AutoFocusCallback $instance,
    bool success,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        success,
      ],
    );
  }
}

class $ShutterCallbackChannel extends TypeChannel<Object> {
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

  Future<Object?> _invoke(
    $ShutterCallback $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[],
    );
  }
}

class $DataCallbackChannel extends TypeChannel<Object> {
  $DataCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/DataCallback');

  Future<PairedInstance?> $$create(
    $DataCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $DataCallback $instance,
    Uint8List data,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        data,
      ],
    );
  }
}

class $OnZoomChangeListenerChannel extends TypeChannel<Object> {
  $OnZoomChangeListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/OnZoomChangeListener');

  Future<PairedInstance?> $$create(
    $OnZoomChangeListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $OnZoomChangeListener $instance,
    int zoomValue,
    bool stopped,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        zoomValue,
        stopped,
      ],
    );
  }
}

class $AutoFocusMoveCallbackChannel extends TypeChannel<Object> {
  $AutoFocusMoveCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/AutoFocusMoveCallback');

  Future<PairedInstance?> $$create(
    $AutoFocusMoveCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $AutoFocusMoveCallback $instance,
    bool start,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        start,
      ],
    );
  }
}

class $OnErrorListenerChannel extends TypeChannel<Object> {
  $OnErrorListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/OnErrorListener');

  Future<PairedInstance?> $$create(
    $OnErrorListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $OnErrorListener $instance,
    int what,
    int extra,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        what,
        extra,
      ],
    );
  }
}

class $OnInfoListenerChannel extends TypeChannel<Object> {
  $OnInfoListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/OnInfoListener');

  Future<PairedInstance?> $$create(
    $OnInfoListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $OnInfoListener $instance,
    int what,
    int extra,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        what,
        extra,
      ],
    );
  }
}

class $ErrorCallbackHandler implements TypeChannelHandler<Object> {
  $ErrorCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $ErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int error,
    ) {
      implementations.channelErrorCallback._invoke(
        function,
        error,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $ErrorCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
    );
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

class $AutoFocusCallbackHandler implements TypeChannelHandler<Object> {
  $AutoFocusCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $AutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      bool success,
    ) {
      implementations.channelAutoFocusCallback._invoke(
        function,
        success,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $AutoFocusCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as bool,
    );
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

class $ShutterCallbackHandler implements TypeChannelHandler<Object> {
  $ShutterCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $ShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function() {
      implementations.channelShutterCallback._invoke(
        function,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $ShutterCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance();
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

class $DataCallbackHandler implements TypeChannelHandler<Object> {
  $DataCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $DataCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      Uint8List data,
    ) {
      implementations.channelDataCallback._invoke(
        function,
        data,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $DataCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as Uint8List,
    );
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

class $OnZoomChangeListenerHandler implements TypeChannelHandler<Object> {
  $OnZoomChangeListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $OnZoomChangeListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int zoomValue,
      bool stopped,
    ) {
      implementations.channelOnZoomChangeListener._invoke(
        function,
        zoomValue,
        stopped,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $OnZoomChangeListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
      arguments[1] as bool,
    );
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

class $AutoFocusMoveCallbackHandler implements TypeChannelHandler<Object> {
  $AutoFocusMoveCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $AutoFocusMoveCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      bool start,
    ) {
      implementations.channelAutoFocusMoveCallback._invoke(
        function,
        start,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $AutoFocusMoveCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as bool,
    );
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

class $OnErrorListenerHandler implements TypeChannelHandler<Object> {
  $OnErrorListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $OnErrorListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int what,
      int extra,
    ) {
      implementations.channelOnErrorListener._invoke(
        function,
        what,
        extra,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $OnErrorListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
      arguments[1] as int,
    );
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

class $OnInfoListenerHandler implements TypeChannelHandler<Object> {
  $OnInfoListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $OnInfoListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int what,
      int extra,
    ) {
      implementations.channelOnInfoListener._invoke(
        function,
        what,
        extra,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $OnInfoListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
      arguments[1] as int,
    );
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

mixin $PictureCallback {}

mixin $PreviewCallback {}

mixin $Camera {}

mixin $CameraParameters {}

mixin $CameraArea {}

mixin $CameraRect {}

mixin $CameraSize {}

mixin $CameraInfo {}

mixin $MediaRecorder {}

mixin $ImageFormat {}

mixin $CamcorderProfile {}

class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
  $PictureCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/PictureCallback');

  Future<PairedInstance?> $$create(
    $PictureCallback $instance, {
    required bool $owner,
    required $DataCallback onPictureTaken,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        onPictureTaken,
      ],
      owner: $owner,
    );
  }
}

class $PreviewCallbackChannel extends TypeChannel<$PreviewCallback> {
  $PreviewCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/PreviewCallback');

  Future<PairedInstance?> $$create(
    $PreviewCallback $instance, {
    required bool $owner,
    required $DataCallback onPreviewFrame,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        onPreviewFrame,
      ],
      owner: $owner,
    );
  }
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

  Future<Object?> $getAllCameraInfo() {
    return sendInvokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[],
    );
  }

  Future<Object?> $open(
    int cameraId,
  ) {
    return sendInvokeStaticMethod(
      'open',
      <Object?>[
        cameraId,
      ],
    );
  }

  Future<Object?> $release(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'release',
      <Object?>[],
    );
  }

  Future<Object?> $startPreview(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'startPreview',
      <Object?>[],
    );
  }

  Future<Object?> $stopPreview(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'stopPreview',
      <Object?>[],
    );
  }

  Future<Object?> $attachPreviewTexture(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'attachPreviewTexture',
      <Object?>[],
    );
  }

  Future<Object?> $releasePreviewTexture(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'releasePreviewTexture',
      <Object?>[],
    );
  }

  Future<Object?> $unlock(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'unlock',
      <Object?>[],
    );
  }

  Future<Object?> $setOneShotPreviewCallback(
    $Camera $instance,
    $PreviewCallback callback,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOneShotPreviewCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<Object?> $setPreviewCallback(
    $Camera $instance,
    $PreviewCallback callback,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPreviewCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<Object?> $reconnect(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'reconnect',
      <Object?>[],
    );
  }

  Future<Object?> $takePicture(
    $Camera $instance,
    $ShutterCallback? shutter,
    $PictureCallback? raw,
    $PictureCallback? postView,
    $PictureCallback? jpeg,
  ) {
    return sendInvokeMethod(
      $instance,
      'takePicture',
      <Object?>[
        shutter,
        raw,
        postView,
        jpeg,
      ],
    );
  }

  Future<Object?> $autoFocus(
    $Camera $instance,
    $AutoFocusCallback callback,
  ) {
    return sendInvokeMethod(
      $instance,
      'autoFocus',
      <Object?>[
        callback,
      ],
    );
  }

  Future<Object?> $cancelAutoFocus(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'cancelAutoFocus',
      <Object?>[],
    );
  }

  Future<Object?> $setDisplayOrientation(
    $Camera $instance,
    int degrees,
  ) {
    return sendInvokeMethod(
      $instance,
      'setDisplayOrientation',
      <Object?>[
        degrees,
      ],
    );
  }

  Future<Object?> $setErrorCallback(
    $Camera $instance,
    $ErrorCallback callback,
  ) {
    return sendInvokeMethod(
      $instance,
      'setErrorCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<Object?> $startSmoothZoom(
    $Camera $instance,
    int value,
  ) {
    return sendInvokeMethod(
      $instance,
      'startSmoothZoom',
      <Object?>[
        value,
      ],
    );
  }

  Future<Object?> $stopSmoothZoom(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'stopSmoothZoom',
      <Object?>[],
    );
  }

  Future<Object?> $getParameters(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getParameters',
      <Object?>[],
    );
  }

  Future<Object?> $setParameters(
    $Camera $instance,
    $CameraParameters parameters,
  ) {
    return sendInvokeMethod(
      $instance,
      'setParameters',
      <Object?>[
        parameters,
      ],
    );
  }

  Future<Object?> $setZoomChangeListener(
    $Camera $instance,
    $OnZoomChangeListener listener,
  ) {
    return sendInvokeMethod(
      $instance,
      'setZoomChangeListener',
      <Object?>[
        listener,
      ],
    );
  }

  Future<Object?> $setAutoFocusMoveCallback(
    $Camera $instance,
    $AutoFocusMoveCallback callback,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAutoFocusMoveCallback',
      <Object?>[
        callback,
      ],
    );
  }

  Future<Object?> $lock(
    $Camera $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'lock',
      <Object?>[],
    );
  }

  Future<Object?> $enableShutterSound(
    $Camera $instance,
    bool enabled,
  ) {
    return sendInvokeMethod(
      $instance,
      'enableShutterSound',
      <Object?>[
        enabled,
      ],
    );
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

  Future<Object?> $getAutoExposureLock(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getAutoExposureLock',
      <Object?>[],
    );
  }

  Future<Object?> $getFocusAreas(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocusAreas',
      <Object?>[],
    );
  }

  Future<Object?> $getFocusDistances(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocusDistances',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxExposureCompensation(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxNumFocusAreas(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxNumFocusAreas',
      <Object?>[],
    );
  }

  Future<Object?> $getMinExposureCompensation(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMinExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedFocusModes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedFocusModes',
      <Object?>[],
    );
  }

  Future<Object?> $isAutoExposureLockSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isAutoExposureLockSupported',
      <Object?>[],
    );
  }

  Future<Object?> $isZoomSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isZoomSupported',
      <Object?>[],
    );
  }

  Future<Object?> $setAutoExposureLock(
    $CameraParameters $instance,
    bool toggle,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAutoExposureLock',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<Object?> $setExposureCompensation(
    $CameraParameters $instance,
    int value,
  ) {
    return sendInvokeMethod(
      $instance,
      'setExposureCompensation',
      <Object?>[
        value,
      ],
    );
  }

  Future<Object?> $setFocusAreas(
    $CameraParameters $instance,
    List<$CameraArea>? focusAreas,
  ) {
    return sendInvokeMethod(
      $instance,
      'setFocusAreas',
      <Object?>[
        focusAreas,
      ],
    );
  }

  Future<Object?> $setFocusMode(
    $CameraParameters $instance,
    String value,
  ) {
    return sendInvokeMethod(
      $instance,
      'setFocusMode',
      <Object?>[
        value,
      ],
    );
  }

  Future<Object?> $getFlashMode(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getFlashMode',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxZoom(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxZoom',
      <Object?>[],
    );
  }

  Future<Object?> $getPictureSize(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPictureSize',
      <Object?>[],
    );
  }

  Future<Object?> $getPreviewSize(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPreviewSize',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedPreviewSizes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPreviewSizes',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedPictureSizes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPictureSizes',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedFlashModes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedFlashModes',
      <Object?>[],
    );
  }

  Future<Object?> $getZoom(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getZoom',
      <Object?>[],
    );
  }

  Future<Object?> $isSmoothZoomSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isSmoothZoomSupported',
      <Object?>[],
    );
  }

  Future<Object?> $setFlashMode(
    $CameraParameters $instance,
    String mode,
  ) {
    return sendInvokeMethod(
      $instance,
      'setFlashMode',
      <Object?>[
        mode,
      ],
    );
  }

  Future<Object?> $setPictureSize(
    $CameraParameters $instance,
    int width,
    int height,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPictureSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<Object?> $setRecordingHint(
    $CameraParameters $instance,
    bool hint,
  ) {
    return sendInvokeMethod(
      $instance,
      'setRecordingHint',
      <Object?>[
        hint,
      ],
    );
  }

  Future<Object?> $setRotation(
    $CameraParameters $instance,
    int rotation,
  ) {
    return sendInvokeMethod(
      $instance,
      'setRotation',
      <Object?>[
        rotation,
      ],
    );
  }

  Future<Object?> $setZoom(
    $CameraParameters $instance,
    int value,
  ) {
    return sendInvokeMethod(
      $instance,
      'setZoom',
      <Object?>[
        value,
      ],
    );
  }

  Future<Object?> $setPreviewSize(
    $CameraParameters $instance,
    int width,
    int height,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPreviewSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<Object?> $getExposureCompensation(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getExposureCompensation',
      <Object?>[],
    );
  }

  Future<Object?> $getExposureCompensationStep(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getExposureCompensationStep',
      <Object?>[],
    );
  }

  Future<Object?> $flatten(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'flatten',
      <Object?>[],
    );
  }

  Future<Object?> $get(
    $CameraParameters $instance,
    String key,
  ) {
    return sendInvokeMethod(
      $instance,
      'get',
      <Object?>[
        key,
      ],
    );
  }

  Future<Object?> $getAntibanding(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getAntibanding',
      <Object?>[],
    );
  }

  Future<Object?> $getAutoWhiteBalanceLock(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getAutoWhiteBalanceLock',
      <Object?>[],
    );
  }

  Future<Object?> $getColorEffect(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getColorEffect',
      <Object?>[],
    );
  }

  Future<Object?> $getFocalLength(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocalLength',
      <Object?>[],
    );
  }

  Future<Object?> $getFocusMode(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocusMode',
      <Object?>[],
    );
  }

  Future<Object?> $getHorizontalViewAngle(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getHorizontalViewAngle',
      <Object?>[],
    );
  }

  Future<Object?> $getInt(
    $CameraParameters $instance,
    String key,
  ) {
    return sendInvokeMethod(
      $instance,
      'getInt',
      <Object?>[
        key,
      ],
    );
  }

  Future<Object?> $getJpegQuality(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getJpegQuality',
      <Object?>[],
    );
  }

  Future<Object?> $getJpegThumbnailQuality(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getJpegThumbnailQuality',
      <Object?>[],
    );
  }

  Future<Object?> $getJpegThumbnailSize(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getJpegThumbnailSize',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxNumMeteringAreas(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxNumMeteringAreas',
      <Object?>[],
    );
  }

  Future<Object?> $getMeteringAreas(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMeteringAreas',
      <Object?>[],
    );
  }

  Future<Object?> $getPictureFormat(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPictureFormat',
      <Object?>[],
    );
  }

  Future<Object?> $getPreferredPreviewSizeForVideo(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPreferredPreviewSizeForVideo',
      <Object?>[],
    );
  }

  Future<Object?> $getPreviewFormat(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPreviewFormat',
      <Object?>[],
    );
  }

  Future<Object?> $getPreviewFpsRange(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getPreviewFpsRange',
      <Object?>[],
    );
  }

  Future<Object?> $getSceneMode(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSceneMode',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedAntibanding(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedAntibanding',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedColorEffects(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedColorEffects',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedJpegThumbnailSizes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedJpegThumbnailSizes',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedPictureFormats(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPictureFormats',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedPreviewFormats(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPreviewFormats',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedPreviewFpsRange(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPreviewFpsRange',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedSceneModes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedSceneModes',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedVideoSizes(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedVideoSizes',
      <Object?>[],
    );
  }

  Future<Object?> $getSupportedWhiteBalance(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedWhiteBalance',
      <Object?>[],
    );
  }

  Future<Object?> $getVerticalViewAngle(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getVerticalViewAngle',
      <Object?>[],
    );
  }

  Future<Object?> $getVideoStabilization(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getVideoStabilization',
      <Object?>[],
    );
  }

  Future<Object?> $getWhiteBalance(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getWhiteBalance',
      <Object?>[],
    );
  }

  Future<Object?> $getZoomRatios(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getZoomRatios',
      <Object?>[],
    );
  }

  Future<Object?> $isAutoWhiteBalanceLockSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isAutoWhiteBalanceLockSupported',
      <Object?>[],
    );
  }

  Future<Object?> $isVideoSnapshotSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isVideoSnapshotSupported',
      <Object?>[],
    );
  }

  Future<Object?> $isVideoStabilizationSupported(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'isVideoStabilizationSupported',
      <Object?>[],
    );
  }

  Future<Object?> $remove(
    $CameraParameters $instance,
    String key,
  ) {
    return sendInvokeMethod(
      $instance,
      'remove',
      <Object?>[
        key,
      ],
    );
  }

  Future<Object?> $removeGpsData(
    $CameraParameters $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'removeGpsData',
      <Object?>[],
    );
  }

  Future<Object?> $set(
    $CameraParameters $instance,
    String key,
    Object value,
  ) {
    return sendInvokeMethod(
      $instance,
      'set',
      <Object?>[
        key,
        value,
      ],
    );
  }

  Future<Object?> $setAntibanding(
    $CameraParameters $instance,
    String antibanding,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAntibanding',
      <Object?>[
        antibanding,
      ],
    );
  }

  Future<Object?> $setAutoWhiteBalanceLock(
    $CameraParameters $instance,
    bool toggle,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAutoWhiteBalanceLock',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<Object?> $setColorEffect(
    $CameraParameters $instance,
    String effect,
  ) {
    return sendInvokeMethod(
      $instance,
      'setColorEffect',
      <Object?>[
        effect,
      ],
    );
  }

  Future<Object?> $setGpsAltitude(
    $CameraParameters $instance,
    double meters,
  ) {
    return sendInvokeMethod(
      $instance,
      'setGpsAltitude',
      <Object?>[
        meters,
      ],
    );
  }

  Future<Object?> $setGpsLatitude(
    $CameraParameters $instance,
    double latitude,
  ) {
    return sendInvokeMethod(
      $instance,
      'setGpsLatitude',
      <Object?>[
        latitude,
      ],
    );
  }

  Future<Object?> $setGpsLongitude(
    $CameraParameters $instance,
    double longitude,
  ) {
    return sendInvokeMethod(
      $instance,
      'setGpsLongitude',
      <Object?>[
        longitude,
      ],
    );
  }

  Future<Object?> $setGpsProcessingMethod(
    $CameraParameters $instance,
    String processingMethod,
  ) {
    return sendInvokeMethod(
      $instance,
      'setGpsProcessingMethod',
      <Object?>[
        processingMethod,
      ],
    );
  }

  Future<Object?> $setGpsTimestamp(
    $CameraParameters $instance,
    int timestamp,
  ) {
    return sendInvokeMethod(
      $instance,
      'setGpsTimestamp',
      <Object?>[
        timestamp,
      ],
    );
  }

  Future<Object?> $setJpegQuality(
    $CameraParameters $instance,
    int quality,
  ) {
    return sendInvokeMethod(
      $instance,
      'setJpegQuality',
      <Object?>[
        quality,
      ],
    );
  }

  Future<Object?> $setJpegThumbnailQuality(
    $CameraParameters $instance,
    int quality,
  ) {
    return sendInvokeMethod(
      $instance,
      'setJpegThumbnailQuality',
      <Object?>[
        quality,
      ],
    );
  }

  Future<Object?> $setJpegThumbnailSize(
    $CameraParameters $instance,
    int width,
    int height,
  ) {
    return sendInvokeMethod(
      $instance,
      'setJpegThumbnailSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<Object?> $setMeteringAreas(
    $CameraParameters $instance,
    List<$CameraArea> meteringAreas,
  ) {
    return sendInvokeMethod(
      $instance,
      'setMeteringAreas',
      <Object?>[
        meteringAreas,
      ],
    );
  }

  Future<Object?> $setPictureFormat(
    $CameraParameters $instance,
    int pixelFormat,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPictureFormat',
      <Object?>[
        pixelFormat,
      ],
    );
  }

  Future<Object?> $setPreviewFormat(
    $CameraParameters $instance,
    int pixelFormat,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPreviewFormat',
      <Object?>[
        pixelFormat,
      ],
    );
  }

  Future<Object?> $setPreviewFpsRange(
    $CameraParameters $instance,
    int min,
    int max,
  ) {
    return sendInvokeMethod(
      $instance,
      'setPreviewFpsRange',
      <Object?>[
        min,
        max,
      ],
    );
  }

  Future<Object?> $setSceneMode(
    $CameraParameters $instance,
    String mode,
  ) {
    return sendInvokeMethod(
      $instance,
      'setSceneMode',
      <Object?>[
        mode,
      ],
    );
  }

  Future<Object?> $setVideoStabilization(
    $CameraParameters $instance,
    bool toggle,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoStabilization',
      <Object?>[
        toggle,
      ],
    );
  }

  Future<Object?> $setWhiteBalance(
    $CameraParameters $instance,
    String value,
  ) {
    return sendInvokeMethod(
      $instance,
      'setWhiteBalance',
      <Object?>[
        value,
      ],
    );
  }

  Future<Object?> $unflatten(
    $CameraParameters $instance,
    String flattened,
  ) {
    return sendInvokeMethod(
      $instance,
      'unflatten',
      <Object?>[
        flattened,
      ],
    );
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

class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
  $CameraInfoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/CameraInfo');

  Future<PairedInstance?> $$create(
    $CameraInfo $instance, {
    required bool $owner,
    required int cameraId,
    required int facing,
    required int orientation,
    required bool? canDisableShutterSound,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        cameraId,
        facing,
        orientation,
        canDisableShutterSound,
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

  Future<Object?> $getAudioSourceMax() {
    return sendInvokeStaticMethod(
      'getAudioSourceMax',
      <Object?>[],
    );
  }

  Future<Object?> $setCamera(
    $MediaRecorder $instance,
    $Camera camera,
  ) {
    return sendInvokeMethod(
      $instance,
      'setCamera',
      <Object?>[
        camera,
      ],
    );
  }

  Future<Object?> $setVideoSource(
    $MediaRecorder $instance,
    int source,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoSource',
      <Object?>[
        source,
      ],
    );
  }

  Future<Object?> $setOutputFilePath(
    $MediaRecorder $instance,
    String path,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOutputFilePath',
      <Object?>[
        path,
      ],
    );
  }

  Future<Object?> $setOutputFormat(
    $MediaRecorder $instance,
    int format,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOutputFormat',
      <Object?>[
        format,
      ],
    );
  }

  Future<Object?> $setVideoEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoEncoder',
      <Object?>[
        encoder,
      ],
    );
  }

  Future<Object?> $setAudioSource(
    $MediaRecorder $instance,
    int source,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioSource',
      <Object?>[
        source,
      ],
    );
  }

  Future<Object?> $setAudioEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioEncoder',
      <Object?>[
        encoder,
      ],
    );
  }

  Future<Object?> $prepare(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'prepare',
      <Object?>[],
    );
  }

  Future<Object?> $start(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'start',
      <Object?>[],
    );
  }

  Future<Object?> $stop(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'stop',
      <Object?>[],
    );
  }

  Future<Object?> $release(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'release',
      <Object?>[],
    );
  }

  Future<Object?> $pause(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'pause',
      <Object?>[],
    );
  }

  Future<Object?> $resume(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'resume',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxAmplitude(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxAmplitude',
      <Object?>[],
    );
  }

  Future<Object?> $reset(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'reset',
      <Object?>[],
    );
  }

  Future<Object?> $setAudioChannels(
    $MediaRecorder $instance,
    int numChannels,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioChannels',
      <Object?>[
        numChannels,
      ],
    );
  }

  Future<Object?> $setAudioEncodingBitRate(
    $MediaRecorder $instance,
    int bitRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioEncodingBitRate',
      <Object?>[
        bitRate,
      ],
    );
  }

  Future<Object?> $setAudioSamplingRate(
    $MediaRecorder $instance,
    int samplingRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioSamplingRate',
      <Object?>[
        samplingRate,
      ],
    );
  }

  Future<Object?> $setCaptureRate(
    $MediaRecorder $instance,
    double fps,
  ) {
    return sendInvokeMethod(
      $instance,
      'setCaptureRate',
      <Object?>[
        fps,
      ],
    );
  }

  Future<Object?> $setLocation(
    $MediaRecorder $instance,
    double latitude,
    double longitude,
  ) {
    return sendInvokeMethod(
      $instance,
      'setLocation',
      <Object?>[
        latitude,
        longitude,
      ],
    );
  }

  Future<Object?> $setMaxDuration(
    $MediaRecorder $instance,
    int maxDurationMs,
  ) {
    return sendInvokeMethod(
      $instance,
      'setMaxDuration',
      <Object?>[
        maxDurationMs,
      ],
    );
  }

  Future<Object?> $setMaxFileSize(
    $MediaRecorder $instance,
    int maxFilesizeBytes,
  ) {
    return sendInvokeMethod(
      $instance,
      'setMaxFileSize',
      <Object?>[
        maxFilesizeBytes,
      ],
    );
  }

  Future<Object?> $setOnErrorListener(
    $MediaRecorder $instance,
    $OnErrorListener onError,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOnErrorListener',
      <Object?>[
        onError,
      ],
    );
  }

  Future<Object?> $setOnInfoListener(
    $MediaRecorder $instance,
    $OnInfoListener onInfo,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOnInfoListener',
      <Object?>[
        onInfo,
      ],
    );
  }

  Future<Object?> $setOrientationHint(
    $MediaRecorder $instance,
    int degrees,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOrientationHint',
      <Object?>[
        degrees,
      ],
    );
  }

  Future<Object?> $setVideoEncodingBitRate(
    $MediaRecorder $instance,
    int bitRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoEncodingBitRate',
      <Object?>[
        bitRate,
      ],
    );
  }

  Future<Object?> $setVideoFrameRate(
    $MediaRecorder $instance,
    int rate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoFrameRate',
      <Object?>[
        rate,
      ],
    );
  }

  Future<Object?> $setVideoSize(
    $MediaRecorder $instance,
    int width,
    int height,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<Object?> $setProfile(
    $MediaRecorder $instance,
    $CamcorderProfile profile,
  ) {
    return sendInvokeMethod(
      $instance,
      'setProfile',
      <Object?>[
        profile,
      ],
    );
  }
}

class $ImageFormatChannel extends TypeChannel<$ImageFormat> {
  $ImageFormatChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ImageFormat');

  Future<PairedInstance?> $$create(
    $ImageFormat $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> $getBitsPerPixel(
    int format,
  ) {
    return sendInvokeStaticMethod(
      'getBitsPerPixel',
      <Object?>[
        format,
      ],
    );
  }
}

class $CamcorderProfileChannel extends TypeChannel<$CamcorderProfile> {
  $CamcorderProfileChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_android_camera/camera/ImageFormat');

  Future<PairedInstance?> $$create(
    $CamcorderProfile $instance, {
    required bool $owner,
    required int audioBitRate,
    required int audioChannels,
    required int audioCodec,
    required int audioSampleRate,
    required int duration,
    required int fileFormat,
    required int quality,
    required int videoBitRate,
    required int videoCodec,
    required int videoFrameHeight,
    required int videoFrameRate,
    required int videoFrameWidth,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        audioBitRate,
        audioChannels,
        audioCodec,
        audioSampleRate,
        duration,
        fileFormat,
        quality,
        videoBitRate,
        videoCodec,
        videoFrameHeight,
        videoFrameRate,
        videoFrameWidth,
      ],
      owner: $owner,
    );
  }

  Future<Object?> $get(
    int cameraId,
    int quality,
  ) {
    return sendInvokeStaticMethod(
      'get',
      <Object?>[
        cameraId,
        quality,
      ],
    );
  }

  Future<Object?> $hasProfile(
    int cameraId,
    int quality,
  ) {
    return sendInvokeStaticMethod(
      'hasProfile',
      <Object?>[
        cameraId,
        quality,
      ],
    );
  }
}

class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
  $PictureCallback $$create(
    TypeChannelMessenger messenger,
    $DataCallback onPictureTaken,
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
  $PictureCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $DataCallback,
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
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $PreviewCallbackHandler implements TypeChannelHandler<$PreviewCallback> {
  $PreviewCallback $$create(
    TypeChannelMessenger messenger,
    $DataCallback onPreviewFrame,
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
  $PreviewCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $DataCallback,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $PreviewCallback instance,
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

class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
  $CameraInfo $$create(
    TypeChannelMessenger messenger,
    int cameraId,
    int facing,
    int orientation,
    bool? canDisableShutterSound,
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
      arguments[3] as bool?,
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
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $ImageFormatHandler implements TypeChannelHandler<$ImageFormat> {
  $ImageFormat $$create(
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
  $ImageFormat createInstance(
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
    $ImageFormat instance,
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

class $CamcorderProfileHandler
    implements TypeChannelHandler<$CamcorderProfile> {
  $CamcorderProfile $$create(
    TypeChannelMessenger messenger,
    int audioBitRate,
    int audioChannels,
    int audioCodec,
    int audioSampleRate,
    int duration,
    int fileFormat,
    int quality,
    int videoBitRate,
    int videoCodec,
    int videoFrameHeight,
    int videoFrameRate,
    int videoFrameWidth,
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
  $CamcorderProfile createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as int,
      arguments[1] as int,
      arguments[2] as int,
      arguments[3] as int,
      arguments[4] as int,
      arguments[5] as int,
      arguments[6] as int,
      arguments[7] as int,
      arguments[8] as int,
      arguments[9] as int,
      arguments[10] as int,
      arguments[11] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CamcorderProfile instance,
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

  $PictureCallbackChannel get channelPictureCallback =>
      $PictureCallbackChannel(messenger);
  $PictureCallbackHandler get handlerPictureCallback =>
      $PictureCallbackHandler();

  $PreviewCallbackChannel get channelPreviewCallback =>
      $PreviewCallbackChannel(messenger);
  $PreviewCallbackHandler get handlerPreviewCallback =>
      $PreviewCallbackHandler();

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

  $CameraInfoChannel get channelCameraInfo => $CameraInfoChannel(messenger);
  $CameraInfoHandler get handlerCameraInfo => $CameraInfoHandler();

  $MediaRecorderChannel get channelMediaRecorder =>
      $MediaRecorderChannel(messenger);
  $MediaRecorderHandler get handlerMediaRecorder => $MediaRecorderHandler();

  $ImageFormatChannel get channelImageFormat => $ImageFormatChannel(messenger);
  $ImageFormatHandler get handlerImageFormat => $ImageFormatHandler();

  $CamcorderProfileChannel get channelCamcorderProfile =>
      $CamcorderProfileChannel(messenger);
  $CamcorderProfileHandler get handlerCamcorderProfile =>
      $CamcorderProfileHandler();

  $ErrorCallbackChannel get channelErrorCallback =>
      $ErrorCallbackChannel(messenger);
  $ErrorCallbackHandler get handlerErrorCallback => $ErrorCallbackHandler(this);

  $AutoFocusCallbackChannel get channelAutoFocusCallback =>
      $AutoFocusCallbackChannel(messenger);
  $AutoFocusCallbackHandler get handlerAutoFocusCallback =>
      $AutoFocusCallbackHandler(this);

  $ShutterCallbackChannel get channelShutterCallback =>
      $ShutterCallbackChannel(messenger);
  $ShutterCallbackHandler get handlerShutterCallback =>
      $ShutterCallbackHandler(this);

  $DataCallbackChannel get channelDataCallback =>
      $DataCallbackChannel(messenger);
  $DataCallbackHandler get handlerDataCallback => $DataCallbackHandler(this);

  $OnZoomChangeListenerChannel get channelOnZoomChangeListener =>
      $OnZoomChangeListenerChannel(messenger);
  $OnZoomChangeListenerHandler get handlerOnZoomChangeListener =>
      $OnZoomChangeListenerHandler(this);

  $AutoFocusMoveCallbackChannel get channelAutoFocusMoveCallback =>
      $AutoFocusMoveCallbackChannel(messenger);
  $AutoFocusMoveCallbackHandler get handlerAutoFocusMoveCallback =>
      $AutoFocusMoveCallbackHandler(this);

  $OnErrorListenerChannel get channelOnErrorListener =>
      $OnErrorListenerChannel(messenger);
  $OnErrorListenerHandler get handlerOnErrorListener =>
      $OnErrorListenerHandler(this);

  $OnInfoListenerChannel get channelOnInfoListener =>
      $OnInfoListenerChannel(messenger);
  $OnInfoListenerHandler get handlerOnInfoListener =>
      $OnInfoListenerHandler(this);
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
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

    implementations.channelMediaRecorder.setHandler(
      implementations.handlerMediaRecorder,
    );

    implementations.channelImageFormat.setHandler(
      implementations.handlerImageFormat,
    );

    implementations.channelCamcorderProfile.setHandler(
      implementations.handlerCamcorderProfile,
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

    implementations.channelDataCallback.setHandler(
      implementations.handlerDataCallback,
    );

    implementations.channelOnZoomChangeListener.setHandler(
      implementations.handlerOnZoomChangeListener,
    );

    implementations.channelAutoFocusMoveCallback.setHandler(
      implementations.handlerAutoFocusMoveCallback,
    );

    implementations.channelOnErrorListener.setHandler(
      implementations.handlerOnErrorListener,
    );

    implementations.channelOnInfoListener.setHandler(
      implementations.handlerOnInfoListener,
    );
  }

  void unregisterHandlers() {
    implementations.channelPictureCallback.removeHandler();

    implementations.channelPreviewCallback.removeHandler();

    implementations.channelCamera.removeHandler();

    implementations.channelCameraParameters.removeHandler();

    implementations.channelCameraArea.removeHandler();

    implementations.channelCameraRect.removeHandler();

    implementations.channelCameraSize.removeHandler();

    implementations.channelCameraInfo.removeHandler();

    implementations.channelMediaRecorder.removeHandler();

    implementations.channelImageFormat.removeHandler();

    implementations.channelCamcorderProfile.removeHandler();

    implementations.channelErrorCallback.removeHandler();

    implementations.channelAutoFocusCallback.removeHandler();

    implementations.channelShutterCallback.removeHandler();

    implementations.channelDataCallback.removeHandler();

    implementations.channelOnZoomChangeListener.removeHandler();

    implementations.channelAutoFocusMoveCallback.removeHandler();

    implementations.channelOnErrorListener.removeHandler();

    implementations.channelOnInfoListener.removeHandler();
  }
}
