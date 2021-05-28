#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>

#import "REFReferenceMatchers.h"

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
  REFTestClass *testClass = [[REFTestClass alloc] init];
  
  __block REFPairedInstance *blockPairedInstance;
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {
    blockPairedInstance = pairedInstance;
  }];
  XCTAssertEqualObjects([REFPairedInstance fromID:@"test_instance_id"], blockPairedInstance);
  XCTAssertTrue([_testMessenger isPaired:testClass]);
  
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {
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
  REFTestClass *testClass = [[REFTestClass alloc] init];
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  
  __block id blockResult;
  [_testChannel invokeMethod:testClass methodName:@"aMethod" arguments:@[] completion:^(id result, NSError *error) {
    blockResult = result;
  }];
  XCTAssertEqualObjects(@"return_value", blockResult);
}

- (void)testDisposeInstancePair {
  REFTestClass *testClass = [[REFTestClass alloc] init];
  
  [_testChannel createNewInstancePair:testClass
                            arguments:@[]
                                owner:YES
                           completion:^(REFPairedInstance *pairedInstance, NSError *error) {}];
  [_testChannel disposeInstancePair:testClass completion:^(NSError *error) {}];
  XCTAssertFalse([_testMessenger isPaired:testClass]);

  [_testChannel disposeInstancePair:testClass completion:^(NSError *error) {}];
}
@end
