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
