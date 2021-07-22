import 'dart:async';
import 'dart:typed_data';

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
  Future<void> start() {
    assert(_initialized, 'CameraController has not been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    return session.startRunning();
  }

  @override
  Future<void> stop() {
    assert(_initialized, 'CameraController has not been initialized.');
    assert(!_disposed, 'CameraController has already been disposed.');
    return session.stopRunning();
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
  }

  @override
  Future<void> setFocusMode(FocusMode mode) {
    device.device.lockForConfiguration();
    switch (mode) {
      case FocusMode.fixed:
        device.device.setFocusMode(CaptureFocusMode.locked);
        break;
      case FocusMode.continuousImageAutoFocus:
        device.device.setFocusMode(CaptureFocusMode.continuousAutoFocus);
        break;
      case FocusMode.continuousVideoAutoFocus:
        device.device.setFocusMode(CaptureFocusMode.continuousAutoFocus);
        break;
    }
    return device.device.unlockForConfiguration();
  }

  @override
  Future<List<FocusMode>> getSupportedFocusModes() async {
    final List<int> focusModes = await device.device.focusModesSupported(<int>[
      CaptureFocusMode.locked,
      CaptureFocusMode.continuousAutoFocus,
    ]);

    final List<FocusMode> supportedModes = <FocusMode>[];
    for (int mode in focusModes) {
      switch (mode) {
        case CaptureFocusMode.locked:
          supportedModes.add(FocusMode.fixed);
          break;
        case CaptureFocusMode.continuousAutoFocus:
          supportedModes.add(FocusMode.continuousImageAutoFocus);
          supportedModes.add(FocusMode.continuousVideoAutoFocus);
          break;
      }
    }
    return supportedModes;
  }

  @override
  Future<List<ExposureMode>> getSupportedExposureModes() async {
    final List<int> exposureModes =
        await device.device.exposureModesSupported(<int>[
      CaptureExposureMode.locked,
      CaptureExposureMode.continuousAutoExposure,
    ]);

    final List<ExposureMode> supportedModes = <ExposureMode>[];
    for (int mode in exposureModes) {
      switch (mode) {
        case CaptureExposureMode.locked:
          supportedModes.add(ExposureMode.locked);
          break;
        case CaptureExposureMode.continuousAutoExposure:
          supportedModes.add(ExposureMode.continuous);
          break;
      }
    }
    return supportedModes;
  }

  @override
  Future<void> setExposureMode(ExposureMode mode) {
    device.device.lockForConfiguration();
    switch (mode) {
      case ExposureMode.locked:
        device.device.setExposureMode(CaptureExposureMode.locked);
        break;
      case ExposureMode.continuous:
        device.device.setExposureMode(
          CaptureExposureMode.continuousAutoExposure,
        );
        break;
    }
    return device.device.unlockForConfiguration();
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
  late CapturePhotoOutput capturePhotoOutput;
  late CapturePhotoCaptureDelegate photoCaptureDelegate;
  late CapturePhotoSettings nextPhotoSettings = _createNextPhotoSettings();
  int? flashMode;

  @override
  Future<void> attach(covariant CameraController controller) {
    capturePhotoOutput = CapturePhotoOutput();
    return controller.session.addOutput(capturePhotoOutput);
  }

  @override
  Future<void> detach(covariant CameraController controller) async {
    // TODO: remove capturePhotoOutput
  }

  CapturePhotoSettings _createNextPhotoSettings() {
    final CapturePhotoSettings settings =
        CapturePhotoSettings.photoSettingsWithFormat(
      <String, Object>{VideoSettingsKeys.videoCodec: VideoCodecType.jpeg},
    );
    if (flashMode != null) nextPhotoSettings.setFlashMode(flashMode!);
    return settings;
  }

  @override
  Future<void> takePicture(ImageCallback callback) async {
    final CapturePhotoSettings oldSettings = nextPhotoSettings;
    nextPhotoSettings = _createNextPhotoSettings();

    photoCaptureDelegate = CapturePhotoCaptureDelegate(
      didFinishProcessingPhoto: (CapturePhoto photo) {
        final Uint8List? photoData = photo.fileDataRepresentation;
        if (photoData == null) {
          throw ArgumentError.value(
            photo.fileDataRepresentation,
            'photo.fileDataRepresentation',
            'Byte data returned empty. This could be due to the video codec type.',
          );
        } else {
          callback(photoData);
        }
      },
    );
    await capturePhotoOutput.capturePhotoWithSettings(
      oldSettings,
      photoCaptureDelegate,
    );
  }

  @override
  Future<List<FlashMode>> getSupportedFlashModes() async {
    final List<int> flashModes = await capturePhotoOutput.supportedFlashModes();

    final List<FlashMode> supportedModes = <FlashMode>[];
    for (int mode in flashModes) {
      switch (mode) {
        case CaptureFlashMode.auto:
          supportedModes.add(FlashMode.auto);
          break;
        case CaptureFlashMode.on:
          supportedModes.add(FlashMode.on);
          break;
        case CaptureFlashMode.off:
          supportedModes.add(FlashMode.off);
          break;
      }
    }
    return supportedModes;
  }

  @override
  Future<void> setFlashMode(FlashMode mode) async {
    switch (mode) {
      case FlashMode.on:
        flashMode = CaptureFlashMode.on;
        break;
      case FlashMode.off:
        flashMode = CaptureFlashMode.off;
        break;
      case FlashMode.auto:
        flashMode = CaptureFlashMode.auto;
        break;
    }
  }
}

class VideoCaptureOutput implements intf.VideoCaptureOutput {
  late CaptureMovieFileOutput movieFileOutput;

  @override
  Future<void> attach(covariant CameraController controller) {
    movieFileOutput = CaptureMovieFileOutput();
    return controller.session.addOutput(movieFileOutput);
  }

  @override
  Future<void> detach(covariant CameraController controller) async {
    // TODO: Remove movieFileOutput
  }

  @override
  Future<void> startRecording({required String fileOutput}) {
    return movieFileOutput.startRecordingToOutputFileURL(
      fileOutput,
      CaptureFileOutputRecordingDelegate(),
    );
  }

  @override
  Future<void> stopRecording() {
    return movieFileOutput.stopRecording();
  }
}
