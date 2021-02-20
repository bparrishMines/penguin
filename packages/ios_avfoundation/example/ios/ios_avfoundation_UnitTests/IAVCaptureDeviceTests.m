#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

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
}

- (void)setUp {
  _testCaptureDevice = [[TestCaptureDevice alloc] init];
}

- (void)testDevicesWithMediaType {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  
  OCMStub(ClassMethod([mockCaptureDevice devicesWithMediaType:@"apple"])).andReturn(@[_testCaptureDevice]);
  
  NSArray<IAVCaptureDeviceProxy *> *devices = [IAVCaptureDeviceProxy devicesWithMediaType:@"apple" channels:nil];
  XCTAssertEqual(devices.count, 1);
  
  IAVCaptureDeviceProxy *device = devices[0];
  XCTAssertEqualObjects(device.uniqueId, @"test_uniqueID");
  XCTAssertEqualObjects(device.position, @(2));
}

-(void)testInitWithUniqueID {
  id mockCaptureDevice = OCMClassMock([AVCaptureDevice class]);
  
  OCMStub(ClassMethod([mockCaptureDevice deviceWithUniqueID:@"test_id"])).andReturn(_testCaptureDevice);
  
  IAVCaptureDeviceProxy *captureDevice = [[IAVCaptureDeviceProxy alloc] initWithCaptureDevice:_testCaptureDevice
                                                                                     channels:nil];
  XCTAssertEqualObjects(_testCaptureDevice, captureDevice.captureDevice);
}
@end
