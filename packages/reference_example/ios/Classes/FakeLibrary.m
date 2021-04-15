#import "FakeLibrary.h"

@implementation ClassTemplate {
  NSInteger _fieldTemplate;
}

-(instancetype)initWithFieldTemplate:(NSInteger)fieldTemplate {
  self = [super init];
  if (self) {
    _fieldTemplate = fieldTemplate;
  }
  return self;
}

+(double)staticMethodTemplate:(NSString *)parameterTemplate {
  return parameterTemplate.length;
}

-(NSString *)methodTemplate:(NSString *)parameterTemplate {
  return [parameterTemplate stringByAppendingString:@" World!"];
}
@end
