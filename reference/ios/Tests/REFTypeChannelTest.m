#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTypeChannelTest : XCTestCase
@end

@implementation REFTypeChannelTest {
  REFTestMessenger *_testMessenger;
  REFTypeChannel *_testChannel;
}

- (void)setUp {
  _testMessenger = [[REFTestMessenger alloc] init];
  _testChannel = [[REFTypeChannel alloc] initWithMessenger:_testMessenger name:@"test_channel"];
}

- (void)testCreateNewInstancePair {
  REFTestClass *testClass = [[REFTestClass alloc] initWithMessenger:_testMessenger];
  
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
  REFTestClass *testClass = [[REFTestClass alloc] initWithMessenger:_testMessenger];
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  
  __block id blockResult;
  [_testChannel invokeMethod:testClass methodName:@"aMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testInvokeMethodOnUnpairedInstance {
  __block id blockResult;
  [_testChannel invokeMethod:[[REFTestClass alloc] initWithMessenger:_testMessenger]
                  methodName:@"aMethod"
                   arguments:@[]
                  completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testDisposePair {
  REFTestClass *testClass = [[REFTestClass alloc] initWithMessenger:_testMessenger];
  
  [_testChannel createNewInstancePair:testClass completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testChannel disposeInstancePair:testClass completion:^(NSError *error) {}];
  
  XCTAssertFalse([_testMessenger isPaired:testClass]);
}
@end
