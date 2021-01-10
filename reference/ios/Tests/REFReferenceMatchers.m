#import "REFReferenceMatchers.h"

@implementation REFTestManager
- (instancetype)init {
  self = [super initWithMessenger:nil];
  if (self) {
    _testHandler = [[REFTestHandler alloc] initWithManager:self];
    [self registerHandler:@"test_channel" handler:_testHandler];
  }
  return self;
}
@end

@implementation REFTestHandler
-(instancetype)initWithManager:(REFTestManager *)manager {
  self = [super init];
  if (self) {
    _testClassInstance = [[REFTestClass alloc] initWithManager:manager];
  }
  return self;
}

- (NSArray *)getCreationArguments:(REFTypeChannelManager *)manager instance:(NSObject *)instance {
  return @[];
}

- (id)createInstance:(REFTypeChannelManager *)manager arguments:(NSArray *)arguments {
  return _testClassInstance;
}

- (id _Nullable)invokeStaticMethod:(REFTypeChannelManager *)manager
                        methodName:(NSString *)methodName
                         arguments:(NSArray *)arguments {
  return @"return_value";
}

- (id _Nullable)invokeMethod:(REFTypeChannelManager *)manager
                    instance:(NSObject *)instance
                  methodName:(NSString *)methodName
                   arguments:(NSArray *)arguments {
  return @"return_value";
}

- (void)onInstanceDisposed:(REFTypeChannelManager *)manager
                  instance:(NSObject *)instance {
  // Do nothing.
}
@end

@implementation REFTestClass
-(instancetype)initWithManager:(REFTestManager *)manager {
  self = [super init];
  if (self) {
    _testManager = manager;
  }
  return self;
}

- (REFTypeChannel *)typeChannel {
  return [[REFTypeChannel alloc] initWithManager:_testManager name:@"test_channel"];
}
@end

@implementation IsUnpairedInstance
- (instancetype _Nonnull)initWithChannelName:(NSString *_Nonnull)channelName
                           creationArguments:(id _Nonnull)creationArguments {
  self = [super init];
  if (self) {
    _channelName = channelName;
    _creationArguments = creationArguments;
  }
  return self;
}

- (BOOL)matches:(id)item {
  if (![item isKindOfClass:[REFNewUnpairedInstance class]]) return NO;
  REFNewUnpairedInstance *unpairedInstance = item;

  if (_channelName != unpairedInstance.channelName) return NO;
  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
    return [_creationArguments matches:unpairedInstance.creationArguments];
  }

  return [_creationArguments isEqualToArray:unpairedInstance.creationArguments];
}

- (void)describeTo:(id<HCDescription>)description {
  [[[description
      appendText:[NSString stringWithFormat:@" A %@ with channelName: ",
                                            NSStringFromClass([REFNewUnpairedInstance class])]]
      appendText:_channelName]
      appendText:@" and creation arguments: "];

  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
    [_creationArguments describeTo:description];
  } else {
    [description appendText:[_creationArguments description]];
  }
}
@end

id isUnpairedInstance(NSString *_Nonnull channelName, id _Nonnull creationArguments) {
  return [[IsUnpairedInstance alloc] initWithChannelName:channelName
                                    creationArguments:creationArguments];
}

//#import "ReferenceMatchers.h"
//
//@implementation TestClass
//+ (TestClass *_Nonnull)testClass {
//  return [[TestClass alloc] init];
//}
//
//- (REFClass *)referenceClass {
//  return [REFClass fromClass:[TestClass class]];
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//  return [TestClass testClass];
//}
//@end
//
//@implementation TestClass2
//+ (TestClass2 *_Nonnull)testClass2 {
//  return [[TestClass2 alloc] init];
//}
//
//- (REFClass *)referenceClass {
//  return [REFClass fromClass:[TestClass2 class]];
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//  return [TestClass2 testClass2];
//}
//@end
//
//@implementation SpyReferenceConverter
//- (instancetype)init {
//  self = [super init];
//  if (self) {
//    _mock = mockProtocol(@protocol(REFReferenceConverter));
//  }
//  return self;
//}
//
//- (id _Nullable)convertReferencesForRemoteManager:(REFReferencePairManager *)manager
//                                              obj:(id _Nullable)obj {
//  [_mock convertReferencesForRemoteManager:manager obj:obj];
//  return [super convertReferencesForRemoteManager:manager obj:obj];
//}
//
//- (id _Nullable)convertReferencesForLocalManager:(REFReferencePairManager *)manager
//                                             obj:(id _Nullable)obj {
//  [_mock convertReferencesForLocalManager:manager obj:obj];
//  return [super convertReferencesForLocalManager:manager obj:obj];
//}
//@end
//
//@implementation TestPoolableReferencePairManager {
//  id<REFRemoteReferenceCommunicationHandler> _remoteHandler;
//  id<REFLocalReferenceCommunicationHandler> _localHandler;
//}
//
//- (instancetype)initWithSupportedClasses:(NSArray<REFClass *> *)supportedClasses
//                                  poolID:(NSString *)poolID {
//  self = [super initWithSupportedClasses:supportedClasses poolID:poolID];
//  if (self) {
//    _remoteHandler = mockProtocol(@protocol(REFRemoteReferenceCommunicationHandler));
//    _localHandler = mockProtocol(@protocol(REFLocalReferenceCommunicationHandler));
//  }
//  return self;
//}
//
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
//  return _remoteHandler;
//}
//
//- (id<REFLocalReferenceCommunicationHandler>)localHandler {
//  return _localHandler;
//}
//@end
//
//@implementation TestReferencePairManager {
//  id<REFRemoteReferenceCommunicationHandler> _remoteHandler;
//  id<REFLocalReferenceCommunicationHandler> _localHandler;
//}
//
//- (instancetype)init {
//  self = [super initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]];
//  if (self) {
//    _remoteHandler = mockProtocol(@protocol(REFRemoteReferenceCommunicationHandler));
//    _localHandler = mockProtocol(@protocol(REFLocalReferenceCommunicationHandler));
//    _spyConverter = [[SpyReferenceConverter alloc] init];
//  }
//  return self;
//}
//
//- (id<REFReferenceConverter>)converter {
//  return _spyConverter;
//}
//
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
//  return _remoteHandler;
//}
//
//- (id<REFLocalReferenceCommunicationHandler>)localHandler {
//  return _localHandler;
//}
//@end
//
//@implementation TestRemoteHandler
//- (instancetype)init {
//  NSObject<FlutterBinaryMessenger> *mockMessenger = mockProtocol(@protocol(FlutterBinaryMessenger));
//  return self = [super initWithChannelName:@"test_channel" binaryMessenger:mockMessenger];
//}
//
//- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
//  return @[];
//}
//@end
//
//@implementation TestMethodChannelReferencePairManager {
//  id<REFRemoteReferenceCommunicationHandler> _remoteHandler;
//  id<REFLocalReferenceCommunicationHandler> _localHandler;
//}
//
//- (instancetype)init {
//  self = [super initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]
//                         binaryMessenger:mockProtocol(@protocol(FlutterBinaryMessenger))
//                             channelName:@"test_channel"];
//  if (self) {
//    _remoteHandler = [[TestRemoteHandler alloc] init];
//    _localHandler = mockProtocol(@protocol(REFLocalReferenceCommunicationHandler));
//  }
//  return self;
//}
//
//- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
//  return _remoteHandler;
//}
//
//- (id<REFLocalReferenceCommunicationHandler>)localHandler {
//  return _localHandler;
//}
//@end
//
//@implementation IsUnpairedReference
//
//- (instancetype)initWithClassID:(NSUInteger)classID
//              creationArguments:(id)creationArguments
//                  managerPoolID:(NSString *)managerPoolID {
//  self = [super init];
//  if (self) {
//    _classID = classID;
//    _creationArguments = creationArguments;
//    _managerPoolID = managerPoolID;
//  }
//  return self;
//}
//
//- (BOOL)matches:(id)item {
//  if (![item isKindOfClass:[REFUnpairedReference class]]) return NO;
//  REFUnpairedReference *reference = item;
//
//  if (_classID != reference.classID) return NO;
//  if (_managerPoolID && ![_managerPoolID isEqualToString:reference.managerPoolID]) {
//    return NO;
//  }
//  if (reference.managerPoolID && ![reference.managerPoolID isEqualToString:_managerPoolID]) {
//    return NO;
//  }
//  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
//    return [_creationArguments matches:reference.creationArguments];
//  }
//
//  return [_creationArguments isEqualToArray:reference.creationArguments];
//}
//
//- (void)describeTo:(id<HCDescription>)description {
//  [[[description
//      appendText:[NSString stringWithFormat:@" An %@ with classID: ",
//                                            NSStringFromClass([REFUnpairedReference class])]]
//      appendText:[NSString stringWithFormat:@"%lu", (unsigned long)_classID]]
//      appendText:@" and creation arguments: "];
//
//  if ([_creationArguments isKindOfClass:[HCBaseMatcher class]]) {
//    [_creationArguments describeTo:description];
//  } else {
//    [description appendText:[_creationArguments description]];
//  }
//
//  [[description appendText:@" and managerPoolID: "]
//      appendText:_managerPoolID ? _managerPoolID : @"nil"];
//}
//@end
//
//id isUnpairedReference(NSUInteger classID, id creationArguments, NSString *managerPoolID) {
//  return [[IsUnpairedReference alloc] initWithClassID:classID
//                                    creationArguments:creationArguments
//                                        managerPoolID:managerPoolID];
//}
