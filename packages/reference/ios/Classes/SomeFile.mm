#import "SomeFile.h"
#import "reference.cpp"

@implementation DummyClass
- (instancetype)init {
  reference_dart_dl_initialize((void *)"fwiejf");
  return nil;
}
@end
