#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@import ios_avfoundation;

@interface SessionTestCaptureDevice : NSObject
@end

@implementation SessionTestCaptureDevice
- (instancetype)init {
  return self = [super init];
}

- (AVCaptureDevicePosition)position {
  return 2;
}

- (NSString *)uniqueID {
  return @"test_uniqueID";
}

- (BOOL)isSmoothAutoFocusSupported {
  return YES;
}

- (BOOL)hasFlash {
  return NO;
}
@end

@interface IAFCaptureDeviceDiscoverySessionTests : XCTestCase
@end

@implementation IAFCaptureDeviceDiscoverySessionTests {
  IAFLibraryImplementations *_mockImplementations;
  SessionTestCaptureDevice *_testCaptureDevice;
  id _mockCaptureDeviceDiscoverySessionChannel;
  _IAFCaptureDeviceChannel *_mockCaptureDeviceChannel;
}

- (void)setUp {
  _mockImplementations = OCMClassMock([IAFLibraryImplementations class]);
  _testCaptureDevice = [[SessionTestCaptureDevice alloc] init];

  _mockCaptureDeviceDiscoverySessionChannel = OCMClassMock([_IAFCaptureDeviceDiscoverySessionChannel class]);
  _mockCaptureDeviceChannel = OCMClassMock([_IAFCaptureDeviceChannel class]);

  OCMStub([_mockImplementations channelCaptureDeviceDiscoverySession]).andReturn(_mockCaptureDeviceDiscoverySessionChannel);
  OCMStub([_mockImplementations channelCaptureDevice]).andReturn(_mockCaptureDeviceChannel);
}

- (void)testCreateCaptureDeviceDiscoverySession {
  AVCaptureDeviceDiscoverySession *mockDiscoverySession = OCMClassMock([AVCaptureDeviceDiscoverySession class]);
  OCMStub([mockDiscoverySession devices]).andReturn(@[_testCaptureDevice]);
  NSMutableOrderedSet* deviceSet = [[NSMutableOrderedSet alloc] initWithArray:@[_testCaptureDevice]];
  OCMStub([mockDiscoverySession supportedMultiCamDeviceSets]).andReturn(@[deviceSet]);
  
  __block BOOL blockRan = NO;

  void (^theBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
    blockRan = YES;
    
    NSArray *devices;
    NSArray *supportedMultiCamDeviceSets;

    [invocation getArgument:&devices atIndex:4];
    [invocation getArgument:&supportedMultiCamDeviceSets atIndex:5];

    XCTAssertEqualObjects([devices[0] captureDevice], self->_testCaptureDevice);
    XCTAssertEqualObjects([supportedMultiCamDeviceSets[0][0] captureDevice], self->_testCaptureDevice);
  };
  [[[_mockCaptureDeviceDiscoverySessionChannel stub] andDo:theBlock] __create:[OCMArg any]
                                                                       _owner:NO
                                                                     devices:[OCMArg isNotNil]
                                                 supportedMultiCamDeviceSets:[OCMArg any] completion:[OCMArg any]];

  IAFCaptureDeviceDiscoverySessionProxy *sessionProxy = [[IAFCaptureDeviceDiscoverySessionProxy alloc]
                                                         initWithCaptureDeviceDiscoverySession:mockDiscoverySession
                                                         implementations:_mockImplementations];
  
  XCTAssertTrue(blockRan);
}
@end
