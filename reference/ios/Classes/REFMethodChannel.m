#import "REFMethodChannel.h"

typedef NS_ENUM(NSInteger, REFReferenceField) {
  REFPairedInstanceValue = 128,
  REFNewUnpairedInstanceValue = 129,
};

NSString *const REFMethodCreate = @"REFERENCE_CREATE";
NSString *const REFMethodStaticMethod = @"REFERENCE_STATIC_METHOD";
NSString *const REFMethodMethod = @"REFERENCE_METHOD";
NSString *const REFMethodUnpairedMethod = @"REFERENCE_UNPAIRED_METHOD";
NSString *const REFMethodDispose = @"REFERENCE_DISPOSE";

@interface REFReferenceReader : FlutterStandardReader
@end

@interface REFReferenceWriter : FlutterStandardWriter
@end

@implementation REFReferenceReader
- (id _Nullable)readValueOfType:(UInt8)type {
  REFReferenceField field = (REFReferenceField)type;
  switch (field) {
    case REFPairedInstanceValue:
      return [REFPairedInstance fromID:[self readValueOfType:[self readByte]]];
    case REFNewUnpairedInstanceValue: {
      return [[REFNewUnpairedInstance alloc] initWithChannelName:[self readValueOfType:[self readByte]]
                                         creationArguments:[self readValueOfType:[self readByte]]];
    }
  }
  return [super readValueOfType:type];
}
@end

@implementation REFReferenceWriter
- (void)writeValue:(id _Nonnull)value {
  if ([value isKindOfClass:[REFPairedInstance class]]) {
    [self writeByte:REFPairedInstanceValue];
    REFPairedInstance *pairedInstance = value;
    [self writeValue:pairedInstance.instanceID];
  } else if ([value isKindOfClass:[REFNewUnpairedInstance class]]) {
    [self writeByte:REFNewUnpairedInstanceValue];
    REFNewUnpairedInstance *unpairedInstance = value;
    [self writeValue:unpairedInstance.channelName];
    [self writeValue:unpairedInstance.creationArguments];
  } else {
    [super writeValue:value];
  }
}
@end

@implementation REFReferenceReaderWriter
- (FlutterStandardReader *_Nonnull)readerWithData:(NSData *_Nonnull)data {
  return [[REFReferenceReader alloc] initWithData:data];
}

- (FlutterStandardWriter *_Nonnull)writerWithData:(NSMutableData *_Nonnull)data {
  return [[REFReferenceWriter alloc] initWithData:data];
}
@end

@implementation REFMethodChannelError {
  NSString *_description;
}

- (instancetype)init {
  return self = [super initWithDomain:@"REFReferencePluginDomain" code:0 userInfo:nil];
}

- (instancetype _Nonnull)initWithFlutterError:(FlutterError *_Nonnull)error {
  self = [self init];
  if (self) {
    _description = [[NSString alloc] initWithFormat:@"%@: %@", error.code, error.message];
  }
  return self;
}

- (instancetype _Nonnull)initWithUnimplementedMethod:(NSString *_Nonnull)methodName {
  self = [self init];
  if (self) {
    _description =
    [[NSString alloc] initWithFormat:@"Method `%@` returned as not implemented.", methodName];
  }
  return self;
}

- (NSString *)localizedDescription {
  return _description;
}
@end

@implementation REFMethodChannelMessenger
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
    _channel = channel;
  }
  return self;
}

- (void)sendCreateNewInstancePair:(nonnull NSString *)handlerChannel
          pairedInstance:(nonnull REFPairedInstance *)pairedInstance
                arguments:(nonnull NSArray<id> *)arguments
               completion:(nonnull void (^)(NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodCreate
               arguments:@[handlerChannel, pairedInstance, arguments]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion([[REFMethodChannelError alloc] initWithFlutterError:result]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      completion([[REFMethodChannelError alloc]
                  initWithUnimplementedMethod:REFMethodCreate]);
    } else {
      completion(nil);
    }
  }];
}

- (void)sendInvokeStaticMethod:(nonnull NSString *)channelName
                    methodName:(nonnull NSString *)methodName
                     arguments:(nonnull NSArray<id> *)arguments
                    completion:(nonnull void (^)(id _Nullable, NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodStaticMethod
               arguments:@[channelName, methodName, arguments ]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion(nil, [[REFMethodChannelError alloc] initWithFlutterError:result]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      completion(nil, [[REFMethodChannelError alloc]
                       initWithUnimplementedMethod:REFMethodMethod]);
    } else {
      completion(result, nil);
    }
  }];
}

- (void)sendInvokeMethod:(nonnull NSString *)channelName
         pairedInstance:(nonnull REFPairedInstance *)pairedInstance
              methodName:(nonnull NSString *)methodName
               arguments:(nonnull NSArray<id> *)arguments
              completion:(nonnull void (^)(id _Nullable, NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodMethod
               arguments:@[channelName, pairedInstance, methodName, arguments ]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion(nil, [[REFMethodChannelError alloc] initWithFlutterError:result]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      completion(nil, [[REFMethodChannelError alloc]
                       initWithUnimplementedMethod:REFMethodMethod]);
    } else {
      completion(result, nil);
    }
  }];
}

- (void)sendInvokeMethodOnUnpairedInstance:(nonnull REFNewUnpairedInstance *)unpairedReference
                                 methodName:(nonnull NSString *)methodName
                                  arguments:(nonnull NSArray<id> *)arguments
                                 completion:(nonnull void (^)(id _Nullable, NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodUnpairedMethod
               arguments:@[unpairedReference, methodName, arguments ]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion(nil, [[REFMethodChannelError alloc] initWithFlutterError:result]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      completion(nil, [[REFMethodChannelError alloc]
                       initWithUnimplementedMethod:REFMethodMethod]);
    } else {
      completion(result, nil);
    }
  }];
}

- (void)sendDisposePair:(nonnull NSString *)handlerChannel
         pairedInstance:(nonnull REFPairedInstance *)pairedInstance
             completion:(nonnull void (^)(NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodDispose
               arguments:@[handlerChannel, pairedInstance]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion([[REFMethodChannelError alloc] initWithFlutterError:result]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      completion([[REFMethodChannelError alloc]
                  initWithUnimplementedMethod:REFMethodCreate]);
    } else {
      completion(nil);
    }
  }];
}
@end

@implementation REFMethodChannelManager
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                            channelName:(NSString *)channelName {
  NSObject<FlutterMethodCodec> *methodCodec =
  [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  _channel = [[FlutterMethodChannel alloc] initWithName:channelName
                                        binaryMessenger:binaryMessenger
                                                  codec:methodCodec];
  
  self = [super initWithMessenger:[[REFMethodChannelMessenger alloc] initWithChannel:_channel]];
  
  if (self) {
    _binaryMessenger = binaryMessenger;
    __block REFMethodChannelManager *weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                     FlutterResult _Nonnull channelResult) {
      if ([REFMethodCreate isEqualToString:call.method]) {
        NSArray<id> *arguments = [call arguments];
        [weakSelf onReceiveCreateNewInstancePair:arguments[0]
                         pairedInstance:arguments[1]
                               arguments:arguments[2]];
        channelResult(nil);
      } else if ([REFMethodStaticMethod isEqualToString:call.method]) {
        NSArray<id> *arguments = [call arguments];
        NSObject *result = [weakSelf onReceiveInvokeStaticMethod:arguments[0]
                                                      methodName:arguments[1]
                                                       arguments:arguments[2]];
        channelResult(result);
      } else if ([REFMethodMethod isEqualToString:call.method]) {
        NSArray<id> *arguments = [call arguments];
        NSObject *result = [weakSelf onReceiveInvokeMethod:arguments[0]
                                           pairedInstance:arguments[1]
                                                methodName:arguments[2]
                                                 arguments:arguments[3]];
        channelResult(result);
      } else if ([REFMethodUnpairedMethod isEqualToString:call.method]) {
        NSArray<id> *arguments = [call arguments];
        NSObject *result = [weakSelf onReceiveInvokeMethodOnUnpairedInstance:arguments[0]
                                                                   methodName:arguments[1]
                                                                    arguments:arguments[2]];
        channelResult(result);
      } else if ([REFMethodDispose isEqualToString:call.method]) {
        NSArray<id> *arguments = [call arguments];
        [weakSelf onReceiveDisposePair:arguments[0] pairedInstance:arguments[1]];
        channelResult(nil);
      } else {
        channelResult(FlutterMethodNotImplemented);
      }
    }];
  }
  return self;
}
@end
