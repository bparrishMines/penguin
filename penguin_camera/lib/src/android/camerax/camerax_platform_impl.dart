import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';

import '../camera/camera_platform_impl.dart';
import 'camerax.dart';
import '../../platform_interface.dart';

class AndroidCameraXDevice implements CameraDevice {
  AndroidCameraXDevice(this.selector);

  final CameraSelector selector;

  @override
  String get name => selector.lensFacing.toString();
}

class CameraXPenguinCamera implements PenguinCamera {
  CameraXPenguinCamera._();

  static CameraXPenguinCamera instance = CameraXPenguinCamera._();

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    if (!await hasMinimumVersion()) {
      PenguinCameraPlatform.instance = AndroidCameraPlatform();
      return CameraXPenguinCamera.instance.getAllCameraDevices();
    }
    return Future<List<CameraDevice>>.value(<CameraDevice>[
      AndroidCameraXDevice(CameraSelector(CameraSelector.lensFacingBack)),
      AndroidCameraXDevice(CameraSelector(CameraSelector.lensFacingFront)),
    ]);
  }

  Future<bool> hasMinimumVersion() async {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 21;
  }
}

class _L extends SuccessListener {
  final Completer<void> completer;

  _L(this.completer);

  @override
  void onError(String code, String message) {
    completer.completeError('$code: $message');
  }

  @override
  void onSuccess() {
    completer.complete();
  }
}

class CameraXCameraController implements CameraController {
  CameraXCameraController(this.device);

  @override
  final CameraDevice device;

  final Preview preview = Preview();
  Camera camera;

  @override
  Future<void> initialize() async {
    final Completer<void> completer = Completer<void>();
    ProcessCameraProvider.initialize(_L(completer));
    return completer.future;
  }

  @override
  Future<Widget> getPreview() async {
    return Texture(textureId: await preview.attachToTexture());
  }

  @override
  Future<void> start() async {
    camera = await ProcessCameraProvider.instance.bindToLifecycle(
      (device as AndroidCameraXDevice).selector,
      preview,
    );
  }

  @override
  Future<void> stop() {
    camera = null;
    return ProcessCameraProvider.instance.unbindAll();
  }

  @override
  Future<void> dispose() {
    stop();
    return preview.releaseTexture();
  }
}

class CameraXCameraPlatform extends PenguinCameraPlatform {
  @override
  CameraController createCameraController(covariant CameraDevice device) {
    return CameraXCameraController(device);
  }

  @override
  PenguinCamera createPenguinCamera() {
    return CameraXPenguinCamera.instance;
  }
}
