flutter pub run reference_generator \
  --dart-out lib/src/media_recorder.g.dart \
  --dart-imports 'package:android_hardware/android_hardware.dart' \
  --java-package dev.penguin.android_media \
  --java-imports 'dev.penguin.android_hardware.*' \
  --java-type-aliases 'Camera=CameraProxy' \
  --java-out android/src/main/java/dev/penguin/android_media/MediaRecorderChannelLibrary.java \
  lib/src/media_recorder.dart
