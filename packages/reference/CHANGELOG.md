## 0.4.3+1

* Remove tracker callback when weak reference is removed on iOS.
* Fix crash from null callback.

## 0.4.3

* Fix struct generative constructor requirement and add `ReferenceConstructor` annotation.
* Add Add auto garbage collection to iOS.

## 0.4.2+1

* Switch to `WeakReference`s on Android.

## 0.4.2

* Garbage collection on Android is now handled automatically by `PhantomReference`s.

## 0.4.1+1

* Format platform exceptions caught by `MethodChannelMessenger`.
* Temporarily hold onto created instance pairs not owned by the `TypeChannelMessenger` that creates
  them.

## 0.4.1

* Implement ReferenceWidgets for easier PlatformView use with instances in `InstanceManager`.

## 0.4.0

* **Breaking Change** `TypeChannelHandler.getCreationArguments` has been removed and is replaced by
  passing arguments to `TypeChannel.createNewInstancePair` and `TypeChannelMessenger.createNewInstancePair`.

## 0.3.1

* Add annotations that can ignore a param or method.

## 0.3.0+1

* Make Java classes public.

## 0.3.0

**Breaking Change** `InstancePairManager` has been replaced by `InstanceManager`.

## 0.2.0

* Use garbage collection in Dart to automatically dispose objects.
* Removed `TypeChannelHandler.onInstanceAdded` with `TypeChannelHandler.onInstanceRemoved`.

## 0.2.0-beta.4

* Add Dart `TypeChannel.removeHandler`.

## 0.2.0-beta.3

* `MethodChannelMessenger` on iOS now handles exceptions when receiving messages.

## 0.2.0-beta.2

* `MethodChannelMessenger` supports `List`s supported by `MethodChannel`.

## 0.2.0-beta.1

* Added `TypeChannelManager.getPairedPairedInstance` and `TypeChannelManager.getPairedObject`.
* Name change of `PairableInstance` to `ReferenceType`.
* Added `TypeChannelHandler.onInstanceAdded`.
* Replaced `TypeChannelHandler.onInstanceDisposed` with `TypeChannelHandler.onInstanceRemoved`.
* `TypeChannelManager.generateUniqueInstanceId` now takes an object and uses the hashcode to create
  unique id.
* `PairedInstance` now has a separate hashcode from its `instanceId`.

## 0.2.0-beta

* Migrate to null safety and transition to using type channels. See documentation for more info.

## 0.1.4+1

* Update templates and README examples.

## 0.1.4

* Add support for static methods.

## 0.1.3

* Removed quiver and uuid Dart dependencies.
* Creating a new pair now returns `null` if the pair already exists.

## 0.1.2+1

* Removed Guava dependency on Android.

## 0.1.2

* Improve documentation.
* Add `assert` that `ReferencePairManager.supportedTypes` must contain at least one value in Dart.

## 0.1.1

* Fix bugs in README code.

## 0.1.0

* Added full support for iOS.
* **Breaking Change**: See README for detailed API explanation.
  - Removal of `TypeReference` in favor of passing supported types to `ReferencePairManager`.
  - Converting references is now handled by `ReferenceConverter`.
  - Removal of `UnpairedRemoteReference` in favor of `UnpairedReference`.
  - Renaming of most methods of `ReferencePairManager`, `RemoteReferenceCommunicationHandler`, and `LocalReferenceCommunicationHandler`.
  - `LocalReference` now has a required method.

## 0.0.2

* Update README and improve Dart documentation.

## 0.0.1

* Initial release.
* Support for Dart and Java.
