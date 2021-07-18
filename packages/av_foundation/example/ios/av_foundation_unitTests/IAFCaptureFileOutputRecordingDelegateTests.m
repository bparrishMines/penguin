#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureFileOutputRecordingDelegateTests : XCTestCase
@end

@implementation AFPCaptureFileOutputRecordingDelegateTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCaptureFileOutputRecordingDelegate {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  AFPCaptureFileOutputRecordingDelegateProxy *captureFileOutputRecordingDelegateProxy = (AFPCaptureFileOutputRecordingDelegateProxy *) [implementations.handlerCaptureFileOutputRecordingDelegate
                                                         _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(captureFileOutputRecordingDelegateProxy);
}
@end
