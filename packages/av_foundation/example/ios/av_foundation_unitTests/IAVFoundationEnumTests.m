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
  XCTAssertEqualObjects(AVMediaTypeAudio, @"soun");
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

- (void) testCaptureSessionPreset {
  XCTAssertEqualObjects(AVCaptureSessionPresetPhoto, @"AVCaptureSessionPresetPhoto");
  XCTAssertEqualObjects(AVCaptureSessionPresetHigh, @"AVCaptureSessionPresetHigh");
  XCTAssertEqualObjects(AVCaptureSessionPresetMedium, @"AVCaptureSessionPresetMedium");
  XCTAssertEqualObjects(AVCaptureSessionPresetLow, @"AVCaptureSessionPresetLow");
  XCTAssertEqualObjects(AVCaptureSessionPreset352x288, @"AVCaptureSessionPreset352x288");
  XCTAssertEqualObjects(AVCaptureSessionPreset640x480, @"AVCaptureSessionPreset640x480");
  XCTAssertEqualObjects(AVCaptureSessionPreset1280x720, @"AVCaptureSessionPreset1280x720");
  XCTAssertEqualObjects(AVCaptureSessionPreset1920x1080, @"AVCaptureSessionPreset1920x1080");
  XCTAssertEqualObjects(AVCaptureSessionPresetiFrame960x540, @"AVCaptureSessionPresetiFrame960x540");
  XCTAssertEqualObjects(AVCaptureSessionPresetiFrame1280x720, @"AVCaptureSessionPresetiFrame1280x720");
}

- (void)testExposureMode {
  XCTAssertEqual(AVCaptureExposureModeLocked, 0);
  XCTAssertEqual(AVCaptureExposureModeAutoExpose, 1);
  XCTAssertEqual(AVCaptureExposureModeContinuousAutoExposure, 2);
  XCTAssertEqual(AVCaptureExposureModeCustom, 3);
}

- (void)testFocusMode {
  XCTAssertEqual(AVCaptureFocusModeLocked, 0);
  XCTAssertEqual(AVCaptureFocusModeAutoFocus, 1);
  XCTAssertEqual(AVCaptureFocusModeContinuousAutoFocus, 2);
}

- (void)testFlashMode {
  XCTAssertEqual(AVCaptureFlashModeOff, 0);
  XCTAssertEqual(AVCaptureFlashModeOn, 1);
  XCTAssertEqual(AVCaptureFlashModeAuto, 2);
}

- (void)testVideoOrientation {
  XCTAssertEqual(AVCaptureVideoOrientationPortrait, 1);
  XCTAssertEqual(AVCaptureVideoOrientationPortraitUpsideDown, 2);
  XCTAssertEqual(AVCaptureVideoOrientationLandscapeRight, 3);
  XCTAssertEqual(AVCaptureVideoOrientationLandscapeLeft, 4);
}

- (void)testTorchMode {
  XCTAssertEqual(AVCaptureTorchModeOff, 0);
  XCTAssertEqual(AVCaptureTorchModeOn, 1);
  XCTAssertEqual(AVCaptureTorchModeAuto, 2);
}
@end
