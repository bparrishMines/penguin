#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface AFPCaptureInputPortTests : XCTestCase
@end

@implementation AFPCaptureInputPortTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureInputPort *_mockCaptureInputPort;
  AFPCaptureInputPortProxy *_testCaptureInputPortProxy;
  _AFPCaptureInputPortChannel *_mockCaptureInputPortChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureInputPort = OCMClassMock([AVCaptureInputPort class]);
  _testCaptureInputPortProxy = [[AFPCaptureInputPortProxy alloc] initWithCaptureInputPort:_mockCaptureInputPort
                                                                          implementations:_mockImplementations];
  _mockCaptureInputPortChannel = OCMClassMock([_AFPCaptureInputPortChannel class]);
  OCMStub([_mockImplementations channelCaptureInputPort]).andReturn(_mockCaptureInputPortChannel);
}

- (void)testCreateCaptureInputPort {
  OCMStub([_mockCaptureInputPort mediaType]).andReturn(@"apple");
  OCMStub([_mockCaptureInputPort sourceDeviceType]).andReturn(@"banana");
  OCMStub([_mockCaptureInputPort sourceDevicePosition]).andReturn(23);
  
  AFPCaptureInputPortProxy *captureInputPortProxy = [[AFPCaptureInputPortProxy alloc] initWithCaptureInputPort:_mockCaptureInputPort
               implementations:_mockImplementations];
  
  OCMVerify([_mockCaptureInputPortChannel _create_:captureInputPortProxy
                                            _owner:NO
                                         mediaType:@"apple"
                                  sourceDeviceType:@"banana"
                              sourceDevicePosition:@(23)
                                        completion:OCMOCK_ANY]);
}

- (void)testSetEnabled {
  [_testCaptureInputPortProxy setEnabled:@YES];
  OCMVerify([_mockCaptureInputPort setEnabled:YES]);
}
@end
