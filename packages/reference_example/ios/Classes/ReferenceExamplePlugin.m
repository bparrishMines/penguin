#import "ReferenceExamplePlugin.h"

/*
@interface MyOtherClass : NSObject<REFLocalReference>
@property (readonly) NSNumber *intField;
+ (NSNumber *)myStaticMethod;
-(instancetype)initWithIntField:(NSNumber *)intField;
@end

@interface MyClass : NSObject<REFLocalReference>
@property (readonly) NSString* stringField;
-(instancetype)initWithStringField:(NSString *)stringField;
-(NSString *)myMethod:(NSNumber *)value myOtherClass:(MyOtherClass *)myOtherClass;
@end

@implementation MyClass
-(instancetype)initWithStringField:(NSString *)stringField {
  self = [super init];
  if (self) {
    _stringField = stringField;
  }
  return self;
}

-(NSString *)myMethod:(NSNumber *)value myOtherClass:(MyOtherClass *)myOtherClass {
  return [NSString stringWithFormat:@"myMethod:%f, %@", value.doubleValue, [myOtherClass description]];
}

// The unique `Class` used to represent this class in a `ReferencePairManager`.
- (REFClass *)referenceClass {
  return [REFClass fromClass:[MyClass class]];
}
@end

@implementation MyOtherClass
-(instancetype)initWithIntField:(NSNumber *)intField {
  self = [super init];
  if (self) {
    _intField = intField;
  }
  return self;
}

+ (NSNumber *)myStaticMethod {
  return @(324);
}

- (REFClass *)referenceClass {
  return [REFClass fromClass:[MyOtherClass class]];
}
@end

@interface MyRemoteHandler : REFMethodChannelRemoteHandler
@end

@implementation MyRemoteHandler
-(instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithChannelName:@"my_method_channel" binaryMessenger:binaryMessenger];
}

// This method should return a list of arguments to instantiate a new instance of the object.
- (NSArray<id> *)getCreationArguments:(id<REFLocalReference>)localReference {
  if (localReference.referenceClass.clazz == [MyClass class]) {
    MyClass *value = localReference;
    return @[value.stringField];
  } else if (localReference.referenceClass.clazz == [MyClass class]) {
    MyOtherClass *value = localReference;
    return @[value.intField];
  }

  @throw [NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"%@ not supported.", localReference]
                               userInfo:nil];
}
@end

@interface MyLocalHandler : NSObject<REFLocalReferenceCommunicationHandler>
@end

@implementation MyLocalHandler
// Every `referenceClass` should represents a type that the LocalReference and RemoteReference
// share. This method should instantiate a new instance for the type reference and arguments.
- (nonnull id<REFLocalReference>)create:(nonnull REFReferencePairManager *)referencePairManager
                         referenceClass:(nonnull Class)referenceClass
                              arguments:(nonnull NSArray<id> *)arguments {
  if (referenceClass == [MyClass class]) {
    return [[MyClass alloc] initWithStringField:arguments[0]];
  } else if (referenceClass == [MyOtherClass class]) {
    return [[MyOtherClass alloc] initWithIntField:arguments[0]];
  }

  @throw [NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"%@ not supported.", NSStringFromClass(referenceClass)]
                               userInfo:nil];
}

// This method handles invoking static methods on LocalReferences stored in
// the ReferencePairManager.
- (id _Nullable)invokeStaticMethod:(nonnull REFReferencePairManager *)referencePairManager
                    referenceClass:(nonnull Class)referenceClass
                        methodName:(nonnull NSString *)methodName
                         arguments:(nonnull NSArray<id> *)arguments {
  if (referenceClass == [MyOtherClass class]) {
    if ([methodName isEqualToString:@"myStaticMethod"]) {
      return [MyOtherClass myStaticMethod];
    }
  }

  @throw [NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"%@:%@ not supported.",
                                         NSStringFromClass(referenceClass),
                                         methodName]
                               userInfo:nil];
}

// This method handles invoking methods on LocalReferences stored in the ReferencePairManager.
- (id _Nullable)invokeMethod:(nonnull REFReferencePairManager *)referencePairManager
              localReference:(nonnull id<REFLocalReference>)localReference
                  methodName:(nonnull NSString *)methodName
                   arguments:(nonnull NSArray<id> *)arguments {
  if (localReference.referenceClass.clazz == [MyClass class]) {
    if ([methodName isEqualToString:@"myMethod"]) {
      MyClass *value = localReference;
      return [value myMethod:arguments[0] myOtherClass:arguments[1]];
    }
  }

  @throw [NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"%@:%@ not supported.",
                                         localReference,
                                         methodName]
                               userInfo:nil];
}

// Handle any additional work when the pair with localReference is removed from a
// ReferencePairManager.
-(void)dispose:(REFReferencePairManager *)referencePairManager
localReference:(id<REFLocalReference>)localReference {
  // Do additional closing.
}
@end

@interface MyReferencePairManager : REFMethodChannelReferencePairManager
// Constructs a ReferencePairManager that supports types: MyClass and MyOtherClass
-(instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
@end

@implementation MyReferencePairManager
-(instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
  return self = [super initWithSupportedClasses:@[[REFClass fromClass:[MyClass class]], [REFClass fromClass:[MyOtherClass class]]]
                                binaryMessenger:binaryMessenger
                                    channelName:@"my_method_channel"];
}

- (id<REFLocalReferenceCommunicationHandler>)localHandler {
  return [[MyLocalHandler alloc] init];
}

- (id<REFRemoteReferenceCommunicationHandler>)remoteHandler {
  return [[MyRemoteHandler alloc] initWithBinaryMessenger:[self binaryMessenger]];
}
@end

*/
@implementation ReferenceExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  //MyReferencePairManager *manager = [[MyReferencePairManager alloc] initWithBinaryMessenger:registrar.messenger];
  //[manager initialize];
}
@end
