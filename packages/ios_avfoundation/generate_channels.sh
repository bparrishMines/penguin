flutter pub run reference_generator --branch master --dart-out lib/src/avfoundation.g.dart --dart-imports 'dart:typed_data' lib/src/avfoundation.dart
flutter pub run reference_generator --no-build --branch ios_camera --objc-prefix _IAF --objc-header-out ios/Classes/IAFChannelLibrary_Internal.h --objc-impl-out ios/Classes/IAFChannelLibrary_Internal.m lib/src/avfoundation.dart
