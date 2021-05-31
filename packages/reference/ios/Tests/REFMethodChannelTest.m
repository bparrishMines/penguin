#import <Flutter/Flutter.h>
#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>

#import "REFReferenceMatchers.h"

@import reference;

@interface REFTestBinaryMessenger : NSObject<FlutterBinaryMessenger>
@property (readonly) NSMutableArray<FlutterMethodCall *> *methodCalls;
@property (readonly) NSMutableDictionary<NSString *, FlutterBinaryMessageHandler> *handlers;
@property (readonly) FlutterMethodCallHandler testMethodCallHandler;
@end

@interface REFTestMethodChannelMessenger : REFMethodChannelMessenger
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

@implementation REFTestMethodChannelMessenger {
  REFTestInstanceManager *_testInstanceManager;
}
- (instancetype)init {
  self = [super initWithBinaryMessenger:[[REFTestBinaryMessenger alloc] init]
                            channelName:@"test_method_channel"];
  if (self) {
    _testHandler = [[REFTestHandler alloc] init];
    [self registerHandler:@"test_channel" handler:_testHandler];
    _testInstanceManager = [[REFTestInstanceManager alloc] init];
  }
  return self;
}

- (REFInstanceManager *)instanceManager {
  return _testInstanceManager;
}
@end

@interface REFMethodChannelTest : XCTestCase
@end

@implementation REFMethodChannelTest {
  FlutterStandardMethodCodec *_methodCodec;
  id<FlutterMessageCodec> _messageCodec;
  REFTestMethodChannelMessenger *_testMessenger;
  REFTestBinaryMessenger *_testBinaryMessenger;
  REFTypeChannel *_testChannel;
}

- (void)setUp {
  _messageCodec =
      [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  _methodCodec =
      [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];

  _testMessenger = [[REFTestMethodChannelMessenger alloc] init];
  _testBinaryMessenger = (REFTestBinaryMessenger *) _testMessenger.binaryMessenger;
  _testChannel = [[REFTypeChannel alloc] initWithMessenger:_testMessenger name:@"test_channel"];
}

- (void)testReferenceReaderWriter_encodeAndDecodePairedInstance {
  XCTAssertEqualObjects(
      [_messageCodec decode:[_messageCodec encode:[REFPairedInstance fromID:@"taco"]]],
      [REFPairedInstance fromID:@"taco"]);
}

- (void)testMethodChannelMessenger_onReceiveCreateNewInstancePair {
  NSArray *arguments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @[], @(YES)];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_CREATE" arguments:arguments];

  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:nil];
  XCTAssertTrue([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
}

- (void)testMethodChannelMessenger_onReceiveInvokeStaticMethod {
  NSArray *arguments = @[@"test_channel", @"aStaticMethod", @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_STATIC_METHOD"
                                                                    arguments:arguments];

  __block id blockResult;
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testMethodChannelMessenger_onReceiveInvokeMethod {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_instance_id"]
                                     arguments:@[] owner:YES];
  
  NSArray *arguments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @"aMethod", @[]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_METHOD"
                                                                    arguments:arguments];
  
  __block id blockResult;
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:^(id result) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testMethodChannelMessenger_onReceiveDisposePair {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_instance_id"]
                                     arguments:@[] owner:YES];
  
  NSArray *arguments = @[[REFPairedInstance fromID:@"test_instance_id"]];
  FlutterMethodCall *methodCall = [FlutterMethodCall methodCallWithMethodName:@"REFERENCE_DISPOSE"
                                                                    arguments:arguments];
  [_testBinaryMessenger handlePlatformMessage:@"test_method_channel" methodCall:methodCall result:nil];
  XCTAssertFalse([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
}

- (void)testMethodChannelMessenger_createNewInstancePair {
  [_testChannel createNewInstancePair:[[REFTestClass alloc] init]
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_CREATE");
  
  NSArray *arugments = @[@"test_channel", [REFPairedInstance fromID:@"test_instance_id"], @[], @(NO)];
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
  REFTestClass *testClass = [[REFTestClass alloc] init];
  
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
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

- (void)testMethodChannelMessenger_disposeInstancePair {
  REFTestClass *testClass = [[REFTestClass alloc] init];
  
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testBinaryMessenger.methodCalls removeAllObjects];
  
  [_testChannel disposeInstancePair:testClass completion:^(NSError *error) {}];
  XCTAssertEqual(1, _testBinaryMessenger.methodCalls.count);
  FlutterMethodCall *methodCall = _testBinaryMessenger.methodCalls[0];
  XCTAssertEqualObjects(methodCall.method, @"REFERENCE_DISPOSE");
  
  NSArray *arugments = @[[REFPairedInstance fromID:@"test_instance_id"]];
  XCTAssertEqualObjects(methodCall.arguments, arugments);
}
@end
