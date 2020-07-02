#import <XCTest/XCTest.h>
#import "ReferenceMatchers.h"

@import OCMockito;
@import OCHamcrest;

@import reference;

@interface REFReferenceTest : XCTestCase
@end

@implementation REFReferenceTest {
  TestReferencePairManager *_testManager;
}

- (void)setUp {
  _testManager = [[TestReferencePairManager alloc] init];
  [_testManager initialize];
}

- (void)testReferencePairManager_pairWithNewLocalReference {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:[TestClass testClass]];
  
  TestClass *result = (TestClass *) [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
                                                                    classID:0];
  
  XCTAssertEqual([_testManager getPairedLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]], result);
  XCTAssertEqualObjects([_testManager getPairedRemoteReference:result], [[REFRemoteReference alloc] initWithReferenceID:@"apple"]);
  
  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:isEmpty()];
  [verify(_testManager.localHandler) create:_testManager
                             referenceClass:[TestClass class]
                                  arguments:isEmpty()];
}

- (void)testReferencePairManager_invokeLocalMethod {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:[[TestClass alloc] init]];
  
  TestClass *testClass = (TestClass *) [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
                                                                       classID:0];
  
  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:isEmpty()];
  
  [_testManager invokeLocalMethod:testClass methodName:@"aMethod"];
  
  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:isEmpty()];
  [verify(_testManager.localHandler) invokeMethod:_testManager
                                   localReference:testClass
                                       methodName:@"aMethod"
                                        arguments:isEmpty()];
  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager obj:nil];
}

- (void)testReferencePairManager_invokeLocalMethodOnUnpairedReference {
  [given([_testManager.localHandler create:_testManager
                           referenceClass:[TestClass class]
                                arguments:anything()])
  willReturn:[[TestClass alloc] init]];
  
  [_testManager invokeLocalMethodOnUnpairedReference:[[REFUnpairedReference alloc] initWithClassID:0
                                                                                 creationArguments:@[]]
                                          methodName:@"aMethod"];
  
  [verify(_testManager.localHandler) invokeMethod:_testManager
                                   localReference:isA([TestClass class])
                                       methodName:@"aMethod"
                                        arguments:isEmpty()];
}
@end
