// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='__prefix__' prefix*/
/*replace :from='REFLibraryTemplate.h' headerFilename*/
#import "REFLibraryTemplate.h"
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate functions function*/
@implementation __prefix____function_name__Channel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__function_channel__"];
}

- (void)__create:(__prefix____function_name__)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance * _Nullable, NSError * _Nullable))completion {
  [self createNewInstancePair:_instance arguments:@[] owner:_owner completion:completion];
}

- (void)invoke:(__prefix____function_name__)_instance
/*iterate parameters parameter*/
      __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@""
           arguments:@[/*iterate parameters parameter*/__parameter_name__,/**/]
          completion:completion];
}
@end
/**/

/*iterate functions function*/
@implementation __prefix____function_name__Handler
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  __block __weak __prefix____function_name__ function;
  __prefix____function_name__ functionInstance = ^(/*iterate :join=',' parameters parameter*//*replace parameter_type*/NSString */**/ _Nullable __parameter_name__/**/) {
    [self->_implementations.channel__function_name__ invoke:function
                                         /*iterate parameters parameter*/
                                         __parameter_name__:__parameter_name__
                                         /**/
                                         completion:^(id result, NSError *error) {}];
    return (NSObject *) nil;
  };
  function = functionInstance;
  return functionInstance;
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  __prefix____function_name__ function = (__prefix____function_name__) instance;
  return function(/*iterate :join=',' parameters parameter*/arguments[/*replace parameter_index*/0/**/]/**/);
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}
@end
/**/

/*iterate classes class*/
@implementation __prefix____class_name__Channel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class_channel__"];
}


- (void)__create:(NSObject<__prefix____class_name__> *)_instance
         _owner:(BOOL)_owner
/*iterate fields field*/
 __field_name__:(/*replace field_type*/NSNumber */**/ _Nullable)__field_name__
/**/
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[/*iterate fields field*/__field_name__,/**/]
                        owner:_owner
                   completion:completion];
}

/*iterate staticMethods staticMethod*/
/*if! returnsFuture*/
- (void)___staticMethod_name__:
/*if hasParameters*/
/*iterate :end=1 parameters parameter*/
(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**//**/
/*iterate :start=1 parameters followingParameter*/
   __followingParameter_name__:(/*replace followingParameter_type*/NSString */**/ _Nullable)__followingParameter_name__
/**/
/*if hasParameters*/completion:/**/(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"__staticMethod_name__"
                 arguments:@[/*iterate parameters parameter*/__parameter_name__,/**/]
                completion:completion];
}
/**/
/**/

/*iterate methods method*/
/*if! returnsFuture*/
- (void)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
      __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@"__method_name__"
           arguments:@[/*iterate parameters parameter*/__parameter_name__,/**/]
          completion:completion];
}
/**/
/**/
@end
/**/

/*iterate classes class*/
@implementation __prefix____class_name__Handler
- (NSObject<__prefix____class_name__> *)__create:(REFTypeChannelMessenger *)messenger
                                 /*iterate fields field*/
                                 __field_name__:(/*replace field_type*/NSNumber */**/)__field_name__
/**/{
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}

/*iterate staticMethods staticMethod*/
/*if returnsFuture*/
- (id _Nullable)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
/*iterate parameters parameter*/
                           __parameter_name__:(/*replace parameter_type*/NSString */**/_Nullable)__parameter_name__
/**/ {
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}
/**/
/**/

/*iterate methods method*/
/*if returnsFuture*/
- (id _Nullable)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
                     __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/ {
  return [_instance __method_name__/*iterate :end=1 parameters parameter*/:__parameter_name__/**/
          /*iterate :start=1 parameters followingParameter*/__followingParameter_name__:/*replace followingParameter_name*/nil/**//**/];
}
/**/
/**/

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  /*iterate :join='else' staticMethods staticMethod*/
  /*if returnsFuture*/
  if ([@"__staticMethod_name__" isEqualToString:methodName]) {
    return [self ___staticMethod_name__:messenger
                    /*iterate parameters parameter*/
                     __parameter_name__:arguments[/*replace parameter_index*/0/**/]] /**/;
  }
  /**/
  /**/
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self __create:messenger /*iterate fields field*/__field_name__:arguments[/*replace field_index*/0/**/] /**/];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<__prefix____class_name__> *value = (NSObject<__prefix____class_name__> *) instance;
  /*iterate :join='else' methods method*/
  /*if returnsFuture*/
  if ([@"__method_name__" isEqualToString:methodName]) {
    return [self ___method_name__:value
               /*iterate parameters parameter*/
               __parameter_name__:arguments[/*replace parameter_index*/0/**/] /**/];
  }
  /**/
  /**/
  
  NSLog(@"Unable to invoke %@.%@", instance, methodName);
  return nil;
}
@end
/**/

@implementation __prefix__LibraryImplementations
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

/*iterate classes class*/
- (__prefix____class_name__Channel *)channel__class_name__ {
  return [[__prefix____class_name__Channel alloc] initWithMessenger:_messenger];
}

- (__prefix____class_name__Handler *)handler__class_name__ {
  return [[__prefix____class_name__Handler alloc] init];
}
/**/

/*iterate functions function*/
- (__prefix____function_name__Channel *)channel__function_name__ {
  return [[__prefix____function_name__Channel alloc] initWithMessenger:_messenger];
}

- (__prefix____function_name__Handler *)handler__function_name__ {
  return [[__prefix____function_name__Handler alloc] initWithImplementations:self];
}
/**/
@end

@implementation __prefix__ChannelRegistrar
- (instancetype)initWithImplementation:(__prefix__LibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (void)registerHandlers {
  /*iterate classes class*/
  [_implementations.channel__class_name__ setHandler:_implementations.handler__class_name__];
  /**/
  /*iterate functions function*/
  [_implementations.channel__function_name__ setHandler:_implementations.handler__function_name__];
  /**/
}

- (void)unregisterHandlers {
  /*iterate classes class*/
  [_implementations.channel__class_name__ removeHandler];
  /**/
  /*iterate functions function*/
  [_implementations.channel__function_name__ removeHandler];
  /**/
}
@end
/**/
