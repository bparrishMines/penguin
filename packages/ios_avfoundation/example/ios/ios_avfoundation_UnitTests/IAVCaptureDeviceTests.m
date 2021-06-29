#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

// AVCaptureDevice can't be mocked so this is used in its place.
@interface TestCaptureDevice : NSObject
@end

@implementation TestCaptureDevice
- (instancetype)init {
  return self = [super init];
}

- (AVCaptureDevicePosition)position {
  return 2;
}

- (NSString *)uniqueID {
  return @"test_uniqueID";
}
@end

@interface IAVCaptureDeviceTests : XCTestCase
@end

@implementation IAVCaptureDeviceTests {
  TestCaptureDevice *_testCaptureDevice;
  IAFLibraryImplementations *_mockImplementations;
  _IAFCaptureDeviceChannel *_mockCaptureDeviceChannel;
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _mockCaptureDeviceChannel = OCMClassMock([_IAFCaptureDeviceChannel class]);
  OCMStub([_mockImplementations channelCaptureDevice]).andReturn(_mockCaptureDeviceChannel);
}

- (void)testCreateCapturePhoto {
  IAFCaptureDeviceProxy *captureDeviceProxy = [[IAFCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                                   implementations:_mockImplementations];
  OCMVerify([_mockCaptureDeviceChannel __create:captureDeviceProxy
                                         _owner:NO
                                       uniqueId:@"test_uniqueID"
                                       position:@2 completion:OCMOCK_ANY]);
}

- (void)testDevicesWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  
  OCMStub(ClassMethod([mockCaptureDevice devicesWithMediaType:@"apple"])).andReturn(@[_testCaptureDevice]);
  
  NSArray<IAFCaptureDeviceProxy *> *devices = [IAFCaptureDeviceProxy devicesWithMediaType:@"apple"
                                                                          implementations:_mockImplementations];
  XCTAssertEqual(devices.count, 1);
  
  IAFCaptureDeviceProxy *device = devices[0];
  XCTAssertEqualObjects(device.captureDevice.uniqueID, @"test_uniqueID");
  XCTAssertEqualObjects(@(device.captureDevice.position), @(2));
}
@end
