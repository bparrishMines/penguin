#import "REFMethodChannelReferencePairManager.h"

typedef NS_ENUM(NSInteger, REFReferenceField) {
  REFRemoteReferenceValue = 128,
  REFUnpairedReferenceValue = 129,
};

NSString *const REFMethodCreate = @"REFERENCE_CREATE";
NSString *const REFMethodStaticMethod = @"REFERENCE_STATIC_METHOD";
NSString *const REFMethodMethod = @"REFERENCE_METHOD";
NSString *const REFMethodDispose = @"REFERENCE_DISPOSE";

@interface REFReferenceReader : FlutterStandardReader
@end

@interface REFReferenceWriter : FlutterStandardWriter
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

@implementation REFReferenceReaderWriter
- (FlutterStandardReader *_Nonnull)readerWithData:(NSData *_Nonnull)data {
  return [[REFReferenceReader alloc] initWithData:data];
}

- (FlutterStandardWriter *_Nonnull)writerWithData:(NSMutableData *_Nonnull)data {
  return [[REFReferenceWriter alloc] initWithData:data];
}
@end

@implementation REFReferenceReader
- (id _Nullable)readValueOfType:(UInt8)type {
  REFReferenceField field = (REFReferenceField)type;
  switch (field) {
    case REFRemoteReferenceValue:
      return [REFRemoteReference fromID:[self readValueOfType:[self readByte]]];
    case REFUnpairedReferenceValue: {
      NSNumber *classID = [self readValueOfType:[self readByte]];
      return [[REFUnpairedReference alloc] initWithClassID:classID.unsignedLongValue
                                         creationArguments:[self readValueOfType:[self readByte]]
                                             managerPoolID:[self readValueOfType:[self readByte]]];
    }
  }
  return [super readValueOfType:type];
}
@end

@implementation REFReferenceWriter
- (void)writeValue:(id _Nonnull)value {
  if ([value isKindOfClass:[REFRemoteReference class]]) {
    [self writeByte:REFRemoteReferenceValue];
    REFRemoteReference *remoteReference = value;
    [self writeValue:remoteReference.referenceID];
  } else if ([value isKindOfClass:[REFUnpairedReference class]]) {
    [self writeByte:REFUnpairedReferenceValue];
    REFUnpairedReference *unpairedReference = value;
    [self writeValue:@(unpairedReference.classID)];
    [self writeValue:unpairedReference.creationArguments];
    [self writeValue:unpairedReference.managerPoolID];
  } else {
    [super writeValue:value];
  }
}
@end

@implementation REFMethodChannelRemoteHandler
- (instancetype)initWithChannelName:(NSString *)channelName
                    binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;

    NSObject<FlutterMethodCodec> *methodCodec =
        [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
    _channel = [[FlutterMethodChannel alloc] initWithName:channelName
                                          binaryMessenger:binaryMessenger
                                                    codec:methodCodec];
  }
  return self;
}

- (void)create:(nonnull REFRemoteReference *)remoteReference
       classID:(NSUInteger)classID
     arguments:(nonnull NSArray<id> *)arguments
    completion:(nonnull void (^)(NSError *_Nullable))completion {
  [_channel invokeMethod:REFMethodCreate
               arguments:@[ remoteReference, @(classID), arguments ]
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

- (void)invokeStaticMethod:(NSUInteger)classID
                methodName:(NSString *)methodName
                 arguments:(NSArray<id> *)arguments
                completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [_channel invokeMethod:REFMethodStaticMethod
               arguments:@[ @(classID), methodName, arguments ]
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

- (void)invokeMethod:(nonnull REFRemoteReference *)remoteReference
          methodName:(nonnull NSString *)methodName
           arguments:(nonnull NSArray<id> *)arguments
          completion:(nonnull void (^)(id _Nullable, NSError *_Nullable))completion {
  [_channel invokeMethod:REFMethodMethod
               arguments:@[ remoteReference, methodName, arguments ]
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

- (void)invokeMethodOnUnpairedReference:(nonnull REFUnpairedReference *)unpairedReference
                             methodName:(nonnull NSString *)methodName
                              arguments:(nonnull NSArray<id> *)arguments
                             completion:
                                 (nonnull void (^)(id _Nullable, NSError *_Nullable))completion {
  [_channel invokeMethod:REFMethodMethod
               arguments:@[ unpairedReference, methodName, arguments ]
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

- (void)dispose:(nonnull REFRemoteReference *)remoteReference
     completion:(nonnull void (^)(NSError *_Nullable))completion {
  [_channel invokeMethod:REFMethodDispose
               arguments:remoteReference
                  result:^(id result) {
                    if ([result isKindOfClass:[FlutterError class]]) {
                      completion([[REFMethodChannelError alloc] initWithFlutterError:result]);
                    } else if ([result isEqual:FlutterMethodNotImplemented]) {
                      completion([[REFMethodChannelError alloc]
                          initWithUnimplementedMethod:REFMethodDispose]);
                    } else {
                      completion(nil);
                    }
                  }];
}

- (nonnull NSArray<id> *)getCreationArguments:(nonnull id<REFLocalReference>)localReference {
  NSString *message = [NSString
      stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
  @throw
      [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
}
@end

@implementation REFMethodChannelReferencePairManager
- (instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses
                         binaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger
                             channelName:(NSString *)channelName {
  self = [super initWithSupportedClasses:supportedClasses poolID:channelName];
  if (self) {
    _channelName = channelName;
    _binaryMessenger = binaryMessenger;
    NSObject<FlutterMethodCodec> *methodCodec =
        [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
    _channel = [[FlutterMethodChannel alloc] initWithName:channelName
                                          binaryMessenger:binaryMessenger
                                                    codec:methodCodec];
  }
  return self;
}

- (void)initialize {
  [super initialize];
  __block REFReferencePairManager *weakSelf = self;
  [_channel setMethodCallHandler:^(FlutterMethodCall *_Nonnull call,
                                   FlutterResult _Nonnull channelResult) {
    // TODO: wrap in try/catch and print error
    if ([REFMethodCreate isEqualToString:call.method]) {
      NSArray<id> *arguments = [call arguments];
      NSNumber *classID = arguments[1];
      [weakSelf pairWithNewLocalReference:arguments[0]
                                  classID:classID.unsignedLongValue
                                arguments:arguments[2]];
      channelResult(nil);
    } else if ([REFMethodStaticMethod isEqualToString:call.method]) {
      NSArray<id> *arguments = [call arguments];
      NSNumber *classID = arguments[0];
      NSObject *result = [weakSelf
          invokeLocalStaticMethod:[weakSelf getReferenceClass:classID.unsignedLongValue].clazz
                       methodName:arguments[1]
                        arguments:arguments[2]];
      channelResult(result);
    } else if ([REFMethodMethod isEqualToString:call.method]) {
      NSArray<id> *arguments = [call arguments];
      NSObject *result;
      if ([arguments[0] isKindOfClass:[REFUnpairedReference class]]) {
        result = [weakSelf invokeLocalMethodOnUnpairedReference:arguments[0]
                                                     methodName:arguments[1]
                                                      arguments:arguments[2]];
      } else if ([arguments[0] isKindOfClass:[REFRemoteReference class]]) {
        result = [weakSelf invokeLocalMethod:[weakSelf getPairedLocalReference:arguments[0]]
                                  methodName:arguments[1]
                                   arguments:arguments[2]];
      } else {
        // TODO: Explanation
        @throw [NSException exceptionWithName:@"FailedMethodCall"
                                       reason:@"methodCallHandler"
                                     userInfo:nil];
      }
      channelResult(result);
    } else if ([REFMethodDispose isEqualToString:call.method]) {
      [weakSelf disposePairWithRemoteReference:call.arguments];
      channelResult(nil);
    } else {
      channelResult(FlutterMethodNotImplemented);
    }
  }];
}
@end
