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
       arguments:@[] owner:YES], _testMessenger.testHandler.testClassInstance);
  
  XCTAssertTrue([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
  
  XCTAssertNil([_testMessenger onReceiveCreateNewInstancePair:@""
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[] owner:YES]);
}

- (void)testOnReceiveInvokeStaticMethod {
  XCTAssertEqualObjects([_testMessenger onReceiveInvokeStaticMethod:@"test_channel"
                                                       methodName:@"aStaticMethod"
                                                        arguments:@[]], @"return_value");
}

- (void)testOnReceiveInvokeMethod {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[] owner:YES];
  
  XCTAssertEqualObjects(@"return_value", [_testMessenger onReceiveInvokeMethod:@"test_channel"
                                                              pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                                                  methodName:@"aMethod"
                                                                   arguments:@[]]);
}

- (void)testOnReceiveDisposeInstancePair {
  [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]
                                     owner:YES];
  [_testMessenger onReceiveDisposeInstancePair:[REFPairedInstance fromID:@"test_id"]];
  XCTAssertFalse([_testMessenger isPaired:_testMessenger.testHandler.testClassInstance]);
}
@end
