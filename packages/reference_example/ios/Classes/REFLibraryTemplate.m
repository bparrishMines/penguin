// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='__prefix__' prefix*/
/*replace :from='REFLibraryTemplate.h' headerFilename*/
#import "REFLibraryTemplate.h"
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate classes class*/
@implementation __prefix____class_name__Channel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class_channel"];
}


- (void)_create:(NSObject<__prefix____class_name__> *)_instance
         _owner:(BOOL)_owner
/*iterate fields field*/
 __field_name__:(/*replace field_type*/NSNumber/**/ *_Nullable)__field_name__
/**/
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[/*iterate fields field*/__field_name__/**/]
                        owner:_owner
                   completion:completion];
}

/*iterate staticMethods staticMethod*/
- (void)___staticMethod_name__:
/*if hasParameters*/
/*iterate :end=1 parameters parameter*/
(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**//**/
/*iterate :start=1 parameters followingParameter*/
   __followingParameter_name__:(/*replace followingParameter_type*/NSString/**/ *_Nullable)__followingParameter_name__
/**/
/*if hasParameters*/completion:/**/(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeStaticMethod:@"__staticMethod_name__"
                 arguments:@[/*iterate parameters parameter*/__parameter_name__,/**/]
                completion:completion];
}
/**/

/*iterate methods method*/
- (void)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
      __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/
              completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@"__method_name__"
           arguments:@[/*iterate parameters parameter*/__parameter_name__,/**/]
          completion:completion];
}
/**/
@end
/**/

/*iterate classes class*/
@implementation __prefix____class_name__Handler
- (NSObject<__prefix____class_name__> *)_create:(REFTypeChannelMessenger *)messenger
                                 /*iterate fields field*/
                                 __field_name__:(/*replace field_type*/NSNumber/**/ *)__field_name__
/**/{
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}

/*iterate staticMethods staticMethod*/
- (NSObject *_Nullable)___staticMethod_name__:(REFTypeChannelMessenger *)messenger
/*iterate parameters parameter*/
                           __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/ {
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}
/**/

/*iterate methods method*/
- (NSObject *_Nullable)___method_name__:(NSObject<__prefix____class_name__> *)_instance
/*iterate parameters parameter*/
                     __parameter_name__:(/*replace parameter_type*/NSString/**/ *_Nullable)__parameter_name__
/**/ {
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  /*iterate :join='else' staticMethods staticMethod*/
  if ([@"__staticMethod_name__" isEqualToString:methodName]) {
    return [self ___staticMethod_name__:messenger
                    /*iterate parameters parameter*/
                     __parameter_name__:arguments[/*replace parameter_index*/0/**/]] /**/;
  }
  /**/
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  return [self _create:messenger /*iterate fields field*/__field_name__:arguments[/*replace field_index*/0/**/] /**/];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  NSObject<__prefix____class_name__> *value = (NSObject<__prefix____class_name__> *) instance;
  /*iterate methods method*/
  if ([@"__method_name__" isEqualToString:methodName]) {
    return [self ___method_name__:value
               /*iterate parameters parameter*/
               __parameter_name__:arguments[/*replace parameter_index*/0/**/] /**/];
  }
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
}

- (void)unregisterHandlers {
  /*iterate classes class*/
  [_implementations.channel__class_name__ removeHandler];
  /**/
}
@end
/**/
