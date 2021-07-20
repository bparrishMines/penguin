import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android/camera1.dart' as android;
import 'ios/av_foundation.dart' as ios;

abstract class PenguinCameraPlatform extends PlatformInterface {
  PenguinCameraPlatform() : super(token: _token);

  static PenguinCameraPlatform _instance = _EmptyPenguinCameraPlatform();

  static final Object _token = Object();

  static PenguinCameraPlatform get instance {
    if (_instance is! _EmptyPenguinCameraPlatform) {
      return _instance;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      _instance = android.CameraPlatform();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _instance = ios.CameraPlatform();
    } else {
      throw AssertionError('Current platform is not supported.');
    }

    return _instance;
  }

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PenguinCameraPlatform] when they register themselves.
  static set instance(PenguinCameraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<CameraDevice>> getAllCameraDevices();
  CameraController createCameraController({
    required CameraDevice device,
    required List<CameraOutput> outputs,
  });
  PreviewOutput createPreviewOutput();
  ImageCaptureOutput createImageCaptureOutput();
  VideoCaptureOutput createVideoCaptureOutput();
}

abstract class PreviewOutput extends CameraOutput {
  factory PreviewOutput() {
    return PenguinCameraPlatform.instance.createPreviewOutput();
  }

  Future<Widget> getPreviewWidget();
}

abstract class ImageCaptureOutput extends CameraOutput {
  factory ImageCaptureOutput() {
    return PenguinCameraPlatform.instance.createImageCaptureOutput();
  }
}

abstract class VideoCaptureOutput extends CameraOutput {
  factory VideoCaptureOutput() {
    return PenguinCameraPlatform.instance.createVideoCaptureOutput();
  }
}

abstract class CameraOutput {
  Future<void> attach(CameraController controller);
  Future<void> detach(CameraController controller);
}

enum CameraPosition { front, back, unspecified }

abstract class PenguinCamera {
  PenguinCamera._();

  static Future<List<CameraDevice>> getAllCameraDevices() =>
      PenguinCameraPlatform.instance.getAllCameraDevices();
}

abstract class CameraDevice {
  String get name;
  CameraPosition get position;
}

abstract class CameraController {
  factory CameraController({
    required CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    return PenguinCameraPlatform.instance.createCameraController(
      device: device,
      outputs: outputs,
    );
  }

  CameraDevice get device;
  List<CameraOutput> get outputs;

  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  Future<void> dispose();
}

class _EmptyPenguinCameraPlatform implements PenguinCameraPlatform {
  @override
  CameraController createCameraController({
    required CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() {
    throw UnimplementedError();
  }

  @override
  ImageCaptureOutput createImageCaptureOutput() {
    throw UnimplementedError();
  }

  @override
  PreviewOutput createPreviewOutput() {
    throw UnimplementedError();
  }

  @override
  VideoCaptureOutput createVideoCaptureOutput() {
    throw UnimplementedError();
  }
}
