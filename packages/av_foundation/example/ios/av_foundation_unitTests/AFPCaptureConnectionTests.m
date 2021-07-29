#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureConnectionTests : XCTestCase
@end

@implementation AFPCaptureConnectionTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureConnection *_mockCaptureConnection;
  AFPCaptureConnectionProxy *_testCaptureConnectionProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureConnection = OCMClassMock([AVCaptureConnection class]);
  _testCaptureConnectionProxy = [[AFPCaptureConnectionProxy alloc] initWithCaptureConnection:_mockCaptureConnection];
}

- (void)testCreateCaptureConnection {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];
  
  AVCaptureInputPort *mockPort = OCMClassMock([AVCaptureInputPort class]);
  AFPCaptureInputPortProxy *portProxy = [[AFPCaptureInputPortProxy alloc] initWithCaptureInputPort:mockPort
                                                                                   implementations:_mockImplementations];
  
  AVCaptureOutput *mockOutput = OCMClassMock([AVCaptureOutput class]);
  AFPCaptureOutputProxy *outputProxy = [[AFPCaptureOutputProxy alloc] initWithCaptureOutput:mockOutput
                                                                            implementations:_mockImplementations];

  AFPCaptureConnectionProxy *captureConnectionProxy = (AFPCaptureConnectionProxy *)
  [implementations.handlerCaptureConnection _create_:_mockTypeChannelMessenger
                                          inputPorts:@[portProxy]
                                              output:outputProxy];

  XCTAssertNotNil(captureConnectionProxy);
  XCTAssertEqualObjects(captureConnectionProxy.captureConnection.inputPorts, @[mockPort]);
  XCTAssertEqualObjects(captureConnectionProxy.captureConnection.output, mockOutput);
}

- (void)testIsVideoMirroringSupported {
  OCMStub([_mockCaptureConnection isVideoMirroringSupported]).andReturn(NO);
  XCTAssertEqualObjects([_testCaptureConnectionProxy isVideoMirroringSupported], @NO);
}

- (void)testIsVideoOrientationSupported {
  OCMStub([_mockCaptureConnection isVideoOrientationSupported]).andReturn(YES);
  XCTAssertEqualObjects([_testCaptureConnectionProxy isVideoOrientationSupported], @YES);
}

- (void)testSetAutomaticallyAdjustsVideoMirroring {
  [_testCaptureConnectionProxy setAutomaticallyAdjustsVideoMirroring:@NO];
  OCMVerify([_mockCaptureConnection setAutomaticallyAdjustsVideoMirroring:NO]);
}

- (void)testSetVideoMirrored {
  [_testCaptureConnectionProxy setVideoMirrored:@YES];
  OCMVerify([_mockCaptureConnection setVideoMirrored:YES]);
}

- (void)testSetVideoOrientation {
  [_testCaptureConnectionProxy setVideoOrientation:@1];
  OCMVerify([_mockCaptureConnection setVideoOrientation:1]);
}
@end
