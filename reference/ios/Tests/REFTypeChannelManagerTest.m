#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFTypeChannelManagerTest : XCTestCase
@end

@implementation REFTypeChannelManagerTest {
  REFTestManager *_testManager;
}

- (void)setUp {
  _testManager = [[REFTestManager alloc] init];
}

- (void)testOnReceiveCreateNewPair {
  XCTAssertEqualObjects([_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]], _testManager.testHandler.testClassInstance);
  
  XCTAssertTrue([_testManager isPaired:_testManager.testHandler.testClassInstance]);
  
  XCTAssertNil([_testManager onReceiveCreateNewInstancePair:@""
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
       arguments:@[]]);
}

- (void)testOnReceiveInvokeStaticMethod {
  XCTAssertEqualObjects([_testManager onReceiveInvokeStaticMethod:@"test_channel"
                                                       methodName:@"aStaticMethod"
                                                        arguments:@[]], @"return_value");
}

- (void)testCreateUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [_testManager createUnpairedInstance:@"test_channel"
                                                                              obj:[[REFTestClass alloc] initWithManager:_testManager]];
  XCTAssertEqualObjects(@"test_channel", unpairedInstance.channelName);
  XCTAssertEqual(0, unpairedInstance.creationArguments.count);
}

- (void)testOnReceiveInvokeMethod {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  
  XCTAssertEqualObjects(@"return_value", [_testManager onReceiveInvokeMethod:@"test_channel"
                                                              pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                                                  methodName:@"aMethod"
                                                                   arguments:@[]]);
}

- (void)testOnReceiveInvokeMethodOnUnpairedInstance {
  REFNewUnpairedInstance *unpairedInstance = [[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel" creationArguments:@[]];
  XCTAssertEqualObjects(@"return_value", [_testManager onReceiveInvokeMethodOnUnpairedInstance:unpairedInstance
                                                                                     methodName:@"aMethod"
                                                                                      arguments:@[]]);
}

- (void)testOnReceiveDisposePair {
  [_testManager onReceiveCreateNewInstancePair:@"test_channel"
  pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                     arguments:@[]];
  [_testManager onReceiveDisposePair:@"test_channel" pairedInstance:[REFPairedInstance fromID:@"test_id"]];
  XCTAssertFalse([_testManager isPaired:_testManager.testHandler.testClassInstance]);
}
@end

//#import <XCTest/XCTest.h>
//#import "ReferenceMatchers.h"
//
//@import OCMockito;
//@import OCHamcrest;
//
//@import reference;
//
//@interface REFReferenceTest : XCTestCase
//@end
//
//@implementation REFReferenceTest {
//  TestReferencePairManager *_testManager;
//
//  TestPoolableReferencePairManager *_testPoolableManager1;
//  TestPoolableReferencePairManager *_testPoolableManager2;
//  REFPoolableReferenceConverter *_poolableConverter;
//
//  REFReferencePairManagerPool *_pool;
//}
//
//- (void)setUp {
//  _testManager = [[TestReferencePairManager alloc] init];
//  [_testManager initialize];
//
//  _testPoolableManager1 = [[TestPoolableReferencePairManager alloc]
//      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]
//                        poolID:@"id1"];
//  [_testPoolableManager1 initialize];
//
//  _testPoolableManager2 = [[TestPoolableReferencePairManager alloc]
//      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass2 class]] ]
//                        poolID:@"id2"];
//  [_testPoolableManager2 initialize];
//
//  _pool = [[REFReferencePairManagerPool alloc] init];
//}
//
//- (void)testReferencePairManager_pairWithNewLocalReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  TestClass *result = (TestClass *)[_testManager
//      pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
//                        classID:0];
//
//  XCTAssertEqual([_testManager getPairedLocalReference:[[REFRemoteReference alloc]
//                                                           initWithReferenceID:@"apple"]],
//                 result);
//  XCTAssertEqualObjects([_testManager getPairedRemoteReference:result],
//                        [[REFRemoteReference alloc] initWithReferenceID:@"apple"]);
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager
//                                                                       obj:isEmpty()];
//  [verify(_testManager.localHandler) create:_testManager
//                             referenceClass:[TestClass class]
//                                  arguments:isEmpty()];
//}
//
//- (void)testReferencePairManager_pairWithNewLocalReference_returnsNull {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
//                                  classID:0];
//
//  XCTAssertNil([_testManager
//      pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
//                        classID:0]);
//}
//
//- (void)testReferencePairManager_invokeLocalStaticMethod {
//  [_testManager invokeLocalStaticMethod:[TestClass class] methodName:@"aStaticMethod"];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager
//                                                                       obj:isEmpty()];
//  [verify(_testManager.localHandler) invokeStaticMethod:_testManager
//                                         referenceClass:[TestClass class]
//                                             methodName:@"aStaticMethod"
//                                              arguments:isEmpty()];
//  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager obj:nil];
//}
//
//- (void)testReferencePairManager_invokeLocalMethod {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[[TestClass alloc] init]];
//
//  TestClass *testClass =
//      (TestClass *)[_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
//                                                   classID:0];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager
//                                                                       obj:isEmpty()];
//
//  [_testManager invokeLocalMethod:testClass methodName:@"aMethod"];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager
//                                                                       obj:isEmpty()];
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:testClass
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager obj:nil];
//}
//
//- (void)testReferencePairManager_invokeLocalMethodOnUnpairedReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[[TestClass alloc] init]];
//
//  [_testManager
//      invokeLocalMethodOnUnpairedReference:[[REFUnpairedReference alloc] initWithClassID:0
//                                                                       creationArguments:@[]]
//                                methodName:@"aMethod"];
//
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:isA([TestClass class])
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//}
//
//- (void)testReferencePairManager_disposePairWithRemoteReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  TestClass *testClass =
//      (TestClass *)[_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"]
//                                                   classID:0];
//  [_testManager disposePairWithRemoteReference:[REFRemoteReference fromID:@"apple"]];
//
//  [verify(_testManager.localHandler) dispose:_testManager localReference:testClass];
//  XCTAssertNil([_testManager getPairedLocalReference:[REFRemoteReference fromID:@"apple"]]);
//  XCTAssertNil([_testManager getPairedRemoteReference:testClass]);
//}
//
//// TODO: Test RemoteReference is returned in completion block
//- (void)testReferencePairManager_pairWithNewRemoteReference {
//  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])]) willReturn:@[]];
//
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//
//  [verify(_testManager.remoteHandler) create:isA([REFRemoteReference class])
//                                     classID:0
//                                   arguments:isEmpty()
//                                  completion:anything()];
//  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager
//                                                                        obj:isEmpty()];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//  XCTAssertEqual([_testManager getPairedLocalReference:remoteReference], testClass);
//  XCTAssertEqualObjects([_testManager getPairedRemoteReference:testClass], remoteReference);
//}
//
//- (void)testReferencePairManager_pairWithNewRemoteReference_returnsNull {
//  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])]) willReturn:@[]];
//
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [verify(_testManager.remoteHandler) create:isA([REFRemoteReference class])
//                                     classID:0
//                                   arguments:isEmpty()
//                                  completion:anything()];
//}
//
//- (void)testReferencePairManager_invokeRemoteStaticMethod {
//  [_testManager invokeRemoteStaticMethod:[TestClass class]
//                              methodName:@"aStaticMethod"
//                              completion:(^(id result, NSError *error){
//                                         })];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager
//                                                                        obj:isEmpty()];
//
//  HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
//  [verify(_testManager.remoteHandler) invokeStaticMethod:0
//                                              methodName:@"aStaticMethod"
//                                               arguments:isEmpty()
//                                              completion:(id)argument];
//
//  void (^block)(id, NSError *) = argument.value;
//  block(nil, nil);
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:nil];
//}
//
//- (void)testReferencePairManager_invokeRemoteMethod {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[[TestClass alloc] init]];
//
//  [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"] classID:0];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager
//                                                                       obj:isEmpty()];
//
//  [_testManager invokeRemoteMethod:[REFRemoteReference fromID:@"apple"]
//                        methodName:@"aMethod"
//                        completion:(^(id result, NSError *error){
//                                   })];
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForRemoteManager:_testManager
//                                                                        obj:isEmpty()];
//
//  HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
//  [verify(_testManager.remoteHandler) invokeMethod:[REFRemoteReference fromID:@"apple"]
//                                        methodName:@"aMethod"
//                                         arguments:isEmpty()
//                                        completion:(id)argument];
//
//  void (^block)(id, NSError *) = argument.value;
//  block(nil, nil);
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:nil];
//}
//
//- (void)testReferencePairManager_invokeRemoteMethodOnUnpairedReference {
//  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])]) willReturn:@[]];
//
//  [_testManager invokeRemoteMethodOnUnpairedReference:[TestClass testClass]
//                                           methodName:@"aMethod"
//                                            arguments:@[]
//                                           completion:^(id result, NSError *error){
//                                           }];
//
//  [verifyCount(_testManager.spyConverter.mock, times(2))
//      convertReferencesForRemoteManager:_testManager
//                                    obj:isEmpty()];
//
//  HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
//  [verify(_testManager.remoteHandler)
//      invokeMethodOnUnpairedReference:isUnpairedReference(0, isEmpty(), nil)
//                           methodName:@"aMethod"
//                            arguments:isEmpty()
//                           completion:(id)argument];
//
//  void (^block)(id, NSError *) = argument.value;
//  block(nil, nil);
//
//  [verify(_testManager.spyConverter.mock) convertReferencesForLocalManager:_testManager obj:nil];
//}
//
//- (void)testReferencePairManager_disposePairWithLocalReference {
//  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])]) willReturn:@[]];
//
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  XCTAssertNotNil(remoteReference);
//
//  [_testManager disposePairWithLocalReference:testClass
//                                   completion:^(NSError *error){
//                                   }];
//
//  XCTAssertNil([_testManager getPairedLocalReference:remoteReference]);
//  XCTAssertNil([_testManager getPairedRemoteReference:testClass]);
//}
//
//- (void)testPoolableReferencePairManager_add {
//  TestPoolableReferencePairManager *sameClassManager = [[TestPoolableReferencePairManager alloc]
//      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]
//                        poolID:@"id3"];
//
//  TestPoolableReferencePairManager *sameIdManager = [[TestPoolableReferencePairManager alloc]
//      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass2 class]] ]
//                        poolID:@"id1"];
//
//  XCTAssertTrue([_pool add:_testPoolableManager1]);
//  XCTAssertTrue([_pool add:_testPoolableManager1]);
//  XCTAssertFalse([_pool add:sameClassManager]);
//  XCTAssertFalse([_pool add:sameIdManager]);
//  XCTAssertTrue([_pool add:_testPoolableManager2]);
//}
//
//- (void)testPoolableReferencePairManager_remove {
//  [_pool add:_testPoolableManager1];
//  [_pool remove:_testPoolableManager1];
//
//  TestPoolableReferencePairManager *manager = [[TestPoolableReferencePairManager alloc]
//      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]
//                        poolID:@"id1"];
//
//  XCTAssertTrue([_pool add:manager]);
//}
//@end
