import 'dart:async';

import 'package:flutter/widgets.dart';

import 'camera.dart';
import '../../platform_interface.dart';

class AndroidCameraDevice implements CameraDevice {
  AndroidCameraDevice(this.info);

  final CameraInfo info;

  @override
  String get name => info.cameraId.toString();
}

class AndroidCameraController implements CameraController {
  AndroidCameraController(this.device);

  @override
  final AndroidCameraDevice device;

  Camera? camera;

  @override
  Future<void> initialize() async {
    if (camera != null) return;
    camera = await Camera.open(device.info.cameraId);
  }

  @override
  Future<Widget> getPreview() async {
    assert(camera != null);
    return Texture(textureId: await camera!.attachPreviewToTexture());
  }

  @override
  Future<void> start() {
    assert(camera != null);
    return camera!.startPreview();
  }

  @override
  Future<void> stop() {
    assert(camera != null);
    return camera!.stopPreview();
  }

  @override
  Future<void> dispose() async {
    if (camera == null) return;
    stop();
    camera!.releaseTexture();

    final Camera oldCamera = camera!;
    camera = null;
    return oldCamera.release();
  }
}

class AndroidCameraPlatform extends PenguinCameraPlatform {
  @override
  AndroidCameraController createCameraController(
    covariant AndroidCameraDevice device,
  ) {
    return AndroidCameraController(device);
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    final List<CameraInfo> allInfo = await Camera.getAllCameraInfo();
    return allInfo
        .map<AndroidCameraDevice>(
            (CameraInfo info) => AndroidCameraDevice(info))
        .toList();
  }

  @override
  void initialize() {
    initializeChannels();
  }
}
