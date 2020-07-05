#import "REFMethodChannelReferencePairManager.h"

typedef NS_ENUM(NSInteger, REFReferenceField) {
  REFRemoteReferenceValue = 128,
  REFUnpairedReferenceValue = 129,
};

NSString *const REFMethodCreate = @"REFERENCE_CREATE";
NSString *const REFMethodMethod = @"REFERENCE_METHOD";
NSString *const REFMethodDispose = @"REFERENCE_DISPOSE";

@interface REFReferenceReader : FlutterStandardReader
@end

@interface REFReferenceWriter : FlutterStandardWriter
@end

@interface REFReferenceError : NSError
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

@implementation REFReferenceError

- (NSString *)localizedDescription {
  return @"
}

@end

@implementation REFMethodChannelRemoteHandler
- (instancetype)initWithName:(NSString *)name binaaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
    
    NSObject<FlutterMethodCodec> *methodCodec = [FlutterStandardMethodCodec
                                                 codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
    _channel = [[FlutterMethodChannel alloc] initWithName:name binaryMessenger:binaryMessenger codec:methodCodec];
  }
  return self;
}

- (void)create:(nonnull REFRemoteReference *)remoteReference
       classID:(NSUInteger)classID
     arguments:(nonnull NSArray<id> *)arguments
    completion:(nonnull void (^)(NSError * _Nullable))completion {
  [_channel invokeMethod:REFMethodCreate
               arguments:@[remoteReference, @(classID), arguments]
                  result:^(id result) {
    if ([result isKindOfClass:[FlutterError class]]) {
      completion([[NSError alloc] initWithDomain:@"REFMethodChannelRemoteHandler" code:0 userInfo:nil]);
    } else if ([result isEqual:FlutterMethodNotImplemented]) {
      
    } else {
      
    }
  }];
}

- (void)dispose:(nonnull REFRemoteReference *)remoteReference completion:(nonnull void (^)(NSError * _Nullable))completion {
  
}

- (nonnull NSArray<id> *)getCreationArguments:(nonnull id<REFLocalReference>)localReference {
  return nil;
}

- (void)invokeMethod:(nonnull REFRemoteReference *)remoteReference methodName:(nonnull NSString *)methodName arguments:(nonnull NSArray<id> *)arguments completion:(nonnull void (^)(id _Nullable, NSError * _Nullable))completion {
  
}

- (void)invokeMethodOnUnpairedReference:(nonnull REFUnpairedReference *)unpairedReference methodName:(nonnull NSString *)methodName arguments:(nonnull NSArray<id> *)arguments completion:(nonnull void (^)(id _Nullable, NSError * _Nullable))completion {
  
}

@end

@implementation REFMethodChannelReferencePairManager
@end
