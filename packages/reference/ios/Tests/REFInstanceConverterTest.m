#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>

#import "REFReferenceMatchers.h"

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
    XCTAssertEqualObjects([_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
                                    pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                         arguments:@[]
                                         owner:YES], _testMessenger.testHandler.testClassInstance);
    
    XCTAssertEqualObjects([REFPairedInstance fromID:@"test_id"],
                          [_converter convertInstancesToPairedInstances:_testMessenger
                                                            obj:_testMessenger.testHandler.testClassInstance]);
}

- (void)testConvertInstancesToPairedInstances_handlesNonPairableInstance {
    XCTAssertEqualObjects(@"potato", [_converter convertInstancesToPairedInstances:_testMessenger obj:@"potato"]);
}

- (void)testConvertPairedInstancesToInstances_handlesPairedInstance {
    [_testMessenger onReceiveCreateNewInstancePair:@"test_channel"
                                    pairedInstance:[REFPairedInstance fromID:@"test_id"]
                                         arguments:@[]
                                         owner:YES];
    
    XCTAssertEqualObjects(_testMessenger.testHandler.testClassInstance,
                          [_converter convertPairedInstancesToInstances:_testMessenger
                                                           obj:[REFPairedInstance fromID:@"test_id"]]);
}

- (void)testConvertPairedInstancesToInstances_handlesNewUnpairedObject {
    XCTAssertEqualObjects([_converter convertPairedInstancesToInstances:_testMessenger obj:@"apple"], @"apple");
}
@end
