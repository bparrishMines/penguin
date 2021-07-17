flutter pub run reference_generator \
  --dart-out lib/src/camera.g.dart \
  --dart-imports 'dart:typed_data' \
  --java-package dev.penguin.android_hardware \
  --java-out android/src/main/java/dev/penguin/android_hardware/CameraChannelLibrary.java \
  lib/src/camera.dart
