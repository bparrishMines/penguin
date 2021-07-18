#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

// AVCaptureDevice can't be mocked so this is used in its place.
@interface TestCaptureDevice : NSObject
@property AVCaptureExposureMode exposureMode;
@property AVCaptureFocusMode focusMode;
@property BOOL smoothAutoFocusEnabled;
@property BOOL lockedForConfiguration;
@property BOOL videoZoomRampCanceled;
@property CGFloat rampZoomFactor;
@property float rampZoomRate;
@property CGFloat videoZoomFactor;
@end

@implementation TestCaptureDevice
- (instancetype)init {
  self = [super init];
  if (self) {
    _lockedForConfiguration = NO;
    _videoZoomRampCanceled = NO;
  }
  return self;
}

- (AVCaptureDevicePosition)position {
  return 2;
}

- (NSString *)uniqueID {
  return @"test_uniqueID";
}

- (BOOL)isSmoothAutoFocusSupported {
  return YES;
}

- (BOOL)hasFlash {
  return NO;
}

- (BOOL)isExposureModeSupported:(AVCaptureExposureMode)mode {
  if (mode == AVCaptureExposureModeLocked) {
    return YES;
  }
  
  return NO;
}

- (BOOL)isFocusModeSupported:(AVCaptureFocusMode)mode {
  if (mode == AVCaptureFocusModeLocked) {
    return YES;
  }
  
  return NO;
}

- (BOOL)isAdjustingExposure {
  return NO;
}

- (BOOL)isAdjustingFocus {
  return YES;
}

- (BOOL)isFlashAvailable {
  return NO;
}

- (BOOL)lockForConfiguration:(NSError * _Nullable * _Nullable)outError {
  _lockedForConfiguration = YES;
  return YES;
}

- (BOOL)supportsAVCaptureSessionPreset:(AVCaptureSessionPreset)preset {
  if (preset == AVCaptureSessionPresetLow) {
    return YES;
  }
  
  return NO;
}

- (void)unlockForConfiguration {
  _lockedForConfiguration = NO;
}

- (void)cancelVideoZoomRamp {
  _videoZoomRampCanceled = YES;
}

- (BOOL)isRampingVideoZoom {
  return NO;
}

- (CGFloat)maxAvailableVideoZoomFactor {
  return 23.23;
}

- (CGFloat)minAvailableVideoZoomFactor {
  return 23.24;
}

- (void)rampToVideoZoomFactor:(CGFloat)factor withRate:(float)rate {
  _rampZoomFactor = factor;
  _rampZoomRate = rate;
}
@end

@interface IAVCaptureDeviceTests : XCTestCase
@end

@implementation IAVCaptureDeviceTests {
  TestCaptureDevice *_testCaptureDevice;
  AFPLibraryImplementations *_mockImplementations;
  _AFPCaptureDeviceChannel *_mockCaptureDeviceChannel;
  AFPCaptureDeviceProxy *_testCaptureDeviceProxy;
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockCaptureDeviceChannel = OCMClassMock([_AFPCaptureDeviceChannel class]);
  OCMStub([_mockImplementations channelCaptureDevice]).andReturn(_mockCaptureDeviceChannel);
  _testCaptureDeviceProxy = [[AFPCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                 implementations:_mockImplementations];
}

- (void)testCreateCapturePhoto {
  AFPCaptureDeviceProxy *captureDeviceProxy = [[AFPCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                                   implementations:_mockImplementations];
  OCMVerify([_mockCaptureDeviceChannel _create_:captureDeviceProxy
                                          _owner:NO
                                        uniqueId:@"test_uniqueID"
                                        position:@2
                      isSmoothAutoFocusSupported:@(YES)
                                        hasFlash:@(NO)
                                      completion:OCMOCK_ANY]);
}

- (void)testDefaultDeviceWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  
  OCMStub(ClassMethod([mockCaptureDevice defaultDeviceWithMediaType:@"apple"])).andReturn(_testCaptureDevice);
  
  AFPCaptureDeviceProxy *deviceProxy = [AFPCaptureDeviceProxy defaultDeviceWithMediaType:@"apple"
                                                                         implementations:_mockImplementations];
  

  XCTAssertEqualObjects(deviceProxy.captureDevice.uniqueID, @"test_uniqueID");
  XCTAssertEqualObjects(@(deviceProxy.captureDevice.position), @(2));
}

- (void)testExposureModesSupported {
  NSArray<NSNumber *> *validModes = [_testCaptureDeviceProxy exposureModesSupported:@[@(AVCaptureExposureModeLocked), @(AVCaptureExposureModeAutoExpose)]];
  XCTAssertEqualObjects(validModes, @[@(AVCaptureExposureModeLocked)]);
}

- (void)testFocusModesSupported {
  NSArray<NSNumber *> *validModes = [_testCaptureDeviceProxy focusModesSupported:@[@(AVCaptureFocusModeLocked), @(AVCaptureFocusModeAutoFocus)]];
  XCTAssertEqualObjects(validModes, @[@(AVCaptureFocusModeLocked)]);
}

- (void)testIsAdjustingExposure {
  XCTAssertEqualObjects([_testCaptureDeviceProxy isAdjustingExposure], @(NO));
}

- (void)testIsAdjustingFocus {
  XCTAssertEqualObjects([_testCaptureDeviceProxy isAdjustingFocus], @(YES));
}

- (void)testIsFlashAvailable {
  XCTAssertEqualObjects([_testCaptureDeviceProxy isFlashAvailable], @(NO));
}

- (void)testLockForConfiguration {
  XCTAssertEqualObjects([_testCaptureDeviceProxy lockForConfiguration], @(YES));
}

- (void)testSetExposureMode {
  [_testCaptureDeviceProxy setExposureMode:@(AVCaptureExposureModeAutoExpose)];
  XCTAssertEqual(_testCaptureDevice.exposureMode, AVCaptureExposureModeAutoExpose);
}

- (void)testSetFocusMode {
  [_testCaptureDeviceProxy setFocusMode:@(AVCaptureFocusModeLocked)];
  XCTAssertEqual(_testCaptureDevice.focusMode, AVCaptureFocusModeLocked);
}

- (void)testSetSmoothAutoFocusEnabled {
  [_testCaptureDeviceProxy setSmoothAutoFocusEnabled:@(YES)];
  XCTAssertTrue(_testCaptureDevice.smoothAutoFocusEnabled);
}

- (void)testSupportsCaptureSessionPresets {
  NSArray<NSString *> *validPresets = [_testCaptureDeviceProxy supportsCaptureSessionPresets:@[AVCaptureSessionPresetMedium, AVCaptureSessionPresetLow]];
  XCTAssertEqualObjects(validPresets, @[AVCaptureSessionPresetLow]);
}

- (void)testUnlockForConfiguration {
  [_testCaptureDeviceProxy lockForConfiguration];
  XCTAssertTrue(_testCaptureDevice.lockedForConfiguration);
  
  [_testCaptureDeviceProxy unlockForConfiguration];
  XCTAssertFalse(_testCaptureDevice.lockedForConfiguration);
}

- (void)testCancelVideoZoomRamp {
  [_testCaptureDeviceProxy cancelVideoZoomRamp];
  XCTAssertTrue(_testCaptureDevice.videoZoomRampCanceled);
}

- (void)testIsRampingVideoZoom {
  XCTAssertEqualObjects([_testCaptureDeviceProxy isRampingVideoZoom], @(NO));
}

- (void)testMaxAvailableVideoZoomFactor {
  XCTAssertEqualObjects([_testCaptureDeviceProxy maxAvailableVideoZoomFactor], @(23.23));
}

- (void)testMinAvailableVideoZoomFactor {
  XCTAssertEqualObjects([_testCaptureDeviceProxy minAvailableVideoZoomFactor], @(23.24));
}

- (void)testRampToVideoZoomFactor {
  [_testCaptureDeviceProxy rampToVideoZoomFactor:@(11.00) rate:@(12.0)];
  XCTAssertEqual(_testCaptureDevice.rampZoomFactor, 11.0);
  XCTAssertEqual(_testCaptureDevice.rampZoomRate, 12.0);
}

-(void)testSetVideoZoomFactor {
  [_testCaptureDeviceProxy setVideoZoomFactor:@(23.00)];
  XCTAssertEqual(_testCaptureDevice.videoZoomFactor, 23.00);
}
@end
