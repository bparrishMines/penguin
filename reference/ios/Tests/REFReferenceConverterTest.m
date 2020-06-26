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
@end
