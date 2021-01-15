#import <Flutter/Flutter.h>
#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTestBinaryMessenger : NSObject<FlutterBinaryMessenger>
@property (readonly) NSMutableArray<FlutterMethodCall *> *methodCalls;
@property (readonly) NSMutableDictionary<NSString *, FlutterBinaryMessageHandler> *handlers;
@property (readonly) FlutterMethodCallHandler testMethodCallHandler;
@end

@interface REFTestMethodChannelManager : REFMethodChannelManager
@property (readonly) REFTestHandler *_Nonnull testHandler;
@end

@implementation REFTestBinaryMessenger {
  FlutterStandardMethodCodec *_methodCodec;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _methodCalls = [NSMutableArray array];
    _handlers = [NSMutableDictionary dictionary];
    _testMethodCallHandler = ^(FlutterMethodCall *call, FlutterResult result) {
      result(nil);
    };
    
    _methodCodec = [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  }
  return self;
}

- (void)sendOnChannel:(NSString*)channel message:(NSData* _Nullable)message {
  [self sendOnChannel:channel message:message binaryReply:nil];
}

- (void)sendOnChannel:(NSString*)channel
              message:(NSData* _Nullable)message
          binaryReply:(FlutterBinaryReply _Nullable)callback {
  if ([@"test_method_channel" isEqualToString:channel]) {
    FlutterMethodCall *methodCall = [_methodCodec decodeMethodCall:message];
    [_methodCalls addObject:methodCall];
    _testMethodCallHandler(methodCall, ^(id result) {
      callback([self->_methodCodec encodeSuccessEnvelope:result]);
    });
  }
}

- (FlutterBinaryMessengerConnection)setMessageHandlerOnChannel:(NSString*)channel
                 binaryMessageHandler:(FlutterBinaryMessageHandler _Nullable)handler {
  if (!handler) {
    [_handlers removeObjectForKey:channel];
  } else {
    _handlers[channel] = handler;
  }
  
  return 1;
}

- (void)handlePlatformMessage:(NSString *)channel
                   methodCall:(FlutterMethodCall *)methodCall
                       result:(FlutterResult)result {
  FlutterBinaryMessageHandler handler = _handlers[channel];
  if (!handler) return;
  handler([_methodCodec encodeMethodCall:methodCall], ^(NSData *reply) {
    if (result && reply) {
      result([self->_methodCodec decodeEnvelope:reply]);
    }
  });
}

- (void)cleanupConnection:(FlutterBinaryMessengerConnection)connection {
  // Do nothing.
}
@end

@implementation REFTestMethodChannelManager
- (instancetype)init {
  self = [super initWithBinaryMessenger:[[REFTestBinaryMessenger alloc] init]
                            channelName:@"test_method_channel"];
  if (self) {
    _testHandler = [[REFTestHandler alloc] initWithManager:self];
    [self registerHandler:@"test_channel" handler:_testHandler];
  }
  return self;
}

- (NSString *)generateUniqueInstanceId {
  return @"test_instance_id";
}
@end

@interface REFMethodChannelTest : XCTestCase
@end

@implementation REFMethodChannelTest {
  FlutterStandardMethodCodec *_methodCodec;
  id<FlutterMessageCodec> _messageCodec;
  REFTestMethodChannelManager *_testManager;
  REFTestBinaryMessenger *_testBinaryMessenger;
}

- (void)setUp {
  _messageCodec =
      [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  _methodCodec =
      [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];

  _testManager = [[REFTestMethodChannelManager alloc] init];
  _testBinaryMessenger = (REFTestBinaryMessenger *) _testManager.binaryMessenger;
}

- (void)testReferenceReaderWriter_encodeAndDecodePairedInstance {
  XCTAssertEqualObjects(
      [_messageCodec decode:[_messageCodec encode:[REFPairedInstance fromID:@"taco"]]],
      [REFPairedInstance fromID:@"taco"]);
}

- (void)testReferenceReaderWriter_encodeAndDecodeUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance =
      [[REFNewUnpairedInstance alloc] initWithChannelName:@"a_channel" creationArguments:@[]];

  NSData *data = [_messageCodec encode:unpairedInstance];
  REFNewUnpairedInstance *result = [_messageCodec decode:data];
  XCTAssertEqualObjects(result.channelName, @"a_channel");
  XCTAssertEqualObjects(result.creationArguments, @[]);
  
  // TODO: WHY DOESN'T THIS WORK!
  //  assertThat(result, isUnpairedInstance(@"a_channel", @[]));
}

- (void)testMethodChannelManager_onReceiveCreateNewInstancePair {
  NSArray *arguments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_CREATE" arguments:arguments];

  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:nil];
  XCTAssertTrue([_testManager isPaired:_testManager.testHandler.testClassInstance]);
}

//- (void)testMethodChannelManager_onReceiveInvokeStaticMethod {
//  NSArray *arguments = @[@"test_channel", @"aStaticMethod", @[]];
//  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_STATIC_METHOD"
//                                                                    arguments:arguments];
//
//  __block id blockResult;
//  [_testManager.testMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
//    blockResult = result;
//  }];
//  XCTAssertEqualObjects(@"return_value", blockResult);
//}

- (void)testMethodChannelManager_onReceiveInvokeMethod {
  
}
@end

//#import <XCTest/XCTest.h>
//#import "ReferenceMatchers.h"
//
//@import OCMockito;
//@import OCHamcrest;
//
//@import reference;
//
//@interface REFMethodChannelTest : XCTestCase
//@end
//
//@implementation REFMethodChannelTest {
//  FlutterStandardMethodCodec *_methodCodec;
//  id<FlutterMessageCodec> _messageCodec;
//  TestMethodChannelReferencePairManager *_testManager;
//}
//
//- (void)setUp {
//  _messageCodec =
//      [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
//  _methodCodec =
//      [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
//
//  _testManager = [[TestMethodChannelReferencePairManager alloc] init];
//  [_testManager initialize];
//}
//
//- (FlutterMethodCall *_Nonnull)getRemoteHandlerMethodCall {
//  TestRemoteHandler *remoteHandler = (TestRemoteHandler *)_testManager.remoteHandler;
//
//  HCArgumentCaptor *messageCaptor = [[HCArgumentCaptor alloc] init];
//  [verify(remoteHandler.binaryMessenger) sendOnChannel:@"test_channel"
//                                               message:(id)messageCaptor
//                                           binaryReply:anything()];
//
//  NSData *messageData = messageCaptor.value;
//
//  return [_methodCodec decodeMethodCall:messageData];
//}
//
//- (FlutterBinaryMessageHandler _Nullable)getBinaryMessageHandler {
//  HCArgumentCaptor *handlerCaptor = [[HCArgumentCaptor alloc] init];
//  [verify(_testManager.binaryMessenger) setMessageHandlerOnChannel:@"test_channel"
//                                              binaryMessageHandler:(id)handlerCaptor];
//
//  return handlerCaptor.value;
//}
//
//- (void)testReferenceReaderWriter_encodeAndDecodeRemoteReference {
//  XCTAssertEqualObjects(
//      [_messageCodec decode:[_messageCodec encode:[REFRemoteReference fromID:@"taco"]]],
//      [REFRemoteReference fromID:@"taco"]);
//}
//
//- (void)testReferenceReaderWriter_encodeAndDecodeUnpairedReference {
//  REFUnpairedReference *unpairedReference =
//      [[REFUnpairedReference alloc] initWithClassID:5 creationArguments:@[] managerPoolID:@"tiny"];
//
//  NSData *data = [_messageCodec encode:unpairedReference];
//  assertThat([_messageCodec decode:data], isUnpairedReference(5, isEmpty(), @"tiny"));
//}
//
//- (void)testMethodChannelReferencePairManager_pairWithNewRemoteReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_CREATE");
//  assertThat(call.arguments, contains(equalTo(remoteReference), equalTo(@(0)), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteStaticMethod {
//  [_testManager invokeRemoteStaticMethod:[TestClass class]
//                              methodName:@"aStaticMethod"
//                              completion:(^(id result, NSError *error){
//                                         })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_STATIC_METHOD");
//  assertThat(call.arguments, contains(equalTo(@(0)), equalTo(@"aStaticMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteMethod {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//  [_testManager invokeRemoteMethod:remoteReference
//                        methodName:@"aMethod"
//                        completion:(^(id result, NSError *error){
//                                   })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_METHOD");
//  assertThat(call.arguments,
//             contains(equalTo(remoteReference), equalTo(@"aMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteMethodOnUnpairedReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  [_testManager invokeRemoteMethodOnUnpairedReference:testClass
//                                           methodName:@"aMethod"
//                                           completion:(^(id result, NSError *error){
//                                                      })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_METHOD");
//  assertThat(call.arguments,
//             contains(isUnpairedReference(0, isEmpty(), nil), equalTo(@"aMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_disposePairWithLocalReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//  [_testManager disposePairWithLocalReference:testClass
//                                   completion:(^(NSError *error){
//                                              })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_DISPOSE");
//  XCTAssertEqualObjects(call.arguments, remoteReference);
//}
//
//- (void)testMethodChannelReferencePairManager_pairWithNewLocalReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_CREATE"
//                                          arguments:@[
//                                            [REFRemoteReference fromID:@"table"], @(0), @[]
//                                          ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  assertThat([_testManager getPairedLocalReference:[REFRemoteReference fromID:@"table"]],
//             isA([TestClass class]));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalStaticMethod {
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_STATIC_METHOD"
//                                          arguments:@[ @(0), @"aStaticMethod", @[] ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeStaticMethod:_testManager
//                                         referenceClass:[TestClass class]
//                                             methodName:@"aStaticMethod"
//                                              arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalMethod {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_METHOD"
//                                          arguments:@[ remoteReference, @"aMethod", @[] ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:testClass
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalMethodOnUnpairedReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  REFUnpairedReference *unpairedReference =
//      [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]];
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_METHOD"
//                                          arguments:@[ unpairedReference, @"aMethod", @[] ]]];
//
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:isA([TestClass class])
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_disposePairWithRemoteReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall methodCallWithMethodName:@"REFERENCE_DISPOSE"
//                                                         arguments:remoteReference]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) dispose:_testManager localReference:testClass];
//}
//@end
