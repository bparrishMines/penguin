#import <AVFoundation/AVFoundation.h>
#import <XCTest/XCTest.h>

@interface PCMFoundationEnumTests : XCTestCase
@end

@implementation PCMFoundationEnumTests

- (void)testCameraDevicePosition {
  XCTAssertEqual(AVCaptureDevicePositionUnspecified, 0);
  XCTAssertEqual(AVCaptureDevicePositionBack, 1);
  XCTAssertEqual(AVCaptureDevicePositionFront, 2);
}

- (void)testMediaType {
  XCTAssertEqualObjects(AVMediaTypeVideo, @"vide");
}
@end
