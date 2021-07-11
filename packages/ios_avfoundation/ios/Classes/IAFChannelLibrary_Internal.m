// GENERATED CODE - DO NOT MODIFY BY HAND



#import "IAFChannelLibrary_Internal.h"


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


@implementation _IAFFinishProcessingPhotoCallbackChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/FinishProcessingPhotoCallback"];
}

- (void)__create:(_IAFFinishProcessingPhotoCallback)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance * _Nullable, NSError * _Nullable))completion {
  [self createNewInstancePair:_instance arguments:@[] owner:_owner completion:completion];
}

- (void)invoke:(_IAFFinishProcessingPhotoCallback)_instance

      photo:(NSObject<_IAFCapturePhoto> * _Nullable)photo

    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@""
           arguments:@[photo ? (NSObject *) photo : [NSNull null],]
          completion:completion];
}
@end



@implementation _IAFFinishProcessingPhotoCallbackHandler
-(instancetype)initWithImplementations:(_IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  __block __weak _IAFFinishProcessingPhotoCallback function;
  _IAFFinishProcessingPhotoCallback functionInstance = ^(NSObject<_IAFCapturePhoto> * _Nullable photo) {
    [self->_implementations.channelFinishProcessingPhotoCallback invoke:function
                                         
                                         photo:photo
                                         
                                         completion:^(id result, NSError *error) {}];
    return (NSObject *) nil;
  };
  function = functionInstance;
  return functionInstance;
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  _IAFFinishProcessingPhotoCallback function = (_IAFFinishProcessingPhotoCallback) instance;
  return function(arguments[0]);
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}
@end



@implementation _IAFCapturePhotoOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoOutput"];
}


- (void)__create:(NSObject<_IAFCapturePhotoOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}








@end

@implementation _IAFCapturePhotoSettingsChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoSettings"];
}


- (void)__create:(NSObject<_IAFCapturePhotoSettings> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}










@end

@implementation _IAFCapturePhotoCaptureDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoCaptureDelegate"];
}


- (void)__create:(NSObject<_IAFCapturePhotoCaptureDelegate> *)_instance
         _owner:(BOOL)_owner

 didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[didFinishProcessingPhoto ? (NSObject *) didFinishProcessingPhoto : [NSNull null],]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureOutput"];
}


- (void)__create:(NSObject<_IAFCaptureOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCapturePhotoChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhoto"];
}


- (void)__create:(NSObject<_IAFCapturePhoto> *)_instance
         _owner:(BOOL)_owner

 fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[fileDataRepresentation ? (NSObject *) fileDataRepresentation : [NSNull null],]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDeviceInput"];
}


- (void)__create:(NSObject<_IAFCaptureDeviceInput> *)_instance
         _owner:(BOOL)_owner

 device:(NSObject<_IAFCaptureDevice> * _Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[device ? (NSObject *) device : [NSNull null],]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureInput"];
}


- (void)__create:(NSObject<_IAFCaptureInput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureSessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureSession"];
}


- (void)__create:(NSObject<_IAFCaptureSession> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}
















@end

@implementation _IAFCaptureDeviceChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDevice"];
}


- (void)__create:(NSObject<_IAFCaptureDevice> *)_instance
         _owner:(BOOL)_owner

 uniqueId:(NSString * _Nullable)uniqueId

 position:(NSNumber * _Nullable)position

 isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

 hasFlash:(NSNumber * _Nullable)hasFlash

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[uniqueId ? (NSObject *) uniqueId : [NSNull null],position ? (NSObject *) position : [NSNull null],isSmoothAutoFocusSupported ? (NSObject *) isSmoothAutoFocusSupported : [NSNull null],hasFlash ? (NSObject *) hasFlash : [NSNull null],]
                        owner:_owner
                   completion:completion];
}








































@end

@implementation _IAFCaptureDeviceDiscoverySessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDeviceDiscoverySession"];
}


- (void)__create:(NSObject<_IAFCaptureDeviceDiscoverySession> *)_instance
         _owner:(BOOL)_owner

 devices:(NSArray<NSObject<_IAFCaptureDevice> *> * _Nullable)devices

 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_IAFCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[devices ? (NSObject *) devices : [NSNull null],supportedMultiCamDeviceSets ? (NSObject *) supportedMultiCamDeviceSets : [NSNull null],]
                        owner:_owner
                   completion:completion];
}






@end

@implementation _IAFPreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/PreviewController"];
}


- (void)__create:(NSObject<_IAFPreviewController> *)_instance
         _owner:(BOOL)_owner

 captureSession:(NSObject<_IAFCaptureSession> * _Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[captureSession ? (NSObject *) captureSession : [NSNull null],]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureFileOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureFileOutput"];
}


- (void)__create:(NSObject<_IAFCaptureFileOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}














@end

@implementation _IAFCaptureMovieFileOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureMovieFileOutput"];
}


- (void)__create:(NSObject<_IAFCaptureMovieFileOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}






@end

@implementation _IAFCaptureFileOutputRecordingDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureFileOutputRecordingDelegate"];
}


- (void)__create:(NSObject<_IAFCaptureFileOutputRecordingDelegate> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}




@end



@implementation _IAFCapturePhotoOutputHandler
- (NSObject<_IAFCapturePhotoOutput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_capturePhotoWithSettings:(NSObject<_IAFCapturePhotoOutput> *)_instance

                     settings:(NSObject<_IAFCapturePhotoSettings> * _Nullable)settings

                     delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> * _Nullable)delegate
 {
  return [_instance capturePhotoWithSettings:settings
          delegate:delegate];
}



- (id _Nullable)_supportedFlashModes:(NSObject<_IAFCapturePhotoOutput> *)_instance
 {
  return [_instance supportedFlashModes
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoOutput> *value = (NSObject<_IAFCapturePhotoOutput> *) instance;
  
  
  if ([@"capturePhotoWithSettings" isEqualToString:methodName]) {
    return [self _capturePhotoWithSettings:value
               
               settings:arguments[0] 
               delegate:arguments[1] ];
  }
  
  else
  
  if ([@"supportedFlashModes" isEqualToString:methodName]) {
    return [self _supportedFlashModes:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCapturePhotoSettingsHandler
- (NSObject<_IAFCapturePhotoSettings> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_photoSettingsWithFormat:(NSObject<_IAFCapturePhotoSettings> *)_instance

                     format:(NSDictionary<NSString *, NSObject *> * _Nullable)format
 {
  return [_instance photoSettingsWithFormat:format
          ];
}



- (id _Nullable)_uniqueID:(NSObject<_IAFCapturePhotoSettings> *)_instance
 {
  return [_instance uniqueID
          ];
}



- (id _Nullable)_setFlashMode:(NSObject<_IAFCapturePhotoSettings> *)_instance

                     mode:(NSNumber * _Nullable)mode
 {
  return [_instance setFlashMode:mode
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoSettings> *value = (NSObject<_IAFCapturePhotoSettings> *) instance;
  
  
  if ([@"photoSettingsWithFormat" isEqualToString:methodName]) {
    return [self _photoSettingsWithFormat:value
               
               format:arguments[0] ];
  }
  
  else
  
  if ([@"uniqueID" isEqualToString:methodName]) {
    return [self _uniqueID:value
               ];
  }
  
  else
  
  if ([@"setFlashMode" isEqualToString:methodName]) {
    return [self _setFlashMode:value
               
               mode:arguments[0] ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCapturePhotoCaptureDelegateHandler
- (NSObject<_IAFCapturePhotoCaptureDelegate> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 didFinishProcessingPhoto:(_IAFFinishProcessingPhotoCallback)didFinishProcessingPhoto
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger didFinishProcessingPhoto:arguments[0] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoCaptureDelegate> *value = (NSObject<_IAFCapturePhotoCaptureDelegate> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureOutputHandler
- (NSObject<_IAFCaptureOutput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureOutput> *value = (NSObject<_IAFCaptureOutput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCapturePhotoHandler
- (NSObject<_IAFCapturePhoto> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 fileDataRepresentation:(NSData *)fileDataRepresentation
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger fileDataRepresentation:arguments[0] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhoto> *value = (NSObject<_IAFCapturePhoto> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureDeviceInputHandler
- (NSObject<_IAFCaptureDeviceInput> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 device:(NSObject<_IAFCaptureDevice> *)device
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger device:arguments[0] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDeviceInput> *value = (NSObject<_IAFCaptureDeviceInput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureInputHandler
- (NSObject<_IAFCaptureInput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureInput> *value = (NSObject<_IAFCaptureInput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureSessionHandler
- (NSObject<_IAFCaptureSession> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_addInput:(NSObject<_IAFCaptureSession> *)_instance

                     input:(NSObject<_IAFCaptureInput> * _Nullable)input
 {
  return [_instance addInput:input
          ];
}



- (id _Nullable)_addOutput:(NSObject<_IAFCaptureSession> *)_instance

                     output:(NSObject<_IAFCaptureOutput> * _Nullable)output
 {
  return [_instance addOutput:output
          ];
}



- (id _Nullable)_startRunning:(NSObject<_IAFCaptureSession> *)_instance
 {
  return [_instance startRunning
          ];
}



- (id _Nullable)_stopRunning:(NSObject<_IAFCaptureSession> *)_instance
 {
  return [_instance stopRunning
          ];
}



- (id _Nullable)_setSessionPreset:(NSObject<_IAFCaptureSession> *)_instance

                     preset:(NSString * _Nullable)preset
 {
  return [_instance setSessionPreset:preset
          ];
}



- (id _Nullable)_canSetSessionPresets:(NSObject<_IAFCaptureSession> *)_instance

                     presets:(NSArray<NSString *> * _Nullable)presets
 {
  return [_instance canSetSessionPresets:presets
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureSession> *value = (NSObject<_IAFCaptureSession> *) instance;
  
  
  if ([@"addInput" isEqualToString:methodName]) {
    return [self _addInput:value
               
               input:arguments[0] ];
  }
  
  else
  
  if ([@"addOutput" isEqualToString:methodName]) {
    return [self _addOutput:value
               
               output:arguments[0] ];
  }
  
  else
  
  if ([@"startRunning" isEqualToString:methodName]) {
    return [self _startRunning:value
               ];
  }
  
  else
  
  if ([@"stopRunning" isEqualToString:methodName]) {
    return [self _stopRunning:value
               ];
  }
  
  else
  
  if ([@"setSessionPreset" isEqualToString:methodName]) {
    return [self _setSessionPreset:value
               
               preset:arguments[0] ];
  }
  
  else
  
  if ([@"canSetSessionPresets" isEqualToString:methodName]) {
    return [self _canSetSessionPresets:value
               
               presets:arguments[0] ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureDeviceHandler
- (NSObject<_IAFCaptureDevice> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 uniqueId:(NSString *)uniqueId

                                 position:(NSNumber *)position

                                 isSmoothAutoFocusSupported:(NSNumber *)isSmoothAutoFocusSupported

                                 hasFlash:(NSNumber *)hasFlash
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}



- (id _Nullable)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString * _Nullable)mediaType
 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_lockForConfiguration:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance lockForConfiguration
          ];
}



- (id _Nullable)_unlockForConfiguration:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance unlockForConfiguration
          ];
}



- (id _Nullable)_supportsCaptureSessionPresets:(NSObject<_IAFCaptureDevice> *)_instance

                     presets:(NSArray<NSString *> * _Nullable)presets
 {
  return [_instance supportsCaptureSessionPresets:presets
          ];
}



- (id _Nullable)_isAdjustingExposure:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance isAdjustingExposure
          ];
}



- (id _Nullable)_setExposureMode:(NSObject<_IAFCaptureDevice> *)_instance

                     mode:(NSNumber * _Nullable)mode
 {
  return [_instance setExposureMode:mode
          ];
}



- (id _Nullable)_exposureModesSupported:(NSObject<_IAFCaptureDevice> *)_instance

                     modes:(NSArray<NSNumber *> * _Nullable)modes
 {
  return [_instance exposureModesSupported:modes
          ];
}



- (id _Nullable)_setFocusMode:(NSObject<_IAFCaptureDevice> *)_instance

                     mode:(NSNumber * _Nullable)mode
 {
  return [_instance setFocusMode:mode
          ];
}



- (id _Nullable)_focusModesSupported:(NSObject<_IAFCaptureDevice> *)_instance

                     modes:(NSArray<NSNumber *> * _Nullable)modes
 {
  return [_instance focusModesSupported:modes
          ];
}



- (id _Nullable)_isAdjustingFocus:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance isAdjustingFocus
          ];
}



- (id _Nullable)_setSmoothAutoFocusEnabled:(NSObject<_IAFCaptureDevice> *)_instance

                     enabled:(NSNumber * _Nullable)enabled
 {
  return [_instance setSmoothAutoFocusEnabled:enabled
          ];
}



- (id _Nullable)_isFlashAvailable:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance isFlashAvailable
          ];
}



- (id _Nullable)_setVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance

                     factor:(NSNumber * _Nullable)factor
 {
  return [_instance setVideoZoomFactor:factor
          ];
}



- (id _Nullable)_minAvailableVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance minAvailableVideoZoomFactor
          ];
}



- (id _Nullable)_maxAvailableVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance maxAvailableVideoZoomFactor
          ];
}



- (id _Nullable)_rampToVideoZoomFactor:(NSObject<_IAFCaptureDevice> *)_instance

                     factor:(NSNumber * _Nullable)factor

                     rate:(NSNumber * _Nullable)rate
 {
  return [_instance rampToVideoZoomFactor:factor
          rate:rate];
}



- (id _Nullable)_isRampingVideoZoom:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance isRampingVideoZoom
          ];
}



- (id _Nullable)_cancelVideoZoomRamp:(NSObject<_IAFCaptureDevice> *)_instance
 {
  return [_instance cancelVideoZoomRamp
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  if ([@"defaultDeviceWithMediaType" isEqualToString:methodName]) {
    return [self _defaultDeviceWithMediaType:messenger
                    
                     mediaType:arguments[0] ];
  }
  
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger uniqueId:arguments[0] position:arguments[1] isSmoothAutoFocusSupported:arguments[2] hasFlash:arguments[3] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDevice> *value = (NSObject<_IAFCaptureDevice> *) instance;
  
  
  if ([@"lockForConfiguration" isEqualToString:methodName]) {
    return [self _lockForConfiguration:value
               ];
  }
  
  else
  
  if ([@"unlockForConfiguration" isEqualToString:methodName]) {
    return [self _unlockForConfiguration:value
               ];
  }
  
  else
  
  if ([@"supportsCaptureSessionPresets" isEqualToString:methodName]) {
    return [self _supportsCaptureSessionPresets:value
               
               presets:arguments[0] ];
  }
  
  else
  
  if ([@"isAdjustingExposure" isEqualToString:methodName]) {
    return [self _isAdjustingExposure:value
               ];
  }
  
  else
  
  if ([@"setExposureMode" isEqualToString:methodName]) {
    return [self _setExposureMode:value
               
               mode:arguments[0] ];
  }
  
  else
  
  if ([@"exposureModesSupported" isEqualToString:methodName]) {
    return [self _exposureModesSupported:value
               
               modes:arguments[0] ];
  }
  
  else
  
  if ([@"setFocusMode" isEqualToString:methodName]) {
    return [self _setFocusMode:value
               
               mode:arguments[0] ];
  }
  
  else
  
  if ([@"focusModesSupported" isEqualToString:methodName]) {
    return [self _focusModesSupported:value
               
               modes:arguments[0] ];
  }
  
  else
  
  if ([@"isAdjustingFocus" isEqualToString:methodName]) {
    return [self _isAdjustingFocus:value
               ];
  }
  
  else
  
  if ([@"setSmoothAutoFocusEnabled" isEqualToString:methodName]) {
    return [self _setSmoothAutoFocusEnabled:value
               
               enabled:arguments[0] ];
  }
  
  else
  
  if ([@"isFlashAvailable" isEqualToString:methodName]) {
    return [self _isFlashAvailable:value
               ];
  }
  
  else
  
  if ([@"setVideoZoomFactor" isEqualToString:methodName]) {
    return [self _setVideoZoomFactor:value
               
               factor:arguments[0] ];
  }
  
  else
  
  if ([@"minAvailableVideoZoomFactor" isEqualToString:methodName]) {
    return [self _minAvailableVideoZoomFactor:value
               ];
  }
  
  else
  
  if ([@"maxAvailableVideoZoomFactor" isEqualToString:methodName]) {
    return [self _maxAvailableVideoZoomFactor:value
               ];
  }
  
  else
  
  if ([@"rampToVideoZoomFactor" isEqualToString:methodName]) {
    return [self _rampToVideoZoomFactor:value
               
               factor:arguments[0] 
               rate:arguments[1] ];
  }
  
  else
  
  if ([@"isRampingVideoZoom" isEqualToString:methodName]) {
    return [self _isRampingVideoZoom:value
               ];
  }
  
  else
  
  if ([@"cancelVideoZoomRamp" isEqualToString:methodName]) {
    return [self _cancelVideoZoomRamp:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureDeviceDiscoverySessionHandler
- (NSObject<_IAFCaptureDeviceDiscoverySession> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 devices:(NSArray<NSObject<_IAFCaptureDevice> *> *)devices

                                 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_IAFCaptureDevice> *> *> *)supportedMultiCamDeviceSets
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}



- (id _Nullable)_discoverySessionWithDeviceTypes:(REFTypeChannelMessenger *)messenger

                           deviceTypes:(NSArray<NSString *> * _Nullable)deviceTypes

                           mediaType:(NSString * _Nullable)mediaType

                           position:(NSNumber * _Nullable)position
 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  if ([@"discoverySessionWithDeviceTypes" isEqualToString:methodName]) {
    return [self _discoverySessionWithDeviceTypes:messenger
                    
                     deviceTypes:arguments[0] 
                     mediaType:arguments[1] 
                     position:arguments[2] ];
  }
  
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger devices:arguments[0] supportedMultiCamDeviceSets:arguments[1] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDeviceDiscoverySession> *value = (NSObject<_IAFCaptureDeviceDiscoverySession> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFPreviewControllerHandler
- (NSObject<_IAFPreviewController> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 captureSession:(NSObject<_IAFCaptureSession> *)captureSession
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger captureSession:arguments[0] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFPreviewController> *value = (NSObject<_IAFPreviewController> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureFileOutputHandler
- (NSObject<_IAFCaptureFileOutput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_outputFileURL:(NSObject<_IAFCaptureFileOutput> *)_instance
 {
  return [_instance outputFileURL
          ];
}



- (id _Nullable)_setMaxRecordedFileSize:(NSObject<_IAFCaptureFileOutput> *)_instance

                     fileSize:(NSNumber * _Nullable)fileSize
 {
  return [_instance setMaxRecordedFileSize:fileSize
          ];
}



- (id _Nullable)_isRecording:(NSObject<_IAFCaptureFileOutput> *)_instance
 {
  return [_instance isRecording
          ];
}



- (id _Nullable)_startRecordingToOutputFileURL:(NSObject<_IAFCaptureFileOutput> *)_instance

                     outputFileURL:(NSString * _Nullable)outputFileURL

                     delegate:(NSObject<_IAFCaptureFileOutputRecordingDelegate> * _Nullable)delegate
 {
  return [_instance startRecordingToOutputFileURL:outputFileURL
          delegate:delegate];
}



- (id _Nullable)_stopRecording:(NSObject<_IAFCaptureFileOutput> *)_instance
 {
  return [_instance stopRecording
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureFileOutput> *value = (NSObject<_IAFCaptureFileOutput> *) instance;
  
  
  if ([@"outputFileURL" isEqualToString:methodName]) {
    return [self _outputFileURL:value
               ];
  }
  
  else
  
  if ([@"setMaxRecordedFileSize" isEqualToString:methodName]) {
    return [self _setMaxRecordedFileSize:value
               
               fileSize:arguments[0] ];
  }
  
  else
  
  if ([@"isRecording" isEqualToString:methodName]) {
    return [self _isRecording:value
               ];
  }
  
  else
  
  if ([@"startRecordingToOutputFileURL" isEqualToString:methodName]) {
    return [self _startRecordingToOutputFileURL:value
               
               outputFileURL:arguments[0] 
               delegate:arguments[1] ];
  }
  
  else
  
  if ([@"stopRecording" isEqualToString:methodName]) {
    return [self _stopRecording:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureMovieFileOutputHandler
- (NSObject<_IAFCaptureMovieFileOutput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_availableVideoCodecTypes:(NSObject<_IAFCaptureMovieFileOutput> *)_instance
 {
  return [_instance availableVideoCodecTypes
          ];
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureMovieFileOutput> *value = (NSObject<_IAFCaptureMovieFileOutput> *) instance;
  
  
  if ([@"availableVideoCodecTypes" isEqualToString:methodName]) {
    return [self _availableVideoCodecTypes:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureFileOutputRecordingDelegateHandler
- (NSObject<_IAFCaptureFileOutputRecordingDelegate> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureFileOutputRecordingDelegate> *value = (NSObject<_IAFCaptureFileOutputRecordingDelegate> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end


@implementation _IAFLibraryImplementations
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}


- (_IAFCapturePhotoOutputChannel *)channelCapturePhotoOutput {
  return [[_IAFCapturePhotoOutputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCapturePhotoOutputHandler *)handlerCapturePhotoOutput {
  return [[_IAFCapturePhotoOutputHandler alloc] init];
}

- (_IAFCapturePhotoSettingsChannel *)channelCapturePhotoSettings {
  return [[_IAFCapturePhotoSettingsChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCapturePhotoSettingsHandler *)handlerCapturePhotoSettings {
  return [[_IAFCapturePhotoSettingsHandler alloc] init];
}

- (_IAFCapturePhotoCaptureDelegateChannel *)channelCapturePhotoCaptureDelegate {
  return [[_IAFCapturePhotoCaptureDelegateChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate {
  return [[_IAFCapturePhotoCaptureDelegateHandler alloc] init];
}

- (_IAFCaptureOutputChannel *)channelCaptureOutput {
  return [[_IAFCaptureOutputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureOutputHandler *)handlerCaptureOutput {
  return [[_IAFCaptureOutputHandler alloc] init];
}

- (_IAFCapturePhotoChannel *)channelCapturePhoto {
  return [[_IAFCapturePhotoChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCapturePhotoHandler *)handlerCapturePhoto {
  return [[_IAFCapturePhotoHandler alloc] init];
}

- (_IAFCaptureDeviceInputChannel *)channelCaptureDeviceInput {
  return [[_IAFCaptureDeviceInputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureDeviceInputHandler *)handlerCaptureDeviceInput {
  return [[_IAFCaptureDeviceInputHandler alloc] init];
}

- (_IAFCaptureInputChannel *)channelCaptureInput {
  return [[_IAFCaptureInputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureInputHandler *)handlerCaptureInput {
  return [[_IAFCaptureInputHandler alloc] init];
}

- (_IAFCaptureSessionChannel *)channelCaptureSession {
  return [[_IAFCaptureSessionChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureSessionHandler *)handlerCaptureSession {
  return [[_IAFCaptureSessionHandler alloc] init];
}

- (_IAFCaptureDeviceChannel *)channelCaptureDevice {
  return [[_IAFCaptureDeviceChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureDeviceHandler *)handlerCaptureDevice {
  return [[_IAFCaptureDeviceHandler alloc] init];
}

- (_IAFCaptureDeviceDiscoverySessionChannel *)channelCaptureDeviceDiscoverySession {
  return [[_IAFCaptureDeviceDiscoverySessionChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession {
  return [[_IAFCaptureDeviceDiscoverySessionHandler alloc] init];
}

- (_IAFPreviewControllerChannel *)channelPreviewController {
  return [[_IAFPreviewControllerChannel alloc] initWithMessenger:_messenger];
}

- (_IAFPreviewControllerHandler *)handlerPreviewController {
  return [[_IAFPreviewControllerHandler alloc] init];
}

- (_IAFCaptureFileOutputChannel *)channelCaptureFileOutput {
  return [[_IAFCaptureFileOutputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureFileOutputHandler *)handlerCaptureFileOutput {
  return [[_IAFCaptureFileOutputHandler alloc] init];
}

- (_IAFCaptureMovieFileOutputChannel *)channelCaptureMovieFileOutput {
  return [[_IAFCaptureMovieFileOutputChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput {
  return [[_IAFCaptureMovieFileOutputHandler alloc] init];
}

- (_IAFCaptureFileOutputRecordingDelegateChannel *)channelCaptureFileOutputRecordingDelegate {
  return [[_IAFCaptureFileOutputRecordingDelegateChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate {
  return [[_IAFCaptureFileOutputRecordingDelegateHandler alloc] init];
}



- (_IAFFinishProcessingPhotoCallbackChannel *)channelFinishProcessingPhotoCallback {
  return [[_IAFFinishProcessingPhotoCallbackChannel alloc] initWithMessenger:_messenger];
}

- (_IAFFinishProcessingPhotoCallbackHandler *)handlerFinishProcessingPhotoCallback {
  return [[_IAFFinishProcessingPhotoCallbackHandler alloc] initWithImplementations:self];
}

@end

@implementation _IAFChannelRegistrar
- (instancetype)initWithImplementation:(_IAFLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (void)registerHandlers {
  
  [_implementations.channelCapturePhotoOutput setHandler:_implementations.handlerCapturePhotoOutput];
  
  [_implementations.channelCapturePhotoSettings setHandler:_implementations.handlerCapturePhotoSettings];
  
  [_implementations.channelCapturePhotoCaptureDelegate setHandler:_implementations.handlerCapturePhotoCaptureDelegate];
  
  [_implementations.channelCaptureOutput setHandler:_implementations.handlerCaptureOutput];
  
  [_implementations.channelCapturePhoto setHandler:_implementations.handlerCapturePhoto];
  
  [_implementations.channelCaptureDeviceInput setHandler:_implementations.handlerCaptureDeviceInput];
  
  [_implementations.channelCaptureInput setHandler:_implementations.handlerCaptureInput];
  
  [_implementations.channelCaptureSession setHandler:_implementations.handlerCaptureSession];
  
  [_implementations.channelCaptureDevice setHandler:_implementations.handlerCaptureDevice];
  
  [_implementations.channelCaptureDeviceDiscoverySession setHandler:_implementations.handlerCaptureDeviceDiscoverySession];
  
  [_implementations.channelPreviewController setHandler:_implementations.handlerPreviewController];
  
  [_implementations.channelCaptureFileOutput setHandler:_implementations.handlerCaptureFileOutput];
  
  [_implementations.channelCaptureMovieFileOutput setHandler:_implementations.handlerCaptureMovieFileOutput];
  
  [_implementations.channelCaptureFileOutputRecordingDelegate setHandler:_implementations.handlerCaptureFileOutputRecordingDelegate];
  
  
  [_implementations.channelFinishProcessingPhotoCallback setHandler:_implementations.handlerFinishProcessingPhotoCallback];
  
}

- (void)unregisterHandlers {
  
  [_implementations.channelCapturePhotoOutput removeHandler];
  
  [_implementations.channelCapturePhotoSettings removeHandler];
  
  [_implementations.channelCapturePhotoCaptureDelegate removeHandler];
  
  [_implementations.channelCaptureOutput removeHandler];
  
  [_implementations.channelCapturePhoto removeHandler];
  
  [_implementations.channelCaptureDeviceInput removeHandler];
  
  [_implementations.channelCaptureInput removeHandler];
  
  [_implementations.channelCaptureSession removeHandler];
  
  [_implementations.channelCaptureDevice removeHandler];
  
  [_implementations.channelCaptureDeviceDiscoverySession removeHandler];
  
  [_implementations.channelPreviewController removeHandler];
  
  [_implementations.channelCaptureFileOutput removeHandler];
  
  [_implementations.channelCaptureMovieFileOutput removeHandler];
  
  [_implementations.channelCaptureFileOutputRecordingDelegate removeHandler];
  
  
  [_implementations.channelFinishProcessingPhotoCallback removeHandler];
  
}
@end

