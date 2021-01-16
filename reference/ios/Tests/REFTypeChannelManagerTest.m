#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTypeChannelManagerTest : XCTestCase
@end

@implementation REFTypeChannelManagerTest {
  REFTestManager *_testManager;
}

- (void)setUp {
  _testManager = [[REFTestManager alloc] init];
}

- (void)testOnReceiveCreateNewPair {
  XCTAssertEqualObjects([_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]], _testManager.testHandler.testClassInstance);
  
  XCTAssertTrue([_testManager isPaired:_testManager.testHandler.testClassInstance]);
  
  XCTAssertNil([_testManager onReceiveCreateNewInstancePair:@""
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]]);
}

- (void)testOnReceiveInvokeStaticMethod {
  XCTAssertEqualObjects([_testManager onReceiveInvokeStaticMethod:@"test_channel"
                                                       methodName:@"aStaticMethod"
                                                        arguments:@[]], @"return_value");
}

- (void)testCreateUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [_testManager createUnpairedInstance:@"test_channel"
                                                                              obj:[[REFTestClass alloc] initWithManager:_testManager]];
  XCTAssertEqualObjects(@"test_channel", unpairedInstance.channelName);
  XCTAssertEqual(0, unpairedInstance.creationArguments.count);
}

- (void)testOnReceiveInvokeMethod {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  
  XCTAssertEqualObjects(@"return_value", [_testManager onReceiveInvokeMethod:@"test_channel"
                                                              pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                                                  methodName:@"aMethod"
                                                                   arguments:@[]]);
}

- (void)testOnReceiveInvokeMethodOnUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel" creationArguments:@[]];
  XCTAssertEqualObjects(@"return_value", [_testManager onReceiveInvokeMethodOnUnpairedInstance:unpairedInstance
                                                                                     methodName:@"aMethod"
                                                                                      arguments:@[]]);
}

- (void)testOnReceiveDisposePair {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  [_testManager onReceiveDisposePair:@"test_channel" pairedInstance:[REFPairedInstance fromID:@"test_id"]];
  XCTAssertFalse([_testManager isPaired:_testManager.testHandler.testClassInstance]);
}
@end
