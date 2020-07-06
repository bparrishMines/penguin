#import <XCTest/XCTest.h>
#import "ReferenceMatchers.h"

@import OCMockito;
@import OCHamcrest;

@import reference;

@interface REFMethodChannelTest : XCTestCase
@end

@implementation REFMethodChannelTest {
  id<FlutterMessageCodec> _codec;
  TestReferencePairManager *_testManager;
}

- (void)setUp {
  _codec = [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
}

- (void)testReferenceReaderWriter_encodeAndDecodeRemoteReference {
  XCTAssertEqualObjects([_codec decode:[_codec encode:[REFRemoteReference fromID:@"taco"]]], [REFRemoteReference fromID:@"taco"]);
}

- (void)testReferenceReaderWriter_encodeAndDecodeUnpairedReference {
  REFUnpairedReference *unpairedReference = [[REFUnpairedReference alloc] initWithClassID:5
                                                                        creationArguments:@[]
                                                                            managerPoolID:@"tiny"];

  NSData *data = [_codec encode:unpairedReference];
  assertThat([_codec decode:data], isUnpairedReference(5, isEmpty(), @"tiny"));
}
@end
