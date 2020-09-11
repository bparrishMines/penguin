#import <XCTest/XCTest.h>
@import e2e;

@interface MyTestRunner : NSObject

- (BOOL)runTest:(NSString **)testResult;

@end

@interface reference_example_exampleTests : XCTestCase
@end
                                                    
@implementation reference_example_exampleTests
                                                      
-(void)testMyPlugin {
  NSString *testResult;
  MyTestRunner *testRunner = [[MyTestRunner alloc] init];
  BOOL testPass = [testRunner runTest:&testResult];
  XCTAssertTrue(testPass, @"%@", testResult);
}
                                                      
@end

@implementation MyTestRunner

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
