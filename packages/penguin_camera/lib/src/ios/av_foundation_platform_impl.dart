import 'dart:async';

import 'package:flutter/widgets.dart';

import 'av_foundation.dart';
import '../platform_interface.dart' as intf;

class CameraDevice implements intf.CameraDevice {
  CameraDevice(this.device);

  final CaptureDevice device;

  @override
  String get name => device.uniqueId;
}

class CameraController implements intf.CameraController {
  CameraController(this.device) {
    session = CaptureSession(
      <CaptureDeviceInput>[CaptureDeviceInput(device.device)],
    );
    preview = Preview(controller: PreviewController(session));
  }

  @override
  final CameraDevice device;

  late final CaptureSession session;

  late final Preview preview;

  @override
  Future<void> initialize() async {
    // Do nothing.
  }

  @override
  Future<Widget> getPreview() async {
    return preview;
  }

  @override
  Future<void> start() async {
    await session.startRunning();
  }

  @override
  Future<void> stop() async {
    await session.stopRunning();
  }

  @override
  Future<void> dispose() async {
    return stop();
  }
}

class CameraPlatform extends intf.PenguinCameraPlatform {
  @override
  CameraController createCameraController(covariant CameraDevice device) {
    return CameraController(device);
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    return (await CaptureDevice.devicesWithMediaType(MediaType.video))
        .map<CameraDevice>((CaptureDevice device) {
      return CameraDevice(device);
    }).toList();
  }

  @override
  void initialize() {
    initializeChannels();
  }
}
