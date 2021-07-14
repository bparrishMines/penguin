flutter pub run reference_generator --branch ios_camera \
  --dart-out lib/src/avfoundation.g.dart \
  --dart-imports 'dart:typed_data','avfoundation.dart' \
  --objc-prefix _IAF \
  --objc-header-out ios/Classes/IAFChannelLibrary_Internal.h \
  --objc-impl-out ios/Classes/IAFChannelLibrary_Internal.m \
  lib/src/avfoundation.dart
