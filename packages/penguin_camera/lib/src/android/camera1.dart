import 'dart:async';
import 'dart:typed_data';

import 'package:android_media/android_media.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:android_hardware/android_hardware.dart';
import 'package:penguin_camera/penguin_camera.dart';

import '../platform_interface.dart' as intf;

/// Implementation of [intf.CameraDevice] using Android Camera1 API.
class CameraDevice implements intf.CameraDevice {
  /// Construct a [CameraDevice].
  CameraDevice(this.info);

  /// Additional information about a camera.
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

/// Implementation of [intf.CameraController] using Android Camera1 API.
class CameraController implements intf.CameraController {
  /// Construct a [CameraController].
  CameraController({required this.device, required this.outputs});

  bool _initialized = false;
  bool _disposed = false;

  @override
  final CameraDevice device;

  @override
  final List<CameraOutput> outputs;

  /// The camera controlled by this controller.
  ///
  /// This should not be accessed until after initialized.
  late final Camera camera;

  /// The parameters used to configure this device.
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
  Future<List<FocusMode>> supportedFocusModes() async {
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
  Future<List<ExposureMode>> supportedExposureModes() async {
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

  @override
  Future<void> setTorchMode(TorchMode mode) {
    switch (mode) {
      case TorchMode.on:
        cameraParameters.setFlashMode(CameraParameters.flashModeTorch);
        break;
      case TorchMode.off:
        cameraParameters.setFlashMode(CameraParameters.flashModeOff);
        break;
    }

    return camera.setParameters(cameraParameters);
  }

  @override
  Future<List<TorchMode>> supportedTorchModes() async {
    final List<String> flashModes =
        await cameraParameters.getSupportedFlashModes();

    for (String mode in flashModes) {
      if (mode == CameraParameters.flashModeTorch) {
        return <TorchMode>[TorchMode.on, TorchMode.off];
      }
    }

    return <TorchMode>[];
  }

  @override
  Future<double> maxZoom() async {
    final List<int> zoomRatios = await cameraParameters.getZoomRatios();
    return zoomRatios.last / 100;
  }

  @override
  Future<double> minZoom() {
    return Future<double>.value(1.0);
  }

  @override
  Future<bool> smoothZoomSupported() {
    return cameraParameters.isSmoothZoomSupported();
  }

  @override
  Future<bool> zoomSupported() {
    return cameraParameters.isZoomSupported();
  }

  @override
  Future<void> smoothZoomTo(double value) async {
    final List<int> zoomRatios = await cameraParameters.getZoomRatios();

    final int valueZoomRatio = (value * 100).round();
    assert(valueZoomRatio >= 100);
    assert(valueZoomRatio < (zoomRatios.last + 1));

    final int index = lowerBound<int>(zoomRatios, (value * 100).round());
    return camera.startSmoothZoom(index);
  }

  @override
  Future<void> setZoom(double value) async {
    final List<int> zoomRatios = await cameraParameters.getZoomRatios();

    final int valueZoomRatio = (value * 100).round();
    assert(valueZoomRatio >= 100);
    assert(valueZoomRatio < (zoomRatios.last + 1));

    final int index = lowerBound<int>(zoomRatios, (value * 100).round());
    cameraParameters.setZoom(index);
    return camera.setParameters(cameraParameters);
  }
}

/// Implementation of [intf.PenguinCameraPlatform] using Android Camera1 API.
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
  VideoCaptureOutput createVideoCaptureOutput({bool includeAudio = false}) {
    return VideoCaptureOutput(includeAudio: includeAudio);
  }
}

/// Implementation of [intf.PreviewOutput] using Android Camera1 API.
class PreviewOutput with PresetChangeListener implements intf.PreviewOutput {
  late CameraController _controller;
  late Completer<Texture> _previewWidgetCompleter;

  @override
  Future<Widget> previewWidget() {
    return _previewWidgetCompleter.future;
  }

  @override
  Future<void> attach(covariant CameraController controller) async {
    _controller = controller;
    _previewWidgetCompleter = Completer<Texture>();
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

  @override
  Future<Size> outputSize() async {
    final CameraSize size = await _controller.cameraParameters.getPreviewSize();
    return Size(size.width.toDouble(), size.height.toDouble());
  }

  @override
  Future<void> setRotation(OutputRotation rotation) {
    late final int angle;
    switch (rotation) {
      case OutputRotation.rotation0:
        angle = 0;
        break;
      case OutputRotation.rotation90:
        throw UnsupportedError('This rotation is not supported by this API.');
      case OutputRotation.rotation180:
        angle = 180;
        break;
      case OutputRotation.rotation270:
        angle = 270;
        break;
    }

    late int displayOrientation;
    final CameraInfo cameraInfo = _controller.device.info;
    if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
      displayOrientation = (cameraInfo.orientation + angle) % 360;
      displayOrientation = (360 - displayOrientation) % 360;
    } else {
      displayOrientation = (cameraInfo.orientation - angle + 360) % 360;
    }

    return _controller.camera.setDisplayOrientation(displayOrientation);
  }
}

/// Implementation of [intf.ImageCaptureOutput] using Android Camera1 API.
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
      jpeg: PictureCallback((Uint8List? bytes) {
        _controller.camera.startPreview();
        // This default implementations of this output should always return a
        // byte array. If the settings of this output is overriden, this could
        // return a null value.
        callback(bytes!);
      }),
    );
  }

  @override
  Future<List<FlashMode>> supportedFlashModes() async {
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

  @override
  Future<Size> outputSize() async {
    final CameraSize size = await _controller.cameraParameters.getPictureSize();
    return Size(size.width.toDouble(), size.height.toDouble());
  }

  @override
  Future<void> setRotation(OutputRotation rotation) {
    final CameraInfo cameraInfo = _controller.device.info;

    late final int imageRotation;
    switch (rotation) {
      case OutputRotation.rotation0:
        imageRotation = cameraInfo.orientation;
        break;
      case OutputRotation.rotation90:
        if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
          imageRotation = (cameraInfo.orientation + 270) % 360;
        } else {
          imageRotation = (cameraInfo.orientation + 90) % 360;
        }
        break;
      case OutputRotation.rotation180:
        imageRotation = (cameraInfo.orientation + 180) % 360;
        break;
      case OutputRotation.rotation270:
        if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
          imageRotation = (cameraInfo.orientation + 90) % 360;
        } else {
          imageRotation = (cameraInfo.orientation + 270) % 360;
        }
        break;
    }

    _controller.cameraParameters.setRotation(imageRotation);
    return _controller.camera.setParameters(_controller.cameraParameters);
  }
}

/// Implementation of [intf.VideoCaptureOutput] using Android Camera1 API.
class VideoCaptureOutput
    with PresetChangeListener
    implements intf.VideoCaptureOutput {
  /// Construct a [VideoCaptureOutput].
  VideoCaptureOutput({this.includeAudio = false});

  /// Whether [mediaController] should include audio settings.
  ///
  /// Defaults to false. A user should make sure audio permissions have been
  /// provided by the user.
  final bool includeAudio;

  late CameraController _controller;

  /// Handles recording video and audio for a [Camera].
  late MediaRecorder mediaRecorder;

  /// Output size in pixels specified by the user.
  ///
  /// This value is null if a user has not awaited
  /// [CameraController.setControllerPreset].
  CameraSize? specifiedSize;

  @override
  Future<void> attach(covariant CameraController controller) {
    _controller = controller;
    mediaRecorder = MediaRecorder();
    mediaRecorder.setCamera(controller.camera);
    mediaRecorder.setVideoSource(VideoSource.camera);
    if (includeAudio) mediaRecorder.setAudioSource(AudioSource.defaultSource);
    mediaRecorder.setOutputFormat(OutputFormat.mpeg4);
    if (includeAudio) mediaRecorder.setAudioEncoder(AudioEncoder.amrNb);
    return mediaRecorder.setVideoEncoder(VideoEncoder.mpeg4Sp);
  }

  @override
  Future<void> detach(covariant CameraController controller) {
    return mediaRecorder.release();
  }

  @override
  Future<void> startRecording({required String fileOutput}) async {
    mediaRecorder.setOutputFilePath(fileOutput);
    await _controller.camera.unlock();
    mediaRecorder.prepare();
    return mediaRecorder.start();
  }

  @override
  Future<void> stopRecording() {
    return mediaRecorder.stop();
  }

  @override
  Future<void> updatePreset(CameraControllerPreset preset) async {
    final List<CameraSize>? supportedSizes =
        await _controller.cameraParameters.getSupportedVideoSizes();

    if (supportedSizes != null) {
      _sortCameraSizes(supportedSizes);
      switch (preset) {
        case CameraControllerPreset.low:
          specifiedSize = supportedSizes.first;
          mediaRecorder.setVideoSize(
            supportedSizes.first.width,
            supportedSizes.first.height,
          );
          break;
        case CameraControllerPreset.medium:
          final int midIndex = ((supportedSizes.length - 1) / 2).round();
          specifiedSize = supportedSizes[midIndex];
          mediaRecorder.setVideoSize(
            supportedSizes[midIndex].width,
            supportedSizes[midIndex].height,
          );
          break;
        case CameraControllerPreset.high:
          specifiedSize = supportedSizes.last;
          mediaRecorder.setVideoSize(
            supportedSizes.last.width,
            supportedSizes.last.height,
          );
          break;
      }
      return;
    }

    final List<CameraSize> previewSizes =
        await _controller.cameraParameters.getSupportedPreviewSizes();
    _sortCameraSizes(previewSizes);
    switch (preset) {
      case CameraControllerPreset.low:
        specifiedSize = previewSizes.first;
        _controller.cameraParameters.setPreviewSize(
          previewSizes.first.width,
          previewSizes.first.height,
        );
        break;
      case CameraControllerPreset.medium:
        final int midIndex = ((previewSizes.length - 1) / 2).round();
        specifiedSize = previewSizes[midIndex];
        _controller.cameraParameters.setPreviewSize(
          previewSizes[midIndex].width,
          previewSizes[midIndex].height,
        );
        break;
      case CameraControllerPreset.high:
        specifiedSize = previewSizes.last;
        _controller.cameraParameters.setPreviewSize(
          previewSizes.last.width,
          previewSizes.last.height,
        );
        break;
    }

    return _controller.camera.setParameters(_controller.cameraParameters);
  }

  @override
  Future<Size?> outputSize() async {
    if (specifiedSize == null) return null;
    return Size(
      specifiedSize!.width.toDouble(),
      specifiedSize!.height.toDouble(),
    );
  }

  @override
  Future<void> setRotation(OutputRotation rotation) {
    final CameraInfo cameraInfo = _controller.device.info;

    late final int videoRotation;
    switch (rotation) {
      case OutputRotation.rotation0:
        videoRotation = cameraInfo.orientation;
        break;
      case OutputRotation.rotation90:
        if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
          videoRotation = (cameraInfo.orientation + 270) % 360;
        } else {
          videoRotation = (cameraInfo.orientation + 90) % 360;
        }
        break;
      case OutputRotation.rotation180:
        videoRotation = (cameraInfo.orientation + 180) % 360;
        break;
      case OutputRotation.rotation270:
        if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
          videoRotation = (cameraInfo.orientation + 90) % 360;
        } else {
          videoRotation = (cameraInfo.orientation + 270) % 360;
        }
        break;
    }

    return mediaRecorder.setOrientationHint(videoRotation);
  }
}

/// Listens when a [CameraController] changes [CameraControllerPreset]s.
mixin PresetChangeListener {
  /// Called when a [CameraController] has changed [CameraControllerPreset]s.
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
