// GENERATED CODE - DO NOT MODIFY BY HAND

#import "IAVChannelLibrary_Internal.h"

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

@implementation GENIAVCaptureDeviceInputCreationArgs
@end
@implementation GENIAVCaptureSessionCreationArgs
@end
@implementation GENIAVCaptureDeviceCreationArgs
@end
@implementation GENIAVPreviewControllerCreationArgs
@end

@implementation GENIAVCaptureDeviceInputChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDeviceInput"];
}




@end


@implementation GENIAVCaptureSessionChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureSession"];
}



- (void)invoke_startRunning:(NSObject<GENIAVCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"startRunning" arguments:@[] completion:completion];
}
- (void)invoke_stopRunning:(NSObject<GENIAVCaptureSession> *)instance
            
                   completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:instance methodName:@"stopRunning" arguments:@[] completion:completion];
}
@end


@implementation GENIAVCaptureDeviceChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"captureDevice"];
}

- (void)invoke_devicesWithMediaType:(NSString *_Nullable)mediaType

                         completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"devicesWithMediaType" arguments:@[mediaType] completion:completion];
}


@end


@implementation GENIAVPreviewControllerChannel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"previewController"];
}




@end

@implementation GENIAVCaptureDeviceInputHandler
- (NSObject<GENIAVCaptureDeviceInput> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureDeviceInputCreationArgs *)args {
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
  NSObject<GENIAVCaptureDeviceInput> *value = (NSObject<GENIAVCaptureDeviceInput> *) instance;
  return @[value.device];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  GENIAVCaptureDeviceInputCreationArgs *args = [[GENIAVCaptureDeviceInputCreationArgs alloc] init];
  args.device = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<GENIAVCaptureDeviceInput> *value = (NSObject<GENIAVCaptureDeviceInput> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end

@implementation GENIAVCaptureSessionHandler
- (NSObject<GENIAVCaptureSession> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureSessionCreationArgs *)args {
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
  NSObject<GENIAVCaptureSession> *value = (NSObject<GENIAVCaptureSession> *) instance;
  return @[value.inputs];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  GENIAVCaptureSessionCreationArgs *args = [[GENIAVCaptureSessionCreationArgs alloc] init];
  args.inputs = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<GENIAVCaptureSession> *value = (NSObject<GENIAVCaptureSession> *) instance;
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

@implementation GENIAVCaptureDeviceHandler
- (NSObject<GENIAVCaptureDevice> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVCaptureDeviceCreationArgs *)args {
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
  NSObject<GENIAVCaptureDevice> *value = (NSObject<GENIAVCaptureDevice> *) instance;
  return @[value.uniqueId,value.position];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  GENIAVCaptureDeviceCreationArgs *args = [[GENIAVCaptureDeviceCreationArgs alloc] init];
  args.uniqueId = arguments[0];
args.position = arguments[1];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<GENIAVCaptureDevice> *value = (NSObject<GENIAVCaptureDevice> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end

@implementation GENIAVPreviewControllerHandler
- (NSObject<GENIAVPreviewController> *)onCreate:(REFTypeChannelMessenger *)messenger
                                    args:(GENIAVPreviewControllerCreationArgs *)args {
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
  NSObject<GENIAVPreviewController> *value = (NSObject<GENIAVPreviewController> *) instance;
  return @[value.captureSession];
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  GENIAVPreviewControllerCreationArgs *args = [[GENIAVPreviewControllerCreationArgs alloc] init];
  args.captureSession = arguments[0];
  return [self onCreate:messenger args:args];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<GENIAVPreviewController> *value = (NSObject<GENIAVPreviewController> *) instance;
  
  
  NSLog(@"Unable to invoke method %@", methodName);
  return nil;
}

- (void)onInstanceAdded:(nonnull REFTypeChannelMessenger *)messenger instance:(nonnull NSObject *)instance {}

- (void)onInstanceRemoved:(nonnull REFTypeChannelMessenger *)messenger
                 instance:(nonnull NSObject *)instance {}
@end
