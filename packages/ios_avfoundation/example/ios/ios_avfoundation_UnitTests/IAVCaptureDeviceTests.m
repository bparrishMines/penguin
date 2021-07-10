#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

// AVCaptureDevice can't be mocked so this is used in its place.
@interface TestCaptureDevice : NSObject
@property AVCaptureExposureMode exposureMode;
@property AVCaptureFocusMode focusMode;
@property BOOL smoothAutoFocusEnabled;
@property BOOL lockedForConfiguration;
@end

@implementation TestCaptureDevice
- (instancetype)init {
  self = [super init];
  if (self) {
    _lockedForConfiguration = NO;
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
@end

@interface IAVCaptureDeviceTests : XCTestCase
@end

@implementation IAVCaptureDeviceTests {
  TestCaptureDevice *_testCaptureDevice;
  IAFLibraryImplementations *_mockImplementations;
  _IAFCaptureDeviceChannel *_mockCaptureDeviceChannel;
  IAFCaptureDeviceProxy *_testCaptureDeviceProxy;
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockCaptureDeviceChannel = OCMClassMock([_IAFCaptureDeviceChannel class]);
  OCMStub([_mockImplementations channelCaptureDevice]).andReturn(_mockCaptureDeviceChannel);
  _testCaptureDeviceProxy = [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                 implementations:_mockImplementations];
}

- (void)testCreateCapturePhoto {
  IAFCaptureDeviceProxy *captureDeviceProxy = [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                                   implementations:_mockImplementations];
  OCMVerify([_mockCaptureDeviceChannel __create:captureDeviceProxy
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
  
  IAFCaptureDeviceProxy *deviceProxy = [IAFCaptureDeviceProxy defaultDeviceWithMediaType:@"apple"
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
@end
