#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAFCaptureInputPortTests : XCTestCase
@end

@implementation IAFCaptureInputPortTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
  AVCaptureInputPort *_mockCaptureInputPort;
  IAFCaptureInputPortProxy *_testCaptureInputPortProxy;
  _IAFCaptureInputPortChannel *_mockCaptureInputPortChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
  _mockCaptureInputPort = OCMClassMock([AVCaptureInputPort class]);
  _testCaptureInputPortProxy = [[IAFCaptureInputPortProxy alloc] initWithCaptureInputPort:_mockCaptureInputPort
                                                                          implementations:_mockImplementations];
  _mockCaptureInputPortChannel = OCMClassMock([_IAFCaptureInputPortChannel class]);
  OCMStub([_mockImplementations channelCaptureInputPort]).andReturn(_mockCaptureInputPortChannel);
}

- (void)testCreateCaptureInputPort {
  OCMStub([_mockCaptureInputPort mediaType]).andReturn(@"apple");
  OCMStub([_mockCaptureInputPort sourceDeviceType]).andReturn(@"banana");
  OCMStub([_mockCaptureInputPort sourceDevicePosition]).andReturn(23);
  
  IAFCaptureInputPortProxy *captureInputPortProxy = [[IAFCaptureInputPortProxy alloc] initWithCaptureInputPort:_mockCaptureInputPort
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
