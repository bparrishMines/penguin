import 'dart:async';
import 'dart:typed_data';

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
  VideoCaptureOutput createVideoCaptureOutput({bool includeAudio = false});
}

enum FocusMode {
  fixed,
  continuousImageAutoFocus,
  continuousVideoAutoFocus,
}

enum ExposureMode { locked, continuous }

enum FlashMode { on, off, auto }

enum TorchMode { on, off }

abstract class PreviewOutput extends CameraOutput {
  factory PreviewOutput() {
    return PenguinCameraPlatform.instance.createPreviewOutput();
  }

  Future<Widget> getPreviewWidget();
}

typedef ImageCallback = void Function(Uint8List bytes);

abstract class ImageCaptureOutput extends CameraOutput {
  factory ImageCaptureOutput() {
    return PenguinCameraPlatform.instance.createImageCaptureOutput();
  }

  Future<void> takePicture(ImageCallback callback);
  Future<void> setFlashMode(FlashMode mode);
  Future<List<FlashMode>> getSupportedFlashModes();
}

abstract class VideoCaptureOutput extends CameraOutput {
  factory VideoCaptureOutput({bool includeAudio = false}) {
    return PenguinCameraPlatform.instance.createVideoCaptureOutput();
  }

  Future<void> startRecording({required String fileOutput});

  Future<void> stopRecording();
}

abstract class CameraOutput {
  Future<void> attach(CameraController controller);
  Future<void> detach(CameraController controller);
  Future<Size?> getOutputSize();
}

enum CameraPosition { front, back, unspecified }

enum CameraControllerPreset { low, medium, high }

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
  Future<void> setFocusMode(FocusMode mode);
  Future<List<FocusMode>> getSupportedFocusModes();
  Future<void> setExposureMode(ExposureMode mode);
  Future<List<ExposureMode>> getSupportedExposureModes();
  Future<void> setControllerPreset(CameraControllerPreset preset);
  Future<void> setTorchMode(TorchMode mode);
  Future<List<TorchMode>> getSupportedTorchModes();
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
  VideoCaptureOutput createVideoCaptureOutput({bool includeAudio = false}) {
    throw UnimplementedError();
  }
}
