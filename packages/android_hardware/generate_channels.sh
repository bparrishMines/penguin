flutter pub run reference_generator \
  --branch gen_update \
  --dart-out lib/src/camera.g.dart \
  --java-package dev.penguin.android_hardware \
  --java-out android/src/main/java/dev/penguin/android_hardware/CameraChannelLibrary.java \
  lib/src/camera.dart
