#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCaptureMovieFileOutputTests : XCTestCase
@end

@implementation IAFCaptureMovieFileOutputTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureMovieFileOutput *_mockCaptureMovieFileOutput;
  IAFCaptureMovieFileOutputProxy *_testCaptureMovieFileOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureMovieFileOutput = OCMClassMock([AVCaptureMovieFileOutput class]);
  _testCaptureMovieFileOutputProxy = [[IAFCaptureMovieFileOutputProxy alloc]
                                 initWithCaptureMovieFileOutput:_mockCaptureMovieFileOutput];
}

- (void)testCreateCaptureMovieFileOutput {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  IAFCaptureMovieFileOutputProxy *captureMovieFileOutputProxy = (IAFCaptureMovieFileOutputProxy *) [implementations.handlerCaptureMovieFileOutput
                                                         __create:_mockTypeChannelMessenger];
  
  XCTAssertNotNil(captureMovieFileOutputProxy);
}

- (void)testAvailableVideoCodecTypes {
  OCMStub([_mockCaptureMovieFileOutput availableVideoCodecTypes]).andReturn(@[AVVideoCodecTypeJPEG]);
  XCTAssertEqualObjects([_testCaptureMovieFileOutputProxy availableVideoCodecTypes], @[AVVideoCodecTypeJPEG]);
}
@end
