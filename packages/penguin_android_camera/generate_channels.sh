flutter pub run reference_generator \
  --dart-out lib/src/camera.g.dart \
  --dart-imports 'dart:typed_data' \
  --java-package github.bparrishMines.penguin.penguin_android_camera \
  --java-out android/src/main/java/github/bparrishMines/penguin/penguin_android_camera/CameraChannelLibrary.java \
  lib/src/camera.dart
