#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFInstanceConverterTest : XCTestCase
@end

@implementation REFInstanceConverterTest {
  REFStandardInstanceConverter *_converter;
  REFTestManager *_testManager;
}

- (void)setUp {
  _converter = [[REFStandardInstanceConverter alloc] init];
  _testManager = [[REFTestManager alloc] init];
}

- (void)testConvertForRemoteManager_handlesPairedObject {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
                                pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  
  XCTAssertEqualObjects([REFPairedInstance fromID:@"test_id"],
                        [_converter convertForRemoteManager:_testManager
                                                        obj:_testManager.testHandler.testClassInstance]);
}

- (void)testConvertForRemoteManager_handlesUnpairedObject {
  assertThat([_converter convertForRemoteManager:_testManager
                                                        obj:[[REFTestClass alloc] initWithManager:_testManager]],
                                                        isUnpairedInstance(@"test_channel", @[]));
}

- (void)testConvertForRemoteManager_handlesNonPairableInstance {
  XCTAssertEqualObjects(@"potato", [_converter convertForRemoteManager:_testManager obj:@"potato"]);
}

- (void)testConvertForLocalManager_handlesPairedInstance {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
                                pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  
  XCTAssertEqualObjects(_testManager.testHandler.testClassInstance,
  [_converter convertForLocalManager:_testManager
                                 obj:[REFPairedInstance fromID:@"test_id"]]);
}

- (void)testConvertForLocalManager_handlesNewUnpairedInstance {
  XCTAssertEqualObjects([_converter convertForLocalManager:_testManager
                                                       obj:[[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel"
                                                                                             creationArguments:@[]]],
                        _testManager.testHandler.testClassInstance);
}
@end
