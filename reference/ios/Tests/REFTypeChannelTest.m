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

- (void)testCreateNewInstancePair {
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

- (void)testInvokeStaticMethod {
  __block id blockResult;
  [_testChannel invokeStaticMethod:@"aStaticMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testInvokeMethod {
  REFTestClass *testClass = [[REFTestClass alloc] initWithManager:_testManager];
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  
  __block id blockResult;
  [_testChannel invokeMethod:testClass methodName:@"aMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testInvokeMethodOnUnpairedInstance {
  __block id blockResult;
  [_testChannel invokeMethod:[[REFTestClass alloc] initWithManager:_testManager]
                  methodName:@"aMethod"
                   arguments:@[]
                  completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testDisposePair {
  REFTestClass *testClass = [[REFTestClass alloc] initWithManager:_testManager];
  
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testChannel disposePair:testClass completion:^(NSError *error) {}];
  
  XCTAssertFalse([_testManager isPaired:testClass]);
}
@end
