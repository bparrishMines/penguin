#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCaptureFileOutputRecordingDelegateTests : XCTestCase
@end

@implementation IAFCaptureFileOutputRecordingDelegateTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCaptureFileOutputRecordingDelegate {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCaptureFileOutputRecordingDelegateProxy *captureFileOutputRecordingDelegateProxy = (IAFCaptureFileOutputRecordingDelegateProxy *) [implementations.handlerCaptureFileOutputRecordingDelegate
                                                         _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(captureFileOutputRecordingDelegateProxy);
}
@end
