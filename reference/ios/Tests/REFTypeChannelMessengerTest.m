#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTypeChannelManagerTest : XCTestCase
@end

@implementation REFTypeChannelManagerTest {
  REFTestMessenger *_testMessenger;
}

- (void)setUp {
  _testMessenger = [[REFTestMessenger alloc] init];
}

- (void)testOnReceiveCreateNewPair {
  XCTAssertEqualObjects([_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]], _testMessenger.testHandler.testClassInstance);
  
  XCTAssertTrue([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
  
  XCTAssertNil([_testMessenger onReceiveCreateNewInstancePair:@""
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]]);
}

- (void)testOnReceiveInvokeStaticMethod {
  XCTAssertEqualObjects([_testMessenger onReceiveInvokeStaticMethod:@"test_channel"
                                                       methodName:@"aStaticMethod"
                                                        arguments:@[]], @"return_value");
}

- (void)testCreateUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [_testMessenger createUnpairedInstance:@"test_channel"
                                                                              obj:[[REFTestClass alloc] initWithMessenger:_testMessenger]];
  XCTAssertEqualObjects(@"test_channel", unpairedInstance.channelName);
  XCTAssertEqual(0, unpairedInstance.creationArguments.count);
}

- (void)testOnReceiveInvokeMethod {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  
  XCTAssertEqualObjects(@"return_value", [_testMessenger onReceiveInvokeMethod:@"test_channel"
                                                              pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                                                  methodName:@"aMethod"
                                                                   arguments:@[]]);
}

- (void)testOnReceiveInvokeMethodOnUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel" creationArguments:@[]];
  XCTAssertEqualObjects(@"return_value", [_testMessenger onReceiveInvokeMethodOnUnpairedInstance:unpairedInstance
                                                                                     methodName:@"aMethod"
                                                                                      arguments:@[]]);
}

- (void)testOnReceiveDisposeInstancePair {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  [_testMessenger onReceiveDisposeInstancePair:@"test_channel" pairedInstance:[REFPairedInstance fromID:@"test_id"]];
  XCTAssertFalse([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
}
@end
