// GENERATED CODE - DO NOT MODIFY BY HAND

#import "IAFChannelLibrary_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation _IAFCapturePhotoOutputCreationArgs
@end
@implementation _IAFCapturePhotoSettingsCreationArgs
@end
@implementation _IAFCapturePhotoCaptureDelegateCreationArgs
@end
@implementation _IAFCaptureOutputCreationArgs
@end
@implementation _IAFCapturePhotoCreationArgs
@end
@implementation _IAFCaptureDeviceInputCreationArgs
@end
@implementation _IAFCaptureInputCreationArgs
@end
@implementation _IAFCaptureSessionCreationArgs
@end
@implementation _IAFCaptureDeviceCreationArgs
@end
@implementation _IAFPreviewControllerCreationArgs
@end

@implementation _IAFCapturePhotoOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"capturePhotoOutput"];
}



- (void)invoke_capturePhoto:(NSObject<_IAFCapturePhotoOutput> *)instance
            settings:(NSObject<_IAFCapturePhotoSettings> *_Nullable)settings
delegate:(NSObject<_IAFCapturePhotoCaptureDelegate> *_Nullable)delegate
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"capturePhoto" arguments:@[settings,delegate] completion:completion];
}
@end


@implementation _IAFCapturePhotoSettingsChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"CapturePhotoSettings"];
}




@end


@implementation _IAFCapturePhotoCaptureDelegateChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"CapturePhotoCaptureDelegate"];
}



- (void)invoke_didFinishProcessingPhoto:(NSObject<_IAFCapturePhotoCaptureDelegate> *)instance
            photo:(NSObject<_IAFCapturePhoto> *_Nullable)photo
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"didFinishProcessingPhoto" arguments:@[photo] completion:completion];
}
@end


@implementation _IAFCaptureOutputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"CaptureOutput"];
}




@end


@implementation _IAFCapturePhotoChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"CapturePhoto"];
}




@end


@implementation _IAFCaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDeviceInput"];
}




@end


@implementation _IAFCaptureInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureInput"];
}




@end


@implementation _IAFCaptureSessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureSession"];
}



- (void)invoke_addInput:(NSObject<_IAFCaptureSession> *)instance
            input:(NSObject<_IAFCaptureInput> *_Nullable)input
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"addInput" arguments:@[input] completion:completion];
}
- (void)invoke_addOutput:(NSObject<_IAFCaptureSession> *)instance
            output:(NSObject<_IAFCaptureOutput> *_Nullable)output
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"addOutput" arguments:@[output] completion:completion];
}
- (void)invoke_startRunning:(NSObject<_IAFCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"startRunning" arguments:@[] completion:completion];
}
- (void)invoke_stopRunning:(NSObject<_IAFCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"stopRunning" arguments:@[] completion:completion];
}
@end


@implementation _IAFCaptureDeviceChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDevice"];
}

- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"devicesWithMediaType" arguments:@[mediaType] completion:completion];
}


@end


@implementation _IAFPreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"previewController"];
}




@end

@implementation _IAFCapturePhotoOutputHandler
- (NSObject<_IAFCapturePhotoOutput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoOutputCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCapturePhotoOutput> *value = (NSObject<_IAFCapturePhotoOutput> *) instance;
  return @[];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCapturePhotoOutputCreationArgs *args = [[_IAFCapturePhotoOutputCreationArgs alloc] init];
  
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoOutput> *value = (NSObject<_IAFCapturePhotoOutput> *) instance;
  if ([@"capturePhoto" isEqualToString:methodName]) {
    return [value capturePhoto:arguments[0] delegate:arguments[1]];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCapturePhotoSettingsHandler
- (NSObject<_IAFCapturePhotoSettings> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoSettingsCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCapturePhotoSettings> *value = (NSObject<_IAFCapturePhotoSettings> *) instance;
  return @[value.processedFormat];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCapturePhotoSettingsCreationArgs *args = [[_IAFCapturePhotoSettingsCreationArgs alloc] init];
  args.processedFormat = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoSettings> *value = (NSObject<_IAFCapturePhotoSettings> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCapturePhotoCaptureDelegateHandler
- (NSObject<_IAFCapturePhotoCaptureDelegate> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoCaptureDelegateCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCapturePhotoCaptureDelegate> *value = (NSObject<_IAFCapturePhotoCaptureDelegate> *) instance;
  return @[];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCapturePhotoCaptureDelegateCreationArgs *args = [[_IAFCapturePhotoCaptureDelegateCreationArgs alloc] init];
  
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhotoCaptureDelegate> *value = (NSObject<_IAFCapturePhotoCaptureDelegate> *) instance;
  if ([@"didFinishProcessingPhoto" isEqualToString:methodName]) {
    return [value didFinishProcessingPhoto:arguments[0] ];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCaptureOutputHandler
- (NSObject<_IAFCaptureOutput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureOutputCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCaptureOutput> *value = (NSObject<_IAFCaptureOutput> *) instance;
  return @[];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCaptureOutputCreationArgs *args = [[_IAFCaptureOutputCreationArgs alloc] init];
  
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureOutput> *value = (NSObject<_IAFCaptureOutput> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCapturePhotoHandler
- (NSObject<_IAFCapturePhoto> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCapturePhotoCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCapturePhoto> *value = (NSObject<_IAFCapturePhoto> *) instance;
  return @[value.fileDataRepresentation];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCapturePhotoCreationArgs *args = [[_IAFCapturePhotoCreationArgs alloc] init];
  args.fileDataRepresentation = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCapturePhoto> *value = (NSObject<_IAFCapturePhoto> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCaptureDeviceInputHandler
- (NSObject<_IAFCaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureDeviceInputCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCaptureDeviceInput> *value = (NSObject<_IAFCaptureDeviceInput> *) instance;
  return @[value.device];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCaptureDeviceInputCreationArgs *args = [[_IAFCaptureDeviceInputCreationArgs alloc] init];
  args.device = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDeviceInput> *value = (NSObject<_IAFCaptureDeviceInput> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCaptureInputHandler
- (NSObject<_IAFCaptureInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureInputCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCaptureInput> *value = (NSObject<_IAFCaptureInput> *) instance;
  return @[];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCaptureInputCreationArgs *args = [[_IAFCaptureInputCreationArgs alloc] init];
  
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureInput> *value = (NSObject<_IAFCaptureInput> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCaptureSessionHandler
- (NSObject<_IAFCaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureSessionCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCaptureSession> *value = (NSObject<_IAFCaptureSession> *) instance;
  return @[];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCaptureSessionCreationArgs *args = [[_IAFCaptureSessionCreationArgs alloc] init];
  
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureSession> *value = (NSObject<_IAFCaptureSession> *) instance;
  if ([@"addInput" isEqualToString:methodName]) {
    return [value addInput:arguments[0] ];
  } else if ([@"addOutput" isEqualToString:methodName]) {
    return [value addOutput:arguments[0] ];
  } else if ([@"startRunning" isEqualToString:methodName]) {
    return [value startRunning ];
  } else if ([@"stopRunning" isEqualToString:methodName]) {
    return [value stopRunning ];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFCaptureDeviceHandler
- (NSObject<_IAFCaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFCaptureDeviceCreationArgs *)args {
  return nil;
}

- (NSObject *_Nullable)on_devicesWithMediaType:(REFTypeChannelMessenger *)messenger
                             mediaType:(NSString *_Nullable)mediaType {
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  if ([@"devicesWithMediaType" isEqualToString:methodName]) {
    return [self on_devicesWithMediaType:messenger mediaType:arguments[0]];
  }
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFCaptureDevice> *value = (NSObject<_IAFCaptureDevice> *) instance;
  return @[value.uniqueId,value.position];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFCaptureDeviceCreationArgs *args = [[_IAFCaptureDeviceCreationArgs alloc] init];
  args.uniqueId = arguments[0];
args.position = arguments[1];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFCaptureDevice> *value = (NSObject<_IAFCaptureDevice> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}
@end
@implementation _IAFPreviewControllerHandler
- (NSObject<_IAFPreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(_IAFPreviewControllerCreationArgs *)args {
  return nil;
}



- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull NSArray *)getCreationArguments:(nonnull REFTypeChannelMessenger *)messenger
                                 instance:(nonnull NSObject *)instance {
  NSObject<_IAFPreviewController> *value = (NSObject<_IAFPreviewController> *) instance;
  return @[value.captureSession];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  _IAFPreviewControllerCreationArgs *args = [[_IAFPreviewControllerCreationArgs alloc] init];
  args.captureSession = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<_IAFPreviewController> *value = (NSObject<_IAFPreviewController> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
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

- (_IAFCapturePhotoOutputChannel *)capturePhotoOutputChannel {
  return [[_IAFCapturePhotoOutputChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCapturePhotoSettingsChannel *)capturePhotoSettingsChannel {
  return [[_IAFCapturePhotoSettingsChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCapturePhotoCaptureDelegateChannel *)capturePhotoCaptureDelegateChannel {
  return [[_IAFCapturePhotoCaptureDelegateChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCaptureOutputChannel *)captureOutputChannel {
  return [[_IAFCaptureOutputChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCapturePhotoChannel *)capturePhotoChannel {
  return [[_IAFCapturePhotoChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCaptureDeviceInputChannel *)captureDeviceInputChannel {
  return [[_IAFCaptureDeviceInputChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCaptureInputChannel *)captureInputChannel {
  return [[_IAFCaptureInputChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCaptureSessionChannel *)captureSessionChannel {
  return [[_IAFCaptureSessionChannel alloc] initWithMessenger:_messenger];
}
- (_IAFCaptureDeviceChannel *)captureDeviceChannel {
  return [[_IAFCaptureDeviceChannel alloc] initWithMessenger:_messenger];
}
- (_IAFPreviewControllerChannel *)previewControllerChannel {
  return [[_IAFPreviewControllerChannel alloc] initWithMessenger:_messenger];
}

- (_IAFCapturePhotoOutputHandler *)capturePhotoOutputHandler {
  return [[_IAFCapturePhotoOutputHandler alloc] init];
}
- (_IAFCapturePhotoSettingsHandler *)capturePhotoSettingsHandler {
  return [[_IAFCapturePhotoSettingsHandler alloc] init];
}
- (_IAFCapturePhotoCaptureDelegateHandler *)capturePhotoCaptureDelegateHandler {
  return [[_IAFCapturePhotoCaptureDelegateHandler alloc] init];
}
- (_IAFCaptureOutputHandler *)captureOutputHandler {
  return [[_IAFCaptureOutputHandler alloc] init];
}
- (_IAFCapturePhotoHandler *)capturePhotoHandler {
  return [[_IAFCapturePhotoHandler alloc] init];
}
- (_IAFCaptureDeviceInputHandler *)captureDeviceInputHandler {
  return [[_IAFCaptureDeviceInputHandler alloc] init];
}
- (_IAFCaptureInputHandler *)captureInputHandler {
  return [[_IAFCaptureInputHandler alloc] init];
}
- (_IAFCaptureSessionHandler *)captureSessionHandler {
  return [[_IAFCaptureSessionHandler alloc] init];
}
- (_IAFCaptureDeviceHandler *)captureDeviceHandler {
  return [[_IAFCaptureDeviceHandler alloc] init];
}
- (_IAFPreviewControllerHandler *)previewControllerHandler {
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
  [_implementations.capturePhotoOutputChannel setHandler:_implementations.capturePhotoOutputHandler];
[_implementations.capturePhotoSettingsChannel setHandler:_implementations.capturePhotoSettingsHandler];
[_implementations.capturePhotoCaptureDelegateChannel setHandler:_implementations.capturePhotoCaptureDelegateHandler];
[_implementations.captureOutputChannel setHandler:_implementations.captureOutputHandler];
[_implementations.capturePhotoChannel setHandler:_implementations.capturePhotoHandler];
[_implementations.captureDeviceInputChannel setHandler:_implementations.captureDeviceInputHandler];
[_implementations.captureInputChannel setHandler:_implementations.captureInputHandler];
[_implementations.captureSessionChannel setHandler:_implementations.captureSessionHandler];
[_implementations.captureDeviceChannel setHandler:_implementations.captureDeviceHandler];
[_implementations.previewControllerChannel setHandler:_implementations.previewControllerHandler];
}

- (void)unregisterHandlers {
  [_implementations.capturePhotoOutputChannel removeHandler];
[_implementations.capturePhotoSettingsChannel removeHandler];
[_implementations.capturePhotoCaptureDelegateChannel removeHandler];
[_implementations.captureOutputChannel removeHandler];
[_implementations.capturePhotoChannel removeHandler];
[_implementations.captureDeviceInputChannel removeHandler];
[_implementations.captureInputChannel removeHandler];
[_implementations.captureSessionChannel removeHandler];
[_implementations.captureDeviceChannel removeHandler];
[_implementations.previewControllerChannel removeHandler];
}
@end
