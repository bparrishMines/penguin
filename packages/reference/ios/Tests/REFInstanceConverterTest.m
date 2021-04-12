#import <XCTest/XCTest.h>

#import "REFReferenceMatchers.h"

@import OCHamcrest;
@import reference;

@interface REFInstanceConverterTest : XCTestCase
@end

@implementation REFInstanceConverterTest {
    REFStandardInstanceConverter *_converter;
    REFTestMessenger *_testMessenger;
}

- (void)setUp {
    _converter = [[REFStandardInstanceConverter alloc] init];
    _testMessenger = [[REFTestMessenger alloc] init];
}

- (void)testConvertInstancesToPairedInstances_handlesPairedObject {
    [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
                                    pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                         arguments:@[]];
    
    XCTAssertEqualObjects([REFPairedInstance fromID:@"test_id"],
                          [_converter convertInstancesToPairedInstances:_testMessenger
                                                            obj:_testMessenger.testHandler.testClassInstance]);
}

- (void)testConvertInstancesToPairedInstances_handlesNonPairableInstance {
    XCTAssertEqualObjects(@"potato", [_converter convertForRemoteMessenger:_testMessenger obj:@"potato"]);
}

- (void)testConvertForLocalMessenger_handlesPairedInstance {
    [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
                                    pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                         arguments:@[]];
    
    XCTAssertEqualObjects(_testMessenger.testHandler.testClassInstance,
                          [_converter convertForLocalMessenger:_testMessenger
                                                           obj:[REFPairedInstance fromID:@"test_id"]]);
}

- (void)testConvertForLocalMessenger_handlesNewUnpairedInstance {
    XCTAssertEqualObjects([_converter convertForLocalMessenger:_testMessenger
                                                           obj:[[REFNewUnpairedInstance alloc] initWithChannelName:@"test_channel"
                                                                                                 creationArguments:@[]]],
                          _testMessenger.testHandler.testClassInstance);
}
@end
