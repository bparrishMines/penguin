#import <XCTest/XCTest.h>
#import "ReferenceMatchers.h"

@import OCMockito;
@import OCHamcrest;

@import reference;

@interface REFMethodChannelTest : XCTestCase
@end

@implementation REFMethodChannelTest {
  id<FlutterMessageCodec> _codec;
  TestMethodChannelReferencePairManager *_testManager;
}

- (void)setUp {
  _codec = [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
  _testManager = [[TestMethodChannelReferencePairManager alloc] init];
  [_testManager initialize];
}

- (FlutterMethodCall *_Nonnull)getRemoteHandlerMethodCall {
  TestRemoteHandler *remoteHandler = (TestRemoteHandler *) _testManager.remoteHandler;

  HCArgumentCaptor *messageCaptor = [[HCArgumentCaptor alloc] init];
  [verify(remoteHandler.binaryMessenger) sendOnChannel:@"test_channel" message:(id)messageCaptor binaryReply:anything()];
  
  NSData *messageData = messageCaptor.value;
  FlutterStandardMethodCodec *methodCodec = [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];

  return [methodCodec decodeMethodCall:messageData];
}

- (FlutterBinaryMessageHandler _Nullable)getBinaryMessageHandler {
  HCArgumentCaptor *handlerCaptor = [[HCArgumentCaptor alloc] init];
  [verify(_testManager.binaryMessenger) setMessageHandlerOnChannel:@"test_channel" binaryMessageHandler:(id)handlerCaptor];
  
  return handlerCaptor.value;
}

- (void)testReferenceReaderWriter_encodeAndDecodeRemoteReference {
  XCTAssertEqualObjects([_codec decode:[_codec encode:[REFRemoteReference fromID:@"taco"]]], [REFRemoteReference fromID:@"taco"]);
}

- (void)testReferenceReaderWriter_encodeAndDecodeUnpairedReference {
  REFUnpairedReference *unpairedReference = [[REFUnpairedReference alloc] initWithClassID:5
                                                                        creationArguments:@[]
                                                                            managerPoolID:@"tiny"];

  NSData *data = [_codec encode:unpairedReference];
  assertThat([_codec decode:data], isUnpairedReference(5, isEmpty(), @"tiny"));
}

- (void)testMethodChannelReferencePairManager_pairWithNewRemoteReference {
  TestClass *testClass = [TestClass testClass];
  
  [_testManager pairWithNewRemoteReference:testClass completion:^(REFRemoteReference *remoteReference, NSError *error) {}];
  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
  
  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
  
  XCTAssertEqualObjects(call.method, @"REFERENCE_CREATE");
  assertThat(call.arguments, contains(equalTo(remoteReference), equalTo(@(0)), isEmpty(), nil));
}
@end
