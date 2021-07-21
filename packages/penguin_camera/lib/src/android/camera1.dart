import 'dart:async';
import 'dart:typed_data';

import 'package:android_media/android_media.dart';
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
  late final CameraParameters cameraParameters;

  @override
  Future<void> initialize() async {
    assert(!_initialized, 'CameraController has already been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    _initialized = true;

    camera = await Camera.open(device.info.cameraId);
    cameraParameters = await camera.getParameters();
    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.attach(this)),
      eagerError: true,
    );
  }

  @override
  Future<void> start() {
    assert(_initialized, 'CameraController has not been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    return camera.startPreview();
  }

  @override
  Future<void> stop() {
    assert(_initialized, 'CameraController has not been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    return camera.stopPreview();
  }

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
  late CameraController _controller;

  @override
  Future<void> attach(covariant CameraController controller) async {
    _controller = controller;
  }

  @override
  Future<void> detach(covariant CameraController controller) async {}

  @override
  Future<void> takePicture(intf.ImageCallback callback) {
    return _controller.camera.takePicture(
      null,
      null,
      null,
      PictureCallback((Uint8List bytes) {
        _controller.camera.startPreview();
        callback(bytes);
      }),
    );
  }
}

class VideoCaptureOutput implements intf.VideoCaptureOutput {
  late MediaRecorder mediaRecorder;

  @override
  Future<void> attach(covariant CameraController controller) {
    mediaRecorder = MediaRecorder();
    controller.camera.unlock();
    return mediaRecorder.setCamera(controller.camera);
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    return mediaRecorder.release();
  }

  @override
  Future<void> startRecording({required String fileOutput}) {
    mediaRecorder.reset();
    mediaRecorder.setVideoSource(VideoSource.camera);
    mediaRecorder.setAudioSource(AudioSource.defaultSource);
    mediaRecorder.setOutputFormat(OutputFormat.mpeg4);
    mediaRecorder.setVideoEncoder(VideoEncoder.mpeg4Sp);
    mediaRecorder.setAudioEncoder(AudioEncoder.amrNb);
    mediaRecorder.setOutputFilePath(fileOutput);

    mediaRecorder.prepare();
    return mediaRecorder.start();
  }

  @override
  Future<void> stopRecording() {
    return mediaRecorder.stop();
  }
}
