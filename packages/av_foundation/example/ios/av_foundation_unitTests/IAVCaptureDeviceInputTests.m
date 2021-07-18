#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import av_foundation;

@interface IAVCaptureDeviceInputTests : XCTestCase
@end

@implementation IAVCaptureDeviceInputTests {
  AFPLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([AFPLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCaptureDeviceInput {
  AFPLibraryImplementations *implementations = [[AFPLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  AFPCaptureDeviceProxy *captureDevice = [[AFPCaptureDeviceProxy alloc] initWithCaptureDevice:mockCaptureDevice
                                                                              implementations:_mockImplementations];
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  OCMStub([mockDeviceInput initWithDevice:mockCaptureDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);
  
  AFPCaptureDeviceInputProxy *captureDeviceProxy = (AFPCaptureDeviceInputProxy *) [implementations.handlerCaptureDeviceInput
                                                    _create_:_mockTypeChannelMessenger
                                                    device:captureDevice];

  XCTAssertEqualObjects(mockDeviceInput, captureDeviceProxy.captureInput);
}
@end
