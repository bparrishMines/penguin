import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:ios_avfoundation/ios_avfoundation.dart';

import '../platform_interface.dart' as intf;

class CameraDevice implements intf.CameraDevice {
  CameraDevice(this.device);

  final CaptureDevice device;

  @override
  String get name => device.uniqueId;
}

class CameraController implements intf.CameraController {
  CameraController(this.device);

  @override
  final CameraDevice device;

  final CaptureSession session = CaptureSession();

  late final Preview preview = Preview(controller: PreviewController(session));

  @override
  Future<void> initialize() async {
    // No-op
  }

  @override
  Future<Widget> getPreview() async {
    return preview;
  }

  @override
  Future<void> start() => session.startRunning();

  @override
  Future<void> stop() => session.stopRunning();

  @override
  Future<void> dispose() => stop();
}

class CameraPlatform extends intf.PenguinCameraPlatform {
  @override
  CameraController createCameraController(covariant CameraDevice device) {
    return CameraController(device);
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    final List<CaptureDevice> devices =
        await CaptureDevice.devicesWithMediaType(MediaType.video);
    return devices
        .map<CameraDevice>((CaptureDevice device) => CameraDevice(device))
        .toList();
  }
}
