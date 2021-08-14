import 'package:flutter/widgets.dart';

import 'platform_interface.dart';

/// Standard implementation of [CameraController].
///
/// This includes verification methods to get initialization state.
abstract class StandardCameraController implements CameraController {
  bool _initialized = false;
  bool _disposed = false;

  /// Whether [dispose] has been called.
  @protected
  bool get disposed => _disposed;

  @mustCallSuper
  @override
  Future<void> initialize() async {
    assert(!_initialized, 'CameraController has already been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    _initialized = true;
  }

  @mustCallSuper
  @override
  Future<void> dispose() async {
    assert(_initialized, 'CameraController has not been initialized.');
    _disposed = true;
  }

  /// Throws an [AssertionError] if this controller has not been initialized.
  @protected
  void verifyInitialized() {
    assert(_initialized, 'CameraController has not been initialized.');
  }

  /// Throws an [AssertionError] if this controller has already been disposed.
  @protected
  void verifyNotDisposed() {
    assert(!_disposed, 'CameraController has already been disposed.');
  }
}

/// Standard implementation of [PreviewOutput].
///
/// This includes a method to verify an output has been attached.
abstract class StandardPreviewOutput implements PreviewOutput {
  bool _attached = false;

  @mustCallSuper
  @override
  Future<void> attach(CameraController controller) async {
    assert(
        !_attached, 'This output is already attached to a CameraController.');
    _attached = true;
  }

  @mustCallSuper
  @override
  Future<void> detach(CameraController controller) async {
    _attached = false;
  }

  /// Throws an [AssertionError] if this [CameraOutput] has not been attached to a [CameraController].
  @protected
  void verifyAttached() {
    assert(_attached, 'This output is not attached to a CameraController.');
  }
}

/// Standard implementation of [ImageCaptureOutput].
///
/// This includes a method to verify an output has been attached.
abstract class StandardImageCaptureOutput implements ImageCaptureOutput {
  bool _attached = false;

  @mustCallSuper
  @override
  Future<void> attach(CameraController controller) async {
    _attached = true;
  }

  @mustCallSuper
  @override
  Future<void> detach(CameraController controller) async {
    _attached = false;
  }

  /// Throws an [AssertionError] if this [CameraOutput] has not been attached to a [CameraController].
  @protected
  void verifyAttached() {
    assert(_attached, 'This output is not attached to a CameraController.');
  }
}

/// Standard implementation of [VideoCaptureOutput].
///
/// This includes a method to verify an output has been attached.
abstract class StandardVideoCaptureOutput implements VideoCaptureOutput {
  bool _attached = false;

  @mustCallSuper
  @override
  Future<void> attach(CameraController controller) async {
    _attached = true;
  }

  @mustCallSuper
  @override
  Future<void> detach(CameraController controller) async {
    _attached = false;
  }

  /// Throws an [AssertionError] if this [CameraOutput] has not been attached to a [CameraController].
  @protected
  void verifyAttached() {
    assert(_attached, 'This output is not attached to a CameraController.');
  }
}
