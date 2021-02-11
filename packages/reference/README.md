# reference

A library for building [Flutter plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages) that want to maintain access to object instances on separate threads/programming languages.

---

## Overview

This library works by managing pairs of references. Each pair consists of a `LocalReference` and a
`RemoteReference` and is stored and managed in a `ReferencePairManager`. Here are the basic
definitions of these classes:
* [LocalReference] - represents an object instance that is locally accessible. Typically on the same thread
and same programming language
* [RemoteReference] - represents an object instance that is remotely accessible. Typically on another thread
and/or another programming language.
* [UnpairedReference] - represents an object that is not paired to any `Reference`.
* [ReferencePairManager] - manages communication between objects represented by `LocalReference`s
and `RemoteReference`s.

Each reference pair is also is maintained by two `ReferencePairManager`s. One `ReferencePairManager`
is locally accessible by the object represented by `LocalReference` and another
`ReferencePairManager` is locally accessible by the object represented by `RemoteReference`.

The labels of **local** and **remote** are relative to a thread or coding language. A
`RemoteReference` in one `ReferencePairManager` will represent a `LocalReference` in another
`ReferencePairManager` and vice versa. This is shown in the diagram below:

<img src="https://raw.githubusercontent.com/bparrishMines/penguin/master/readme_images/reference/reference_architecture.jpg" alt="Reference Architecture" />

It’s also important to note that the `RemoteReference` in both `ReferencePairManagers` are
considered equivalent values, so they can be used to identify their paired `LocalReference`s. One
could also view this as if the two `LocalReference`s are paired and the `RemoteReference`s represents
the object on another thread and/or programming language.

For every reference pair, the `ReferencePairManager`’s role is to handle communication between
paired objects represented by `LocalReference` and `RemoteReference`.

For more information on how a `ReferencePairManager` handles communication for each reference pair,
see [Additional Overview](https://pub.dev/packages/reference#additional-overview).
Below is a short guide for getting started.

## Getting Started

To use this with your own plugin, you will have to extend `ReferencePairManager` and implement
`RemoteReferenceCommunicationHandler` and `LocalReferenceCommunicationHandler`. This needs to be
done in Dart and then on every platform that is wanted to be supported. (e.g. Java/Kotlin for
Android or Obj-C/Swift for iOS). This plugin allows you to use any system for IPC (e.g.
[MethodChannel] or [dart:ffi](https://dart.dev/guides/libraries/c-interop)), but it also provides a
[MethodChannelReferencePairManager] that is a partial implementation using `MethodChannel`s.

Below is a guide for using `MethodChannelReferencePairManager`. It is not required, but a
basic understanding of [MethodChannel]s helps understand how this plugin works. The full example
project lives at https://github.com/bparrishMines/penguin/tree/master/reference_example.

To get access to the `reference` plugin API, start by adding the plugin to your `pubspec.yaml` and
following the instructions to
[add the dependency for each supported platform](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#dependencies).

### Implementing `LocalReference`

Start by deciding which classes that will be supported. Each of these classes should implement
`LocalReference`. This should be done in Dart and platform code:

**Dart:**
```dart
import 'package:reference/reference.dart';

class MyClass with LocalReference {
  String stringField;

  Future<void> myMethod(double value, MyOtherClass myOtherClass) {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}

class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  static Future<int> myStaticMethod() {

  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}
```

**Java:**
```java
public class MyClass implements LocalReference {
  public MyClass(String stringField) {
    this.stringField = stringField;
  }

  public final String stringField;

  public String myMethod(double value, MyOtherClass myOtherClass) {
    return String.format("myMethod(%f, %s)", value, myOtherClass.toString());
  }

  // The unique `Class` used to represent this class in a `ReferencePairManager`.
  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return MyClass.class;
  }
}

class MyOtherClass implements LocalReference {
  public final int intField;

  static Integer myStaticMethod() {
    return 324;
  }

  public MyOtherClass(int intField) {
    this.intField = intField;
  }

  // The unique `Class` used to represent this class in a `ReferencePairManager`.
  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return MyOtherClass.class;
  }
}
```

**Objective-C:**
```objectivec
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
```

### Extending `MethodChannelRemoteHandler`

This class is responsible for sending messages to other `ReferencePairManager`s when a new pair is
created, a pair is disposed or a `RemoteReference` needs to invoke a method. This class requires
implementation of `getCreationArguments`, passing a shared unique channel name, and a
`BinaryMessenger` if the platform requires it.

**Dart:**
```dart
class MyRemoteHandler extends MethodChannelRemoteHandler {
  MyRemoteHandler() : super('my_method_channel');

  // This method should return a list of arguments to instantiate a new instance of the object.
  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    if (localReference is MyClass) {
      return <Object>[localReference.stringField];
    } else if (localReference is MyOtherClass) {
      return <Object>[localReference.intField];
    }

    throw UnsupportedError('${localReference.referenceType} is not supported.');
  }
}
```

**Java:**
```java
class MyRemoteHandler extends MethodChannelRemoteHandler {
  MyRemoteHandler(BinaryMessenger binaryMessenger) {
    super(binaryMessenger, "my_method_channel");
  }

  // This method should return a list of arguments to instantiate a new instance of the object.
  @Override
  public List<Object> getCreationArguments(LocalReference localReference) {
    if (localReference instanceof MyClass) {
      final MyClass value = (MyClass) localReference;
      return Collections.singletonList((Object) value.stringField);
    } else if (localReference instanceof MyOtherClass) {
      final MyOtherClass value = (MyOtherClass) localReference;
      return Collections.singletonList((Object) value.intField);
    }

    throw new UnsupportedOperationException(String.format("%s is not supported.", localReference));
  }
}
```

**Objective-C:**
```objectivec
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
```

### Implementing `LocalReferenceCommunicationHandler`

This class is responsible for receiving messages from `ReferencePairManager`s when it would like to
establish a new pair, dispose a pair or execute a method on a `LocalReference`:

**Dart:**
```dart
class MyLocalHandler implements LocalReferenceCommunicationHandler {
  // Every `referenceType` should represents a type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @override
  LocalReference create(
    ReferencePairManager manager,
    Type referenceType,
    List<Object> arguments,
  ) {
    if (referenceType == MyClass) {
      return MyClass(arguments[0]);
    } else if (referenceType == MyOtherClass) {
      return MyOtherClass(arguments[0]);
    }

    throw UnsupportedError('$referenceType is not supported.');
  }

  // This method handles invoking static methods on LocalReferences stored in
  // the ReferencePairManager.
  @override
  Object invokeStaticMethod(
    ReferencePairManager referencePairManager,
    Type referenceType,
    String methodName,
    List<Object> arguments,
  ) {
    if (referenceType == MyOtherClass && methodName == 'myStaticMethod') {
      return MyOtherClass.myStaticMethod();
    }

    throw UnimplementedError('$referenceType.$methodName');
  }

  // This method handles invoking methods on LocalReferences stored in the ReferencePairManager.
  @override
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    if (localReference is MyClass && methodName == 'myMethod') {
      return localReference.myMethod(arguments[0], arguments[1]);
    }

    throw UnimplementedError('${localReference.referenceType}.$methodName');
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager. This method is optional.
  @override
  void dispose(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {
    // Do additional closing.
  }
}
```

**Java:**
```java
class MyLocalHandler implements LocalReferenceCommunicationHandler {
  // Every `referenceClass` should represents a type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @Override
  public LocalReference create(ReferencePairManager referencePairManager,
                               Class<? extends LocalReference> referenceClass,
                               List<Object> arguments) {
    if (referenceClass == MyClass.class) {
      return new MyClass((String) arguments.get(0));
    } else if (referenceClass == MyOtherClass.class) {
      return new MyOtherClass((Integer) arguments.get(0));
    }

    throw new UnsupportedOperationException(String.format("%s not supported.", referenceClass));
  }

  // This method handles invoking static methods on LocalReferences stored in
  // the ReferencePairManager.
  @Override
  public Object invokeStaticMethod(ReferencePairManager referencePairManager,
                                   Class<? extends LocalReference> referenceClass,
                                   String methodName, List<Object> arguments) {
    if (referenceClass == MyOtherClass.class && methodName.equals("myStaticMethod")) {
      return MyOtherClass.myStaticMethod();
    }

    throw new UnsupportedOperationException(
        String.format("%s.%s not supported.", referenceClass, methodName)
    );
  }

  // This method handles invoking methods on LocalReferences stored in the ReferencePairManager.
  @Override
  public Object invokeMethod(ReferencePairManager referencePairManager,
                             LocalReference localReference,
                             String methodName,
                             List<Object> arguments) {
    if (localReference instanceof MyClass && methodName.equals("myMethod")) {
      final MyClass value = (MyClass) localReference;
      return value.myMethod((Double) arguments.get(0), (MyOtherClass) arguments.get(1));
    }

    throw new UnsupportedOperationException(
        String.format("%s.%s not supported.", localReference, methodName)
    );
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager.
  @Override
  public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) {
    // Do additional closing.
  }
}
```

**Objective-C:**
```objectivec
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
                                 reason:[NSString stringWithFormat:@"%@:%@ not supported.", localReference, methodName]
                               userInfo:nil];
}

// Handle any additional work when the pair with localReference is removed from a
// ReferencePairManager.
-(void)dispose:(REFReferencePairManager *)referencePairManager
localReference:(id<REFLocalReference>)localReference {
  // Do additional closing.
}
@end
```

### Extending `MethodChannelReferencePairManager`

This class is the entry point when creating a new pair, disposing a pair, or invoking a method. You
should extend it and pass it instances of your `MethodChannelRemoteHandler` and
`LocalReferenceCommunicationHandler`.

**Dart:**
```dart
class MyReferencePairManager extends MethodChannelReferencePairManager {
  // Constructs a MethodChannelReferencePairManager that supports types: MyClass and MyOtherClass
  MyReferencePairManager()
      : super(<Type>[MyClass, MyOtherClass], 'my_method_channel');

  @override
  LocalReferenceCommunicationHandler get localHandler => MyLocalHandler();

  @override
  MethodChannelRemoteHandler get remoteHandler => MyRemoteHandler();
}
```

**Java:**
```java
class MyReferencePairManager extends MethodChannelReferencePairManager {
  // Constructs a ReferencePairManager that supports types: MyClass and MyOtherClass
  MyReferencePairManager(final BinaryMessenger binaryMessenger) {
    super(asList(MyClass.class, MyOtherClass.class),
        binaryMessenger,
        "my_method_channel");
  }

  @Override
  public ReferencePairManager.LocalReferenceCommunicationHandler getLocalHandler() {
    return new MyLocalHandler();
  }

  @Override
  public MethodChannelRemoteHandler getRemoteHandler() {
    return new MyRemoteHandler(binaryMessenger);
  }
}
```

**Objective-C:**
```objectivec
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
```

### Usage

Your `ReferencePairManager`s can now be used by instantiating them and calling `initialize`. Below
is an example of updating `MyClass` to use `ReferencePairManager` and preparing the
`ReferencePairManager` in your plugin:

**Dart:**
```dart
final MyReferencePairManager referencePairManager = MyReferencePairManager()
  ..initialize();

class MyClass with LocalReference {
  MyClass(this.stringField) {
    referencePairManager.pairWithNewRemoteReference(this);
  }

  final String stringField;

  Future<String> myMethod(double value, MyOtherClass myOtherClass) async {
    return (await referencePairManager.invokeRemoteMethod(
      referencePairManager.getPairedRemoteReference(this),
      'myMethod',
      <dynamic>[value, myOtherClass],
    )) as String;
  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}

class MyOtherClass with LocalReference {
  MyOtherClass(this.intField);

  final int intField;

  static Future<int> myStaticMethod() async {
    return (await referencePairManager.invokeRemoteStaticMethod(
      MyOtherClass,
      'myMethod',
    )) as int;
  }

  // The unique `Type` used to represent this class in a `ReferencePairManager`.
  @override
  Type get referenceType => runtimeType;
}
```

**Java:**
```java
public class ReferenceExamplePlugin implements FlutterPlugin {
  public static void registerWith(Registrar registrar) {
    new ReferenceExamplePlugin().initialize(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initialize(flutterPluginBinding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new MyReferencePairManager(binaryMessenger).initialize();
  }
}
```

**Objective-C:**
```objectivec
@interface ReferenceExamplePlugin : NSObject<FlutterPlugin>
@end

@implementation ReferenceExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  MyReferencePairManager *manager = [[MyReferencePairManager alloc] initWithBinaryMessenger:registrar.messenger];
  [manager initialize];
}
@end
```

## Additional Overview

### How ReferencePairManager Handles Communication

`ReferencePairManager`s are responsible for creating pairs, disposing pairs, and invoking methods
on paired references. This class doesn’t have any IPC of its own and depends on delegates that
should be implemented by the user that handles sending messages and receiving messages with another
thread or coding language. The definition of these delegates follow:

* [RemoteReferenceCommunicationHandler] - Handles communication with `RemoteReference`s for a
`ReferencePairManager`. This class communicates with other `ReferencePairManager`s to create,
dispose, or invoke methods on `RemoteReference`s.
* [LocalReferenceCommunicationHandler] - Handles communication with `LocalReference`s for a
`ReferencePairManager`. This class handles communication from other `ReferencePairManager`s to
create, dispose, or invoke methods for a `LocalReference`.
* [ReferenceConverter] - Handles converting `Reference`s for a `ReferencePairManager`. When a
`ReferencePairManager` receives arguments from another `ReferencePairManager` or sends arguments to
another `ReferencePairManager`, it converts `Reference`s to their paired
`LocalReference`/`RemoteReference` or creates a new `UnpairedReference`.

Below is the typical flow for either creating a pair, disposing of a pair, or a `LocalReference`
executing a method on it’s paired `RemoteReference`. The `ReferencePairManager` API should be
identical on each platform/language, so the flow should remain the same when starting from any
thread or programming language. A detailed example of this flow follows.

<img src="https://raw.githubusercontent.com/bparrishMines/penguin/master/readme_images/reference/reference_flow.jpg" alt="Reference Architecture" />

Let’s assume we want to create a new pair. It’s also important to remember that what is considered a
`LocalReference` to one `ReferencePairManager`, is considered a `RemoteReference` to another.

1. An instance of `LocalReference` is created.
1. `LocalReference` tells ReferencePairManager1 to create a `RemoteReference`.
1. ReferencePairManager1 creates a `RemoteReference` and stores the `RemoteReference` and the `LocalReference` as a pair.
1. ReferencePairManager1 tells its `RemoteReferenceCommunicationHandler` to communicate with another `ReferencePairManager` to create a `RemoteReference` for the instance of `LocalReference`.
1. `RemoteReferenceCommunicationHandler` tells ReferencePairManager2 to make a `RemoteReference`.
1. ReferencePairManager2 tells its `LocalReferenceCommunicationHandler` to create a `LocalReference`.
1. `LocalReferenceCommunicationHandler` creates and returns a `LocalReference`.
1. ReferencePairManager2 stores the `RemoteReference` and the `LocalReference` from `LocalReferenceCommunicationHandler` as a pair.

<!-- Links -->
[LocalReference]: https://pub.dev/documentation/reference/latest/reference/LocalReference-mixin.html
[RemoteReference]: https://pub.dev/documentation/reference/latest/reference/RemoteReference-class.html
[UnpairedReference]: https://pub.dev/documentation/reference/latest/reference/UnpairedReference-class.html
[ReferenceConverter]: https://pub.dev/documentation/reference/latest/reference/ReferenceConverter-mixin.html
[ReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/ReferencePairManager-class.html
[LocalReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/LocalReferenceCommunicationHandler-mixin.html
[RemoteReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/RemoteReferenceCommunicationHandler-mixin.html
[MethodChannelReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/MethodChannelReferencePairManager-class.html
[MethodChannel]: https://flutter.dev/docs/development/platform-integration/platform-channels