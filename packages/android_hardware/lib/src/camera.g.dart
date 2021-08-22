// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import  'package:android_hardware/src/camera.dart' ;

import  'dart:core' ;

import  'dart:typed_data' ;


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


class $ErrorCallbackChannel extends TypeChannel<Object> {
  $ErrorCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/ErrorCallback');

  Future<PairedInstance?> $create(
    ErrorCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    ErrorCallback $instance,
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
      : super(messenger, r'android_hardware/camera/AutoFocusCallback');

  Future<PairedInstance?> $create(
    AutoFocusCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    AutoFocusCallback $instance,
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
      : super(messenger, r'android_hardware/camera/ShutterCallback');

  Future<PairedInstance?> $create(
    ShutterCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    ShutterCallback $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        
      ],
    );
  }
}

class $DataCallbackChannel extends TypeChannel<Object> {
  $DataCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/DataCallback');

  Future<PairedInstance?> $create(
    DataCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    DataCallback $instance,
     Uint8List? data,
    
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
      : super(messenger, r'android_hardware/camera/OnZoomChangeListener');

  Future<PairedInstance?> $create(
    OnZoomChangeListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    OnZoomChangeListener $instance,
     int zoomValue,
     bool stopped,
    
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
         zoomValue,  stopped, 
      ],
    );
  }
}

class $AutoFocusMoveCallbackChannel extends TypeChannel<Object> {
  $AutoFocusMoveCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/AutoFocusMoveCallback');

  Future<PairedInstance?> $create(
    AutoFocusMoveCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    AutoFocusMoveCallback $instance,
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



class $ErrorCallbackHandler implements TypeChannelHandler<Object> {
  $ErrorCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  ErrorCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
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
    covariant ErrorCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
          
          arguments[0] 
           as int,
          
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

class $AutoFocusCallbackHandler implements TypeChannelHandler<Object> {
  $AutoFocusCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  AutoFocusCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
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
    covariant AutoFocusCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
          
          arguments[0] 
           as bool,
          
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

class $ShutterCallbackHandler implements TypeChannelHandler<Object> {
  $ShutterCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  ShutterCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      
    ) {
      implementations.channelShutterCallback._invoke(
        function,
        
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant ShutterCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
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

class $DataCallbackHandler implements TypeChannelHandler<Object> {
  $DataCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  DataCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
       Uint8List? data,
      
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
    covariant DataCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
          
          arguments[0] 
           as Uint8List?,
          
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

class $OnZoomChangeListenerHandler implements TypeChannelHandler<Object> {
  $OnZoomChangeListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  OnZoomChangeListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
       int zoomValue,
       bool stopped,
      
    ) {
      implementations.channelOnZoomChangeListener._invoke(
        function,
         zoomValue,  stopped, 
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant OnZoomChangeListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
          
          arguments[0] 
           as int,
          
          
          arguments[1] 
           as bool,
          
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

class $AutoFocusMoveCallbackHandler implements TypeChannelHandler<Object> {
  $AutoFocusMoveCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  AutoFocusMoveCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
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
    covariant AutoFocusMoveCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          
          
          arguments[0] 
           as bool,
          
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



class $PictureCallbackChannel extends TypeChannel<PictureCallback> {
  $PictureCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/PictureCallback');

  
  Future<PairedInstance?> $create$(
    PictureCallback $instance, {
    required bool $owner,
    
    required DataCallback onPictureTaken,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         onPictureTaken, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $PreviewCallbackChannel extends TypeChannel<PreviewCallback> {
  $PreviewCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/PreviewCallback');

  
  Future<PairedInstance?> $create$(
    PreviewCallback $instance, {
    required bool $owner,
    
    required DataCallback onPreviewFrame,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         onPreviewFrame, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CameraChannel extends TypeChannel<Camera> {
  $CameraChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/Camera');

  
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
  

  
  
  Future< List<CameraInfo> >
      $getAllCameraInfo(
    
  ) async {
    
    return  (
        await sendInvokeStaticMethod(
      r'getAllCameraInfo',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as CameraInfo).toList() ;
  }
  
  
  
  Future< Camera >
      $open(
     int cameraId,
    
  ) async {
    
    return  
        await sendInvokeStaticMethod(
      r'open',
      <Object?>[
         cameraId, 
      ],
    )  as Camera ;
  }
  
  

  
  
  Future< void > $release(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'release',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $startPreview(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'startPreview',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $stopPreview(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'stopPreview',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< int > $attachPreviewTexture(
    Camera $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'attachPreviewTexture',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< void > $releasePreviewTexture(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'releasePreviewTexture',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $unlock(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'unlock',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $setOneShotPreviewCallback(
    Camera $instance,
     PreviewCallback callback,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setOneShotPreviewCallback',
      <Object?>[
         callback, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPreviewCallback(
    Camera $instance,
     PreviewCallback? callback,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPreviewCallback',
      <Object?>[
         callback, 
      ],
    )  ;
  }
  
  
  
  Future< void > $reconnect(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'reconnect',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $takePicture(
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
         shutter,  raw,  postView,  jpeg, 
      ],
    )  ;
  }
  
  
  
  Future< void > $autoFocus(
    Camera $instance,
     AutoFocusCallback callback,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'autoFocus',
      <Object?>[
         callback, 
      ],
    )  ;
  }
  
  
  
  Future< void > $cancelAutoFocus(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'cancelAutoFocus',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $setDisplayOrientation(
    Camera $instance,
     int degrees,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setDisplayOrientation',
      <Object?>[
         degrees, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setErrorCallback(
    Camera $instance,
     ErrorCallback callback,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setErrorCallback',
      <Object?>[
         callback, 
      ],
    )  ;
  }
  
  
  
  Future< void > $startSmoothZoom(
    Camera $instance,
     int value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'startSmoothZoom',
      <Object?>[
         value, 
      ],
    )  ;
  }
  
  
  
  Future< void > $stopSmoothZoom(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'stopSmoothZoom',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< CameraParameters > $getParameters(
    Camera $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getParameters',
      <Object?>[
        
      ],
    )  as CameraParameters ;
  }
  
  
  
  Future< void > $setParameters(
    Camera $instance,
     CameraParameters parameters,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setParameters',
      <Object?>[
         parameters, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setZoomChangeListener(
    Camera $instance,
     OnZoomChangeListener listener,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setZoomChangeListener',
      <Object?>[
         listener, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setAutoFocusMoveCallback(
    Camera $instance,
     AutoFocusMoveCallback callback,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setAutoFocusMoveCallback',
      <Object?>[
         callback, 
      ],
    )  ;
  }
  
  
  
  Future< void > $lock(
    Camera $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'lock',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< bool > $enableShutterSound(
    Camera $instance,
     bool enabled,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'enableShutterSound',
      <Object?>[
         enabled, 
      ],
    )  as bool ;
  }
  
  
}

class $CameraParametersChannel extends TypeChannel<CameraParameters> {
  $CameraParametersChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/CameraParameters');

  
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
  

  

  
  
  Future< bool > $getAutoExposureLock(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getAutoExposureLock',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< List<CameraArea>? > $getFocusAreas(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getFocusAreas',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as CameraArea).toList() ;
  }
  
  
  
  Future< List<double> > $getFocusDistances(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getFocusDistances',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as double).toList() ;
  }
  
  
  
  Future< int > $getMaxExposureCompensation(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getMaxExposureCompensation',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< int > $getMaxNumFocusAreas(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getMaxNumFocusAreas',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< int > $getMinExposureCompensation(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getMinExposureCompensation',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< List<String> > $getSupportedFocusModes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedFocusModes',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as String).toList() ;
  }
  
  
  
  Future< bool > $isAutoExposureLockSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isAutoExposureLockSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< bool > $isZoomSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isZoomSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< void > $setAutoExposureLock(
    CameraParameters $instance,
     bool toggle,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setAutoExposureLock',
      <Object?>[
         toggle, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setExposureCompensation(
    CameraParameters $instance,
     int value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setExposureCompensation',
      <Object?>[
         value, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setFocusAreas(
    CameraParameters $instance,
     List<CameraArea>? focusAreas,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setFocusAreas',
      <Object?>[
         focusAreas, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setFocusMode(
    CameraParameters $instance,
     String value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setFocusMode',
      <Object?>[
         value, 
      ],
    )  ;
  }
  
  
  
  Future< String? > $getFlashMode(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getFlashMode',
      <Object?>[
        
      ],
    )  as String? ;
  }
  
  
  
  Future< int > $getMaxZoom(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getMaxZoom',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< CameraSize > $getPictureSize(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getPictureSize',
      <Object?>[
        
      ],
    )  as CameraSize ;
  }
  
  
  
  Future< CameraSize > $getPreviewSize(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getPreviewSize',
      <Object?>[
        
      ],
    )  as CameraSize ;
  }
  
  
  
  Future< List<CameraSize> > $getSupportedPreviewSizes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewSizes',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as CameraSize).toList() ;
  }
  
  
  
  Future< List<CameraSize> > $getSupportedPictureSizes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedPictureSizes',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as CameraSize).toList() ;
  }
  
  
  
  Future< List<String> > $getSupportedFlashModes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedFlashModes',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as String).toList() ;
  }
  
  
  
  Future< int > $getZoom(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getZoom',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< bool > $isSmoothZoomSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isSmoothZoomSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< void > $setFlashMode(
    CameraParameters $instance,
     String mode,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setFlashMode',
      <Object?>[
         mode, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPictureSize(
    CameraParameters $instance,
     int width,
     int height,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPictureSize',
      <Object?>[
         width,  height, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setRecordingHint(
    CameraParameters $instance,
     bool hint,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setRecordingHint',
      <Object?>[
         hint, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setRotation(
    CameraParameters $instance,
     int rotation,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setRotation',
      <Object?>[
         rotation, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setZoom(
    CameraParameters $instance,
     int value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setZoom',
      <Object?>[
         value, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPreviewSize(
    CameraParameters $instance,
     int width,
     int height,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPreviewSize',
      <Object?>[
         width,  height, 
      ],
    )  ;
  }
  
  
  
  Future< int > $getExposureCompensation(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getExposureCompensation',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< double > $getExposureCompensationStep(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getExposureCompensationStep',
      <Object?>[
        
      ],
    )  as double ;
  }
  
  
  
  Future< String > $flatten(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'flatten',
      <Object?>[
        
      ],
    )  as String ;
  }
  
  
  
  Future< String? > $get(
    CameraParameters $instance,
     String key,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'get',
      <Object?>[
         key, 
      ],
    )  as String? ;
  }
  
  
  
  Future< String > $getAntibanding(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getAntibanding',
      <Object?>[
        
      ],
    )  as String ;
  }
  
  
  
  Future< bool > $getAutoWhiteBalanceLock(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getAutoWhiteBalanceLock',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< String > $getColorEffect(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getColorEffect',
      <Object?>[
        
      ],
    )  as String ;
  }
  
  
  
  Future< double > $getFocalLength(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getFocalLength',
      <Object?>[
        
      ],
    )  as double ;
  }
  
  
  
  Future< String > $getFocusMode(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getFocusMode',
      <Object?>[
        
      ],
    )  as String ;
  }
  
  
  
  Future< double > $getHorizontalViewAngle(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getHorizontalViewAngle',
      <Object?>[
        
      ],
    )  as double ;
  }
  
  
  
  Future< int > $getInt(
    CameraParameters $instance,
     String key,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getInt',
      <Object?>[
         key, 
      ],
    )  as int ;
  }
  
  
  
  Future< int > $getJpegQuality(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getJpegQuality',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< int > $getJpegThumbnailQuality(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getJpegThumbnailQuality',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< CameraSize > $getJpegThumbnailSize(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getJpegThumbnailSize',
      <Object?>[
        
      ],
    )  as CameraSize ;
  }
  
  
  
  Future< int > $getMaxNumMeteringAreas(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getMaxNumMeteringAreas',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< List<CameraArea>? > $getMeteringAreas(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getMeteringAreas',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as CameraArea).toList() ;
  }
  
  
  
  Future< int > $getPictureFormat(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getPictureFormat',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< CameraSize? > $getPreferredPreviewSizeForVideo(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getPreferredPreviewSizeForVideo',
      <Object?>[
        
      ],
    )  as CameraSize? ;
  }
  
  
  
  Future< int > $getPreviewFormat(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getPreviewFormat',
      <Object?>[
        
      ],
    )  as int ;
  }
  
  
  
  Future< List<int> > $getPreviewFpsRange(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getPreviewFpsRange',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as int).toList() ;
  }
  
  
  
  Future< String? > $getSceneMode(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getSceneMode',
      <Object?>[
        
      ],
    )  as String? ;
  }
  
  
  
  Future< List<String>? > $getSupportedAntibanding(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedAntibanding',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as String).toList() ;
  }
  
  
  
  Future< List<String>? > $getSupportedColorEffects(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedColorEffects',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as String).toList() ;
  }
  
  
  
  Future< List<CameraSize> > $getSupportedJpegThumbnailSizes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedJpegThumbnailSizes',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as CameraSize).toList() ;
  }
  
  
  
  Future< List<int> > $getSupportedPictureFormats(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedPictureFormats',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as int).toList() ;
  }
  
  
  
  Future< List<int> > $getSupportedPreviewFormats(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewFormats',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as int).toList() ;
  }
  
  
  
  Future< List<List<int>> > $getSupportedPreviewFpsRange(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedPreviewFpsRange',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => (_ as List<dynamic>).map((_) => _ as int).toList()).toList() ;
  }
  
  
  
  Future< List<String>? > $getSupportedSceneModes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedSceneModes',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as String).toList() ;
  }
  
  
  
  Future< List<CameraSize>? > $getSupportedVideoSizes(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedVideoSizes',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as CameraSize).toList() ;
  }
  
  
  
  Future< List<String>? > $getSupportedWhiteBalance(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getSupportedWhiteBalance',
      <Object?>[
        
      ],
    )  as List<dynamic>?)?.map((_) => _ as String).toList() ;
  }
  
  
  
  Future< double > $getVerticalViewAngle(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getVerticalViewAngle',
      <Object?>[
        
      ],
    )  as double ;
  }
  
  
  
  Future< bool > $getVideoStabilization(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getVideoStabilization',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< String? > $getWhiteBalance(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'getWhiteBalance',
      <Object?>[
        
      ],
    )  as String? ;
  }
  
  
  
  Future< List<int> > $getZoomRatios(
    CameraParameters $instance,
    
  ) async {
    
    return  ( await sendInvokeMethod(
      $instance,
      r'getZoomRatios',
      <Object?>[
        
      ],
    )  as List<dynamic>).map((_) => _ as int).toList() ;
  }
  
  
  
  Future< bool > $isAutoWhiteBalanceLockSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isAutoWhiteBalanceLockSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< bool > $isVideoSnapshotSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isVideoSnapshotSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< bool > $isVideoStabilizationSupported(
    CameraParameters $instance,
    
  ) async {
    
    return   await sendInvokeMethod(
      $instance,
      r'isVideoStabilizationSupported',
      <Object?>[
        
      ],
    )  as bool ;
  }
  
  
  
  Future< void > $remove(
    CameraParameters $instance,
     String key,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'remove',
      <Object?>[
         key, 
      ],
    )  ;
  }
  
  
  
  Future< void > $removeGpsData(
    CameraParameters $instance,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'removeGpsData',
      <Object?>[
        
      ],
    )  ;
  }
  
  
  
  Future< void > $set(
    CameraParameters $instance,
     String key,
     Object value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'set',
      <Object?>[
         key,  value, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setAntibanding(
    CameraParameters $instance,
     String antibanding,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setAntibanding',
      <Object?>[
         antibanding, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setAutoWhiteBalanceLock(
    CameraParameters $instance,
     bool toggle,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setAutoWhiteBalanceLock',
      <Object?>[
         toggle, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setColorEffect(
    CameraParameters $instance,
     String effect,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setColorEffect',
      <Object?>[
         effect, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setGpsAltitude(
    CameraParameters $instance,
     double meters,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setGpsAltitude',
      <Object?>[
         meters, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setGpsLatitude(
    CameraParameters $instance,
     double latitude,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setGpsLatitude',
      <Object?>[
         latitude, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setGpsLongitude(
    CameraParameters $instance,
     double longitude,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setGpsLongitude',
      <Object?>[
         longitude, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setGpsProcessingMethod(
    CameraParameters $instance,
     String processingMethod,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setGpsProcessingMethod',
      <Object?>[
         processingMethod, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setGpsTimestamp(
    CameraParameters $instance,
     int timestamp,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setGpsTimestamp',
      <Object?>[
         timestamp, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setJpegQuality(
    CameraParameters $instance,
     int quality,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setJpegQuality',
      <Object?>[
         quality, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setJpegThumbnailQuality(
    CameraParameters $instance,
     int quality,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setJpegThumbnailQuality',
      <Object?>[
         quality, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setJpegThumbnailSize(
    CameraParameters $instance,
     int width,
     int height,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setJpegThumbnailSize',
      <Object?>[
         width,  height, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setMeteringAreas(
    CameraParameters $instance,
     List<CameraArea> meteringAreas,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setMeteringAreas',
      <Object?>[
         meteringAreas, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPictureFormat(
    CameraParameters $instance,
     int pixelFormat,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPictureFormat',
      <Object?>[
         pixelFormat, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPreviewFormat(
    CameraParameters $instance,
     int pixelFormat,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPreviewFormat',
      <Object?>[
         pixelFormat, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setPreviewFpsRange(
    CameraParameters $instance,
     int min,
     int max,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setPreviewFpsRange',
      <Object?>[
         min,  max, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setSceneMode(
    CameraParameters $instance,
     String mode,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setSceneMode',
      <Object?>[
         mode, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setVideoStabilization(
    CameraParameters $instance,
     bool toggle,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setVideoStabilization',
      <Object?>[
         toggle, 
      ],
    )  ;
  }
  
  
  
  Future< void > $setWhiteBalance(
    CameraParameters $instance,
     String value,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'setWhiteBalance',
      <Object?>[
         value, 
      ],
    )  ;
  }
  
  
  
  Future< void > $unflatten(
    CameraParameters $instance,
     String flattened,
    
  ) async {
      await sendInvokeMethod(
      $instance,
      r'unflatten',
      <Object?>[
         flattened, 
      ],
    )  ;
  }
  
  
}

class $CameraAreaChannel extends TypeChannel<CameraArea> {
  $CameraAreaChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/CameraArea');

  
  Future<PairedInstance?> $create$(
    CameraArea $instance, {
    required bool $owner,
    
    required CameraRect rect,
    
    required int weight,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         rect,  weight, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CameraRectChannel extends TypeChannel<CameraRect> {
  $CameraRectChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/CameraRect');

  
  Future<PairedInstance?> $create$(
    CameraRect $instance, {
    required bool $owner,
    
    required int top,
    
    required int bottom,
    
    required int right,
    
    required int left,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         top,  bottom,  right,  left, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CameraSizeChannel extends TypeChannel<CameraSize> {
  $CameraSizeChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/CameraSize');

  
  Future<PairedInstance?> $create$(
    CameraSize $instance, {
    required bool $owner,
    
    required int width,
    
    required int height,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         width,  height, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CameraInfoChannel extends TypeChannel<CameraInfo> {
  $CameraInfoChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/CameraInfo');

  
  Future<PairedInstance?> $create$(
    CameraInfo $instance, {
    required bool $owner,
    
    required int cameraId,
    
    required int facing,
    
    required int orientation,
    
    required bool? canDisableShutterSound,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'',
         cameraId,  facing,  orientation,  canDisableShutterSound, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $ImageFormatChannel extends TypeChannel<ImageFormat> {
  $ImageFormatChannel(TypeChannelMessenger messenger)
      : super(messenger, r'android_hardware/camera/ImageFormat');

  

  
  
  Future< int >
      $getBitsPerPixel(
     int format,
    
  ) async {
    
    return  
        await sendInvokeStaticMethod(
      r'getBitsPerPixel',
      <Object?>[
         format, 
      ],
    )  as int ;
  }
  
  

  
}



class $PictureCallbackHandler implements TypeChannelHandler<PictureCallback> {
  
  PictureCallback $create$(
    TypeChannelMessenger messenger,
    
    DataCallback onPictureTaken,
    
  ) {
    return PictureCallback  (
      
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
          
          
          arguments[1] 
           as DataCallback,
          
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
    
    DataCallback onPreviewFrame,
    
  ) {
    return PreviewCallback  (
      
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
          
          
          arguments[1] 
           as DataCallback,
          
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
    return Camera  (
      
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
    return CameraParameters  (
      
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
    return CameraArea  (
      
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
          
          
          arguments[1] 
           as CameraRect,
          
          
          arguments[2] 
           as int,
          
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
    return CameraRect  (
      
       top:  top,
      
       bottom:  bottom,
      
       right:  right,
      
       left:  left,
      
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
          
          
          arguments[1] 
           as int,
          
          
          arguments[2] 
           as int,
          
          
          arguments[3] 
           as int,
          
          
          arguments[4] 
           as int,
          
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
    return CameraSize  (
      
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
          
          
          arguments[1] 
           as int,
          
          
          arguments[2] 
           as int,
          
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
    return CameraInfo  (
      
       cameraId:  cameraId,
      
       facing:  facing,
      
       orientation:  orientation,
      
       canDisableShutterSound:  canDisableShutterSound,
      
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
          
          
          arguments[1] 
           as int,
          
          
          arguments[2] 
           as int,
          
          
          arguments[3] 
           as int,
          
          
          arguments[4] 
           as bool?,
          
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

  
  late $PictureCallbackChannel channelPictureCallback =
      $PictureCallbackChannel(messenger);
  $PictureCallbackHandler handlerPictureCallback = $PictureCallbackHandler();
  
  late $PreviewCallbackChannel channelPreviewCallback =
      $PreviewCallbackChannel(messenger);
  $PreviewCallbackHandler handlerPreviewCallback = $PreviewCallbackHandler();
  
  late $CameraChannel channelCamera =
      $CameraChannel(messenger);
  $CameraHandler handlerCamera = $CameraHandler();
  
  late $CameraParametersChannel channelCameraParameters =
      $CameraParametersChannel(messenger);
  $CameraParametersHandler handlerCameraParameters = $CameraParametersHandler();
  
  late $CameraAreaChannel channelCameraArea =
      $CameraAreaChannel(messenger);
  $CameraAreaHandler handlerCameraArea = $CameraAreaHandler();
  
  late $CameraRectChannel channelCameraRect =
      $CameraRectChannel(messenger);
  $CameraRectHandler handlerCameraRect = $CameraRectHandler();
  
  late $CameraSizeChannel channelCameraSize =
      $CameraSizeChannel(messenger);
  $CameraSizeHandler handlerCameraSize = $CameraSizeHandler();
  
  late $CameraInfoChannel channelCameraInfo =
      $CameraInfoChannel(messenger);
  $CameraInfoHandler handlerCameraInfo = $CameraInfoHandler();
  
  late $ImageFormatChannel channelImageFormat =
      $ImageFormatChannel(messenger);
  $ImageFormatHandler handlerImageFormat = $ImageFormatHandler();
  

  
  late $ErrorCallbackChannel channelErrorCallback =
      $ErrorCallbackChannel(messenger);
  late $ErrorCallbackHandler handlerErrorCallback =
      $ErrorCallbackHandler(this);
  
  late $AutoFocusCallbackChannel channelAutoFocusCallback =
      $AutoFocusCallbackChannel(messenger);
  late $AutoFocusCallbackHandler handlerAutoFocusCallback =
      $AutoFocusCallbackHandler(this);
  
  late $ShutterCallbackChannel channelShutterCallback =
      $ShutterCallbackChannel(messenger);
  late $ShutterCallbackHandler handlerShutterCallback =
      $ShutterCallbackHandler(this);
  
  late $DataCallbackChannel channelDataCallback =
      $DataCallbackChannel(messenger);
  late $DataCallbackHandler handlerDataCallback =
      $DataCallbackHandler(this);
  
  late $OnZoomChangeListenerChannel channelOnZoomChangeListener =
      $OnZoomChangeListenerChannel(messenger);
  late $OnZoomChangeListenerHandler handlerOnZoomChangeListener =
      $OnZoomChangeListenerHandler(this);
  
  late $AutoFocusMoveCallbackChannel channelAutoFocusMoveCallback =
      $AutoFocusMoveCallbackChannel(messenger);
  late $AutoFocusMoveCallbackHandler handlerAutoFocusMoveCallback =
      $AutoFocusMoveCallbackHandler(this);
  
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  static $ChannelRegistrar instance = $ChannelRegistrar(
      $LibraryImplementations(MethodChannelMessenger.instance))
    ..registerHandlers();

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
    
    implementations.channelImageFormat.setHandler(
      implementations.handlerImageFormat,
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
    
    implementations.channelImageFormat.removeHandler();
    
    
    implementations.channelErrorCallback.removeHandler();
    
    implementations.channelAutoFocusCallback.removeHandler();
    
    implementations.channelShutterCallback.removeHandler();
    
    implementations.channelDataCallback.removeHandler();
    
    implementations.channelOnZoomChangeListener.removeHandler();
    
    implementations.channelAutoFocusMoveCallback.removeHandler();
    
  }
}
