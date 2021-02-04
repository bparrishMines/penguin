// GENERATED CODE - DO NOT MODIFY BY HAND

#import "PCM_CameraChannelLibrary.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation PCM_CaptureDeviceInputCreationArgs
@end
@implementation PCM_CaptureSessionCreationArgs
@end
@implementation PCM_CaptureDeviceCreationArgs
@end
@implementation PCM_PreviewControllerCreationArgs
@end

@implementation PCM_CaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDeviceInput"];
}




@end


@implementation PCM_CaptureSessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureSession"];
}



- (void)invoke_startRunning:(NSObject<PCM_CaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"startRunning" arguments:@[] completion:completion];
}
- (void)invoke_stopRunning:(NSObject<PCM_CaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"stopRunning" arguments:@[] completion:completion];
}
@end


@implementation PCM_CaptureDeviceChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDevice"];
}

- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"devicesWithMediaType" arguments:@[mediaType] completion:completion];
}


@end


@implementation PCM_PreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"previewController"];
}




@end

@implementation PCM_CaptureDeviceInputHandler
- (NSObject<PCM_CaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureDeviceInputCreationArgs *)args {
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
  NSObject<PCM_CaptureDeviceInput> *value = (NSObject<PCM_CaptureDeviceInput> *) instance;
  return @[value.device];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  PCM_CaptureDeviceInputCreationArgs *args = [[PCM_CaptureDeviceInputCreationArgs alloc] init];
  args.device = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<PCM_CaptureDeviceInput> *value = (NSObject<PCM_CaptureDeviceInput> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end

@implementation PCM_CaptureSessionHandler
- (NSObject<PCM_CaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureSessionCreationArgs *)args {
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
  NSObject<PCM_CaptureSession> *value = (NSObject<PCM_CaptureSession> *) instance;
  return @[value.inputs];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  PCM_CaptureSessionCreationArgs *args = [[PCM_CaptureSessionCreationArgs alloc] init];
  args.inputs = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<PCM_CaptureSession> *value = (NSObject<PCM_CaptureSession> *) instance;
  if ([@"startRunning" isEqualToString:methodName]) {
    return [value startRunning ];
  } else if ([@"stopRunning" isEqualToString:methodName]) {
    return [value stopRunning ];
  }
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end

@implementation PCM_CaptureDeviceHandler
- (NSObject<PCM_CaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_CaptureDeviceCreationArgs *)args {
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
  NSObject<PCM_CaptureDevice> *value = (NSObject<PCM_CaptureDevice> *) instance;
  return @[value.uniqueId,value.position];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  PCM_CaptureDeviceCreationArgs *args = [[PCM_CaptureDeviceCreationArgs alloc] init];
  args.uniqueId = arguments[0];
args.position = arguments[1];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<PCM_CaptureDevice> *value = (NSObject<PCM_CaptureDevice> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end

@implementation PCM_PreviewControllerHandler
- (NSObject<PCM_PreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(PCM_PreviewControllerCreationArgs *)args {
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
  NSObject<PCM_PreviewController> *value = (NSObject<PCM_PreviewController> *) instance;
  return @[value.captureSession];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  PCM_PreviewControllerCreationArgs *args = [[PCM_PreviewControllerCreationArgs alloc] init];
  args.captureSession = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<PCM_PreviewController> *value = (NSObject<PCM_PreviewController> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end
