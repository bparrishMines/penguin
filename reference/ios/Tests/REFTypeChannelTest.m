#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTypeChannelTest : XCTestCase
@end

@implementation REFTypeChannelTest {
  REFTestManager *_testManager;
  REFTypeChannel *_testChannel;
}

- (void)setUp {
  _testManager = [[REFTestManager alloc] init];
  _testChannel = [[REFTypeChannel alloc] initWithManager:_testManager name:@"test_channel"];
}

- (void)testCreateNewPair {
  REFTestClass *testClass = [[REFTestClass alloc] initWithManager:_testManager];
  
  __block REFPairedInstance *blockPairedInstance;
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {
    blockPairedInstance = pairedInstance;
  }];
  
  XCTAssertEqualObjects([REFPairedInstance fromID:@"test_instance_id"], blockPairedInstance);
  
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {
    blockPairedInstance = pairedInstance;
  }];
  XCTAssertNil(blockPairedInstance);
}
@end
