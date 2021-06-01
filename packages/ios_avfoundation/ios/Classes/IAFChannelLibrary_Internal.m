// GENERATED CODE - DO NOT MODIFY BY HAND



#import "IAFChannelLibrary_Internal.h"


// **************************************************************************
// ReferenceGenerator
// **************************************************************************


@implementation _IAFCapturePhotoOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
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
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFCapturePhotoSettings> *)_instance
         _owner:(BOOL)_owner

 processedFormat:(NSDictionary<NSString *,NSObject *> *_Nullable)processedFormat

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[processedFormat,]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCapturePhotoCaptureDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFCapturePhotoCaptureDelegate> *)_instance
         _owner:(BOOL)_owner

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[]
                        owner:_owner
                   completion:completion];
}





- (void)_didFinishProcessingPhoto:(NSObject<_IAFCapturePhotoCaptureDelegate> *)_instance

      photo:(NSObject<_IAFCapturePhoto> *_Nullable)photo

              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@"didFinishProcessingPhoto"
           arguments:@[photo,]
          completion:completion];
}


@end

@implementation _IAFCaptureOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
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
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFCapturePhoto> *)_instance
         _owner:(BOOL)_owner

 fileDataRepresentation:(NSData *_Nullable)fileDataRepresentation

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[fileDataRepresentation,]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFCaptureDeviceInput> *)_instance
         _owner:(BOOL)_owner

 device:(NSObject<_IAFCaptureDevice> *_Nullable)device

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[device,]
                        owner:_owner
                   completion:completion];
}




@end

@implementation _IAFCaptureInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
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
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
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
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFCaptureDevice> *)_instance
         _owner:(BOOL)_owner

 uniqueId:(NSString *_Nullable)uniqueId

 position:(NSNumber *_Nullable)position

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[uniqueId,position,]
                        owner:_owner
                   completion:completion];
}






@end

@implementation _IAFPreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class__channel"];
}


- (void)__create:(NSObject<_IAFPreviewController> *)_instance
         _owner:(BOOL)_owner

 captureSession:(NSObject<_IAFCaptureSession> *_Nullable)captureSession

     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[captureSession,]
                        owner:_owner
                   completion:completion];
}




@end



@implementation _IAFCapturePhotoOutputHandler
- (NSObject<_IAFCapturePhotoOutput> *)__create:(REFTypeChannelMessenger *)messenger
                                 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)_capturePhoto:(NSObject<_IAFCapturePhotoOutput> *)_instance

                     settings:(NSObject<_IAFCapturePhotoSettings> *_Nullable)settings

                     delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> *_Nullable)delegate
 {
  return [_instance capturePhoto:settings
          delegate:delegate];
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
  
  
  if ([@"capturePhoto" isEqualToString:methodName]) {
    return [self _capturePhoto:value
               
               settings:arguments[0] 
               delegate:arguments[1] ];
  }
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCapturePhotoSettingsHandler
- (NSObject<_IAFCapturePhotoSettings> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 processedFormat:(NSDictionary<NSString *,NSObject *> *)processedFormat
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
  return [self __create:messenger processedFormat:arguments[0] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoSettings> *value = (NSObject<_IAFCapturePhotoSettings> *) instance;
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCapturePhotoCaptureDelegateHandler
- (NSObject<_IAFCapturePhotoCaptureDelegate> *)__create:(REFTypeChannelMessenger *)messenger
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

                     input:(NSObject<_IAFCaptureInput> *_Nullable)input
 {
  return [_instance addInput:input
          ];
}



- (id _Nullable)_addOutput:(NSObject<_IAFCaptureSession> *)_instance

                     output:(NSObject<_IAFCaptureOutput> *_Nullable)output
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
  
  
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end

@implementation _IAFCaptureDeviceHandler
- (NSObject<_IAFCaptureDevice> *)__create:(REFTypeChannelMessenger *)messenger
                                 
                                 uniqueId:(NSString *)uniqueId

                                 position:(NSNumber *)position
{
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}



- (id _Nullable)_devicesWithMediaType:(REFTypeChannelMessenger *)messenger

                           mediaType:(NSString *_Nullable)mediaType
 {
  @throw [NSException exceptionWithName:@"_IAFUnimplementedException" reason:nil userInfo:nil];
}





- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  if ([@"devicesWithMediaType" isEqualToString:methodName]) {
    return [self _devicesWithMediaType:messenger
                    
                     mediaType:arguments[0]] ;
  }
  
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger uniqueId:arguments[0] position:arguments[1] ];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDevice> *value = (NSObject<_IAFCaptureDevice> *) instance;
  
  
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

- (_IAFPreviewControllerChannel *)channelPreviewController {
  return [[_IAFPreviewControllerChannel alloc] initWithMessenger:_messenger];
}

- (_IAFPreviewControllerHandler *)handlerPreviewController {
  return [[_IAFPreviewControllerHandler alloc] init];
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
  
  [_implementations.channelPreviewController setHandler:_implementations.handlerPreviewController];
  
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
  
  [_implementations.channelPreviewController removeHandler];
  
}
@end

