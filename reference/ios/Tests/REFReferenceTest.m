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
  
  TestClass *testClass = (TestClass *) [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
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

- (void)testReferencePairManager_disposePairWithRemoteReference {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:[TestClass testClass]];
  
  TestClass *testClass = (TestClass *) [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
                                                                       classID:0];
  [_testManager disposePairWithRemoteReference:[REFRemoteReference fromID:@"apple"]];
  
  [verify(_testManager.localHandler) dispose:_testManager localReference:testClass];
  XCTAssertNil([_testManager getPairedLocalReference:[REFRemoteReference fromID:@"apple"]]);
  XCTAssertNil([_testManager getPairedRemoteReference:testClass]);
}

// TODO: Test RemoteReference is returned in completion block
- (void)testReferencePairManager_pairWithNewRemoteReference {
  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])])
   willReturn:@[]];
  
  TestClass *testClass = [TestClass testClass];
  
  [_testManager pairWithNewRemoteReference:testClass completion:^(REFRemoteReference *remoteReference, NSError *error) {}];
  
  [verify(_testManager.remoteHandler) create:isA([REFRemoteReference class])
                                     classID:0
                                   arguments:isEmpty()
                                  completion:anything()];
  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager obj:isEmpty()];
  
  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
  XCTAssertEqual([_testManager getPairedLocalReference:remoteReference], testClass);
  XCTAssertEqualObjects([_testManager getPairedRemoteReference:testClass], remoteReference);
}

- (void)testReferencePairManager_invokeRemoteMethod {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:[[TestClass alloc] init]];
  
  TestClass *testClass = (TestClass *) [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
                                                                       classID:0];
  
  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:isEmpty()];
  
  [_testManager invokeRemoteMethod:[REFRemoteReference fromID:@"apple"]
                        methodName:@"aMethod"
                        completion:(^(id result, NSError *error) {})];
  
  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager obj:isEmpty()];
  
  HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
  [verify(_testManager.remoteHandler) invokeMethod:[REFRemoteReference fromID:@"apple"]
                                        methodName:@"aMethod"
                                         arguments:isEmpty()
                                        completion:(id)argument];

  void (^block)(id, NSError *) = argument.value;
  block(nil, nil);
  
  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:nil];
}
@end
