// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import  'dart:typed_data' ;


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


mixin $Camera {
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CameraParameters {
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CameraArea {
  
}

mixin $CameraRect {
  
}

mixin $CameraSize {
  
}

mixin $ErrorCallback {
  
  
  dynamic onError(
     int error,
    
  );
  
  
}

mixin $AutoFocusCallback {
  
  
  dynamic onAutoFocus(
     bool success,
    
  );
  
  
}

mixin $ShutterCallback {
  
  
  dynamic onShutter(
    
  );
  
  
}

mixin $PictureCallback {
  
  
  dynamic onPictureTaken(
     Uint8List data,
    
  );
  
  
}

mixin $CameraInfo {
  
}

mixin $MediaRecorder {
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
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

  
  
  Future<Object?> $getAllCameraInfo(
    
  ) {
    return sendInvokeStaticMethod(
      'getAllCameraInfo',
      <Object?>[
        
      ],
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
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $startPreview(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'startPreview',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $stopPreview(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'stopPreview',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $attachPreviewTexture(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'attachPreviewTexture',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $releasePreviewTexture(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'releasePreviewTexture',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $unlock(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'unlock',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $reconnect(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'reconnect',
      <Object?>[
        
      ],
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
         shutter,  raw,  postView,  jpeg, 
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
      <Object?>[
        
      ],
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
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getParameters(
    $Camera $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getParameters',
      <Object?>[
        
      ],
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

  

  
  
  Future<Object?> $getAutoExposureLock(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getAutoExposureLock',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getFocusAreas(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocusAreas',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getFocusDistances(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getFocusDistances',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getMaxExposureCompensation(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxExposureCompensation',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getMaxNumFocusAreas(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxNumFocusAreas',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getMinExposureCompensation(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getMinExposureCompensation',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getSupportedFocusModes(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedFocusModes',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $isAutoExposureLockSupported(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isAutoExposureLockSupported',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $isZoomSupported(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isZoomSupported',
      <Object?>[
        
      ],
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
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getMaxZoom(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxZoom',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getPictureSize(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getPictureSize',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getPreviewSize(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getPreviewSize',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getSupportedPreviewSizes(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPreviewSizes',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getSupportedPictureSizes(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedPictureSizes',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getSupportedFlashModes(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getSupportedFlashModes',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getZoom(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getZoom',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $isSmoothZoomSupported(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isSmoothZoomSupported',
      <Object?>[
        
      ],
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
         width,  height, 
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
         width,  height, 
      ],
    );
  }
  
  
  
  Future<Object?> $getExposureCompensation(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getExposureCompensation',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $getExposureCompensationStep(
    $CameraParameters $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'getExposureCompensationStep',
      <Object?>[
        
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
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $start(
    $MediaRecorder $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'start',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $stop(
    $MediaRecorder $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'stop',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $release(
    $MediaRecorder $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'release',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $pause(
    $MediaRecorder $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'pause',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $resume(
    $MediaRecorder $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'resume',
      <Object?>[
        
      ],
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

class $CameraParametersHandler implements TypeChannelHandler<$CameraParameters> {
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

  

  
  
  dynamic $onError(
    $ErrorCallback $instance,
    
    int error,
    
  ) {
    return $instance.onError(
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

  

  
  
  dynamic $onAutoFocus(
    $AutoFocusCallback $instance,
    
    bool success,
    
  ) {
    return $instance.onAutoFocus(
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

  

  
  
  dynamic $onShutter(
    $ShutterCallback $instance,
    
  ) {
    return $instance.onShutter(
      
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

  

  
  
  dynamic $onPictureTaken(
    $PictureCallback $instance,
    
    Uint8List data,
    
  ) {
    return $instance.onPictureTaken(
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
