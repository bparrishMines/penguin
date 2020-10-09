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

  TestPoolableReferencePairManager *_testPoolableManager1;
  TestPoolableReferencePairManager *_testPoolableManager2;
  REFPoolableReferenceConverter *_poolableConverter;

  REFReferencePairManagerPool *_pool;
}

- (void)setUp {
  _testManager = [[TestReferencePairManager alloc] init];
  [_testManager initialize];

  _converter = [[REFStandardReferenceConverter alloc] init];

  _testPoolableManager1 = [[TestPoolableReferencePairManager alloc]
      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass class]] ]
                        poolID:@"id1"];
  [_testPoolableManager1 initialize];

  _testPoolableManager2 = [[TestPoolableReferencePairManager alloc]
      initWithSupportedClasses:@[ [REFClass fromClass:[TestClass2 class]] ]
                        poolID:@"id2"];
  [_testPoolableManager2 initialize];

  _pool = [[REFReferencePairManagerPool alloc] init];
  [_pool add:_testPoolableManager1];
  [_pool add:_testPoolableManager2];

  _poolableConverter = [[REFPoolableReferenceConverter alloc] init];
}

- (void)
    testStandardReferenceConverter_convertReferencesForRemoteManager_handlesPairedLocalReference {
  TestClass *testClass = [TestClass testClass];

  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()]) willReturn:testClass];

  [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"] classID:0];

  XCTAssertEqualObjects([_converter convertReferencesForRemoteManager:_testManager obj:testClass],
                        [REFRemoteReference fromID:@"apple"]);
}

- (void)
    testStandardReferenceConverter_convertReferencesForRemoteManager_handlesUnpairedLocalReference {
  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])]) willReturn:@[]];

  assertThat([_converter convertReferencesForRemoteManager:_testManager obj:[TestClass testClass]],
             isUnpairedReference(0, isEmpty(), nil));
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesEmptyList {
  assertThat([_converter convertReferencesForRemoteManager:_testManager obj:@[]], isEmpty());
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesList {
  __block NSMutableArray<NSArray<NSObject *> *> *creationArguments =
      [NSMutableArray arrayWithObjects:@[ [TestClass testClass] ], @[], nil];

  [given([_testManager.remoteHandler getCreationArguments:anything()])
      willDo:^id(NSInvocation *invocation) {
        NSArray<NSObject *> *arguments = creationArguments[0];
        [creationArguments removeObjectAtIndex:0];
        return arguments;
      }];

  id result =
      [_converter convertReferencesForRemoteManager:_testManager obj:@[ [TestClass testClass] ]];

  assertThat(result, contains(isUnpairedReference(
                                  0, contains(isUnpairedReference(0, isEmpty(), nil), nil), nil),
                              nil));
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesMap {
  __block NSMutableArray<NSArray<NSObject *> *> *creationArguments = [NSMutableArray
      arrayWithObjects:@[ [TestClass testClass] ], @[], @[ [TestClass testClass] ], @[], nil];

  [given([_testManager.remoteHandler getCreationArguments:anything()])
      willDo:^id(NSInvocation *invocation) {
        NSArray<NSObject *> *arguments = creationArguments[0];
        [creationArguments removeObjectAtIndex:0];
        return arguments;
      }];

  NSDictionary<id, id> *result = [_converter
      convertReferencesForRemoteManager:_testManager
                                    obj:@{[TestClass testClass] : [TestClass testClass]}];

  XCTAssertEqual(result.count, 1);
  assertThat(result.allKeys[0],
             isUnpairedReference(0, contains(isUnpairedReference(0, isEmpty(), nil), nil), nil));
  assertThat(result.allValues[0],
             isUnpairedReference(0, contains(isUnpairedReference(0, isEmpty(), nil), nil), nil));
}

- (void)testStandardReferenceConverter_convertReferencesForRemoteManager_handlesNonLocalReference {
  XCTAssertEqualObjects([_converter convertReferencesForRemoteManager:_testManager obj:@"apple"],
                        @"apple");
}

- (void)testStandardReferenceConverter_convertReferencesForLocalManager_handlesRemoteReference {
  TestClass *testClass = [TestClass testClass];

  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()]) willReturn:testClass];

  [_testManager pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"] classID:0];

  XCTAssertEqualObjects(
      [_converter convertReferencesForLocalManager:_testManager
                                               obj:[REFRemoteReference fromID:@"apple"]],
      testClass);
}

- (void)testStandardReferenceConverter_convertReferencesForLocalManager_handlesUnpairedReference {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()]) willReturn:[TestClass testClass]];

  assertThat([_converter convertReferencesForLocalManager:_testManager
                                                      obj:[[REFUnpairedReference alloc]
                                                                initWithClassID:0
                                                              creationArguments:@[]]],
             isA([TestClass class]));
}

- (void)testStandardReferenceConverter_convertReferencesForLocalManager_handlesList {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()]) willReturn:[TestClass testClass]];

  assertThat([_converter convertReferencesForLocalManager:_testManager
                                                      obj:@[ [[REFUnpairedReference alloc]
                                                                initWithClassID:0
                                                              creationArguments:@[]] ]],
             contains(isA([TestClass class]), nil));
}

- (void)testStandardReferenceConverter_convertReferencesForLocalManager_handlesMap {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()]) willReturn:[TestClass testClass]];

  REFUnpairedReference *unpairedReference =
      [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]];

  NSDictionary<id, id> *result =
      [_converter convertReferencesForLocalManager:_testManager
                                               obj:@{unpairedReference : unpairedReference}];

  XCTAssertEqual(result.count, 1);
  assertThat(result.allKeys[0], isA([TestClass class]));
  assertThat(result.allValues[0], isA([TestClass class]));
}

- (void)testStandardReferenceConverter_convertReferencesForLocalManager_handlesNonLocalReference {
  XCTAssertEqualObjects([_converter convertReferencesForLocalManager:_testManager obj:@"apple"],
                        @"apple");
}

- (void)
    testPoolableReferenceConverter_convertReferencesForRemoteManager_handlesPairedLocalReference {
  TestClass *testClass = [TestClass testClass];
  TestClass2 *testClass2 = [TestClass2 testClass2];

  [given([_testPoolableManager1.localHandler create:_testPoolableManager1
                                     referenceClass:[TestClass class]
                                          arguments:anything()]) willReturn:testClass];
  [given([_testPoolableManager2.localHandler create:_testPoolableManager2
                                     referenceClass:[TestClass2 class]
                                          arguments:anything()]) willReturn:testClass2];

  [_testPoolableManager1 pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"] classID:0];
  [_testPoolableManager2 pairWithNewLocalReference:[REFRemoteReference fromID:@"apple2"] classID:0];

  XCTAssertEqualObjects(
      [_poolableConverter convertReferencesForRemoteManager:_testPoolableManager1 obj:testClass],
      [REFRemoteReference fromID:@"apple"]);

  XCTAssertEqualObjects(
      [_poolableConverter convertReferencesForRemoteManager:_testPoolableManager1 obj:testClass2],
      [REFRemoteReference fromID:@"apple2"]);
}

- (void)
    testPoolableReferenceConverter_convertReferencesForRemoteManager_handlesUnpairedLocalReference {
  [given([_testPoolableManager1.remoteHandler getCreationArguments:isA([TestClass class])])
      willReturn:@[]];

  [given([_testPoolableManager2.remoteHandler getCreationArguments:isA([TestClass2 class])])
      willReturn:@[]];

  assertThat([_poolableConverter convertReferencesForRemoteManager:_testPoolableManager1
                                                               obj:[TestClass testClass]],
             isUnpairedReference(0, isEmpty(), @"id1"));
  assertThat([_poolableConverter convertReferencesForRemoteManager:_testPoolableManager1
                                                               obj:[TestClass2 testClass2]],
             isUnpairedReference(0, isEmpty(), @"id2"));
}

- (void)testPoolableReferenceConverter_convertReferencesForLocalManager_handlesRemoteReference {
  TestClass *testClass = [TestClass testClass];
  TestClass2 *testClass2 = [TestClass2 testClass2];

  [given([_testPoolableManager1.localHandler create:_testPoolableManager1
                                     referenceClass:[TestClass class]
                                          arguments:anything()]) willReturn:testClass];
  [given([_testPoolableManager2.localHandler create:_testPoolableManager2
                                     referenceClass:[TestClass2 class]
                                          arguments:anything()]) willReturn:testClass2];

  [_testPoolableManager1 pairWithNewLocalReference:[REFRemoteReference fromID:@"apple"] classID:0];
  [_testPoolableManager2 pairWithNewLocalReference:[REFRemoteReference fromID:@"apple2"] classID:0];

  XCTAssertEqualObjects(
      [_poolableConverter convertReferencesForLocalManager:_testPoolableManager1
                                                       obj:[REFRemoteReference fromID:@"apple"]],
      testClass);

  XCTAssertEqualObjects(
      [_poolableConverter convertReferencesForLocalManager:_testPoolableManager1
                                                       obj:[REFRemoteReference fromID:@"apple2"]],
      testClass2);
}

- (void)testPoolableReferenceConverter_convertReferencesForLocalManager_handlesUnpairedReference {
  [given([_testPoolableManager1.localHandler create:_testPoolableManager1
                                     referenceClass:[TestClass class]
                                          arguments:anything()]) willReturn:[TestClass testClass]];

  [given([_testPoolableManager2.localHandler create:_testPoolableManager2
                                     referenceClass:[TestClass2 class]
                                          arguments:anything()])
      willReturn:[TestClass2 testClass2]];

  assertThat([_poolableConverter convertReferencesForLocalManager:_testPoolableManager1
                                                              obj:[[REFUnpairedReference alloc]
                                                                        initWithClassID:0
                                                                      creationArguments:@[]
                                                                          managerPoolID:@"id1"]],
             isA([TestClass class]));

  assertThat([_poolableConverter convertReferencesForLocalManager:_testPoolableManager1
                                                              obj:[[REFUnpairedReference alloc]
                                                                        initWithClassID:0
                                                                      creationArguments:@[]
                                                                          managerPoolID:@"id2"]],
             isA([TestClass2 class]));
}
@end
