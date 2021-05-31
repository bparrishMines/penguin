// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import  'dart:typed_data' ;


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


mixin $Camera {
  void $release();
  
  void $startPreview(
    
  );
  
  void $stopPreview(
    
  );
  
  int $attachPreviewTexture(
    
  );
  
  void $releasePreviewTexture(
    
  );
  
  void $unlock(
    
  );
  
  void $reconnect(
    
  );
  
  void $takePicture(
     $ShutterCallback? shutter,
     $PictureCallback? raw,
     $PictureCallback? postView,
     $PictureCallback? jpeg,
    
  );
  
  void $autoFocus(
     $AutoFocusCallback callback,
    
  );
  
  void $cancelAutoFocus(
    
  );
  
  void $setDisplayOrientation(
     int degrees,
    
  );
  
  void $setErrorCallback(
     $ErrorCallback callback,
    
  );
  
  void $startSmoothZoom(
     int value,
    
  );
  
  void $stopSmoothZoom(
    
  );
  
  $CameraParameters $getParameters(
    
  );
  
  void $setParameters(
     $CameraParameters parameters,
    
  );
  
}

mixin $CameraParameters {
  
  bool $getAutoExposureLock(
    
  );
  
  List<$CameraArea>? $getFocusAreas(
    
  );
  
  List<double> $getFocusDistances(
    
  );
  
  int $getMaxExposureCompensation(
    
  );
  
  int $getMaxNumFocusAreas(
    
  );
  
  int $getMinExposureCompensation(
    
  );
  
  List<String> $getSupportedFocusModes(
    
  );
  
  bool $isAutoExposureLockSupported(
    
  );
  
  bool $isZoomSupported(
    
  );
  
  void $setAutoExposureLock(
     bool toggle,
    
  );
  
  void $setExposureCompensation(
     int value,
    
  );
  
  void $setFocusAreas(
     List<$CameraArea>? focusAreas,
    
  );
  
  void $setFocusMode(
     String value,
    
  );
  
  String? $getFlashMode(
    
  );
  
  int $getMaxZoom(
    
  );
  
  $CameraSize $getPictureSize(
    
  );
  
  $CameraSize $getPreviewSize(
    
  );
  
  List<$CameraSize> $getSupportedPreviewSizes(
    
  );
  
  List<$CameraSize> $getSupportedPictureSizes(
    
  );
  
  List<String> $getSupportedFlashModes(
    
  );
  
  int $getZoom(
    
  );
  
  bool $isSmoothZoomSupported(
    
  );
  
  void $setFlashMode(
     String mode,
    
  );
  
  void $setPictureSize(
     int width,
     int height,
    
  );
  
  void $setRecordingHint(
     bool hint,
    
  );
  
  void $setRotation(
     int rotation,
    
  );
  
  void $setZoom(
     int value,
    
  );
  
  void $setPreviewSize(
     int width,
     int height,
    
  );
  
  int $getExposureCompensation(
    
  );
  
  double $getExposureCompensationStep(
    
  );
  
}

mixin $CameraArea {
  
}

mixin $CameraRect {
  
}

mixin $CameraSize {
  
}

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
  
  void $onShutter(
    
  );
  
}

mixin $PictureCallback {
  
  void $onPictureTaken(
     Uint8List data,
    
  );
  
}

mixin $CameraInfo {
  
}

mixin $MediaRecorder {
  
  void $setCamera(
     $Camera camera,
    
  );
  
  void $setVideoSource(
     int source,
    
  );
  
  void $setOutputFilePath(
     String path,
    
  );
  
  void $setOutputFormat(
     int format,
    
  );
  
  void $setVideoEncoder(
     int encoder,
    
  );
  
  void $setAudioSource(
     int source,
    
  );
  
  void $setAudioEncoder(
     int encoder,
    
  );
  
  void $prepare(
    
  );
  
  void $start(
    
  );
  
  void $stop(
    
  );
  
  void $release(
    
  );
  
  void $pause(
    
  );
  
  void $resume(
    
  );
  
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  
  Future< List<$CameraInfo> > $getAllCameraInfo() async {
     await sendInvokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[],
    ) as List<$CameraInfo>;
  }
  
  Future< $Camera >
      $open(
     int cameraId,
    
  ) async {
     await sendInvokeStaticMethod(
      'open',
      <Object?>[
         cameraId, 
      ],
    ) as $Camera;
  }
  

  
  Future< void > $release(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'release',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $startPreview($Camera $instance,) async {
     return  await sendInvokeMethod(
      $instance,
      'startPreview',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $stopPreview(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'stopPreview',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< int > $attachPreviewTexture(
    $Camera $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'attachPreviewTexture',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< void > $releasePreviewTexture(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'releasePreviewTexture',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $unlock(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'unlock',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $reconnect(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'reconnect',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $takePicture(
    $Camera $instance,
     $ShutterCallback? shutter,
     $PictureCallback? raw,
     $PictureCallback? postView,
     $PictureCallback? jpeg,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'takePicture',
      <Object?>[
         shutter,  raw,  postView,  jpeg, 
      ],
    ) as void;
  }
  
  Future< void > $autoFocus(
    $Camera $instance,
     $AutoFocusCallback callback,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'autoFocus',
      <Object?>[
         callback, 
      ],
    ) as void;
  }
  
  Future< void > $cancelAutoFocus(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'cancelAutoFocus',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $setDisplayOrientation(
    $Camera $instance,
     int degrees,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setDisplayOrientation',
      <Object?>[
         degrees, 
      ],
    ) as void;
  }
  
  Future< void > $setErrorCallback(
    $Camera $instance,
     $ErrorCallback callback,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setErrorCallback',
      <Object?>[
         callback, 
      ],
    ) as void;
  }
  
  Future< void > $startSmoothZoom(
    $Camera $instance,
     int value,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'startSmoothZoom',
      <Object?>[
         value, 
      ],
    ) as void;
  }
  
  Future< void > $stopSmoothZoom(
    $Camera $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'stopSmoothZoom',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< $CameraParameters > $getParameters(
    $Camera $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getParameters',
      <Object?>[
        
      ],
    ) as $CameraParameters;
  }
  
  Future< void > $setParameters(
    $Camera $instance,
     $CameraParameters parameters,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setParameters',
      <Object?>[
         parameters, 
      ],
    ) as void;
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< bool > $getAutoExposureLock(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getAutoExposureLock',
      <Object?>[
        
      ],
    ) as bool;
  }
  
  Future< List<$CameraArea>? > $getFocusAreas(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getFocusAreas',
      <Object?>[
        
      ],
    ) as List<$CameraArea>?;
  }
  
  Future< List<double> > $getFocusDistances(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getFocusDistances',
      <Object?>[
        
      ],
    ) as List<double>;
  }
  
  Future< int > $getMaxExposureCompensation(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getMaxExposureCompensation',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< int > $getMaxNumFocusAreas(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getMaxNumFocusAreas',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< int > $getMinExposureCompensation(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getMinExposureCompensation',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< List<String> > $getSupportedFocusModes(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getSupportedFocusModes',
      <Object?>[
        
      ],
    ) as List<String>;
  }
  
  Future< bool > $isAutoExposureLockSupported(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'isAutoExposureLockSupported',
      <Object?>[
        
      ],
    ) as bool;
  }
  
  Future< bool > $isZoomSupported(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'isZoomSupported',
      <Object?>[
        
      ],
    ) as bool;
  }
  
  Future< void > $setAutoExposureLock(
    $CameraParameters $instance,
     bool toggle,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setAutoExposureLock',
      <Object?>[
         toggle, 
      ],
    ) as void;
  }
  
  Future< void > $setExposureCompensation(
    $CameraParameters $instance,
     int value,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setExposureCompensation',
      <Object?>[
         value, 
      ],
    ) as void;
  }
  
  Future< void > $setFocusAreas(
    $CameraParameters $instance,
     List<$CameraArea>? focusAreas,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setFocusAreas',
      <Object?>[
         focusAreas, 
      ],
    ) as void;
  }
  
  Future< void > $setFocusMode(
    $CameraParameters $instance,
     String value,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setFocusMode',
      <Object?>[
         value, 
      ],
    ) as void;
  }
  
  Future< String? > $getFlashMode(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getFlashMode',
      <Object?>[
        
      ],
    ) as String?;
  }
  
  Future< int > $getMaxZoom(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getMaxZoom',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< $CameraSize > $getPictureSize(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getPictureSize',
      <Object?>[
        
      ],
    ) as $CameraSize;
  }
  
  Future< $CameraSize > $getPreviewSize(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getPreviewSize',
      <Object?>[
        
      ],
    ) as $CameraSize;
  }
  
  Future< List<$CameraSize> > $getSupportedPreviewSizes(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getSupportedPreviewSizes',
      <Object?>[
        
      ],
    ) as List<$CameraSize>;
  }
  
  Future< List<$CameraSize> > $getSupportedPictureSizes(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getSupportedPictureSizes',
      <Object?>[
        
      ],
    ) as List<$CameraSize>;
  }
  
  Future< List<String> > $getSupportedFlashModes(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getSupportedFlashModes',
      <Object?>[
        
      ],
    ) as List<String>;
  }
  
  Future< int > $getZoom(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getZoom',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< bool > $isSmoothZoomSupported(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'isSmoothZoomSupported',
      <Object?>[
        
      ],
    ) as bool;
  }
  
  Future< void > $setFlashMode(
    $CameraParameters $instance,
     String mode,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setFlashMode',
      <Object?>[
         mode, 
      ],
    ) as void;
  }
  
  Future< void > $setPictureSize(
    $CameraParameters $instance,
     int width,
     int height,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setPictureSize',
      <Object?>[
         width,  height, 
      ],
    ) as void;
  }
  
  Future< void > $setRecordingHint(
    $CameraParameters $instance,
     bool hint,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setRecordingHint',
      <Object?>[
         hint, 
      ],
    ) as void;
  }
  
  Future< void > $setRotation(
    $CameraParameters $instance,
     int rotation,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setRotation',
      <Object?>[
         rotation, 
      ],
    ) as void;
  }
  
  Future< void > $setZoom(
    $CameraParameters $instance,
     int value,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setZoom',
      <Object?>[
         value, 
      ],
    ) as void;
  }
  
  Future< void > $setPreviewSize(
    $CameraParameters $instance,
     int width,
     int height,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setPreviewSize',
      <Object?>[
         width,  height, 
      ],
    ) as void;
  }
  
  Future< int > $getExposureCompensation(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getExposureCompensation',
      <Object?>[
        
      ],
    ) as int;
  }
  
  Future< double > $getExposureCompensationStep(
    $CameraParameters $instance,
    
  ) async {
     await sendInvokeMethod(
      $instance,
      'getExposureCompensationStep',
      <Object?>[
        
      ],
    ) as double;
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
         rect,  weight, 
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
         top,  bottom,  right,  left, 
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
         width,  height, 
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< void > $onError(
    $ErrorCallback $instance,
     int error,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'onError',
      <Object?>[
         error, 
      ],
    ) as void;
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< void > $onAutoFocus(
    $AutoFocusCallback $instance,
     bool success,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'onAutoFocus',
      <Object?>[
         success, 
      ],
    ) as void;
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< void > $onShutter(
    $ShutterCallback $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'onShutter',
      <Object?>[
        
      ],
    ) as void;
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< void > $onPictureTaken(
    $PictureCallback $instance,
     Uint8List data,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'onPictureTaken',
      <Object?>[
         data, 
      ],
    ) as void;
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
         cameraId,  facing,  orientation, 
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
      <Object?>[
        
      ],
      owner: $owner,
    );
  }

  

  
  Future< void > $setCamera(
    $MediaRecorder $instance,
     $Camera camera,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setCamera',
      <Object?>[
         camera, 
      ],
    ) as void;
  }
  
  Future< void > $setVideoSource(
    $MediaRecorder $instance,
     int source,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setVideoSource',
      <Object?>[
         source, 
      ],
    ) as void;
  }
  
  Future< void > $setOutputFilePath(
    $MediaRecorder $instance,
     String path,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setOutputFilePath',
      <Object?>[
         path, 
      ],
    ) as void;
  }
  
  Future< void > $setOutputFormat(
    $MediaRecorder $instance,
     int format,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setOutputFormat',
      <Object?>[
         format, 
      ],
    ) as void;
  }
  
  Future< void > $setVideoEncoder(
    $MediaRecorder $instance,
     int encoder,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setVideoEncoder',
      <Object?>[
         encoder, 
      ],
    ) as void;
  }
  
  Future< void > $setAudioSource(
    $MediaRecorder $instance,
     int source,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setAudioSource',
      <Object?>[
         source, 
      ],
    ) as void;
  }
  
  Future< void > $setAudioEncoder(
    $MediaRecorder $instance,
     int encoder,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'setAudioEncoder',
      <Object?>[
         encoder, 
      ],
    ) as void;
  }
  
  Future< void > $prepare(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'prepare',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $start(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'start',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $stop(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'stop',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $release(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'release',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $pause(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'pause',
      <Object?>[
        
      ],
    ) as void;
  }
  
  Future< void > $resume(
    $MediaRecorder $instance,
    
  ) async {
     return  await sendInvokeMethod(
      $instance,
      'resume',
      <Object?>[
        
      ],
    ) as void;
  }
  
}



class $CameraHandler implements TypeChannelHandler<$Camera> {
  $Camera $$create(
    TypeChannelMessenger messenger,
    
  ) {
    throw UnimplementedError();
  }

  
  List<$CameraInfo> $getAllCameraInfo(
    TypeChannelMessenger messenger,
    
  ) {
    throw UnimplementedError();
  }
  
  $Camera $open(
    TypeChannelMessenger messenger,
    
    int cameraId,
    
  ) {
    throw UnimplementedError();
  }
  

  
  void $release(
    $Camera $instance,
    
  ) {
     return  $instance.$release(
      
    );
  }
  
  void $startPreview(
    $Camera $instance,
    
  ) {
     return  $instance.$startPreview(
      
    );
  }
  
  void $stopPreview(
    $Camera $instance,
    
  ) {
     return  $instance.$stopPreview(
      
    );
  }
  
  int $attachPreviewTexture(
    $Camera $instance,
    
  ) {
     $instance.$attachPreviewTexture(
      
    );
  }
  
  void $releasePreviewTexture(
    $Camera $instance,
    
  ) {
     return  $instance.$releasePreviewTexture(
      
    );
  }
  
  void $unlock(
    $Camera $instance,
    
  ) {
     return  $instance.$unlock(
      
    );
  }
  
  void $reconnect(
    $Camera $instance,
    
  ) {
     return  $instance.$reconnect(
      
    );
  }
  
  void $takePicture(
    $Camera $instance,
    
    $ShutterCallback? shutter,
    
    $PictureCallback? raw,
    
    $PictureCallback? postView,
    
    $PictureCallback? jpeg,
    
  ) {
     return  $instance.$takePicture(
       shutter,  raw,  postView,  jpeg, 
    );
  }
  
  void $autoFocus(
    $Camera $instance,
    
    $AutoFocusCallback callback,
    
  ) {
     return  $instance.$autoFocus(
       callback, 
    );
  }
  
  void $cancelAutoFocus(
    $Camera $instance,
    
  ) {
     return  $instance.$cancelAutoFocus(
      
    );
  }
  
  void $setDisplayOrientation(
    $Camera $instance,
    
    int degrees,
    
  ) {
     return  $instance.$setDisplayOrientation(
       degrees, 
    );
  }
  
  void $setErrorCallback(
    $Camera $instance,
    
    $ErrorCallback callback,
    
  ) {
     return  $instance.$setErrorCallback(
       callback, 
    );
  }
  
  void $startSmoothZoom(
    $Camera $instance,
    
    int value,
    
  ) {
     return  $instance.$startSmoothZoom(
       value, 
    );
  }
  
  void $stopSmoothZoom(
    $Camera $instance,
    
  ) {
     return  $instance.$stopSmoothZoom(
      
    );
  }
  
  $CameraParameters $getParameters(
    $Camera $instance,
    
  ) {
     $instance.$getParameters(
      
    );
  }
  
  void $setParameters(
    $Camera $instance,
    
    $CameraParameters parameters,
    
  ) {
     return  $instance.$setParameters(
       parameters, 
    );
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
           arguments[
                  0]
              as int, 
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
           arguments[
                  0]
              as $ShutterCallback?,  arguments[
                  1]
              as $PictureCallback?,  arguments[
                  2]
              as $PictureCallback?,  arguments[
                  3]
              as $PictureCallback?, 
        );
      
      case 'autoFocus':
        return $autoFocus(
          instance,
           arguments[
                  0]
              as $AutoFocusCallback, 
        );
      
      case 'cancelAutoFocus':
        return $cancelAutoFocus(
          instance,
          
        );
      
      case 'setDisplayOrientation':
        return $setDisplayOrientation(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setErrorCallback':
        return $setErrorCallback(
          instance,
           arguments[
                  0]
              as $ErrorCallback, 
        );
      
      case 'startSmoothZoom':
        return $startSmoothZoom(
          instance,
           arguments[
                  0]
              as int, 
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
           arguments[
                  0]
              as $CameraParameters, 
        );
      
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CameraParametersHandler implements TypeChannelHandler<$CameraParameters> {
  $CameraParameters $$create(
    TypeChannelMessenger messenger,
    
  ) {
    throw UnimplementedError();
  }

  

  
  bool $getAutoExposureLock(
    $CameraParameters $instance,
    
  ) {
     $instance.$getAutoExposureLock(
      
    );
  }
  
  List<$CameraArea>? $getFocusAreas(
    $CameraParameters $instance,
    
  ) {
     $instance.$getFocusAreas(
      
    );
  }
  
  List<double> $getFocusDistances(
    $CameraParameters $instance,
    
  ) {
     $instance.$getFocusDistances(
      
    );
  }
  
  int $getMaxExposureCompensation(
    $CameraParameters $instance,
    
  ) {
     $instance.$getMaxExposureCompensation(
      
    );
  }
  
  int $getMaxNumFocusAreas(
    $CameraParameters $instance,
    
  ) {
     $instance.$getMaxNumFocusAreas(
      
    );
  }
  
  int $getMinExposureCompensation(
    $CameraParameters $instance,
    
  ) {
     $instance.$getMinExposureCompensation(
      
    );
  }
  
  List<String> $getSupportedFocusModes(
    $CameraParameters $instance,
    
  ) {
     $instance.$getSupportedFocusModes(
      
    );
  }
  
  bool $isAutoExposureLockSupported(
    $CameraParameters $instance,
    
  ) {
     $instance.$isAutoExposureLockSupported(
      
    );
  }
  
  bool $isZoomSupported(
    $CameraParameters $instance,
    
  ) {
     $instance.$isZoomSupported(
      
    );
  }
  
  void $setAutoExposureLock(
    $CameraParameters $instance,
    
    bool toggle,
    
  ) {
     return  $instance.$setAutoExposureLock(
       toggle, 
    );
  }
  
  void $setExposureCompensation(
    $CameraParameters $instance,
    
    int value,
    
  ) {
     return  $instance.$setExposureCompensation(
       value, 
    );
  }
  
  void $setFocusAreas(
    $CameraParameters $instance,
    
    List<$CameraArea>? focusAreas,
    
  ) {
     return  $instance.$setFocusAreas(
       focusAreas, 
    );
  }
  
  void $setFocusMode(
    $CameraParameters $instance,
    
    String value,
    
  ) {
     return  $instance.$setFocusMode(
       value, 
    );
  }
  
  String? $getFlashMode(
    $CameraParameters $instance,
    
  ) {
     $instance.$getFlashMode(
      
    );
  }
  
  int $getMaxZoom(
    $CameraParameters $instance,
    
  ) {
     $instance.$getMaxZoom(
      
    );
  }
  
  $CameraSize $getPictureSize(
    $CameraParameters $instance,
    
  ) {
     $instance.$getPictureSize(
      
    );
  }
  
  $CameraSize $getPreviewSize(
    $CameraParameters $instance,
    
  ) {
     $instance.$getPreviewSize(
      
    );
  }
  
  List<$CameraSize> $getSupportedPreviewSizes(
    $CameraParameters $instance,
    
  ) {
     $instance.$getSupportedPreviewSizes(
      
    );
  }
  
  List<$CameraSize> $getSupportedPictureSizes(
    $CameraParameters $instance,
    
  ) {
     $instance.$getSupportedPictureSizes(
      
    );
  }
  
  List<String> $getSupportedFlashModes(
    $CameraParameters $instance,
    
  ) {
     $instance.$getSupportedFlashModes(
      
    );
  }
  
  int $getZoom(
    $CameraParameters $instance,
    
  ) {
     $instance.$getZoom(
      
    );
  }
  
  bool $isSmoothZoomSupported(
    $CameraParameters $instance,
    
  ) {
     $instance.$isSmoothZoomSupported(
      
    );
  }
  
  void $setFlashMode(
    $CameraParameters $instance,
    
    String mode,
    
  ) {
     return  $instance.$setFlashMode(
       mode, 
    );
  }
  
  void $setPictureSize(
    $CameraParameters $instance,
    
    int width,
    
    int height,
    
  ) {
     return  $instance.$setPictureSize(
       width,  height, 
    );
  }
  
  void $setRecordingHint(
    $CameraParameters $instance,
    
    bool hint,
    
  ) {
     return  $instance.$setRecordingHint(
       hint, 
    );
  }
  
  void $setRotation(
    $CameraParameters $instance,
    
    int rotation,
    
  ) {
     return  $instance.$setRotation(
       rotation, 
    );
  }
  
  void $setZoom(
    $CameraParameters $instance,
    
    int value,
    
  ) {
     return  $instance.$setZoom(
       value, 
    );
  }
  
  void $setPreviewSize(
    $CameraParameters $instance,
    
    int width,
    
    int height,
    
  ) {
     return  $instance.$setPreviewSize(
       width,  height, 
    );
  }
  
  int $getExposureCompensation(
    $CameraParameters $instance,
    
  ) {
     $instance.$getExposureCompensation(
      
    );
  }
  
  double $getExposureCompensationStep(
    $CameraParameters $instance,
    
  ) {
     $instance.$getExposureCompensationStep(
      
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
           arguments[
                  0]
              as bool, 
        );
      
      case 'setExposureCompensation':
        return $setExposureCompensation(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setFocusAreas':
        return $setFocusAreas(
          instance,
           arguments[
                  0]
              as List<$CameraArea>?, 
        );
      
      case 'setFocusMode':
        return $setFocusMode(
          instance,
           arguments[
                  0]
              as String, 
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
           arguments[
                  0]
              as String, 
        );
      
      case 'setPictureSize':
        return $setPictureSize(
          instance,
           arguments[
                  0]
              as int,  arguments[
                  1]
              as int, 
        );
      
      case 'setRecordingHint':
        return $setRecordingHint(
          instance,
           arguments[
                  0]
              as bool, 
        );
      
      case 'setRotation':
        return $setRotation(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setZoom':
        return $setZoom(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setPreviewSize':
        return $setPreviewSize(
          instance,
           arguments[
                  0]
              as int,  arguments[
                  1]
              as int, 
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
       arguments[0]
          as $CameraRect,  arguments[1]
          as int, 
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
       arguments[0]
          as int,  arguments[1]
          as int,  arguments[2]
          as int,  arguments[3]
          as int, 
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
       arguments[0]
          as int,  arguments[1]
          as int, 
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
     return  $instance.$onError(
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
           arguments[
                  0]
              as int, 
        );
      
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $AutoFocusCallbackHandler implements TypeChannelHandler<$AutoFocusCallback> {
  $AutoFocusCallback $$create(
    TypeChannelMessenger messenger,
    
  ) {
    throw UnimplementedError();
  }

  

  
  void $onAutoFocus(
    $AutoFocusCallback $instance,
    
    bool success,
    
  ) {
     return  $instance.$onAutoFocus(
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
           arguments[
                  0]
              as bool, 
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
     return  $instance.$onShutter(
      
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
     return  $instance.$onPictureTaken(
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
           arguments[
                  0]
              as Uint8List, 
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
       arguments[0]
          as int,  arguments[1]
          as int,  arguments[2]
          as int, 
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

  

  
  void $setCamera(
    $MediaRecorder $instance,
    
    $Camera camera,
    
  ) {
     return  $instance.$setCamera(
       camera, 
    );
  }
  
  void $setVideoSource(
    $MediaRecorder $instance,
    
    int source,
    
  ) {
     return  $instance.$setVideoSource(
       source, 
    );
  }
  
  void $setOutputFilePath(
    $MediaRecorder $instance,
    
    String path,
    
  ) {
     return  $instance.$setOutputFilePath(
       path, 
    );
  }
  
  void $setOutputFormat(
    $MediaRecorder $instance,
    
    int format,
    
  ) {
     return  $instance.$setOutputFormat(
       format, 
    );
  }
  
  void $setVideoEncoder(
    $MediaRecorder $instance,
    
    int encoder,
    
  ) {
     return  $instance.$setVideoEncoder(
       encoder, 
    );
  }
  
  void $setAudioSource(
    $MediaRecorder $instance,
    
    int source,
    
  ) {
     return  $instance.$setAudioSource(
       source, 
    );
  }
  
  void $setAudioEncoder(
    $MediaRecorder $instance,
    
    int encoder,
    
  ) {
     return  $instance.$setAudioEncoder(
       encoder, 
    );
  }
  
  void $prepare(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$prepare(
      
    );
  }
  
  void $start(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$start(
      
    );
  }
  
  void $stop(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$stop(
      
    );
  }
  
  void $release(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$release(
      
    );
  }
  
  void $pause(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$pause(
      
    );
  }
  
  void $resume(
    $MediaRecorder $instance,
    
  ) {
     return  $instance.$resume(
      
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
           arguments[
                  0]
              as $Camera, 
        );
      
      case 'setVideoSource':
        return $setVideoSource(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setOutputFilePath':
        return $setOutputFilePath(
          instance,
           arguments[
                  0]
              as String, 
        );
      
      case 'setOutputFormat':
        return $setOutputFormat(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setVideoEncoder':
        return $setVideoEncoder(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setAudioSource':
        return $setAudioSource(
          instance,
           arguments[
                  0]
              as int, 
        );
      
      case 'setAudioEncoder':
        return $setAudioEncoder(
          instance,
           arguments[
                  0]
              as int, 
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

  
  $CameraChannel get channelCamera =>
      $CameraChannel(messenger);
  $CameraHandler get handlerCamera => $CameraHandler();
  
  $CameraParametersChannel get channelCameraParameters =>
      $CameraParametersChannel(messenger);
  $CameraParametersHandler get handlerCameraParameters => $CameraParametersHandler();
  
  $CameraAreaChannel get channelCameraArea =>
      $CameraAreaChannel(messenger);
  $CameraAreaHandler get handlerCameraArea => $CameraAreaHandler();
  
  $CameraRectChannel get channelCameraRect =>
      $CameraRectChannel(messenger);
  $CameraRectHandler get handlerCameraRect => $CameraRectHandler();
  
  $CameraSizeChannel get channelCameraSize =>
      $CameraSizeChannel(messenger);
  $CameraSizeHandler get handlerCameraSize => $CameraSizeHandler();
  
  $ErrorCallbackChannel get channelErrorCallback =>
      $ErrorCallbackChannel(messenger);
  $ErrorCallbackHandler get handlerErrorCallback => $ErrorCallbackHandler();
  
  $AutoFocusCallbackChannel get channelAutoFocusCallback =>
      $AutoFocusCallbackChannel(messenger);
  $AutoFocusCallbackHandler get handlerAutoFocusCallback => $AutoFocusCallbackHandler();
  
  $ShutterCallbackChannel get channelShutterCallback =>
      $ShutterCallbackChannel(messenger);
  $ShutterCallbackHandler get handlerShutterCallback => $ShutterCallbackHandler();
  
  $PictureCallbackChannel get channelPictureCallback =>
      $PictureCallbackChannel(messenger);
  $PictureCallbackHandler get handlerPictureCallback => $PictureCallbackHandler();
  
  $CameraInfoChannel get channelCameraInfo =>
      $CameraInfoChannel(messenger);
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
