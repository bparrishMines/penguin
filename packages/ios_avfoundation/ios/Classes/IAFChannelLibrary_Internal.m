#import "IAFChannelLibrary_Internal.h"

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

@implementation _IAFChannelRegistrar
- (instancetype)initWithImplementation:(id<_IAFLibraryImplementations>)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (void)registerHandlers {
  [_implementations.captureDeviceInputChannel setHandler:_implementations.captureDeviceInputHandler];
[_implementations.captureInputChannel setHandler:_implementations.captureInputHandler];
[_implementations.captureSessionChannel setHandler:_implementations.captureSessionHandler];
[_implementations.captureDeviceChannel setHandler:_implementations.captureDeviceHandler];
[_implementations.previewControllerChannel setHandler:_implementations.previewControllerHandler];
}

- (void)unregisterHandlers {
  [_implementations.captureDeviceInputChannel removeHandler];
[_implementations.captureInputChannel removeHandler];
[_implementations.captureSessionChannel removeHandler];
[_implementations.captureDeviceChannel removeHandler];
[_implementations.previewControllerChannel removeHandler];
}
@end
