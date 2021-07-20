import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:android_hardware/android_hardware.dart';
import 'package:penguin_camera/penguin_camera.dart';

import '../platform_interface.dart' as intf;

class CameraDevice implements intf.CameraDevice {
  CameraDevice(this.info);

  final CameraInfo info;

  @override
  String get name => info.cameraId.toString();

  @override
  intf.CameraPosition get position {
    switch (info.facing) {
      case CameraInfo.cameraFacingFront:
        return CameraPosition.front;
      case CameraInfo.cameraFacingBack:
        return CameraPosition.back;
      default:
        return CameraPosition.unspecified;
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

  late final Camera camera;

  @override
  Future<void> initialize() async {
    assert(!_initialized, 'CameraController has already been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    _initialized = true;

    camera = await Camera.open(device.info.cameraId);
    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.attach(this)),
      eagerError: true,
    );

    final CameraParameters params = await camera.getParameters();

    final List<String> focusModes = await params.getSupportedFocusModes();
    if (focusModes.contains(CameraParameters.focusModeContinuousPicture)) {
      params.setFocusMode(CameraParameters.focusModeContinuousPicture);
      camera.setParameters(params);
    }
  }

  @override
  Future<void> start() => camera.startPreview();

  @override
  Future<void> stop() => camera.stopPreview();

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
    return camera.release();
  }
}

class CameraPlatform extends intf.PenguinCameraPlatform {
  @override
  CameraController createCameraController({
    required covariant CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    return CameraController(device: device, outputs: outputs);
  }

  @override
  Future<List<CameraDevice>> getAllCameraDevices() async {
    final List<CameraInfo> allInfo = await Camera.getAllCameraInfo();
    return allInfo
        .map<CameraDevice>((CameraInfo info) => CameraDevice(info))
        .toList();
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
  late Completer<Texture> _previewWidgetCompleter;

  @override
  Future<Widget> getPreviewWidget() {
    return _previewWidgetCompleter.future;
  }

  @override
  Future<void> attach(covariant CameraController controller) async {
    _previewWidgetCompleter = Completer<Texture>();

    late int rotation;
    final CameraInfo cameraInfo = controller.device.info;
    if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
      rotation = cameraInfo.orientation % 360;
      rotation = (360 - rotation) % 360;
    } else {
      rotation = (cameraInfo.orientation + 360) % 360;
    }
    controller.camera.setDisplayOrientation(rotation);

    _previewWidgetCompleter.complete(
      Texture(textureId: await controller.camera.attachPreviewTexture()),
    );
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    return controller.camera.releasePreviewTexture();
  }
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
