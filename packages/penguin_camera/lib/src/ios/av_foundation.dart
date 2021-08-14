import 'dart:async';
import 'dart:typed_data';

import 'package:av_foundation/av_foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:penguin_camera/penguin_camera.dart';

import '../platform_interface.dart' as intf;
import '../standard_platform_interface.dart';

/// Implementation of [intf.CameraDevice] using iOS AVFoundation API.
class CameraDevice implements intf.CameraDevice {
  /// Construct a [CameraDevice].
  CameraDevice(this.device);

  /// The iOS camera device being used.
  ///
  /// This also offers controls for hardware-specific capture features.
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

/// Implementation of [intf.CameraController] using iOS AVFoundation API.
class CameraController extends StandardCameraController {
  /// Construct a [CameraController].
  CameraController({required this.device, required this.outputs})
      : captureDeviceInput = CaptureDeviceInput(device.device);

  @override
  final CameraDevice device;

  @override
  final List<CameraOutput> outputs;

  /// Manages capture activity and coordinates the flow of data from input devices to capture outputs.
  final CaptureSession session = CaptureSession();

  /// Provides media from a capture device to a capture session.
  final CaptureDeviceInput captureDeviceInput;

  /// The [CaptureSessionPreset] with [CaptureSession] used when a [CameraControllerPreset] is set.
  String? capturePreset;

  @override
  Future<void> initialize() async {
    super.initialize();

    session.addInput(captureDeviceInput);
    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.attach(this)),
      eagerError: true,
    );
  }

  @override
  Future<void> start() {
    verifyInitialized();
    verifyNotDisposed();
    return session.startRunning();
  }

  @override
  Future<void> stop() {
    verifyInitialized();
    verifyNotDisposed();
    return session.stopRunning();
  }

  @override
  Future<void> dispose() async {
    if (disposed) return Future<void>.value();
    stop();
    super.dispose();

    await Future.wait(
      outputs.map<Future<void>>((CameraOutput output) => output.detach(this)),
      eagerError: true,
    );
  }

  @override
  Future<void> setFocusMode(FocusMode mode) {
    verifyInitialized();
    verifyNotDisposed();
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
  Future<List<FocusMode>> supportedFocusModes() async {
    verifyInitialized();
    verifyNotDisposed();
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
  Future<List<ExposureMode>> supportedExposureModes() async {
    verifyInitialized();
    verifyNotDisposed();
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
    verifyInitialized();
    verifyNotDisposed();
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

  @override
  Future<void> setControllerPreset(CameraControllerPreset preset) async {
    verifyInitialized();
    verifyNotDisposed();
    final List<String> supportedPresets =
        await session.canSetSessionPresets(<String>[
      CaptureSessionPreset.preset352x288,
      CaptureSessionPreset.preset640x480,
      CaptureSessionPreset.iFrame960x540,
      CaptureSessionPreset.preset1280x720,
      CaptureSessionPreset.preset1920x1080,
    ]);

    switch (preset) {
      case CameraControllerPreset.low:
        capturePreset = supportedPresets.first;
        return session.setSessionPreset(supportedPresets.first);
      case CameraControllerPreset.medium:
        final int midIndex = ((supportedPresets.length - 1) / 2).round();
        capturePreset = supportedPresets[midIndex];
        return session.setSessionPreset(supportedPresets[midIndex]);
      case CameraControllerPreset.high:
        capturePreset = supportedPresets.last;
        return session.setSessionPreset(supportedPresets.last);
    }
  }

  @override
  Future<void> setTorchMode(TorchMode mode) {
    verifyInitialized();
    verifyNotDisposed();
    device.device.lockForConfiguration();
    switch (mode) {
      case TorchMode.on:
        device.device.setTorchMode(CaptureTorchMode.on);
        break;
      case TorchMode.off:
        device.device.setTorchMode(CaptureTorchMode.off);
        break;
    }
    return device.device.unlockForConfiguration();
  }

  @override
  Future<List<TorchMode>> supportedTorchModes() async {
    verifyInitialized();
    verifyNotDisposed();
    if (!device.device.hasTorch) return <TorchMode>[];

    final List<int> torchModes = await device.device.torchModesSupported(
      <int>[CaptureTorchMode.on, CaptureTorchMode.off],
    );

    for (int mode in torchModes) {
      if (mode == CaptureTorchMode.on) {
        return <TorchMode>[TorchMode.on, TorchMode.off];
      }
    }

    return <TorchMode>[];
  }

  @override
  Future<double> maxZoom() {
    verifyInitialized();
    verifyNotDisposed();
    return device.device.maxAvailableVideoZoomFactor();
  }

  @override
  Future<double> minZoom() {
    verifyInitialized();
    verifyNotDisposed();
    return device.device.minAvailableVideoZoomFactor();
  }

  @override
  Future<bool> smoothZoomSupported() {
    verifyInitialized();
    verifyNotDisposed();
    return Future<bool>.value(true);
  }

  @override
  Future<bool> zoomSupported() {
    verifyInitialized();
    verifyNotDisposed();
    return Future<bool>.value(true);
  }

  @override
  Future<void> setZoom(double value) {
    verifyInitialized();
    verifyNotDisposed();
    device.device.lockForConfiguration();
    device.device.setVideoZoomFactor(value);
    return device.device.unlockForConfiguration();
  }

  @override
  Future<void> smoothZoomTo(double value) {
    verifyInitialized();
    verifyNotDisposed();
    device.device.lockForConfiguration();
    device.device.rampToVideoZoomFactor(value, 1.0);
    return device.device.unlockForConfiguration();
  }
}

/// Implementation of [intf.PenguinCameraPlatform] using iOS AVFoundation API.
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
  VideoCaptureOutput createVideoCaptureOutput({bool includeAudio = false}) {
    return VideoCaptureOutput(includeAudio: includeAudio);
  }
}

/// Implementation of [intf.PreviewOutput] using iOS AVFoundation API.
class PreviewOutput extends StandardPreviewOutput {
  late CameraController _controller;

  /// Widget to display preview frames of a [CaptureDevice].
  ///
  /// This value is `null` until [attach] is called.
  late final Preview preview;

  @override
  Future<void> attach(covariant CameraController controller) {
    super.attach(controller);
    _controller = controller;
    preview = Preview(controller: PreviewController(controller.session));
    return Future<void>.value();
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    super.detach(controller);
    return Future<void>.value();
  }

  @override
  Future<Widget> previewWidget() => Future<Widget>.value(preview);

  @override
  Future<Size?> outputSize() async {
    verifyAttached();
    if (_controller.capturePreset == null) return null;
    switch (_controller.capturePreset) {
      case CaptureSessionPreset.preset352x288:
        return const Size(352, 288);
      case CaptureSessionPreset.preset640x480:
        return const Size(640, 480);
      case CaptureSessionPreset.iFrame960x540:
        return const Size(960, 540);
      case CaptureSessionPreset.preset1280x720:
        return const Size(1280, 720);
      case CaptureSessionPreset.preset1920x1080:
        return const Size(1920, 1080);
    }
  }

  @override
  Future<void> setRotation(OutputRotation rotation) async {
    verifyAttached();
    final CaptureConnection? connection = await preview.controller.connection();

    if (connection == null) {
      throw StateError(
        'Could not find a connection for this output. This may not be attached to a CameraController.',
      );
    }

    switch (rotation) {
      case OutputRotation.rotation0:
        return connection.setVideoOrientation(CaptureVideoOrientation.portrait);
      case OutputRotation.rotation270:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeLeft,
        );
      case OutputRotation.rotation180:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.portraitUpsideDown,
        );
      case OutputRotation.rotation90:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeRight,
        );
    }
  }
}

/// Implementation of [intf.ImageCaptureOutput] using iOS AVFoundation API.
class ImageCaptureOutput extends StandardImageCaptureOutput {
  late CameraController _controller;

  /// Handles capturing photos when added to a [CaptureSession].
  ///
  /// This value is `null` until [attach] is called.
  late CapturePhotoOutput capturePhotoOutput;

  /// Callback delegate when a photo is taken with [capturePhotoOutput].
  late CapturePhotoCaptureDelegate photoCaptureDelegate;

  /// The [CapturePhotoSettings] to be used when [takePicture] is called.
  ///
  /// This value is `null` until [attach] is called.
  late CapturePhotoSettings nextPhotoSettings = _createNextPhotoSettings();

  /// The [CaptureFlashMode] used when [setFlashMode] is called.
  ///
  /// This value is passed to [CapturePhotoSettings] when [takePicture] is called.
  int? flashMode;

  @override
  Future<void> attach(covariant CameraController controller) {
    super.attach(controller);
    _controller = controller;
    capturePhotoOutput = CapturePhotoOutput();
    return controller.session.addOutput(capturePhotoOutput);
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    super.detach(controller);
    return _controller.session.removeOutput(capturePhotoOutput);
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
    verifyAttached();
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
  Future<List<FlashMode>> supportedFlashModes() async {
    verifyAttached();
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
    verifyAttached();
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

  @override
  Future<Size?> outputSize() async {
    verifyAttached();
    if (_controller.capturePreset == null) return null;
    switch (_controller.capturePreset) {
      case CaptureSessionPreset.preset352x288:
        return const Size(352, 288);
      case CaptureSessionPreset.preset640x480:
        return const Size(640, 480);
      case CaptureSessionPreset.iFrame960x540:
        return const Size(960, 540);
      case CaptureSessionPreset.preset1280x720:
        return const Size(1280, 720);
      case CaptureSessionPreset.preset1920x1080:
        return const Size(1920, 1080);
    }
  }

  @override
  Future<void> setRotation(OutputRotation rotation) async {
    verifyAttached();
    final CaptureConnection? connection =
        await capturePhotoOutput.connectionWithMediaType(MediaType.video);

    if (connection == null) {
      throw StateError(
        'Could not find a connection for this output. This may not be attached to a CameraController.',
      );
    }

    switch (rotation) {
      case OutputRotation.rotation0:
        return connection.setVideoOrientation(CaptureVideoOrientation.portrait);
      case OutputRotation.rotation90:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeLeft,
        );
      case OutputRotation.rotation180:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.portraitUpsideDown,
        );
      case OutputRotation.rotation270:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeRight,
        );
    }
  }
}

/// Implementation of [intf.VideoCaptureOutput] using iOS AVFoundation API.
class VideoCaptureOutput extends StandardVideoCaptureOutput {
  /// Construct a [VideoCaptureOutput].
  VideoCaptureOutput({this.includeAudio = false});

  /// Whether an audio device should be added to the [CaptureSession] in [CameraController].
  ///
  /// The user is responsible for handling permissions for this feature.
  ///
  /// This value is `null` until [attach] is called.
  final bool includeAudio;

  late CameraController _controller;

  /// The [CaptureOutput] used to record video for a [CaptureSession].
  ///
  /// This value is `null` until [attach] is called.
  late CaptureMovieFileOutput movieFileOutput;

  @override
  Future<void> attach(covariant CameraController controller) async {
    super.attach(controller);
    _controller = controller;

    if (includeAudio) {
      final CaptureDevice? audioDevice =
          await CaptureDevice.defaultDeviceWithMediaType(MediaType.audio);

      if (audioDevice == null) {
        throw StateError('Could not find an audio device for this device.');
      }

      controller.session.addInput(CaptureDeviceInput(audioDevice));
    }

    movieFileOutput = CaptureMovieFileOutput();
    return controller.session.addOutput(movieFileOutput);
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    super.detach(controller);
    return _controller.session.removeOutput(movieFileOutput);
  }

  @override
  Future<void> startRecording({required String fileOutput}) {
    verifyAttached();
    return movieFileOutput.startRecordingToOutputFileURL(
      fileOutput,
      CaptureFileOutputRecordingDelegate(),
    );
  }

  @override
  Future<void> stopRecording() {
    verifyAttached();
    return movieFileOutput.stopRecording();
  }

  @override
  Future<Size?> outputSize() async {
    verifyAttached();
    if (_controller.capturePreset == null) return null;
    switch (_controller.capturePreset) {
      case CaptureSessionPreset.preset352x288:
        return const Size(352, 288);
      case CaptureSessionPreset.preset640x480:
        return const Size(640, 480);
      case CaptureSessionPreset.iFrame960x540:
        return const Size(960, 540);
      case CaptureSessionPreset.preset1280x720:
        return const Size(1280, 720);
      case CaptureSessionPreset.preset1920x1080:
        return const Size(1920, 1080);
    }
  }

  @override
  Future<void> setRotation(OutputRotation rotation) async {
    verifyAttached();
    final CaptureConnection? connection =
        await movieFileOutput.connectionWithMediaType(MediaType.video);

    if (connection == null) {
      throw StateError(
        'Could not find a connection for this output. This may not be attached to a CameraController.',
      );
    }

    switch (rotation) {
      case OutputRotation.rotation0:
        return connection.setVideoOrientation(CaptureVideoOrientation.portrait);
      case OutputRotation.rotation90:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeLeft,
        );
      case OutputRotation.rotation180:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.portraitUpsideDown,
        );
      case OutputRotation.rotation270:
        return connection.setVideoOrientation(
          CaptureVideoOrientation.landscapeRight,
        );
    }
  }
}
