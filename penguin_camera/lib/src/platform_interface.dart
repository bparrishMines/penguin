import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android/camerax/camerax_platform_impl.dart';

abstract class PenguinCameraPlatform extends PlatformInterface {
  PenguinCameraPlatform() : super(token: _token);

  static PenguinCameraPlatform _instance;

  static final Object _token = Object();

  static PenguinCameraPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SuperCameraPlatform] when they register themselves.
  static set instance(PenguinCameraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  PenguinCamera createPenguinCamera();
  CameraController createCameraController(CameraDevice device);
}

abstract class PenguinCamera {
  PenguinCamera._();

  static PenguinCamera get instance =>
      PenguinCameraPlatform.instance.createPenguinCamera();

  static void initialize() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      PenguinCameraPlatform.instance = CameraXCameraPlatform();
    }
  }

  Future<List<CameraDevice>> getAllCameraDevices();
}

abstract class CameraDevice {
  String get name;
}

abstract class CameraController {
  factory CameraController(CameraDevice device) {
    return PenguinCameraPlatform.instance.createCameraController(device);
  }

  CameraDevice get device;

  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  Future<void> dispose();
  Future<Widget> getPreview();
}
