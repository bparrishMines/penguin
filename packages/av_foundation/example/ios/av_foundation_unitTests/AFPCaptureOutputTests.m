#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureOutputTests : XCTestCase

@end

@implementation AFPCaptureOutputTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureOutput *_mockCaptureOutput;
  AFPCaptureOutputProxy *_testCaptureOutputProxy;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureOutput = OCMClassMock([AVCaptureOutput class]);
  _testCaptureOutputProxy = [[AFPCaptureOutputProxy alloc] initWithCaptureOutput:_mockCaptureOutput];
}

- (void)testCreateCaptureOutput {
  _AFPCaptureOutputChannel *mockOutputChannel = OCMClassMock([_AFPCaptureOutputChannel class]);
  OCMStub([_mockImplementations channelCaptureOutput]).andReturn(mockOutputChannel);
  
  AFPCaptureOutputProxy *outputProxy = [[AFPCaptureOutputProxy alloc] initWithCaptureOutput:_mockCaptureOutput
                                                                            implementations:_mockImplementations];
  OCMVerify([mockOutputChannel _create_:outputProxy _owner:NO completion:OCMOCK_ANY]);
}

- (void)testConnectionWithMediaType {
  AVCaptureConnection *mockConnection = OCMClassMock([AVCaptureConnection class]);
  OCMStub([_mockCaptureOutput connectionWithMediaType:AVMediaTypeVideo]).andReturn(mockConnection);
 
  AFPCaptureConnectionProxy *connectionProxy = [_testCaptureOutputProxy connectionWithMediaType:AVMediaTypeVideo];
  XCTAssertEqualObjects(connectionProxy.captureConnection, mockConnection);
}
@end
