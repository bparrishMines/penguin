#import <XCTest/XCTest.h>
@import e2e;

@interface MyTestRunner : NSObject
- (instancetype)initWithClass:(Class)clazz;
- (BOOL)runTest:(NSString **)testResult;
@end

@interface reference_example_exampleTests : XCTestCase
@end

@interface MyPluginTests : XCTestCaseRun
- (void)testMyClass;
@end
                                                    
@implementation reference_example_exampleTests
                                                      
-(void)testMyPlugin {
  NSString *testResult;
  MyTestRunner *testRunner = [[MyTestRunner alloc] initWithClass:[MyPluginTests class]];
  BOOL testPass = [testRunner runTest:&testResult];
  XCTAssertTrue(testPass, @"%@", testResult);
}
                                                      
@end

@implementation MyTestRunner {
  NSObject *_testClassInstance;
}

- (instancetype)initWithClass:(Class)clazz {
  self = [super init];
  if (self) {
    _testClassInstance = [[clazz alloc] init];
  }
  return self;
}

- (BOOL)runTest:(NSString **)testResult {
  E2EPlugin *e2ePlugin = [E2EPlugin instance];
  UIViewController *rootViewController =
      [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  if (![rootViewController isKindOfClass:[FlutterViewController class]]) {
    NSLog(@"expected FlutterViewController as rootViewController.");
    return NO;
  }
  FlutterViewController *flutterViewController = (FlutterViewController *)rootViewController;
  [e2ePlugin setupChannels:flutterViewController.engine.binaryMessenger];
  
  FlutterMethodChannel *testChannel = [FlutterMethodChannel methodChannelWithName:@"test_channel" binaryMessenger:flutterViewController.engine.binaryMessenger];
  [testChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult _Nonnull result) {
    if (![call.method isEqualToString:@"verify"]) {
      result(FlutterMethodNotImplemented);
    }
    
    SEL methodSelector = NSSelectorFromString(call.arguments);
    if (![self->_testClassInstance respondsToSelector:methodSelector]) {
      result(FlutterMethodNotImplemented);
      return;
    }
    
    IMP imp = [self->_testClassInstance methodForSelector:methodSelector];
    void (*func)(id, SEL) = (void *)imp;
    func(self->_testClassInstance, methodSelector);
    
    result(nil);
  }];
  
  while (!e2ePlugin.testResults) {
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.f, NO);
  }
  NSDictionary<NSString *, NSString *> *testResults = e2ePlugin.testResults;
  NSMutableArray<NSString *> *passedTests = [NSMutableArray array];
  NSMutableArray<NSString *> *failedTests = [NSMutableArray array];
  NSLog(@"==================== Test Results =====================");
  for (NSString *test in testResults.allKeys) {
    NSString *result = testResults[test];
    if ([result isEqualToString:@"success"]) {
      NSLog(@"%@ passed.", test);
      [passedTests addObject:test];
    } else {
      NSLog(@"%@ failed.", test);
      [failedTests addObject:test];
    }
  }
  NSLog(@"================== Test Results End ====================");
  BOOL testPass = failedTests.count == 0;
  if (!testPass && testResult) {
    *testResult =
        [NSString stringWithFormat:@"Detected failed E2E test(s) %@ among %@",
                                   failedTests.description, testResults.allKeys.description];
  }
  return testPass;
}

@end

@implementation MyPluginTests

- (void)myClassTest {
  
}
@end
