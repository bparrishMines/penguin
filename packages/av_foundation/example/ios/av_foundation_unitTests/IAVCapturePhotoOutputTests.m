#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface IAVCapturePhotoOutputTests : XCTestCase

@end

@implementation IAVCapturePhotoOutputTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCapturePhotoOutput *_mockCapturePhotoOutput;
  AFPCapturePhotoOutputProxy *_testCapturePhotoOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCapturePhotoOutput = OCMClassMock([AVCapturePhotoOutput class]);
  _testCapturePhotoOutputProxy = [[AFPCapturePhotoOutputProxy alloc]
                                  initWithCapturePhotoOutput:_mockCapturePhotoOutput];
}

- (void)testCreateCapturePhotoOutput {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  AFPCapturePhotoOutputProxy *capturePhotoOutputProxy = (AFPCapturePhotoOutputProxy *) [implementations.handlerCapturePhotoOutput
                                                         _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(capturePhotoOutputProxy);
}

- (void)testCapturePhotoWithSettings {
  AFPCapturePhotoSettingsProxy *settingsProxy = [[AFPCapturePhotoSettingsProxy alloc] init];
  
  AFPCapturePhotoCaptureDelegateProxy *delegateProxy = [[AFPCapturePhotoCaptureDelegateProxy alloc] initWithCallback:^NSObject * _Nullable(NSObject<_AFPCapturePhoto> * _Nullable photo) {
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
