#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureMovieFileOutputTests : XCTestCase
@end

@implementation AFPCaptureMovieFileOutputTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureMovieFileOutput *_mockCaptureMovieFileOutput;
  AFPCaptureMovieFileOutputProxy *_testCaptureMovieFileOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureMovieFileOutput = OCMClassMock([AVCaptureMovieFileOutput class]);
  _testCaptureMovieFileOutputProxy = [[AFPCaptureMovieFileOutputProxy alloc]
                                 initWithCaptureMovieFileOutput:_mockCaptureMovieFileOutput];
}

- (void)testCreateCaptureMovieFileOutput {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  AFPCaptureMovieFileOutputProxy *captureMovieFileOutputProxy = (AFPCaptureMovieFileOutputProxy *) [implementations.handlerCaptureMovieFileOutput
                                                         _create_:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(captureMovieFileOutputProxy);
}

- (void)testAvailableVideoCodecTypes {
  OCMStub([_mockCaptureMovieFileOutput availableVideoCodecTypes]).andReturn(@[AVVideoCodecTypeJPEG]);
  XCTAssertEqualObjects([_testCaptureMovieFileOutputProxy availableVideoCodecTypes], @[AVVideoCodecTypeJPEG]);
}
@end
