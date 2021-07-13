#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCapturePhotoCaptureDelegateTests : XCTestCase

@end

@implementation IAFCapturePhotoCaptureDelegateTests{
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCapturePhotoCaptureDelegate {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  __block BOOL callbackCalled = NO;
  IAFCapturePhotoCaptureDelegateProxy *delegateProxy = (IAFCapturePhotoCaptureDelegateProxy *) [implementations.handlerCapturePhotoCaptureDelegate _create_:_mockTypeChannelMessenger didFinishProcessingPhoto:^NSObject * _Nullable(NSObject<_IAFCapturePhoto> * _Nullable photo) {
    callbackCalled = YES;
    return nil;
  }];
  
  [delegateProxy captureOutput:OCMClassMock([AVCapturePhotoOutput class])
      didFinishProcessingPhoto:OCMClassMock([AVCapturePhoto class])
                         error:nil];
  
  XCTAssertNotNil(delegateProxy);
  XCTAssertTrue(callbackCalled);
}
@end
