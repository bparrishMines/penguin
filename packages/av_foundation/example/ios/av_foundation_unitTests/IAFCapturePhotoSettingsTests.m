#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCapturePhotoSettingsTests : XCTestCase

@end

@implementation AFPCapturePhotoSettingsTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AFPCapturePhotoSettingsProxy *_testCapturePhotoSettingsProxy;
  AVCapturePhotoSettings *_mockCapturePhotoSettings;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCapturePhotoSettings = OCMClassMock([AVCapturePhotoSettings class]);
  _testCapturePhotoSettingsProxy = [[AFPCapturePhotoSettingsProxy alloc] initWithCapturePhotoSettings:_mockCapturePhotoSettings];
}

- (void)testCreateCapturePhotoSettings {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  AFPCapturePhotoSettingsProxy *settingsProxy = (AFPCapturePhotoSettingsProxy *) [implementations.handlerCapturePhotoSettings
                                                                                  _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(settingsProxy);
  XCTAssertNotNil(settingsProxy.capturePhotoSettings);
}

- (void)testCreatePhotoSettingsWithFormat {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];
  
  AFPCapturePhotoSettingsProxy *settingsProxy = (AFPCapturePhotoSettingsProxy *) [implementations.handlerCapturePhotoSettings
                                                 _create_photoSettingsWithFormat:_mockTypeChannelMessenger
                                                 format:@{@"AVVideoCodecKey": @"jpeg"}];
  XCTAssertEqualObjects(settingsProxy.capturePhotoSettings.format, @{@"AVVideoCodecKey": @"jpeg"});
}

- (void)testSetFlashMode {
  [_testCapturePhotoSettingsProxy setFlashMode:@(AVCaptureFlashModeOn)];
  OCMVerify([_mockCapturePhotoSettings setFlashMode:AVCaptureFlashModeOn]);
}

- (void)testUniqueID {
  OCMStub([_mockCapturePhotoSettings uniqueID]).andReturn(42);
  XCTAssertEqualObjects([_testCapturePhotoSettingsProxy uniqueID], @(42));
}
@end
