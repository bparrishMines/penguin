#import <XCTest/XCTest.h>

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

- (void)testReferencePairManagerPairWithNewLocalReference {
  [given([_testManager.localHandler create:_testManager
                            referenceClass:[TestClass class]
                                 arguments:anything()])
                                willReturn:[[TestClass alloc] init]];

  TestClass *result = [_testManager pairWithNewLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]
                                                      classID:0
                                                    arguments:@[@"table"]];

  [verify(_testManager.localHandler) create:_testManager
                             referenceClass:[TestClass class]
                                  arguments:anything()];

  XCTAssertEqual([_testManager getPairedLocalReference:[[REFRemoteReference alloc] initWithReferenceID:@"apple"]], result);
  XCTAssertEqualObjects([_testManager getPairedRemoteReference:result], [[REFRemoteReference alloc] initWithReferenceID:@"apple"]);
}
@end
