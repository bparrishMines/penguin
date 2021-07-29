#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureFileOutputTests : XCTestCase
@end

@implementation AFPCaptureFileOutputTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureFileOutput *_mockCaptureFileOutput;
  AFPCaptureFileOutputProxy *_testCaptureFileOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureFileOutput = OCMClassMock([AVCaptureFileOutput class]);
  _testCaptureFileOutputProxy = [[AFPCaptureFileOutputProxy alloc]
                                 initWithCaptureFileOutput:_mockCaptureFileOutput implementations:_mockImplementations];
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
  AFPCaptureFileOutputRecordingDelegateProxy *testDelegateProxy = [[AFPCaptureFileOutputRecordingDelegateProxy alloc] init];
  [_testCaptureFileOutputProxy startRecordingToOutputFileURL:@"https://www.google.com" delegate:testDelegateProxy];
  OCMVerify([_mockCaptureFileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:@"https://www.google.com"]
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
