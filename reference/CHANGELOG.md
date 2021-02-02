0.2.0-beta.1

* Added `TypeChannelManager.getPairedPairedInstance` and `TypeChannelManager.getPairedObject`.
* Name change of `PairableInstance` to `ReferenceType`.
* Added `TypeChannelHandler.onInstanceAdded`.
* Replaced `TypeChannelHandler.onInstanceDisposed` with `TypeChannelHandler.onInstanceRemoved`.
* `TypeChannelManager.generateUniqueInstanceId` now takes an object and uses the hashcode to create
  unique id.

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
