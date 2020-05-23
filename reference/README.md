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

A `LocalReference` and `RemoteReference` pair is also maintained by a pair of
`ReferencePairManager`s. One `ReferencePairManager` is on the same thread/process as the object that
`LocalReference` represents and another `ReferencePairManager` is on the same thread/process as the
object that `RemoteReference` represents.

The labels of local and remote are relative to which thread one is on. A `RemoteReference` in a
`ReferencePairManager` will represent a `LocalReference` in another `ReferencePairManager` and vice
versa. This is shown in the diagram below:

<img src="https://raw.githubusercontent.com/bparrishMines/penguin/master/readme_images/reference/reference_architecture.jpg" alt="Reference Architecture" />

It’s also important to note that the `RemoteReference` in both `ReferencePairManagers` are
considered equivalent values, so they can be used to identify paired `LocalReferences`.

For every reference pair, the `ReferencePairManager`’s role is to handle communication between the
objects represented by `LocalReference` and `RemoteReference`.

## How ReferencePairManager Handles Communication

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
calling a method on it’s paired `RemoteReference`. A detailed example follows.

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

## How ReferencePairManager Handles Arguments

When creating a `RemoteReference` or executing a method, you have the option to pass arguments as
well. Before a `ReferencePairManager` hands off arguments to a
`RemoteReferenceCommunicationHandler`, it converts all `LocalReference`s to `RemoteReference`s and
before a `ReferencePairManager` hands off arguments to a `LocalReferenceCommunicationHandler` it
converts all `RemoteReference`s to `LocalReference`s.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

To use this with your own plugin, you will have to extend `ReferencePairManager` and implement
`RemoteReferenceCommunicationHandler` and `LocalReferenceCommunicationHandler`. This needs to be
done in Dart and then on every platform that is wanted to be supported. (e.g. Java/Kotlin for
Android or Obj-C/Swift for iOS. This plugin allows you to use any system for IPC (e.g.
`MethodChannel` or dart:ffi), but it also provides a [MethodChannelReferencePairManager] that is a
partial implementation using `MethodChannel`s. Here are the latest example implementations for
[Dart](https://github.com/bparrishMines/penguin/blob/master/reference/lib/src/template/src/template.g.dart)
and [Java](https://github.com/bparrishMines/penguin/blob/master/reference/android/src/main/java/github/penguin/reference/templates/GeneratedReferencePairManager.java).

<!-- Links -->
[LocalReference]: https://pub.dev/documentation/reference/latest/reference/LocalReference-mixin.html
[RemoteReference]: https://pub.dev/documentation/reference/latest/reference/RemoteReference-class.html
[TypeReference]: https://pub.dev/documentation/reference/latest/reference/TypeReference-class.html
[ReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/ReferencePairManager-class.html
[LocalReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/LocalReferenceCommunicationHandler-mixin.html
[RemoteReferenceCommunicationHandler]: https://pub.dev/documentation/reference/latest/reference/RemoteReferenceCommunicationHandler-mixin.html
[MethodChannelReferencePairManager]: https://pub.dev/documentation/reference/latest/reference/MethodChannelReferencePairManager-class.html
