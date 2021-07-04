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

- (void) testCaptureDeviceType {
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInMicrophone, @"AVCaptureDeviceTypeBuiltInMicrophone");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInWideAngleCamera, @"AVCaptureDeviceTypeBuiltInWideAngleCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInTelephotoCamera, @"AVCaptureDeviceTypeBuiltInTelephotoCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInUltraWideCamera, @"AVCaptureDeviceTypeBuiltInUltraWideCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInDualCamera, @"AVCaptureDeviceTypeBuiltInDualCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInDualWideCamera, @"AVCaptureDeviceTypeBuiltInDualWideCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInTripleCamera, @"AVCaptureDeviceTypeBuiltInTripleCamera");
  XCTAssertEqualObjects(AVCaptureDeviceTypeBuiltInTrueDepthCamera, @"AVCaptureDeviceTypeBuiltInTrueDepthCamera");
}
@end
