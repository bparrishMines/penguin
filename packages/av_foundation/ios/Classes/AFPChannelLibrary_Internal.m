// GENERATED CODE - DO NOT MODIFY BY HAND



#import "AFPChannelLibrary_Internal.h"


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


@implementation _AFPFinishProcessingPhotoCallbackChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/FinishProcessingPhotoCallback"];
}

- (void)__create:(_AFPFinishProcessingPhotoCallback)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance * _Nullable, NSError * _Nullable))completion {
  [self createNewInstancePair:_instance arguments:@[] owner:_owner completion:completion];
}

- (void)invoke:(_AFPFinishProcessingPhotoCallback)_instance

      photo:(NSObject<_AFPCapturePhoto> * _Nullable)photo

    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@""
           arguments:@[photo ? (NSObject *) photo : [NSNull null],]
          completion:completion];
}
@end



@implementation _AFPFinishProcessingPhotoCallbackHandler
-(instancetype)initWithImplementations:(_AFPLibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  __block __weak _AFPFinishProcessingPhotoCallback function;
  _AFPFinishProcessingPhotoCallback functionInstance = ^(NSObject<_AFPCapturePhoto> * _Nullable photo) {
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
  _AFPFinishProcessingPhotoCallback function = (_AFPFinishProcessingPhotoCallback) instance;
  return function(arguments[0]);
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}
@end



@implementation _AFPCapturePhotoOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoOutput"];
}



- (void)_create_:(NSObject<_AFPCapturePhotoOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}









@end

@implementation _AFPCapturePhotoSettingsChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoSettings"];
}



- (void)_create_:(NSObject<_AFPCapturePhotoSettings> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}

- (void)_create_photoSettingsWithFormat:(NSObject<_AFPCapturePhotoSettings> *)_instance
         _owner:(BOOL)_owner

 format:(NSDictionary<NSString *, NSObject *> * _Nullable)format

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"photoSettingsWithFormat",
  format ? (NSObject *) format : [NSNull null],]
                        owner:_owner
                   completion:completion];
}









@end

@implementation _AFPCapturePhotoCaptureDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhotoCaptureDelegate"];
}



- (void)_create_:(NSObject<_AFPCapturePhotoCaptureDelegate> *)_instance
         _owner:(BOOL)_owner

 didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback _Nullable)didFinishProcessingPhoto

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  didFinishProcessingPhoto ? (NSObject *) didFinishProcessingPhoto : [NSNull null],]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureOutput"];
}



- (void)_create_:(NSObject<_AFPCaptureOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCapturePhotoChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CapturePhoto"];
}



- (void)_create_:(NSObject<_AFPCapturePhoto> *)_instance
         _owner:(BOOL)_owner

 fileDataRepresentation:(NSData * _Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  fileDataRepresentation ? (NSObject *) fileDataRepresentation : [NSNull null],]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDeviceInput"];
}



- (void)_create_:(NSObject<_AFPCaptureDeviceInput> *)_instance
         _owner:(BOOL)_owner

 device:(NSObject<_AFPCaptureDevice> * _Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  device ? (NSObject *) device : [NSNull null],]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureInput"];
}



- (void)_create_:(NSObject<_AFPCaptureInput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureSessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureSession"];
}



- (void)_create_:(NSObject<_AFPCaptureSession> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}

















@end

@implementation _AFPCaptureDeviceChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDevice"];
}



- (void)_create_:(NSObject<_AFPCaptureDevice> *)_instance
         _owner:(BOOL)_owner

 uniqueId:(NSString * _Nullable)uniqueId

 position:(NSNumber * _Nullable)position

 isSmoothAutoFocusSupported:(NSNumber * _Nullable)isSmoothAutoFocusSupported

 hasFlash:(NSNumber * _Nullable)hasFlash

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  uniqueId ? (NSObject *) uniqueId : [NSNull null],position ? (NSObject *) position : [NSNull null],isSmoothAutoFocusSupported ? (NSObject *) isSmoothAutoFocusSupported : [NSNull null],hasFlash ? (NSObject *) hasFlash : [NSNull null],]
                        owner:_owner
                   completion:completion];
}









































@end

@implementation _AFPCaptureDeviceDiscoverySessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureDeviceDiscoverySession"];
}



- (void)_create_:(NSObject<_AFPCaptureDeviceDiscoverySession> *)_instance
         _owner:(BOOL)_owner

 devices:(NSArray<NSObject<_AFPCaptureDevice> *> * _Nullable)devices

 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_AFPCaptureDevice> *> *> * _Nullable)supportedMultiCamDeviceSets

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  devices ? (NSObject *) devices : [NSNull null],supportedMultiCamDeviceSets ? (NSObject *) supportedMultiCamDeviceSets : [NSNull null],]
                        owner:_owner
                   completion:completion];
}







@end

@implementation _AFPPreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/PreviewController"];
}



- (void)_create_:(NSObject<_AFPPreviewController> *)_instance
         _owner:(BOOL)_owner

 captureSession:(NSObject<_AFPCaptureSession> * _Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  captureSession ? (NSObject *) captureSession : [NSNull null],]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureFileOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureFileOutput"];
}



- (void)_create_:(NSObject<_AFPCaptureFileOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}















@end

@implementation _AFPCaptureMovieFileOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureMovieFileOutput"];
}



- (void)_create_:(NSObject<_AFPCaptureMovieFileOutput> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}







@end

@implementation _AFPCaptureFileOutputRecordingDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureFileOutputRecordingDelegate"];
}



- (void)_create_:(NSObject<_AFPCaptureFileOutputRecordingDelegate> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  ]
                        owner:_owner
                   completion:completion];
}





@end

@implementation _AFPCaptureConnectionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureConnection"];
}



- (void)_create_:(NSObject<_AFPCaptureConnection> *)_instance
         _owner:(BOOL)_owner

 inputPorts:(NSArray<NSObject<_AFPCaptureInputPort> *> * _Nullable)inputPorts

 output:(NSObject<_AFPCaptureOutput> * _Nullable)output

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  inputPorts ? (NSObject *) inputPorts : [NSNull null],output ? (NSObject *) output : [NSNull null],]
                        owner:_owner
                   completion:completion];
}















@end

@implementation _AFPCaptureInputPortChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"ios_avfoundation/avfoundation/CaptureInputPort"];
}



- (void)_create_:(NSObject<_AFPCaptureInputPort> *)_instance
         _owner:(BOOL)_owner

 mediaType:(NSString * _Nullable)mediaType

 sourceDeviceType:(NSString * _Nullable)sourceDeviceType

 sourceDevicePosition:(NSNumber * _Nullable)sourceDevicePosition

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"",
  mediaType ? (NSObject *) mediaType : [NSNull null],sourceDeviceType ? (NSObject *) sourceDeviceType : [NSNull null],sourceDevicePosition ? (NSObject *) sourceDevicePosition : [NSNull null],]
                        owner:_owner
                   completion:completion];
}







@end



@implementation _AFPCapturePhotoOutputHandler

- (NSObject<_AFPCapturePhotoOutput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_capturePhotoWithSettings:(NSObject<_AFPCapturePhotoOutput> *)_instance

                     settings:(NSObject<_AFPCapturePhotoSettings> * _Nullable)settings

                     delegate:(NSObject<_AFPCapturePhotoCaptureDelegate> * _Nullable)delegate
 {
  return [_instance capturePhotoWithSettings:settings
          delegate:delegate];
}



- (id _Nullable)_supportedFlashModes:(NSObject<_AFPCapturePhotoOutput> *)_instance
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CapturePhotoOutput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCapturePhotoOutput> *value = (NSObject<_AFPCapturePhotoOutput> *) instance;
  
  
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

@implementation _AFPCapturePhotoSettingsHandler

- (NSObject<_AFPCapturePhotoSettings> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}

- (NSObject<_AFPCapturePhotoSettings> *)_create_photoSettingsWithFormat:(REFTypeChannelMessenger *)messenger
                                 
                                 format:(NSDictionary<NSString *, NSObject *> *)format
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_uniqueID:(NSObject<_AFPCapturePhotoSettings> *)_instance
 {
  return [_instance uniqueID
          ];
}



- (id _Nullable)_setFlashMode:(NSObject<_AFPCapturePhotoSettings> *)_instance

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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  else
  if ([@"photoSettingsWithFormat" isEqualToString:constructorName]) {
    return [self _create_photoSettingsWithFormat:messenger
            format:arguments[1] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CapturePhotoSettings' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCapturePhotoSettings> *value = (NSObject<_AFPCapturePhotoSettings> *) instance;
  
  
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

@implementation _AFPCapturePhotoCaptureDelegateHandler

- (NSObject<_AFPCapturePhotoCaptureDelegate> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 didFinishProcessingPhoto:(_AFPFinishProcessingPhotoCallback)didFinishProcessingPhoto
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            didFinishProcessingPhoto:arguments[1] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CapturePhotoCaptureDelegate' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCapturePhotoCaptureDelegate> *value = (NSObject<_AFPCapturePhotoCaptureDelegate> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureOutputHandler

- (NSObject<_AFPCaptureOutput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureOutput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureOutput> *value = (NSObject<_AFPCaptureOutput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCapturePhotoHandler

- (NSObject<_AFPCapturePhoto> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 fileDataRepresentation:(NSData *)fileDataRepresentation
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            fileDataRepresentation:arguments[1] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CapturePhoto' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCapturePhoto> *value = (NSObject<_AFPCapturePhoto> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureDeviceInputHandler

- (NSObject<_AFPCaptureDeviceInput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 device:(NSObject<_AFPCaptureDevice> *)device
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            device:arguments[1] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureDeviceInput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureDeviceInput> *value = (NSObject<_AFPCaptureDeviceInput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureInputHandler

- (NSObject<_AFPCaptureInput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureInput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureInput> *value = (NSObject<_AFPCaptureInput> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureSessionHandler

- (NSObject<_AFPCaptureSession> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_addInput:(NSObject<_AFPCaptureSession> *)_instance

                     input:(NSObject<_AFPCaptureInput> * _Nullable)input
 {
  return [_instance addInput:input
          ];
}



- (id _Nullable)_addOutput:(NSObject<_AFPCaptureSession> *)_instance

                     output:(NSObject<_AFPCaptureOutput> * _Nullable)output
 {
  return [_instance addOutput:output
          ];
}



- (id _Nullable)_startRunning:(NSObject<_AFPCaptureSession> *)_instance
 {
  return [_instance startRunning
          ];
}



- (id _Nullable)_stopRunning:(NSObject<_AFPCaptureSession> *)_instance
 {
  return [_instance stopRunning
          ];
}



- (id _Nullable)_setSessionPreset:(NSObject<_AFPCaptureSession> *)_instance

                     preset:(NSString * _Nullable)preset
 {
  return [_instance setSessionPreset:preset
          ];
}



- (id _Nullable)_canSetSessionPresets:(NSObject<_AFPCaptureSession> *)_instance

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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureSession' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureSession> *value = (NSObject<_AFPCaptureSession> *) instance;
  
  
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

@implementation _AFPCaptureDeviceHandler

- (NSObject<_AFPCaptureDevice> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 uniqueId:(NSString *)uniqueId

                                 position:(NSNumber *)position

                                 isSmoothAutoFocusSupported:(NSNumber *)isSmoothAutoFocusSupported

                                 hasFlash:(NSNumber *)hasFlash
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}




- (id _Nullable)_defaultDeviceWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString * _Nullable)mediaType
 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_lockForConfiguration:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance lockForConfiguration
          ];
}



- (id _Nullable)_unlockForConfiguration:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance unlockForConfiguration
          ];
}



- (id _Nullable)_supportsCaptureSessionPresets:(NSObject<_AFPCaptureDevice> *)_instance

                     presets:(NSArray<NSString *> * _Nullable)presets
 {
  return [_instance supportsCaptureSessionPresets:presets
          ];
}



- (id _Nullable)_isAdjustingExposure:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance isAdjustingExposure
          ];
}



- (id _Nullable)_setExposureMode:(NSObject<_AFPCaptureDevice> *)_instance

                     mode:(NSNumber * _Nullable)mode
 {
  return [_instance setExposureMode:mode
          ];
}



- (id _Nullable)_exposureModesSupported:(NSObject<_AFPCaptureDevice> *)_instance

                     modes:(NSArray<NSNumber *> * _Nullable)modes
 {
  return [_instance exposureModesSupported:modes
          ];
}



- (id _Nullable)_setFocusMode:(NSObject<_AFPCaptureDevice> *)_instance

                     mode:(NSNumber * _Nullable)mode
 {
  return [_instance setFocusMode:mode
          ];
}



- (id _Nullable)_focusModesSupported:(NSObject<_AFPCaptureDevice> *)_instance

                     modes:(NSArray<NSNumber *> * _Nullable)modes
 {
  return [_instance focusModesSupported:modes
          ];
}



- (id _Nullable)_isAdjustingFocus:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance isAdjustingFocus
          ];
}



- (id _Nullable)_setSmoothAutoFocusEnabled:(NSObject<_AFPCaptureDevice> *)_instance

                     enabled:(NSNumber * _Nullable)enabled
 {
  return [_instance setSmoothAutoFocusEnabled:enabled
          ];
}



- (id _Nullable)_isFlashAvailable:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance isFlashAvailable
          ];
}



- (id _Nullable)_setVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance

                     factor:(NSNumber * _Nullable)factor
 {
  return [_instance setVideoZoomFactor:factor
          ];
}



- (id _Nullable)_minAvailableVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance minAvailableVideoZoomFactor
          ];
}



- (id _Nullable)_maxAvailableVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance maxAvailableVideoZoomFactor
          ];
}



- (id _Nullable)_rampToVideoZoomFactor:(NSObject<_AFPCaptureDevice> *)_instance

                     factor:(NSNumber * _Nullable)factor

                     rate:(NSNumber * _Nullable)rate
 {
  return [_instance rampToVideoZoomFactor:factor
          rate:rate];
}



- (id _Nullable)_isRampingVideoZoom:(NSObject<_AFPCaptureDevice> *)_instance
 {
  return [_instance isRampingVideoZoom
          ];
}



- (id _Nullable)_cancelVideoZoomRamp:(NSObject<_AFPCaptureDevice> *)_instance
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            uniqueId:arguments[1] position:arguments[2] isSmoothAutoFocusSupported:arguments[3] hasFlash:arguments[4] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureDevice' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureDevice> *value = (NSObject<_AFPCaptureDevice> *) instance;
  
  
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

@implementation _AFPCaptureDeviceDiscoverySessionHandler

- (NSObject<_AFPCaptureDeviceDiscoverySession> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 devices:(NSArray<NSObject<_AFPCaptureDevice> *> *)devices

                                 supportedMultiCamDeviceSets:(NSArray<NSArray<NSObject<_AFPCaptureDevice> *> *> *)supportedMultiCamDeviceSets
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}




- (id _Nullable)_discoverySessionWithDeviceTypes:(REFTypeChannelMessenger *)messenger

                           deviceTypes:(NSArray<NSString *> * _Nullable)deviceTypes

                           mediaType:(NSString * _Nullable)mediaType

                           position:(NSNumber * _Nullable)position
 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            devices:arguments[1] supportedMultiCamDeviceSets:arguments[2] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureDeviceDiscoverySession' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureDeviceDiscoverySession> *value = (NSObject<_AFPCaptureDeviceDiscoverySession> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPPreviewControllerHandler

- (NSObject<_AFPPreviewController> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 captureSession:(NSObject<_AFPCaptureSession> *)captureSession
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            captureSession:arguments[1] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'PreviewController' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPPreviewController> *value = (NSObject<_AFPPreviewController> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureFileOutputHandler

- (NSObject<_AFPCaptureFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_outputFileURL:(NSObject<_AFPCaptureFileOutput> *)_instance
 {
  return [_instance outputFileURL
          ];
}



- (id _Nullable)_setMaxRecordedFileSize:(NSObject<_AFPCaptureFileOutput> *)_instance

                     fileSize:(NSNumber * _Nullable)fileSize
 {
  return [_instance setMaxRecordedFileSize:fileSize
          ];
}



- (id _Nullable)_isRecording:(NSObject<_AFPCaptureFileOutput> *)_instance
 {
  return [_instance isRecording
          ];
}



- (id _Nullable)_startRecordingToOutputFileURL:(NSObject<_AFPCaptureFileOutput> *)_instance

                     outputFileURL:(NSString * _Nullable)outputFileURL

                     delegate:(NSObject<_AFPCaptureFileOutputRecordingDelegate> * _Nullable)delegate
 {
  return [_instance startRecordingToOutputFileURL:outputFileURL
          delegate:delegate];
}



- (id _Nullable)_stopRecording:(NSObject<_AFPCaptureFileOutput> *)_instance
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureFileOutput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureFileOutput> *value = (NSObject<_AFPCaptureFileOutput> *) instance;
  
  
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

@implementation _AFPCaptureMovieFileOutputHandler

- (NSObject<_AFPCaptureMovieFileOutput> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_availableVideoCodecTypes:(NSObject<_AFPCaptureMovieFileOutput> *)_instance
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureMovieFileOutput' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureMovieFileOutput> *value = (NSObject<_AFPCaptureMovieFileOutput> *) instance;
  
  
  if ([@"availableVideoCodecTypes" isEqualToString:methodName]) {
    return [self _availableVideoCodecTypes:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureFileOutputRecordingDelegateHandler

- (NSObject<_AFPCaptureFileOutputRecordingDelegate> *)_create_:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureFileOutputRecordingDelegate' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureFileOutputRecordingDelegate> *value = (NSObject<_AFPCaptureFileOutputRecordingDelegate> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureConnectionHandler

- (NSObject<_AFPCaptureConnection> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 inputPorts:(NSArray<NSObject<_AFPCaptureInputPort> *> *)inputPorts

                                 output:(NSObject<_AFPCaptureOutput> *)output
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_setVideoOrientation:(NSObject<_AFPCaptureConnection> *)_instance

                     orientation:(NSNumber * _Nullable)orientation
 {
  return [_instance setVideoOrientation:orientation
          ];
}



- (id _Nullable)_isVideoOrientationSupported:(NSObject<_AFPCaptureConnection> *)_instance
 {
  return [_instance isVideoOrientationSupported
          ];
}



- (id _Nullable)_setAutomaticallyAdjustsVideoMirroring:(NSObject<_AFPCaptureConnection> *)_instance

                     adjust:(NSNumber * _Nullable)adjust
 {
  return [_instance setAutomaticallyAdjustsVideoMirroring:adjust
          ];
}



- (id _Nullable)_setVideoMirrored:(NSObject<_AFPCaptureConnection> *)_instance

                     mirrored:(NSNumber * _Nullable)mirrored
 {
  return [_instance setVideoMirrored:mirrored
          ];
}



- (id _Nullable)_isVideoMirroringSupported:(NSObject<_AFPCaptureConnection> *)_instance
 {
  return [_instance isVideoMirroringSupported
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            inputPorts:arguments[1] output:arguments[2] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureConnection' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureConnection> *value = (NSObject<_AFPCaptureConnection> *) instance;
  
  
  if ([@"setVideoOrientation" isEqualToString:methodName]) {
    return [self _setVideoOrientation:value
               
               orientation:arguments[0] ];
  }
  
  else
  
  if ([@"isVideoOrientationSupported" isEqualToString:methodName]) {
    return [self _isVideoOrientationSupported:value
               ];
  }
  
  else
  
  if ([@"setAutomaticallyAdjustsVideoMirroring" isEqualToString:methodName]) {
    return [self _setAutomaticallyAdjustsVideoMirroring:value
               
               adjust:arguments[0] ];
  }
  
  else
  
  if ([@"setVideoMirrored" isEqualToString:methodName]) {
    return [self _setVideoMirrored:value
               
               mirrored:arguments[0] ];
  }
  
  else
  
  if ([@"isVideoMirroringSupported" isEqualToString:methodName]) {
    return [self _isVideoMirroringSupported:value
               ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _AFPCaptureInputPortHandler

- (NSObject<_AFPCaptureInputPort> *)_create_:(REFTypeChannelMessenger *)messenger
                                 
                                 mediaType:(NSString *)mediaType

                                 sourceDeviceType:(NSString *)sourceDeviceType

                                 sourceDevicePosition:(NSNumber *)sourceDevicePosition
{
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:nil userInfo:nil];
}






- (id _Nullable)_setEnabled:(NSObject<_AFPCaptureInputPort> *)_instance

                     enabled:(NSNumber * _Nullable)enabled
 {
  return [_instance setEnabled:enabled
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
  NSString *constructorName = arguments[0];
  
  if ([@"" isEqualToString:constructorName]) {
    return [self _create_:messenger
            mediaType:arguments[1] sourceDeviceType:arguments[2] sourceDevicePosition:arguments[3] ];
  }
  
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a 'CaptureInputPort' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"_AFPUnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_AFPCaptureInputPort> *value = (NSObject<_AFPCaptureInputPort> *) instance;
  
  
  if ([@"setEnabled" isEqualToString:methodName]) {
    return [self _setEnabled:value
               
               enabled:arguments[0] ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end


@implementation _AFPLibraryImplementations
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}


- (_AFPCapturePhotoOutputChannel *)channelCapturePhotoOutput {
  return [[_AFPCapturePhotoOutputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCapturePhotoOutputHandler *)handlerCapturePhotoOutput {
  return [[_AFPCapturePhotoOutputHandler alloc] init];
}

- (_AFPCapturePhotoSettingsChannel *)channelCapturePhotoSettings {
  return [[_AFPCapturePhotoSettingsChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCapturePhotoSettingsHandler *)handlerCapturePhotoSettings {
  return [[_AFPCapturePhotoSettingsHandler alloc] init];
}

- (_AFPCapturePhotoCaptureDelegateChannel *)channelCapturePhotoCaptureDelegate {
  return [[_AFPCapturePhotoCaptureDelegateChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCapturePhotoCaptureDelegateHandler *)handlerCapturePhotoCaptureDelegate {
  return [[_AFPCapturePhotoCaptureDelegateHandler alloc] init];
}

- (_AFPCaptureOutputChannel *)channelCaptureOutput {
  return [[_AFPCaptureOutputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureOutputHandler *)handlerCaptureOutput {
  return [[_AFPCaptureOutputHandler alloc] init];
}

- (_AFPCapturePhotoChannel *)channelCapturePhoto {
  return [[_AFPCapturePhotoChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCapturePhotoHandler *)handlerCapturePhoto {
  return [[_AFPCapturePhotoHandler alloc] init];
}

- (_AFPCaptureDeviceInputChannel *)channelCaptureDeviceInput {
  return [[_AFPCaptureDeviceInputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureDeviceInputHandler *)handlerCaptureDeviceInput {
  return [[_AFPCaptureDeviceInputHandler alloc] init];
}

- (_AFPCaptureInputChannel *)channelCaptureInput {
  return [[_AFPCaptureInputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureInputHandler *)handlerCaptureInput {
  return [[_AFPCaptureInputHandler alloc] init];
}

- (_AFPCaptureSessionChannel *)channelCaptureSession {
  return [[_AFPCaptureSessionChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureSessionHandler *)handlerCaptureSession {
  return [[_AFPCaptureSessionHandler alloc] init];
}

- (_AFPCaptureDeviceChannel *)channelCaptureDevice {
  return [[_AFPCaptureDeviceChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureDeviceHandler *)handlerCaptureDevice {
  return [[_AFPCaptureDeviceHandler alloc] init];
}

- (_AFPCaptureDeviceDiscoverySessionChannel *)channelCaptureDeviceDiscoverySession {
  return [[_AFPCaptureDeviceDiscoverySessionChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureDeviceDiscoverySessionHandler *)handlerCaptureDeviceDiscoverySession {
  return [[_AFPCaptureDeviceDiscoverySessionHandler alloc] init];
}

- (_AFPPreviewControllerChannel *)channelPreviewController {
  return [[_AFPPreviewControllerChannel alloc] initWithMessenger:_messenger];
}

- (_AFPPreviewControllerHandler *)handlerPreviewController {
  return [[_AFPPreviewControllerHandler alloc] init];
}

- (_AFPCaptureFileOutputChannel *)channelCaptureFileOutput {
  return [[_AFPCaptureFileOutputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureFileOutputHandler *)handlerCaptureFileOutput {
  return [[_AFPCaptureFileOutputHandler alloc] init];
}

- (_AFPCaptureMovieFileOutputChannel *)channelCaptureMovieFileOutput {
  return [[_AFPCaptureMovieFileOutputChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureMovieFileOutputHandler *)handlerCaptureMovieFileOutput {
  return [[_AFPCaptureMovieFileOutputHandler alloc] init];
}

- (_AFPCaptureFileOutputRecordingDelegateChannel *)channelCaptureFileOutputRecordingDelegate {
  return [[_AFPCaptureFileOutputRecordingDelegateChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureFileOutputRecordingDelegateHandler *)handlerCaptureFileOutputRecordingDelegate {
  return [[_AFPCaptureFileOutputRecordingDelegateHandler alloc] init];
}

- (_AFPCaptureConnectionChannel *)channelCaptureConnection {
  return [[_AFPCaptureConnectionChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureConnectionHandler *)handlerCaptureConnection {
  return [[_AFPCaptureConnectionHandler alloc] init];
}

- (_AFPCaptureInputPortChannel *)channelCaptureInputPort {
  return [[_AFPCaptureInputPortChannel alloc] initWithMessenger:_messenger];
}

- (_AFPCaptureInputPortHandler *)handlerCaptureInputPort {
  return [[_AFPCaptureInputPortHandler alloc] init];
}



- (_AFPFinishProcessingPhotoCallbackChannel *)channelFinishProcessingPhotoCallback {
  return [[_AFPFinishProcessingPhotoCallbackChannel alloc] initWithMessenger:_messenger];
}

- (_AFPFinishProcessingPhotoCallbackHandler *)handlerFinishProcessingPhotoCallback {
  return [[_AFPFinishProcessingPhotoCallbackHandler alloc] initWithImplementations:self];
}

@end

@implementation _AFPChannelRegistrar
- (instancetype)initWithImplementation:(_AFPLibraryImplementations *)implementations {
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
  
  [_implementations.channelCaptureConnection setHandler:_implementations.handlerCaptureConnection];
  
  [_implementations.channelCaptureInputPort setHandler:_implementations.handlerCaptureInputPort];
  
  
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
  
  [_implementations.channelCaptureConnection removeHandler];
  
  [_implementations.channelCaptureInputPort removeHandler];
  
  
  [_implementations.channelFinishProcessingPhotoCallback removeHandler];
  
}
@end

