#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCapturePhotoCaptureDelegateTests : XCTestCase

@end

@implementation AFPCapturePhotoCaptureDelegateTests{
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCapturePhotoCaptureDelegate {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  __block BOOL callbackCalled = NO;
  AFPCapturePhotoCaptureDelegateProxy *delegateProxy = (AFPCapturePhotoCaptureDelegateProxy *) [implementations.handlerCapturePhotoCaptureDelegate _create_:_mockTypeChannelMessenger didFinishProcessingPhoto:^NSObject * _Nullable(NSObject<_AFPCapturePhoto> * _Nullable photo) {
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
