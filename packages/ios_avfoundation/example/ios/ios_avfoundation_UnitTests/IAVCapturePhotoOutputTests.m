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
                                                         __create:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(capturePhotoOutputProxy);
}

- (void)testCapturePhoto {
  IAFCapturePhotoSettingsProxy *settingsProxy = [[IAFCapturePhotoSettingsProxy alloc]
                                                 initwithProcessedFormat:@{@"AVVideoCodecKey": @"jpeg"}];
  
  IAFCapturePhotoCaptureDelegateProxy *delegateProxy = [[IAFCapturePhotoCaptureDelegateProxy alloc] initWithCallback:^NSObject * _Nullable(NSObject<_IAFCapturePhoto> * _Nullable photo) {
    return nil;
  } implementations:_mockImplementations];
  
  [_testCapturePhotoOutputProxy capturePhoto:settingsProxy delegate:delegateProxy];
  OCMVerify([_mockCapturePhotoOutput capturePhotoWithSettings:settingsProxy.capturePhotoSettings
                                                     delegate:delegateProxy]);
}
@end
