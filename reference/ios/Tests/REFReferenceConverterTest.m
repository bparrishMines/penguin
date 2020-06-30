#import <XCTest/XCTest.h>
#import "ReferenceMatchers.h"

@import OCMockito;
@import OCHamcrest;

@import reference;

@interface REFReferenceConverterTest : XCTestCase
@end

@implementation REFReferenceConverterTest {
  TestReferencePairManager *_testManager;
  REFStandardReferenceConverter *_converter;
}

- (void)setUp {
  _testManager = [[TestReferencePairManager alloc] init];
  [_testManager initialize];
  
  _converter = [[REFStandardReferenceConverter alloc] init];
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesPairedLocalReference {
  TestClass *testClass = [TestClass testClass];
  
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:testClass];
  
  TestClass *result = [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
                                                      classID:0];
  
  XCTAssertEqualObjects([_converter convertReferencesForRemoteManager:_testManager obj: testClass],
                        [REFRemoteReference fromID:@"apple"]);
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesUnpairedLocalReference {
  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])])
   willReturn:@[]];
  
  assertThat([_converter convertReferencesForRemoteManager:_testManager obj: [TestClass testClass]],
             isUnpairedReference(0, isEmpty(), nil));
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesEmptyList {
  assertThat([_converter convertReferencesForRemoteManager:_testManager obj:@[]], isEmpty());
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesList {
  __block NSMutableArray<NSArray<NSObject *> *> *creationArguments = [NSMutableArray
                                                                      arrayWithObjects:@[[TestClass testClass]], @[], nil];

  [given([_testManager.remoteHandler getCreationArguments:anything()])
   willDo:^id (NSInvocation *invocation) {
    NSArray<NSObject *> *arguments = creationArguments[0];
    [creationArguments removeObjectAtIndex:0];
    return arguments;
  }];

  id result = [_converter convertReferencesForRemoteManager:_testManager obj:@[[TestClass testClass]]];

  assertThat(result,
             contains(isUnpairedReference(0, contains(isUnpairedReference(0, isEmpty(), nil),nil),nil),nil));
}
@end
