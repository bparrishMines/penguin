#import "EXPChannelRegistrar.h"

@implementation __class_name__
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations
                                create:(BOOL)create
                    __parameter_name__:(NSNumber *)__parameter_name__{
  return [self initWithClassTemplate:implementations
                              create:create
                       classTemplate:[[ClassTemplate alloc] initWithFieldTemplate:__parameter_name__.intValue]];
}

-(instancetype)initWithClassTemplate:(__prefix__LibraryImplementations *)implementations
                              create:(BOOL)create
                       classTemplate:(ClassTemplate *)classTemplate {
  if (self) {
    _implementations = implementations;
    _classTemplate = classTemplate;
    if (create) {
      [_implementations.channel__class_name__ _create___constructor_name__:self
                                                                    _owner:false
                                                        __parameter_name__:@(_classTemplate.fieldTemplate)
                                                                completion:^(REFPairedInstance *instance, NSError *error) {}];
    }
  }
  
  return self;
}

+ (NSNumber *)__staticMethod_name__:(NSString *)__parameter_name__ {
  return @([ClassTemplate staticMethodTemplate:__parameter_name__]);
}


- (NSString *)__method_name__:(NSString *_Nullable)__parameter_name__ {
  return [_classTemplate methodTemplate:__parameter_name__];
}
@end
