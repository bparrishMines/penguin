#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCapturePhotoOutputTests : XCTestCase

@end

@implementation IAVCapturePhotoOutputTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCapturePhotoOutput *_mockCapturePhotoOutput;
  IAFCapturePhotoOutputProxy *_testCapturePhotoOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCapturePhotoOutput = OCMClassMock([AVCapturePhotoOutput class]);
  _testCapturePhotoOutputProxy = [[IAFCapturePhotoOutputProxy alloc]
                                  initWithCapturePhotoOutput:_mockCapturePhotoOutput];
}

- (void)testCreateCapturePhotoOutput {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCapturePhotoOutputProxy *capturePhotoOutputProxy = (IAFCapturePhotoOutputProxy *) [implementations.handlerCapturePhotoOutput
                                                         _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(capturePhotoOutputProxy);
}

- (void)testCapturePhotoWithSettings {
  IAFCapturePhotoSettingsProxy *settingsProxy = [[IAFCapturePhotoSettingsProxy alloc] init];
  
  IAFCapturePhotoCaptureDelegateProxy *delegateProxy = [[IAFCapturePhotoCaptureDelegateProxy alloc] initWithCallback:^NSObject * _Nullable(NSObject<_IAFCapturePhoto> * _Nullable photo) {
    return nil;
  } implementations:_mockImplementations];
  
  [_testCapturePhotoOutputProxy capturePhotoWithSettings:settingsProxy delegate:delegateProxy];
  OCMVerify([_mockCapturePhotoOutput capturePhotoWithSettings:settingsProxy.capturePhotoSettings
                                                     delegate:delegateProxy]);
}

- (void)testSupportedFlashModes {
  OCMStub([_mockCapturePhotoOutput supportedFlashModes]).andReturn(@[@(AVCaptureFlashModeAuto)]);
  XCTAssertEqualObjects([_testCapturePhotoOutputProxy supportedFlashModes], @[@(AVCaptureFlashModeAuto)]);
}
@end
