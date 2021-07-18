flutter pub run reference_generator --no-build \
  --dart-out lib/src/av_foundation.g.dart \
  --dart-imports 'dart:typed_data','av_foundation.dart' \
  --objc-prefix _AFP \
  --objc-header-out ios/Classes/AFPChannelLibrary_Internal.h \
  --objc-impl-out ios/Classes/AFPChannelLibrary_Internal.m \
  lib/src/av_foundation.dart
