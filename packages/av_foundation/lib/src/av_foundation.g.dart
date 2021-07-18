// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import  'dart:typed_data' ;

import  'av_foundation.dart' ;


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


typedef $FinishProcessingPhotoCallback = dynamic Function(
   CapturePhoto photo,
  
);



class $FinishProcessingPhotoCallbackChannel extends TypeChannel<Object> {
  $FinishProcessingPhotoCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/FinishProcessingPhotoCallback');

  Future<PairedInstance?> $$create(
    $FinishProcessingPhotoCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $FinishProcessingPhotoCallback $instance,
     CapturePhoto photo,
    
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
         photo, 
      ],
    );
  }
}



class $FinishProcessingPhotoCallbackHandler implements TypeChannelHandler<Object> {
  $FinishProcessingPhotoCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $FinishProcessingPhotoCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
       CapturePhoto photo,
      
    ) {
      implementations.channelFinishProcessingPhotoCallback._invoke(
        function,
         photo, 
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $FinishProcessingPhotoCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      
      arguments[0] as CapturePhoto,
      
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



mixin $CapturePhotoOutput {
  
  
  
  
  
}

mixin $CapturePhotoSettings {
  
  
  
  
  
}

mixin $CapturePhotoCaptureDelegate {
  
}

mixin $CaptureOutput {
  
}

mixin $CapturePhoto {
  
}

mixin $CaptureDeviceInput {
  
}

mixin $CaptureInput {
  
}

mixin $CaptureSession {
  
  
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CaptureDevice {
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CaptureDeviceDiscoverySession {
  
}

mixin $PreviewController {
  
}

mixin $CaptureFileOutput {
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CaptureMovieFileOutput {
  
  
  
}

mixin $CaptureFileOutputRecordingDelegate {
  
}

mixin $CaptureConnection {
  
  
  
  
  
  
  
  
  
  
  
}

mixin $CaptureInputPort {
  
  
  
}



class $CapturePhotoOutputChannel extends TypeChannel<$CapturePhotoOutput> {
  $CapturePhotoOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhotoOutput');

  
  Future<PairedInstance?> $create$(
    $CapturePhotoOutput $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $capturePhotoWithSettings(
    $CapturePhotoOutput $instance,
     $CapturePhotoSettings settings,
     $CapturePhotoCaptureDelegate delegate,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'capturePhotoWithSettings',
      <Object?>[
         settings,  delegate, 
      ],
    );
  }
  
  
  
  Future<Object?> $supportedFlashModes(
    $CapturePhotoOutput $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'supportedFlashModes',
      <Object?>[
        
      ],
    );
  }
  
  
}

class $CapturePhotoSettingsChannel extends TypeChannel<$CapturePhotoSettings> {
  $CapturePhotoSettingsChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhotoSettings');

  
  Future<PairedInstance?> $create$(
    $CapturePhotoSettings $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  
  Future<PairedInstance?> $create$photoSettingsWithFormat(
    $CapturePhotoSettings $instance, {
    required bool $owner,
    
    required Map format,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        'photoSettingsWithFormat',
         format, 
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $uniqueID(
    $CapturePhotoSettings $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'uniqueID',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setFlashMode(
    $CapturePhotoSettings $instance,
     int mode,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setFlashMode',
      <Object?>[
         mode, 
      ],
    );
  }
  
  
}

class $CapturePhotoCaptureDelegateChannel extends TypeChannel<$CapturePhotoCaptureDelegate> {
  $CapturePhotoCaptureDelegateChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhotoCaptureDelegate');

  
  Future<PairedInstance?> $create$(
    $CapturePhotoCaptureDelegate $instance, {
    required bool $owner,
    
    required $FinishProcessingPhotoCallback didFinishProcessingPhoto,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         didFinishProcessingPhoto, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureOutputChannel extends TypeChannel<$CaptureOutput> {
  $CaptureOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureOutput');

  
  Future<PairedInstance?> $create$(
    $CaptureOutput $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CapturePhotoChannel extends TypeChannel<$CapturePhoto> {
  $CapturePhotoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhoto');

  
  Future<PairedInstance?> $create$(
    $CapturePhoto $instance, {
    required bool $owner,
    
    required Uint8List? fileDataRepresentation,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         fileDataRepresentation, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureDeviceInputChannel extends TypeChannel<$CaptureDeviceInput> {
  $CaptureDeviceInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureDeviceInput');

  
  Future<PairedInstance?> $create$(
    $CaptureDeviceInput $instance, {
    required bool $owner,
    
    required $CaptureDevice device,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         device, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureInputChannel extends TypeChannel<$CaptureInput> {
  $CaptureInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureInput');

  
  Future<PairedInstance?> $create$(
    $CaptureInput $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureSessionChannel extends TypeChannel<$CaptureSession> {
  $CaptureSessionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureSession');

  
  Future<PairedInstance?> $create$(
    $CaptureSession $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $addInput(
    $CaptureSession $instance,
     $CaptureInput input,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'addInput',
      <Object?>[
         input, 
      ],
    );
  }
  
  
  
  Future<Object?> $addOutput(
    $CaptureSession $instance,
     $CaptureOutput output,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'addOutput',
      <Object?>[
         output, 
      ],
    );
  }
  
  
  
  Future<Object?> $startRunning(
    $CaptureSession $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'startRunning',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $stopRunning(
    $CaptureSession $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'stopRunning',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setSessionPreset(
    $CaptureSession $instance,
     String preset,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setSessionPreset',
      <Object?>[
         preset, 
      ],
    );
  }
  
  
  
  Future<Object?> $canSetSessionPresets(
    $CaptureSession $instance,
     List<String> presets,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'canSetSessionPresets',
      <Object?>[
         presets, 
      ],
    );
  }
  
  
}

class $CaptureDeviceChannel extends TypeChannel<$CaptureDevice> {
  $CaptureDeviceChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureDevice');

  
  Future<PairedInstance?> $create$(
    $CaptureDevice $instance, {
    required bool $owner,
    
    required String uniqueId,
    
    required int position,
    
    required bool isSmoothAutoFocusSupported,
    
    required bool hasFlash,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         uniqueId,  position,  isSmoothAutoFocusSupported,  hasFlash, 
      ],
      owner: $owner,
    );
  }
  

  
  
  Future<Object?> $defaultDeviceWithMediaType(
     String mediaType,
    
  ) {
    return sendInvokeStaticMethod(
      'defaultDeviceWithMediaType',
      <Object?>[
         mediaType, 
      ],
    );
  }
  
  

  
  
  Future<Object?> $lockForConfiguration(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'lockForConfiguration',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $unlockForConfiguration(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'unlockForConfiguration',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $supportsCaptureSessionPresets(
    $CaptureDevice $instance,
     List<String> presets,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'supportsCaptureSessionPresets',
      <Object?>[
         presets, 
      ],
    );
  }
  
  
  
  Future<Object?> $isAdjustingExposure(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isAdjustingExposure',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setExposureMode(
    $CaptureDevice $instance,
     int mode,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setExposureMode',
      <Object?>[
         mode, 
      ],
    );
  }
  
  
  
  Future<Object?> $exposureModesSupported(
    $CaptureDevice $instance,
     List<int> modes,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'exposureModesSupported',
      <Object?>[
         modes, 
      ],
    );
  }
  
  
  
  Future<Object?> $setFocusMode(
    $CaptureDevice $instance,
     int mode,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setFocusMode',
      <Object?>[
         mode, 
      ],
    );
  }
  
  
  
  Future<Object?> $focusModesSupported(
    $CaptureDevice $instance,
     List<int> modes,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'focusModesSupported',
      <Object?>[
         modes, 
      ],
    );
  }
  
  
  
  Future<Object?> $isAdjustingFocus(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isAdjustingFocus',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setSmoothAutoFocusEnabled(
    $CaptureDevice $instance,
     bool enabled,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setSmoothAutoFocusEnabled',
      <Object?>[
         enabled, 
      ],
    );
  }
  
  
  
  Future<Object?> $isFlashAvailable(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isFlashAvailable',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setVideoZoomFactor(
    $CaptureDevice $instance,
     double factor,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoZoomFactor',
      <Object?>[
         factor, 
      ],
    );
  }
  
  
  
  Future<Object?> $minAvailableVideoZoomFactor(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'minAvailableVideoZoomFactor',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $maxAvailableVideoZoomFactor(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'maxAvailableVideoZoomFactor',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $rampToVideoZoomFactor(
    $CaptureDevice $instance,
     double factor,
     double rate,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'rampToVideoZoomFactor',
      <Object?>[
         factor,  rate, 
      ],
    );
  }
  
  
  
  Future<Object?> $isRampingVideoZoom(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isRampingVideoZoom',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $cancelVideoZoomRamp(
    $CaptureDevice $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'cancelVideoZoomRamp',
      <Object?>[
        
      ],
    );
  }
  
  
}

class $CaptureDeviceDiscoverySessionChannel extends TypeChannel<$CaptureDeviceDiscoverySession> {
  $CaptureDeviceDiscoverySessionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureDeviceDiscoverySession');

  
  Future<PairedInstance?> $create$(
    $CaptureDeviceDiscoverySession $instance, {
    required bool $owner,
    
    required List<$CaptureDevice> devices,
    
    required List<List<$CaptureDevice>> supportedMultiCamDeviceSets,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         devices,  supportedMultiCamDeviceSets, 
      ],
      owner: $owner,
    );
  }
  

  
  
  Future<Object?> $discoverySessionWithDeviceTypes(
     List<String> deviceTypes,
     String? mediaType,
     int position,
    
  ) {
    return sendInvokeStaticMethod(
      'discoverySessionWithDeviceTypes',
      <Object?>[
         deviceTypes,  mediaType,  position, 
      ],
    );
  }
  
  

  
}

class $PreviewControllerChannel extends TypeChannel<$PreviewController> {
  $PreviewControllerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/PreviewController');

  
  Future<PairedInstance?> $create$(
    $PreviewController $instance, {
    required bool $owner,
    
    required $CaptureSession captureSession,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         captureSession, 
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureFileOutputChannel extends TypeChannel<$CaptureFileOutput> {
  $CaptureFileOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureFileOutput');

  
  Future<PairedInstance?> $create$(
    $CaptureFileOutput $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $outputFileURL(
    $CaptureFileOutput $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'outputFileURL',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setMaxRecordedFileSize(
    $CaptureFileOutput $instance,
     int fileSize,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setMaxRecordedFileSize',
      <Object?>[
         fileSize, 
      ],
    );
  }
  
  
  
  Future<Object?> $isRecording(
    $CaptureFileOutput $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isRecording',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $startRecordingToOutputFileURL(
    $CaptureFileOutput $instance,
     String outputFileURL,
     $CaptureFileOutputRecordingDelegate delegate,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'startRecordingToOutputFileURL',
      <Object?>[
         outputFileURL,  delegate, 
      ],
    );
  }
  
  
  
  Future<Object?> $stopRecording(
    $CaptureFileOutput $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'stopRecording',
      <Object?>[
        
      ],
    );
  }
  
  
}

class $CaptureMovieFileOutputChannel extends TypeChannel<$CaptureMovieFileOutput> {
  $CaptureMovieFileOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureMovieFileOutput');

  
  Future<PairedInstance?> $create$(
    $CaptureMovieFileOutput $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $availableVideoCodecTypes(
    $CaptureMovieFileOutput $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'availableVideoCodecTypes',
      <Object?>[
        
      ],
    );
  }
  
  
}

class $CaptureFileOutputRecordingDelegateChannel extends TypeChannel<$CaptureFileOutputRecordingDelegate> {
  $CaptureFileOutputRecordingDelegateChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureFileOutputRecordingDelegate');

  
  Future<PairedInstance?> $create$(
    $CaptureFileOutputRecordingDelegate $instance, {
    required bool $owner,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        
      ],
      owner: $owner,
    );
  }
  

  

  
}

class $CaptureConnectionChannel extends TypeChannel<$CaptureConnection> {
  $CaptureConnectionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureConnection');

  
  Future<PairedInstance?> $create$(
    $CaptureConnection $instance, {
    required bool $owner,
    
    required List<$CaptureInputPort> inputPorts,
    
    required $CaptureOutput output,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         inputPorts,  output, 
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $setVideoOrientation(
    $CaptureConnection $instance,
     int orientation,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoOrientation',
      <Object?>[
         orientation, 
      ],
    );
  }
  
  
  
  Future<Object?> $isVideoOrientationSupported(
    $CaptureConnection $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isVideoOrientationSupported',
      <Object?>[
        
      ],
    );
  }
  
  
  
  Future<Object?> $setAutomaticallyAdjustsVideoMirroring(
    $CaptureConnection $instance,
     bool adjust,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setAutomaticallyAdjustsVideoMirroring',
      <Object?>[
         adjust, 
      ],
    );
  }
  
  
  
  Future<Object?> $setVideoMirrored(
    $CaptureConnection $instance,
     bool mirrored,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoMirrored',
      <Object?>[
         mirrored, 
      ],
    );
  }
  
  
  
  Future<Object?> $isVideoMirroringSupported(
    $CaptureConnection $instance,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'isVideoMirroringSupported',
      <Object?>[
        
      ],
    );
  }
  
  
}

class $CaptureInputPortChannel extends TypeChannel<$CaptureInputPort> {
  $CaptureInputPortChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureInputPort');

  
  Future<PairedInstance?> $create$(
    $CaptureInputPort $instance, {
    required bool $owner,
    
    required String mediaType,
    
    required String? sourceDeviceType,
    
    required int sourceDevicePosition,
    
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
         mediaType,  sourceDeviceType,  sourceDevicePosition, 
      ],
      owner: $owner,
    );
  }
  

  

  
  
  Future<Object?> $setEnabled(
    $CaptureInputPort $instance,
     bool enabled,
    
  ) {
    return sendInvokeMethod(
      $instance,
      'setEnabled',
      <Object?>[
         enabled, 
      ],
    );
  }
  
  
}



class $CapturePhotoOutputHandler implements TypeChannelHandler<$CapturePhotoOutput> {
  
  $CapturePhotoOutput $create$(
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
  $CapturePhotoOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CapturePhotoOutput instance,
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

class $CapturePhotoSettingsHandler implements TypeChannelHandler<$CapturePhotoSettings> {
  
  $CapturePhotoSettings $create$(
    TypeChannelMessenger messenger,
    
  ) {
    throw UnimplementedError();
  }
  
  $CapturePhotoSettings $create$photoSettingsWithFormat(
    TypeChannelMessenger messenger,
    
    Map format,
    
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
  $CapturePhotoSettings createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
        );
      
      case 'photoSettingsWithFormat':
        return $create$photoSettingsWithFormat(
          messenger,
          
          arguments[1] as Map,
          
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
    $CapturePhotoSettings instance,
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

class $CapturePhotoCaptureDelegateHandler implements TypeChannelHandler<$CapturePhotoCaptureDelegate> {
  
  $CapturePhotoCaptureDelegate $create$(
    TypeChannelMessenger messenger,
    
    $FinishProcessingPhotoCallback didFinishProcessingPhoto,
    
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
  $CapturePhotoCaptureDelegate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as $FinishProcessingPhotoCallback,
          
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
    $CapturePhotoCaptureDelegate instance,
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

class $CaptureOutputHandler implements TypeChannelHandler<$CaptureOutput> {
  
  $CaptureOutput $create$(
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
  $CaptureOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureOutput instance,
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

class $CapturePhotoHandler implements TypeChannelHandler<$CapturePhoto> {
  
  $CapturePhoto $create$(
    TypeChannelMessenger messenger,
    
    Uint8List? fileDataRepresentation,
    
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
  $CapturePhoto createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as Uint8List?,
          
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
    $CapturePhoto instance,
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

class $CaptureDeviceInputHandler implements TypeChannelHandler<$CaptureDeviceInput> {
  
  $CaptureDeviceInput $create$(
    TypeChannelMessenger messenger,
    
    $CaptureDevice device,
    
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
  $CaptureDeviceInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as $CaptureDevice,
          
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
    $CaptureDeviceInput instance,
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

class $CaptureInputHandler implements TypeChannelHandler<$CaptureInput> {
  
  $CaptureInput $create$(
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
  $CaptureInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureInput instance,
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

class $CaptureSessionHandler implements TypeChannelHandler<$CaptureSession> {
  
  $CaptureSession $create$(
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
  $CaptureSession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureSession instance,
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

class $CaptureDeviceHandler implements TypeChannelHandler<$CaptureDevice> {
  
  $CaptureDevice $create$(
    TypeChannelMessenger messenger,
    
    String uniqueId,
    
    int position,
    
    bool isSmoothAutoFocusSupported,
    
    bool hasFlash,
    
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
  $CaptureDevice createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as String,
          
          arguments[2] as int,
          
          arguments[3] as bool,
          
          arguments[4] as bool,
          
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
    $CaptureDevice instance,
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

class $CaptureDeviceDiscoverySessionHandler implements TypeChannelHandler<$CaptureDeviceDiscoverySession> {
  
  $CaptureDeviceDiscoverySession $create$(
    TypeChannelMessenger messenger,
    
    List<$CaptureDevice> devices,
    
    List<List<$CaptureDevice>> supportedMultiCamDeviceSets,
    
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
  $CaptureDeviceDiscoverySession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          (arguments[1] as List<dynamic>).map((_) => _ as $CaptureDevice).toList(),
          
          (arguments[2] as List<dynamic>).map((_) => (_ as List<dynamic>).map((_) => _ as $CaptureDevice).toList()).toList(),
          
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
    $CaptureDeviceDiscoverySession instance,
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

class $PreviewControllerHandler implements TypeChannelHandler<$PreviewController> {
  
  $PreviewController $create$(
    TypeChannelMessenger messenger,
    
    $CaptureSession captureSession,
    
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
  $PreviewController createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as $CaptureSession,
          
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
    $PreviewController instance,
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

class $CaptureFileOutputHandler implements TypeChannelHandler<$CaptureFileOutput> {
  
  $CaptureFileOutput $create$(
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
  $CaptureFileOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureFileOutput instance,
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

class $CaptureMovieFileOutputHandler implements TypeChannelHandler<$CaptureMovieFileOutput> {
  
  $CaptureMovieFileOutput $create$(
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
  $CaptureMovieFileOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureMovieFileOutput instance,
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

class $CaptureFileOutputRecordingDelegateHandler implements TypeChannelHandler<$CaptureFileOutputRecordingDelegate> {
  
  $CaptureFileOutputRecordingDelegate $create$(
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
  $CaptureFileOutputRecordingDelegate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
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
    $CaptureFileOutputRecordingDelegate instance,
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

class $CaptureConnectionHandler implements TypeChannelHandler<$CaptureConnection> {
  
  $CaptureConnection $create$(
    TypeChannelMessenger messenger,
    
    List<$CaptureInputPort> inputPorts,
    
    $CaptureOutput output,
    
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
  $CaptureConnection createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          (arguments[1] as List<dynamic>).map((_) => _ as $CaptureInputPort).toList(),
          
          arguments[2] as $CaptureOutput,
          
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
    $CaptureConnection instance,
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

class $CaptureInputPortHandler implements TypeChannelHandler<$CaptureInputPort> {
  
  $CaptureInputPort $create$(
    TypeChannelMessenger messenger,
    
    String mediaType,
    
    String? sourceDeviceType,
    
    int sourceDevicePosition,
    
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
  $CaptureInputPort createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      
      case '':
        return $create$(
          messenger,
          
          arguments[1] as String,
          
          arguments[2] as String?,
          
          arguments[3] as int,
          
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
    $CaptureInputPort instance,
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

  
  $CapturePhotoOutputChannel get channelCapturePhotoOutput =>
      $CapturePhotoOutputChannel(messenger);
  $CapturePhotoOutputHandler get handlerCapturePhotoOutput => $CapturePhotoOutputHandler();
  
  $CapturePhotoSettingsChannel get channelCapturePhotoSettings =>
      $CapturePhotoSettingsChannel(messenger);
  $CapturePhotoSettingsHandler get handlerCapturePhotoSettings => $CapturePhotoSettingsHandler();
  
  $CapturePhotoCaptureDelegateChannel get channelCapturePhotoCaptureDelegate =>
      $CapturePhotoCaptureDelegateChannel(messenger);
  $CapturePhotoCaptureDelegateHandler get handlerCapturePhotoCaptureDelegate => $CapturePhotoCaptureDelegateHandler();
  
  $CaptureOutputChannel get channelCaptureOutput =>
      $CaptureOutputChannel(messenger);
  $CaptureOutputHandler get handlerCaptureOutput => $CaptureOutputHandler();
  
  $CapturePhotoChannel get channelCapturePhoto =>
      $CapturePhotoChannel(messenger);
  $CapturePhotoHandler get handlerCapturePhoto => $CapturePhotoHandler();
  
  $CaptureDeviceInputChannel get channelCaptureDeviceInput =>
      $CaptureDeviceInputChannel(messenger);
  $CaptureDeviceInputHandler get handlerCaptureDeviceInput => $CaptureDeviceInputHandler();
  
  $CaptureInputChannel get channelCaptureInput =>
      $CaptureInputChannel(messenger);
  $CaptureInputHandler get handlerCaptureInput => $CaptureInputHandler();
  
  $CaptureSessionChannel get channelCaptureSession =>
      $CaptureSessionChannel(messenger);
  $CaptureSessionHandler get handlerCaptureSession => $CaptureSessionHandler();
  
  $CaptureDeviceChannel get channelCaptureDevice =>
      $CaptureDeviceChannel(messenger);
  $CaptureDeviceHandler get handlerCaptureDevice => $CaptureDeviceHandler();
  
  $CaptureDeviceDiscoverySessionChannel get channelCaptureDeviceDiscoverySession =>
      $CaptureDeviceDiscoverySessionChannel(messenger);
  $CaptureDeviceDiscoverySessionHandler get handlerCaptureDeviceDiscoverySession => $CaptureDeviceDiscoverySessionHandler();
  
  $PreviewControllerChannel get channelPreviewController =>
      $PreviewControllerChannel(messenger);
  $PreviewControllerHandler get handlerPreviewController => $PreviewControllerHandler();
  
  $CaptureFileOutputChannel get channelCaptureFileOutput =>
      $CaptureFileOutputChannel(messenger);
  $CaptureFileOutputHandler get handlerCaptureFileOutput => $CaptureFileOutputHandler();
  
  $CaptureMovieFileOutputChannel get channelCaptureMovieFileOutput =>
      $CaptureMovieFileOutputChannel(messenger);
  $CaptureMovieFileOutputHandler get handlerCaptureMovieFileOutput => $CaptureMovieFileOutputHandler();
  
  $CaptureFileOutputRecordingDelegateChannel get channelCaptureFileOutputRecordingDelegate =>
      $CaptureFileOutputRecordingDelegateChannel(messenger);
  $CaptureFileOutputRecordingDelegateHandler get handlerCaptureFileOutputRecordingDelegate => $CaptureFileOutputRecordingDelegateHandler();
  
  $CaptureConnectionChannel get channelCaptureConnection =>
      $CaptureConnectionChannel(messenger);
  $CaptureConnectionHandler get handlerCaptureConnection => $CaptureConnectionHandler();
  
  $CaptureInputPortChannel get channelCaptureInputPort =>
      $CaptureInputPortChannel(messenger);
  $CaptureInputPortHandler get handlerCaptureInputPort => $CaptureInputPortHandler();
  

  
  $FinishProcessingPhotoCallbackChannel get channelFinishProcessingPhotoCallback =>
      $FinishProcessingPhotoCallbackChannel(messenger);
  $FinishProcessingPhotoCallbackHandler get handlerFinishProcessingPhotoCallback =>
      $FinishProcessingPhotoCallbackHandler(this);
  
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    
    implementations.channelCapturePhotoOutput.setHandler(
      implementations.handlerCapturePhotoOutput,
    );
    
    implementations.channelCapturePhotoSettings.setHandler(
      implementations.handlerCapturePhotoSettings,
    );
    
    implementations.channelCapturePhotoCaptureDelegate.setHandler(
      implementations.handlerCapturePhotoCaptureDelegate,
    );
    
    implementations.channelCaptureOutput.setHandler(
      implementations.handlerCaptureOutput,
    );
    
    implementations.channelCapturePhoto.setHandler(
      implementations.handlerCapturePhoto,
    );
    
    implementations.channelCaptureDeviceInput.setHandler(
      implementations.handlerCaptureDeviceInput,
    );
    
    implementations.channelCaptureInput.setHandler(
      implementations.handlerCaptureInput,
    );
    
    implementations.channelCaptureSession.setHandler(
      implementations.handlerCaptureSession,
    );
    
    implementations.channelCaptureDevice.setHandler(
      implementations.handlerCaptureDevice,
    );
    
    implementations.channelCaptureDeviceDiscoverySession.setHandler(
      implementations.handlerCaptureDeviceDiscoverySession,
    );
    
    implementations.channelPreviewController.setHandler(
      implementations.handlerPreviewController,
    );
    
    implementations.channelCaptureFileOutput.setHandler(
      implementations.handlerCaptureFileOutput,
    );
    
    implementations.channelCaptureMovieFileOutput.setHandler(
      implementations.handlerCaptureMovieFileOutput,
    );
    
    implementations.channelCaptureFileOutputRecordingDelegate.setHandler(
      implementations.handlerCaptureFileOutputRecordingDelegate,
    );
    
    implementations.channelCaptureConnection.setHandler(
      implementations.handlerCaptureConnection,
    );
    
    implementations.channelCaptureInputPort.setHandler(
      implementations.handlerCaptureInputPort,
    );
    
    
    implementations.channelFinishProcessingPhotoCallback.setHandler(
      implementations.handlerFinishProcessingPhotoCallback,
    );
    
  }

  void unregisterHandlers() {
    
    implementations.channelCapturePhotoOutput.removeHandler();
    
    implementations.channelCapturePhotoSettings.removeHandler();
    
    implementations.channelCapturePhotoCaptureDelegate.removeHandler();
    
    implementations.channelCaptureOutput.removeHandler();
    
    implementations.channelCapturePhoto.removeHandler();
    
    implementations.channelCaptureDeviceInput.removeHandler();
    
    implementations.channelCaptureInput.removeHandler();
    
    implementations.channelCaptureSession.removeHandler();
    
    implementations.channelCaptureDevice.removeHandler();
    
    implementations.channelCaptureDeviceDiscoverySession.removeHandler();
    
    implementations.channelPreviewController.removeHandler();
    
    implementations.channelCaptureFileOutput.removeHandler();
    
    implementations.channelCaptureMovieFileOutput.removeHandler();
    
    implementations.channelCaptureFileOutputRecordingDelegate.removeHandler();
    
    implementations.channelCaptureConnection.removeHandler();
    
    implementations.channelCaptureInputPort.removeHandler();
    
    
    implementations.channelFinishProcessingPhotoCallback.removeHandler();
    
  }
}
