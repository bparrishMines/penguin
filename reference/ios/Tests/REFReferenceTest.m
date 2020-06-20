#import <XCTest/XCTest.h>
#import "ReferenceMatchers.h"

@import OCMockito;
@import OCHamcrest;

@import reference;

@interface TestClass : NSObject<REFLocalReference>
@end

@interface TestReferencePairManager : REFReferencePairManager
@end

@implementation TestClass
- (REFClass *)referenceClass {
  return [REFClass fromClass:[TestClass class]];
}
@end

@implementation TestReferencePairManager {
  id<REFRemoteReferenceCommunicationHandler> _remoteHandler;
  id<REFLocalReferenceCommunicationHandler> _localHandler;
}

-(instancetype)init {
  self = [super initWithSupportedClasses:@[[REFClass fromClass:[TestClass class]]]];
  if (self) {
    _remoteHandler = mockProtocol(@protocol(REFRemoteReferenceCommunicationHandler));
    _localHandler = mockProtocol(@protocol(REFLocalReferenceCommunicationHandler));
  }
  return self;
}

-(id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  return _remoteHandler;
}

-(id<REFLocalReferenceCommunicationHandler>)localHandler {
  return _localHandler;
}
@end

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
   willReturn:[[TestClass alloc] init]];
  
  TestClass *result = [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
                                                      classID:0
                                                    arguments:@[@"Hello",
                                                                [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]],
                                                                @[[[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]]],
                                                                @{@(1.1): [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]]}
                                                    ]];
  
  XCTAssertEqual([_testManager getPairedLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]], result);
  XCTAssertEqualObjects([_testManager getPairedRemoteReference:result], [[REFRemoteReference alloc] initWithReferenceID:@"apple"]);
  
  HCArgumentCaptor *creationArguments = [[HCArgumentCaptor alloc] init];
  [verifyCount(_testManager.localHandler, times(4)) create:_testManager
                                            referenceClass:[TestClass class]
                                                 arguments:(id)creationArguments];
  
  assertThat(creationArguments.allValues, contains(
                                                   isEmpty(),
                                                   isEmpty(),
                                                   isEmpty(),
                                                   contains(
                                                            equalTo(@"Hello"),
                                                            isA([TestClass class]),
                                                            contains(isA([TestClass class]), nil),
                                                            hasEntry(equalTo(@(1.1)), isA([TestClass class])), nil), nil));
}

- (void)testReferencePairManager_invokeLocalMethod {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willReturn:[[TestClass alloc] init]];
  
  TestClass *localReference = [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
                                                              classID:0];
  
  [_testManager invokeLocalMethod:localReference methodName:@"aMethod" arguments:@[@"Hello",
                                                                                   [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]],
                                                                                   @[[[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]]],
                                                                                   @{@(1.1): [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]]}
  ]];
  
  HCArgumentCaptor *methodArguments = [[HCArgumentCaptor alloc] init];
  [verify(_testManager.localHandler) invokeMethod:_testManager
                                   localReference:localReference
                                       methodName:@"aMethod"
                                        arguments:(id)methodArguments];
  
  assertThat(methodArguments.value,
             contains(
                      equalTo(@"Hello"),
                      isA([TestClass class]),
                      contains(isA([TestClass class]), nil),
                      hasEntry(equalTo(@(1.1)), isA([TestClass class])), nil));
}

- (void)testReferencePairManager_invokeLocalMethod_convertsReturnedLocalReferences {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
   willDo:^id (NSInvocation *invocation) {
    return [[TestClass alloc] init];
  }];
  
  [given([_testManager.remoteHandler getCreationArguments:isA([TestClass class])])
   willReturn:@[]];
  
  TestClass *caller = [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"] classID:0];
  
  TestClass *hasRemoteRef = [_testManager
                             pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"banana"]
                             classID:0];
  
  [given([_testManager.localHandler invokeMethod:_testManager
                                  localReference:caller
                                      methodName:@"aMethod"
                                       arguments:anything()])
   willReturn:@[[[TestClass alloc] init], hasRemoteRef, [NSNull null]]];
  
  id result = [_testManager invokeLocalMethod:caller methodName:@"aMethod"];
  
  assertThat(result,
             contains(
                      isUnpairedReference(0, isEmpty(), nil),
                      equalTo([[REFRemoteReference alloc] initWithReferenceID:@"banana"]),
                      equalTo([NSNull null]),
                      nil
                      )
             );
}
@end
