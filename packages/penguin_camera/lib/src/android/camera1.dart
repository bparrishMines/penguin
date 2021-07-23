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
    stop();
    _disposed = true;

    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.detach(this)),
      eagerError: true,
    );
    return camera.release();
  }

  @override
  Future<void> setFocusMode(FocusMode mode) {
    switch (mode) {
      case FocusMode.fixed:
        cameraParameters.setFocusMode(CameraParameters.focusModeFixed);
        break;
      case FocusMode.continuousImageAutoFocus:
        cameraParameters.setFocusMode(
          CameraParameters.focusModeContinuousPicture,
        );
        break;
      case FocusMode.continuousVideoAutoFocus:
        cameraParameters.setFocusMode(
          CameraParameters.focusModeContinuousVideo,
        );
        break;
    }
    return camera.setParameters(cameraParameters);
  }

  @override
  Future<List<FocusMode>> getSupportedFocusModes() async {
    final List<String> focusModes =
        await cameraParameters.getSupportedFocusModes();

    final List<FocusMode> supportedModes = <FocusMode>[];
    for (String mode in focusModes) {
      switch (mode) {
        case CameraParameters.focusModeFixed:
          supportedModes.add(FocusMode.fixed);
          break;
        case CameraParameters.focusModeContinuousPicture:
          supportedModes.add(FocusMode.continuousImageAutoFocus);
          break;
        case CameraParameters.focusModeContinuousVideo:
          supportedModes.add(FocusMode.continuousVideoAutoFocus);
          break;
      }
    }
    return supportedModes;
  }

  @override
  Future<List<ExposureMode>> getSupportedExposureModes() async {
    final bool lockSupported =
        await cameraParameters.isAutoExposureLockSupported();
    return <ExposureMode>[
      ExposureMode.continuous,
      if (lockSupported) ExposureMode.locked,
    ];
  }

  @override
  Future<void> setExposureMode(ExposureMode mode) {
    switch (mode) {
      case ExposureMode.locked:
        return cameraParameters.setAutoExposureLock(toggle: true);
      case ExposureMode.continuous:
        return cameraParameters.setAutoExposureLock(toggle: false);
    }
  }

  @override
  Future<void> setControllerPreset(CameraControllerPreset preset) async {
    await Future.wait(
      outputs.cast<PresetChangeListener>().map<Future<void>>(
          (PresetChangeListener listener) => listener.updatePreset(preset)),
      eagerError: true,
    );
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

class PreviewOutput with PresetChangeListener implements intf.PreviewOutput {
  late CameraController _controller;
  late Completer<Texture> _previewWidgetCompleter;

  @override
  Future<Widget> getPreviewWidget() {
    return _previewWidgetCompleter.future;
  }

  @override
  Future<void> attach(covariant CameraController controller) async {
    _controller = controller;
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

  @override
  Future<void> updatePreset(CameraControllerPreset preset) async {
    final List<CameraSize> supportedSizes =
        await _controller.cameraParameters.getSupportedPreviewSizes();

    _sortCameraSizes(supportedSizes);
    switch (preset) {
      case CameraControllerPreset.low:
        _controller.cameraParameters.setPreviewSize(
          supportedSizes.first.width,
          supportedSizes.first.height,
        );
        break;
      case CameraControllerPreset.medium:
        final int midIndex = ((supportedSizes.length - 1) / 2).round();
        _controller.cameraParameters.setPreviewSize(
          supportedSizes[midIndex].width,
          supportedSizes[midIndex].height,
        );
        break;
      case CameraControllerPreset.high:
        _controller.cameraParameters.setPreviewSize(
          supportedSizes.last.width,
          supportedSizes.last.height,
        );
        break;
    }

    return _controller.camera.setParameters(_controller.cameraParameters);
  }
}

class ImageCaptureOutput
    with PresetChangeListener
    implements intf.ImageCaptureOutput {
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

  @override
  Future<List<FlashMode>> getSupportedFlashModes() async {
    final List<String> flashModes =
        await _controller.cameraParameters.getSupportedFlashModes();

    final List<FlashMode> supportedModes = <FlashMode>[];
    for (String mode in flashModes) {
      switch (mode) {
        case CameraParameters.flashModeAuto:
          supportedModes.add(FlashMode.auto);
          break;
        case CameraParameters.flashModeOff:
          supportedModes.add(FlashMode.off);
          break;
        case CameraParameters.flashModeOn:
          supportedModes.add(FlashMode.on);
          break;
      }
    }
    return supportedModes;
  }

  @override
  Future<void> setFlashMode(FlashMode mode) {
    switch (mode) {
      case FlashMode.on:
        _controller.cameraParameters.setFlashMode(CameraParameters.flashModeOn);
        break;
      case FlashMode.off:
        _controller.cameraParameters.setFlashMode(
          CameraParameters.flashModeOff,
        );
        break;
      case FlashMode.auto:
        _controller.cameraParameters.setFlashMode(
          CameraParameters.flashModeAuto,
        );
        break;
    }
    return _controller.camera.setParameters(_controller.cameraParameters);
  }

  @override
  Future<void> updatePreset(CameraControllerPreset preset) async {
    final List<CameraSize> supportedSizes =
        await _controller.cameraParameters.getSupportedPictureSizes();

    _sortCameraSizes(supportedSizes);
    switch (preset) {
      case CameraControllerPreset.low:
        _controller.cameraParameters.setPictureSize(
          supportedSizes.first.width,
          supportedSizes.first.height,
        );
        break;
      case CameraControllerPreset.medium:
        final int midIndex = ((supportedSizes.length - 1) / 2).round();
        _controller.cameraParameters.setPictureSize(
          supportedSizes[midIndex].width,
          supportedSizes[midIndex].height,
        );
        break;
      case CameraControllerPreset.high:
        _controller.cameraParameters.setPictureSize(
          supportedSizes.last.width,
          supportedSizes.last.height,
        );
        break;
    }

    return _controller.camera.setParameters(_controller.cameraParameters);
  }
}

class VideoCaptureOutput
    with PresetChangeListener
    implements intf.VideoCaptureOutput {
  late CameraController _controller;
  late MediaRecorder mediaRecorder;
  CameraSize? specifiedOutputSize;

  @override
  Future<void> attach(covariant CameraController controller) {
    _controller = controller;
    mediaRecorder = MediaRecorder();
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
    if (specifiedOutputSize != null) {
      mediaRecorder.setVideoSize(
        specifiedOutputSize!.width,
        specifiedOutputSize!.height,
      );
    }
    mediaRecorder.setOutputFilePath(fileOutput);

    _controller.camera.unlock();
    mediaRecorder.prepare();
    return mediaRecorder.start();
  }

  @override
  Future<void> stopRecording() {
    return mediaRecorder.stop();
  }

  @override
  Future<void> updatePreset(CameraControllerPreset preset) async {
    final List<CameraSize> supportedSizes =
        await _controller.cameraParameters.getSupportedVideoSizes() ??
            await _controller.cameraParameters.getSupportedPreviewSizes();

    _sortCameraSizes(supportedSizes);
    switch (preset) {
      case CameraControllerPreset.low:
        specifiedOutputSize = supportedSizes.first;
        break;
      case CameraControllerPreset.medium:
        final int midIndex = ((supportedSizes.length - 1) / 2).round();
        specifiedOutputSize = supportedSizes[midIndex];
        break;
      case CameraControllerPreset.high:
        specifiedOutputSize = supportedSizes.last;
        break;
    }
    return;
  }
}

mixin PresetChangeListener {
  Future<void> updatePreset(CameraControllerPreset preset);
}

void _sortCameraSizes(List<CameraSize> sizes) {
  sizes.sort((CameraSize a, CameraSize b) {
    final int aArea = a.width * a.height;
    final int bArea = b.width * b.height;
    if (aArea > bArea) return 1;
    if (bArea > aArea) return -1;
    return 0;
  });
}
