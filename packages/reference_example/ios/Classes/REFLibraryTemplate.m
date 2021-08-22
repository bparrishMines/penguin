// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='__prefix__' prefix*/
/*replace :from='REFLibraryTemplate.h' headerFilename*/
#import "REFLibraryTemplate.h"
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate functions function*/
@implementation __function_name__Channel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__function_channel__"];
}

- (void)_create:(__function_name__)_instance
          _owner:(BOOL)_owner
      completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance arguments:@[] owner:_owner completion:completion];
}

- (void)invoke:(__function_name__)_instance
/*iterate parameters parameter*/
      __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
    completion:(void (^)(id _Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@""
           arguments:@[/*iterate parameters parameter*/__parameter_name__ ? (NSObject *) __parameter_name__ : [NSNull null],/**/]
          completion:completion];
}
@end
/**/

/*iterate functions function*/
@implementation __function_name__Handler
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations {
  self = [super init];
  if (self) {
    _implementations = implementations;
  }
  return self;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  __block __weak __function_name__ function;
  __function_name__ functionInstance = ^(/*iterate :join=',' parameters parameter*//*replace parameter_type*/NSString */**/ _Nullable __parameter_name__/**/) {
    [self->_implementations.channel__function_name__ invoke:function
                                         /*iterate parameters parameter*/
                                         __parameter_name__:__parameter_name__
                                         /**/
                                         completion:^(id result, NSError *error) {}];
  };
  function = functionInstance;
  return functionInstance;
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  __function_name__ function = (__function_name__) instance;
  function(/*iterate :join=',' parameters parameter*/arguments[/*replace parameter_index*/0/**/]/**/);
  return nil;
}

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:nil userInfo:nil];
}
@end
/**/

/*iterate classes class*/
@implementation __class_name__Channel
- (instancetype)initWithMessenger:(REFTypeChannelMessenger *)messenger {
  return self = [super initWithMessenger:messenger name:@"__class_channel__"];
}


/*iterate constructors constructor*/
- (void)_create___constructor_name__:(__class_name__ *)_instance
         _owner:(BOOL)_owner
/*iterate parameters parameter*/
 __parameter_name__:(/*replace parameter_type*/NSNumber */**/ _Nullable)__parameter_name__
/**/
     completion:(void (^)(REFPairedInstance *_Nullable, NSError *_Nullable))completion {
  [self createNewInstancePair:_instance
                    arguments:@[@"__constructor_name__",
  /*iterate parameters parameter*/__parameter_name__ ? (NSObject *) __parameter_name__ : [NSNull null],/**/]
                        owner:_owner
                   completion:completion];
}
/**/

/*iterate staticMethods staticMethod*/
/*if! returnsFuture*/
- (void)___staticMethod_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/

/*if hasParameters*/completion/**/:(void (^)(/*replace staticMethod_returnType*/NSNumber */**/_Nullable,
                                             NSError *_Nullable))completion {
  [self invokeStaticMethod:@"__staticMethod_name__"
                 arguments:@[/*iterate parameters parameter*/__parameter_name__ ? (NSObject *) __parameter_name__ : [NSNull null],/**/]
                completion:completion];
}
/**/
/**/

/*iterate methods method*/
/*if! returnsFuture*/
- (void)___method_name__:(__class_name__ *)_instance
/*iterate parameters parameter*/
      __parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/
              completion:(void (^)(/*replace method_returnType*/NSString */**/_Nullable, NSError *_Nullable))completion {
  [self invokeMethod:_instance
          methodName:@"__method_name__"
           arguments:@[/*iterate parameters parameter*/__parameter_name__ ? (NSObject *) __parameter_name__ : [NSNull null],/**/]
          completion:completion];
}
/**/
/**/
@end
/**/

/*iterate classes class*/
@implementation __class_name__Handler
-(instancetype)initWithImplementations:(__prefix__LibraryImplementations *)implementations {
  if (self) {
    _implemntations = implementations;
  }
  return self;
}

/*iterate constructors constructor*/
- (__class_name__ *)_create___constructor_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSNumber */**/_Nullable)__parameter_name__/**/
/**/ {
  return [[__class_name__ alloc] initWithImplementations:_implemntations
                                                  create:NO
                                      /*iterate parameters parameter*/
                                      __parameter_name__:__parameter_name__
  /**/];
}
/**/

/*iterate staticMethods staticMethod*/
/*if returnsFuture*/
- (/*replace staticMethod_returnType*/NSNumber */**/_Nullable)___staticMethod_name__
/*iterate parameters parameter*/
/*if! first*//*erase*////**/__parameter_name__/**/
:(/*replace parameter_type*/NSString */**/_Nullable)__parameter_name__/**/
/**/ {
  return [__class_name__ __staticMethod_name__
          /*iterate parameters parameter*/
          /*if! first*//*erase*////**/__parameter_name__/**/
          :__parameter_name__/**/
          /**/
          ];
}
/**/
/**/

/*iterate methods method*/
/*if returnsFuture*/
- (/*replace method_returnType*/NSString */**/_Nullable)___method_name__:(__class_name__ *)_instance
/*iterate parameters parameter*/
__parameter_name__:(/*replace parameter_type*/NSString */**/ _Nullable)__parameter_name__
/**/ {
  return [_instance __method_name__
          /*iterate parameters parameter*/
          /*if! first*//*erase*////**/__parameter_name__/**/
          :__parameter_name__/**/
          /**/
          ];
}
/**/
/**/

- (id _Nullable)invokeStaticMethod:(nonnull REFTypeChannelMessenger *)messenger
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray *)arguments {
  /*iterate :join='else' staticMethods staticMethod*/
  /*if returnsFuture*/
  if ([@"__staticMethod_name__" isEqualToString:methodName]) {
    return [self ___staticMethod_name__
            /*iterate parameters parameter*/
            /*if! first*//*erase*////**/__parameter_name__/**/
            :arguments[/*replace parameter_index*/0/**/]
            /**/];
  }
  /**/
  /**/
  
  NSLog(@"Unable to invoke static method %@", methodName);
  return nil;
}

- (nonnull id)createInstance:(nonnull REFTypeChannelMessenger *)messenger
                   arguments:(nonnull NSArray *)arguments {
  NSString *constructorName = arguments[0];
  /*iterate :join='else' constructors constructor*/
  if ([@"__constructor_name__" isEqualToString:constructorName]) {
    return [self _create___constructor_name__
            /*iterate parameters parameter*/
            /*if! first*//*erase*////**/__parameter_name__/**/
            :arguments[/*replace parameter_index*/1/**/]
            /**/];
  }
  /**/
  
  NSString *reason = [NSString stringWithFormat:@"Unable to create a '__class_name__' with constructor name `%@`", constructorName];
  @throw [NSException exceptionWithName:@"__prefix__UnimplementedException" reason:reason userInfo:nil];
}

- (id _Nullable)invokeMethod:(nonnull REFTypeChannelMessenger *)messenger
                    instance:(nonnull NSObject *)instance
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray *)arguments {
  __class_name__ *value = (__class_name__ *) instance;
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
    /*iterate classes class*/
    _channel__class_name__ = [[__class_name__Channel alloc] initWithMessenger:messenger];
    _handler__class_name__ = [[__class_name__Handler alloc] initWithImplementations:self];
    /**/
    /*iterate functions function*/
    _channel__function_name__ = [[__function_name__Channel alloc] initWithMessenger:messenger];
    _handler__function_name__ = [[__function_name__Handler alloc] initWithImplementations:self];
    /**/
  }
  return self;
}
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
