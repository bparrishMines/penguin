import 'dart:async';

import 'package:av_foundation/av_foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:penguin_camera/penguin_camera.dart';

import '../platform_interface.dart' as intf;

class CameraDevice implements intf.CameraDevice {
  CameraDevice(this.device);

  final CaptureDevice device;

  @override
  String get name => device.uniqueId;

  @override
  intf.CameraPosition get position {
    switch (device.position) {
      case CaptureDevicePosition.back:
        return intf.CameraPosition.back;
      case CaptureDevicePosition.front:
        return CameraPosition.front;
      case CaptureDevicePosition.unspecified:
        return intf.CameraPosition.unspecified;
      default:
        throw UnsupportedError('CaptureDevicePosition not found.');
    }
  }
}

class CameraController implements intf.CameraController {
  CameraController({required this.device, required this.outputs});

  bool _initialized = false;
  bool _disposed = false;

  @override
  final CameraDevice device;

  @override
  final List<CameraOutput> outputs;

  final CaptureSession session = CaptureSession();

  @override
  Future<void> initialize() async {
    assert(!_initialized, 'CameraController has already been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    _initialized = true;

    session.addInput(CaptureDeviceInput(device.device));
    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.attach(this)),
      eagerError: true,
    );
  }

  @override
  Future<void> start() => session.startRunning();

  @override
  Future<void> stop() => session.stopRunning();

  @override
  Future<void> dispose() async {
    assert(_initialized, 'CameraController has not been initialized.');
    if (_disposed) return Future<void>.value();
    _disposed = true;

    stop();
    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.detach(this)),
      eagerError: true,
    );
  }
}

class CameraPlatform extends intf.PenguinCameraPlatform {
  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    final CaptureDeviceDiscoverySession session =
        await CaptureDeviceDiscoverySession.discoverySessionWithDeviceTypes(
      deviceTypes: <String>[CaptureDeviceType.builtInWideAngleCamera],
      mediaType: MediaType.video,
      position: CaptureDevicePosition.unspecified,
    );
    return session.devices
        .map<CameraDevice>((CaptureDevice device) => CameraDevice(device))
        .toList();
  }

  @override
  CameraController createCameraController({
    required covariant CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    return CameraController(device: device, outputs: outputs);
  }

  @override
  ImageCaptureOutput createImageCaptureOutput() {
    return ImageCaptureOutput();
  }

  @override
  PreviewOutput createPreviewOutput() {
    return PreviewOutput();
  }

  @override
  VideoCaptureOutput createVideoCaptureOutput() {
    return VideoCaptureOutput();
  }
}

class PreviewOutput implements intf.PreviewOutput {
  late final Preview preview;

  @override
  Future<void> attach(covariant CameraController controller) {
    preview = Preview(controller: PreviewController(controller.session));
    return Future<void>.value();
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    return Future<void>.value();
  }

  @override
  Future<Widget> getPreviewWidget() => Future<Widget>.value(preview);
}

class ImageCaptureOutput implements intf.ImageCaptureOutput {
  @override
  Future<void> attach(covariant CameraController controller) {
    // TODO: implement attach
    throw UnimplementedError();
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    // TODO: implement detach
    throw UnimplementedError();
  }
}

class VideoCaptureOutput implements intf.VideoCaptureOutput {
  @override
  Future<void> attach(covariant CameraController controller) {
    // TODO: implement attach
    throw UnimplementedError();
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    // TODO: implement detach
    throw UnimplementedError();
  }
}
