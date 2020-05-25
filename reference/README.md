# reference

A library for building Flutter plugins that want to maintain access to object instances on separate threads/processes.

---

## Overview

This library works by managing pairs of references. Each pair consists of a `LocalReference` and a
`RemoteReference`. The pairs are stored and managed in a `ReferencePairManager`. Here are the basic
definitions of these classes:
* [LocalReference] - represents an object on the same thread/process.
* [RemoteReference] - represents an object on a different thread/process.
* [ReferencePairManager] - manages communication between objects represented by `LocalReference`s
and `RemoteReference`s.

A `LocalReference` and `RemoteReference` that are paired are also maintained by two
`ReferencePairManager`s. One `ReferencePairManager` is on the same thread/process as the object that
`LocalReference` represents and another `ReferencePairManager` is on the same thread/process as the
object that `RemoteReference` represents.

The labels of **local** and **remote** are relative to which thread one is on. A `RemoteReference`
in one `ReferencePairManager` will represent a `LocalReference` in another `ReferencePairManager`
and vice versa. This is shown in the diagram below:

<img src="https://raw.githubusercontent.com/bparrishMines/penguin/master/readme_images/reference/reference_architecture.jpg" alt="Reference Architecture" />

It’s also important to note that the `RemoteReference` in both `ReferencePairManagers` are
considered equivalent values, so they can be used to identify their paired `LocalReference`s. One
could also view this as if the two `LocalReference`s are paired and the `RemoteReference`s are a
stand in for an object on another thread.

For every reference pair, the `ReferencePairManager`’s role is to handle communication between
paired objects represented by `LocalReference` and `RemoteReference`.

## Getting Started

`ReferencePairManager`s are responsible for creating pairs, disposing pairs, and executing
methods on paired References. Here are the relevant classes:
* [TypeReference] - represents a type. This type must be able to be represented by a
`LocalReference`.
* [RemoteReferenceCommunicationHandler] - handles communication with `RemoteReference`s for a
`ReferencePairManager`. This class communicates with other `ReferencePairManager`s to create,
dispose, or execute methods on `RemoteReference`s.
* [LocalReferenceCommunicationHandler] - handles communication with `LocalReference`s for a
`ReferencePairManager`. This class handles communication from other `ReferencePairManager`s to
create, dispose, or execute methods for a `LocalReference`.

To use this with your own plugin, you will have to extend `ReferencePairManager` and implement
`RemoteReferenceCommunicationHandler` and `LocalReferenceCommunicationHandler`. This needs to be
done in Dart and then on every platform that is wanted to be supported. (e.g. Java/Kotlin for
Android or Obj-C/Swift for iOS). This plugin allows you to use any system for IPC (e.g.
`MethodChannel` or [dart:ffi](https://dart.dev/guides/libraries/c-interop)), but it also provides a [MethodChannelReferencePairManager] that is a
partial implementation using `MethodChannel`s. Here are the latest template implementations for
[Dart](https://github.com/bparrishMines/penguin/blob/master/reference/lib/src/template/src/template.g.dart)
and [Java](https://github.com/bparrishMines/penguin/blob/master/reference/android/src/main/java/github/penguin/reference/templates/$ReferencePairManager.java).

Below is a walk-through for using `MethodChannelReferencePairManager`.

### Implementing `LocalReference`

Start by deciding which classes will need to support being paired to a `RemoteReference` or is
a user defined type that can be passed as a parameter when creating a `RemoteReference` or executing
a method on one. Each of these classes should implement `LocalReference`. This should be done in
Dart and platform code:

**Dart:**
```dart
class MyClass with LocalReference {
  String stringField;

  void myMethod(double value, MyOtherClass myOtherClass) {

  }
}

class MyOtherClass with LocalReference {
  int intField;
}
```

**Java:**
```java
class MyClass implements LocalReference {
  String stringField;

  void myMethod(double value, MyOtherClass myOtherClass) {

  }
}

class MyOtherClass implements LocalReference {
  int intField;
}
```

### Extending `MethodChannelRemoteReferenceCommunicationHandler`

This class is responsible for sending messages to other `ReferencePairManager`s when a new pair is
created, a pair is disposed or a `RemoteReference` needs to execute a method. The only method
that needs to be implemented is creationArgumentsFor(LocalReference):

**Dart:**
```dart
class MyRemoteHandler extends MethodChannelRemoteReferenceCommunicationHandler {
  This method should return a list of arguments to instantiate a new instance of the object.
  @override
  List<dynamic> creationArgumentsFor(LocalReference localReference) {
    if (localReference is MyClass) {
      return <dynamic>[localReference.stringField];
    } else if (localReference is MyOtherClass) {
      return <dynamic>[localReference.intField];
    }

    throw UnsupportedError('${localReference.runtimeType} is not supported');
  }
}
```

**Java:**
```java
class MyRemoteHandler extends MethodChannelRemoteReferenceCommunicationHandler {
  // This method should return a list of arguments to instantiate a new instance of the object.
  @Override
  public List<Object> creationArgumentsFor(LocalReference localReference) {
    if (localReference instanceof MyClass) {
      return Arrays.asList((Object) ((MyClass) localReference).stringField);
    } else if (localReference instanceof MyOtherClass) {
      return Arrays.asList((Object) ((MyOtherClass) localReference).intField);
    }

    throw new IllegalStateException("meesage");
  }
}
```

### Implementing `LocalReferenceCommunicationHandler`

This class is responsible for receiving messages from `ReferencePairManager`s when it would like to
establish a new pair, dispose a pair or execute a method on a LocalReference:

**Dart:**
```dart
class MyLocalHandler implements LocalReferenceCommunicationHandler {
  // Every TypeReference represents a the type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @override
  LocalReference createLocalReference(
    ReferencePairManager referencePairManager,
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    if (typeReference == TypeReference(0)) {
      return MyClass()..stringField = arguments[0];
    } else if (typeReference == TypeReference(1)) {
      return MyOtherClass()..intField = arguments[0];
    }

    throw UnsupportedError("message");
  }

  // This method handles executing methods on LocalReferences stored in the ReferencePairManager.
  @override
  dynamic executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    if (localReference is MyClass && methodName == 'myMethod') {
      return localReference.myMethod(arguments[0], arguments[1]);
    }

    throw UnimplementedError();
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager.
  @override
  void disposeLocalReference(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {
    // Do additional closing.
  }
}
```

**Java:**
```java
class MyLocalHandler implements ReferencePairManager.LocalReferenceCommunicationHandler {
  // Every TypeReference represents a the type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @Override
  public LocalReference createLocalReference(ReferencePairManager referencePairManager,
                                      TypeReference typeReference,
                                      List<Object> arguments) {
    if (typeReference.equals(new TypeReference(0))) {
      final MyClass value = new MyClass();
      value.stringField = (String) arguments.get(0);
      return value;
    } else if (typeReference.equals(new TypeReference(1))) {
      final MyClass value = new MyClass();
      value.stringField = (String) arguments.get(0);
      return value;
    }

    throw new IllegalStateException("message");
  }

  // This method handles executing methods on LocalReferences stored in the ReferencePairManager.
  @Override
  public Object executeLocalMethod(ReferencePairManager referencePairManager,
                                   LocalReference localReference,
                                   String methodName,
                                   List<Object> arguments) {
    if (localReference instanceof MyClass && methodName.equals("myMethod")) {
      ((MyClass) localReference).myMethod((Double) arguments.get(0), (MyOtherClass) arguments.get(1));
    }

    throw new IllegalStateException("message");
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager.
  @Override
  public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
    // Do additional closing.
  }
}
```

### Extending `MethodChannelReferencePairManager`

This class is the entry point when creating a new pair, disposing a pair, or executing a method. You
should extend it and pass it instances of your `MethodChannelRemoteReferenceCommunicationHandler`
and `LocalReferenceCommunicationHandler`.

**Dart:**
```dart
class MyReferencePairManager extends MethodChannelReferencePairManager {
  MyReferencePairManager(String channelName)
      : super(
          channelName,
          localHandler: MyLocalHandler(),
          remoteHandler: MyRemoteHandler(),
        );

  // Establishes a unique TypeReference for each supported class.
  @override
  TypeReference typeReferenceFor(LocalReference localReference) {
    if (localReference is MyClass) return TypeReference(0);
    if (localReference is MyOtherClass) return TypeReference(1);
    throw UnimplementedError();
  }
}
```

**Java:**
```java
class MyReferencePairManager extends MethodChannelReferencePairManager {
  MyReferencePairManager(final BinaryMessenger binaryMessenger, final String channelName) {
    super(binaryMessenger, channelName, new MyLocalHandler(), new MyRemoteHandler());
  }

  // Establishes a unique TypeReference for each supported class.
  @Override
  TypeReference typeReferenceFor(LocalReference localReference) {
    if (localReference instanceOf MyClass) return new TypeReference(0);
    if (localReference instanceOf MyOtherClass) return new TypeReference(1);

    throw new IllegalStateException("message");
  }
}
```

### Usage

The `ReferencePairManager`s can now be used by instantiating them and calling `initialize`. When
you would like to create a new pair, call `ReferencePairManager.createRemoteReferenceFor(LocalReference)`.

## Additional Overview

### How ReferencePairManager Handles Communication

`ReferencePairManager`s are responsible for creating pairs, disposing pairs, and calling methods on
paired References. Here are the relevant classes:
* [TypeReference] - represents a type. This type must be able to be represented by a
`LocalReference`.
* [RemoteReferenceCommunicationHandler] - handles communication with `RemoteReference`s for a
`ReferencePairManager`. This class communicates with other `ReferencePairManager`s to create,
dispose, or execute methods on `RemoteReference`s.
* [LocalReferenceCommunicationHandler] - handles communication with `LocalReference`s for a
`ReferencePairManager`. This class handles communication from other `ReferencePairManager`s to
create, dispose, or execute methods for a `LocalReference`.

Below is the typical flow for either creating a pair, disposing of a pair, or a `LocalReference`
executing a method on it’s paired `RemoteReference`. A detailed example follows.

<img src="https://raw.githubusercontent.com/bparrishMines/penguin/master/readme_images/reference/reference_flow.jpg" alt="Reference Architecture" />

To give a more detailed explanation, let’s assume we want to create a new pair. It’s also important
to remember that what is considered a `LocalReference` to one `ReferencePairManager`, is considered
a `RemoteReference` to another.

1. An instance of `LocalReference` is created.
1. `LocalReference` tells ReferencePairManager1 to create a `RemoteReference`.
1. ReferencePairManager1 creates a `RemoteReference` and stores the `RemoteReference` and the `LocalReference` as a pair.
1. ReferencePairManager1 tells its `RemoteReferenceCommunicationHandler` to communicate with another `ReferencePairManager` to create a `RemoteReference` for the instance of `LocalReference`.
1. `RemoteReferenceCommunicationHandler` tells ReferencePairManager2 to make a `RemoteReference`.
1. ReferencePairManager2 tells its `LocalReferenceCommunicationHandler` to create a `LocalReference`.
1. `LocalReferenceCommunicationHandler` creates and returns a `LocalReference`.
1. ReferencePairManager2 stores the `RemoteReference` and the `LocalReference` from `LocalReferenceCommunicationHandler` as a pair.

### How ReferencePairManager Handles Arguments

When creating a `RemoteReference` or executing a method, you have the option to pass arguments as
well. Before a `ReferencePairManager` hands off arguments to a
`RemoteReferenceCommunicationHandler`, it converts all `LocalReference`s to `RemoteReference`s and
before a `ReferencePairManager` hands off arguments to a `LocalReferenceCommunicationHandler` it
converts all `RemoteReference`s to `LocalReference`s.

<!-- Links -->
[LocalReference]: https://pub.dev/documentation/reference/latest/reference/LocalReference-mixin.html
[RemoteReference]: https://pub.dev/documentation/reference/latest/reference/RemoteReference-class.html
[TypeReference]: https://pub.dev/documentation/reference/latest/reference/TypeReference-class.html
[ReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/ReferencePairManager-class.html
[LocalReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/LocalReferenceCommunicationHandler-mixin.html
[RemoteReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/RemoteReferenceCommunicationHandler-mixin.html
[MethodChannelReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/MethodChannelReferencePairManager-class.html
