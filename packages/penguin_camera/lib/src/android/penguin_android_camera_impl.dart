import 'package:flutter/widgets.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';

import '../platform_interface.dart' as intf;

class CameraDevice implements intf.CameraDevice {
  CameraDevice(this.info);

  final CameraInfo info;

  @override
  String get name => info.cameraId.toString();
}

class CameraController implements intf.CameraController {
  CameraController(this.device);

  @override
  final CameraDevice device;

  late final Camera camera;

  late Texture? _previewWidget;

  @override
  Future<void> initialize() async {
    camera = await Camera.open(device.info.cameraId);
  }

  @override
  Future<Widget> getPreview() async {
    return _previewWidget ??=
        Texture(textureId: await camera.attachPreviewTexture());
  }

  @override
  Future<void> start() => camera.startPreview();

  @override
  Future<void> stop() => camera.stopPreview();

  @override
  Future<void> dispose() async {
    stop();
    camera.releasePreviewTexture();
    _previewWidget = null;
    return camera.release();
  }
}

class CameraPlatform extends intf.PenguinCameraPlatform {
  @override
  CameraController createCameraController(covariant CameraDevice device) {
    return CameraController(device);
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    final List<CameraInfo> allInfo = await Camera.getAllCameraInfo();
    return allInfo
        .map<CameraDevice>((CameraInfo info) => CameraDevice(info))
        .toList();
  }
}
