#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCaptureFileOutputTests : XCTestCase
@end

@implementation IAFCaptureFileOutputTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureFileOutput *_mockCaptureFileOutput;
  IAFCaptureFileOutputProxy *_testCaptureFileOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureFileOutput = OCMClassMock([AVCaptureFileOutput class]);
  _testCaptureFileOutputProxy = [[IAFCaptureFileOutputProxy alloc]
                                 initWithCaptureFileOutput:_mockCaptureFileOutput];
}

- (void)testIsRecording {
  OCMStub([_mockCaptureFileOutput isRecording]).andReturn(YES);
  XCTAssertEqualObjects([_testCaptureFileOutputProxy isRecording], @(YES));
}

- (void)testSetMaxRecordedFileSize {
  [_testCaptureFileOutputProxy setMaxRecordedFileSize:@(23)];
  OCMVerify([_mockCaptureFileOutput setMaxRecordedFileSize:23]);
}

- (void)testStartRecordingToOutputFileURL {
  IAFCaptureFileOutputRecordingDelegateProxy *testDelegateProxy = [[IAFCaptureFileOutputRecordingDelegateProxy alloc] init];
  [_testCaptureFileOutputProxy startRecordingToOutputFileURL:@"https://www.google.com" delegate:testDelegateProxy];
  OCMVerify([_mockCaptureFileOutput startRecordingToOutputFileURL:[NSURL URLWithString:@"https://www.google.com"]
                                                recordingDelegate:testDelegateProxy]);
}

- (void)testStopRecording {
  [_testCaptureFileOutputProxy stopRecording];
  OCMVerify([_mockCaptureFileOutput stopRecording]);
}

- (void)testOutputFileURL {
  OCMStub([_mockCaptureFileOutput outputFileURL]).andReturn([NSURL URLWithString:@"https://www.google.com"]);
  XCTAssertEqualObjects([_testCaptureFileOutputProxy outputFileURL], @"https://www.google.com");
}
@end
