#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCapturePhotoSettingsTests : XCTestCase

@end

@implementation IAFCapturePhotoSettingsTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  IAFCapturePhotoSettingsProxy *_testCapturePhotoSettingsProxy;
  AVCapturePhotoSettings *_mockCapturePhotoSettings;
}

- (void)setUp {
  AVCaptureVideoOrientation
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCapturePhotoSettings = OCMClassMock([AVCapturePhotoSettings class]);
  _testCapturePhotoSettingsProxy = [[IAFCapturePhotoSettingsProxy alloc] initWithCapturePhotoSettings:_mockCapturePhotoSettings];
}

- (void)testCreateCapturePhotoSettings {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCapturePhotoSettingsProxy *settingsProxy = (IAFCapturePhotoSettingsProxy *) [implementations.handlerCapturePhotoSettings
                                                                                  _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(settingsProxy);
  XCTAssertNotNil(settingsProxy.capturePhotoSettings);
}

- (void)testCreatePhotoSettingsWithFormat {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];
  
  IAFCapturePhotoSettingsProxy *settingsProxy = (IAFCapturePhotoSettingsProxy *) [implementations.handlerCapturePhotoSettings
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
