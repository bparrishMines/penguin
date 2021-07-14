#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface IAVCaptureDeviceInputTests : XCTestCase
@end

@implementation IAVCaptureDeviceInputTests {
  IAFLibraryImplementations *_mockImplementations;
  REFTypeChannelMessenger *_mockTypeChannelMessenger;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockTypeChannelMessenger = OCMClassMock([REFTypeChannelMessenger class]);
}

- (void)testCreateCaptureDeviceInput {
  IAFLibraryImplementations *implementations = [[IAFLibraryImplementations alloc]
                                                initWithMessenger:_mockTypeChannelMessenger];

  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  IAFCaptureDeviceProxy *captureDevice = [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:mockCaptureDevice
                                                                              implementations:_mockImplementations];
  
  id mockDeviceInput = OCMClassMock([AVCaptureDeviceInput class]);
  OCMStub([mockDeviceInput alloc]).andReturn(mockDeviceInput);
  OCMStub([mockDeviceInput initWithDevice:mockCaptureDevice
                                    error:((NSError __autoreleasing **)[OCMArg anyPointer])]).andReturn(mockDeviceInput);
  
  IAFCaptureDeviceInputProxy *captureDeviceProxy = (IAFCaptureDeviceInputProxy *) [implementations.handlerCaptureDeviceInput
                                                    _create_:_mockTypeChannelMessenger
                                                    device:captureDevice];

  XCTAssertEqualObjects(mockDeviceInput, captureDeviceProxy.captureInput);
}
@end
