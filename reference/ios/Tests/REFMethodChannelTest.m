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
      if ([@"REFERENCE_METHOD" isEqualToString:call.method] && [call.arguments[2] isEqualToString:@"aMethod"]) {
        result(@"return_value");
      } else if ([@"REFERENCE_STATIC_METHOD" isEqualToString:call.method] && [call.arguments[1] isEqualToString:@"aStaticMethod"]) {
        result(@"return_value");
      } else if ([@"REFERENCE_UNPAIRED_METHOD" isEqualToString:call.method] && [call.arguments[1] isEqualToString:@"aMethod"]) {
        result(@"return_value");
      } else {
        result(nil);
      }
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
  REFTypeChannel *_testChannel;
}

- (void)setUp {
  _messageCodec =
      [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  _methodCodec =
      [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];

  _testManager = [[REFTestMethodChannelManager alloc] init];
  _testBinaryMessenger = (REFTestBinaryMessenger *) _testManager.binaryMessenger;
  _testChannel = [[REFTypeChannel alloc] initWithManager:_testManager name:@"test_channel"];
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

- (void)testMethodChannelManager_onReceiveInvokeStaticMethod {
  NSArray *arguments = @[@"test_channel", @"aStaticMethod", @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_STATIC_METHOD"
                                                                    arguments:arguments];

  __block id blockResult;
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testMethodChannelManager_onReceiveInvokeMethod {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_instance_id"]
                                     arguments:@[]];
  
  NSArray *arguments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @"aMethod", @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_METHOD"
                                                                    arguments:arguments];
  
  __block id blockResult;
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testMethodChannelManager_onReceiveInvokeMethodOnUnpairedInstance {
  NSArray *arguments = @[[[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel" creationArguments:@[]],
                         @"aMethod",
                         @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_UNPAIRED_METHOD"
                                                                    arguments:arguments];
  
  __block id blockResult;
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testMethodChannelManager_onReceiveDisposePair {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_instance_id"]
                                     arguments:@[]];
  
  NSArray *arguments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_DISPOSE"
                                                                    arguments:arguments];
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:nil];
  XCTAssertFalse([_testManager isPaired:_testManager.testHandler.testClassInstance]);
}

- (void)testMethodChannelMessenger_createNewPair {
  [_testChannel createNewInstancePair:[[REFTestClass alloc] initWithManager:_testManager]
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_CREATE");
  
  NSArray *arugments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @[]];
  XCTAssertEqualObjects(methodCall.arguments, arugments);
}

- (void)testMethodChannelMessenger_sendInvokeStaticMethod {
  __block id blockResult;
  [_testChannel invokeStaticMethod:@"aStaticMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  
  XCTAssertEqualObjects(blockResult, @"return_value");
  
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_STATIC_METHOD");
  
  NSArray *arugments = @[@"test_channel", @"aStaticMethod", @[]];
  XCTAssertEqualObjects(methodCall.arguments, arugments);
}

- (void)testMethodChannelMessenger_sendInvokeMethod {
  REFTestClass *testClass = [[REFTestClass alloc] initWithManager:_testManager];
  
  [_testChannel createNewInstancePair:testClass
  completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testBinaryMessenger.methodCalls removeAllObjects];
  
  __block id blockResult;
  [_testChannel invokeMethod:testClass methodName:@"aMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(blockResult, @"return_value");
  
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_METHOD");
  
  NSArray *arugments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @"aMethod", @[]];
  XCTAssertEqualObjects(methodCall.arguments, arugments);
}

- (void)testMethodChannelMessenger_sendInvokeMethodOnUnpairedReference {
  __block id blockResult;
  [_testChannel invokeMethod:[[REFTestClass alloc] initWithManager:_testManager]
                  methodName:@"aMethod"
                   arguments:@[]
                  completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(blockResult, @"return_value");
  
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_UNPAIRED_METHOD");
  
  REFNewUnpairedInstance *unpairedReference = methodCall.arguments[0];
  XCTAssertEqualObjects(unpairedReference.channelName, @"test_channel");
  XCTAssertEqualObjects(unpairedReference.creationArguments, @[]);
  NSArray *arugments = @[@"aMethod", @[]];
  XCTAssertEqualObjects([methodCall.arguments subarrayWithRange:NSMakeRange(1, 2)], arugments);
}

- (void)testMethodChannelMessenger_disposePair {
  REFTestClass *testClass = [[REFTestClass alloc] initWithManager:_testManager];
  
  [_testChannel createNewInstancePair:testClass
  completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testBinaryMessenger.methodCalls removeAllObjects];
  
  [_testChannel disposePair:testClass completion:^(NSError *error) {}];
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_DISPOSE");
  
  NSArray *arugments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"]];
  XCTAssertEqualObjects(methodCall.arguments, arugments);
}
@end
