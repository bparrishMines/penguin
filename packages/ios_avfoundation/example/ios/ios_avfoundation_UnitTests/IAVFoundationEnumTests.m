#import <AVFoundation/AVFoundation.h>
#import <XCTest/XCTest.h>

@interface IAVFoundationEnumTests : XCTestCase
@end

@implementation IAVFoundationEnumTests

- (void)testCameraDevicePosition {
  XCTAssertEqual(AVCaptureDevicePositionUnspecified, 0);
  XCTAssertEqual(AVCaptureDevicePositionBack, 1);
  XCTAssertEqual(AVCaptureDevicePositionFront, 2);
}

- (void)testMediaType {
  XCTAssertEqualObjects(AVMediaTypeVideo, @"vide");
}

- (void)testVideoSettingsKeys {
  XCTAssertEqualObjects(AVVideoCodecKey, @"AVVideoCodecKey");
}

- (void) testVideoCodecType {
  XCTAssertEqualObjects(AVVideoCodecTypeJPEG, @"jpeg");
}
@end
