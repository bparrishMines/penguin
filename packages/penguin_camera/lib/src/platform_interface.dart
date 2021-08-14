import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android/camera1.dart' as android;
import 'ios/av_foundation.dart' as ios;

/// Callback to receive bytes when an image is taken.
///
/// See: [ImageCaptureOutput.takePicture].
typedef ImageCallback = void Function(Uint8List bytes);

/// The cross-platform interface for penguin camera.
abstract class PenguinCameraPlatform extends PlatformInterface {
  /// Constructs a [PenguinCameraPlatform].
  PenguinCameraPlatform() : super(token: _token);

  static PenguinCameraPlatform? _instance;

  static final Object _token = Object();

  /// Current platform implementation of the platform interface.
  ///
  /// If none has been explicitly set, the default implementations are used for
  /// their respective platforms.
  ///
  /// Supported Default Platform Implementations:
  /// Android: [android.CameraPlatform]
  /// iOS: [ios.CameraPlatform]
  static PenguinCameraPlatform get instance {
    if (_instance != null) return _instance!;

    if (defaultTargetPlatform == TargetPlatform.android) {
      _instance = android.CameraPlatform();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _instance = ios.CameraPlatform();
    } else {
      throw AssertionError('Current platform is not supported.');
    }

    return _instance!;
  }

  /// Platform-specific plugins should set this with their own platform-specific class that extends [PenguinCameraPlatform] when they register themselves.
  static set instance(PenguinCameraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Retrieve information for all available camera devices.
  Future<List<CameraDevice>> getAllCameraDevices() {
    throw UnimplementedError();
  }

  /// Create an instance of [CameraController].
  ///
  /// A platform implementation of [PenguinCameraPlatform] should implement a
  /// class of [CameraController] and return it here.
  CameraController createCameraController({
    required CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    throw UnimplementedError();
  }

  /// Create an instance of [PreviewOutput].
  ///
  /// A platform implementation of [PenguinCameraPlatform] should implement a
  /// class of [PreviewOutput] and return it here.
  PreviewOutput createPreviewOutput() {
    throw UnimplementedError();
  }

  /// Create an instance of [ImageCaptureOutput].
  ///
  /// A platform implementation of [PenguinCameraPlatform] should implement a
  /// class of [ImageCaptureOutput] and return it here.
  ImageCaptureOutput createImageCaptureOutput() {
    throw UnimplementedError();
  }

  /// Create an instance of [VideoCaptureOutput].
  ///
  /// A platform implementation of [PenguinCameraPlatform] should implement a
  /// class of [VideoCaptureOutput] and return it here.
  VideoCaptureOutput createVideoCaptureOutput({bool includeAudio = false}) {
    throw UnimplementedError();
  }
}

/// Indicates the mode of the focus on the receiver's device, if it has one.
///
/// See:
///   [CameraController.supportedFocusModes].
///   [CameraController.setFocusMode].
enum FocusMode {
  /// Focus is fixed.
  ///
  /// The camera is always in this mode if the focus is not adjustable. If the
  /// camera has auto-focus, this mode can fix the focus, which is usually at
  /// hyperfocal distance.
  fixed,

  /// Continuous auto focus mode intended for taking pictures.
  ///
  /// The camera continuously tries to focus. The speed of focus change is more
  /// aggressive than [continuousVideoAutoFocus]. Auto focus starts when the
  /// parameter is set.
  ///
  /// Not all platforms will support different auto focus modes for images and
  /// videos and will default to a more general auto focus mode.
  continuousImageAutoFocus,

  /// Continuous auto focus mode intended for taking pictures.
  ///
  /// The camera continuously tries to focus. This is the best choice for video
  /// recording because the focus changes smoothly. Applications still can call
  /// [ImageCaptureOutput.takePicture] in this mode but the subject may not be
  /// in focus.
  ///
  /// Not all platforms will support different auto focus modes for images and
  /// videos and will default to a more general auto focus mode.
  continuousVideoAutoFocus,
}

/// Degrees to rotate the output image for a [CameraOutput].
enum OutputRotation {
  /// Rotate the output 0 degrees counter-clockwise from its natural orientation.
  ///
  /// For example, a phone's natural orientation is typically portrait-up.
  rotation0,

  /// Rotate the output 90 degrees counter-clockwise from its natural orientation.
  ///
  /// For example, a phone's natural orientation is typically portrait-up.
  rotation90,

  /// Rotate the output 180 degrees counter-clockwise from its natural orientation.
  ///
  /// For example, a phone's natural orientation is typically portrait-up.
  rotation180,

  /// Rotate the output 270 degrees counter-clockwise from its natural orientation.
  ///
  /// For example, a phone's natural orientation is typically portrait-up.
  rotation270,
}

/// Constants indicating the mode of the exposure on the receiver's device, if it has adjustable exposure.
enum ExposureMode {
  /// Indicates that the exposure should be locked at its current value.
  locked,

  /// Indicates that the device should automatically adjust exposure when needed.
  continuous,
}

/// Constants indicating the mode of the flash on the receiver's device, if it has one.
///
/// It's possible for a flash mode to override the value of a torch mode. This
/// depends on the platform.
enum FlashMode {
  /// Indicates that the flash should always be on.
  on,

  /// Indicates that the flash should always be off.
  off,

  /// Indicates that the flash should be used automatically depending on ambient light conditions.
  auto,
}

/// Constants to specify the capture device’s torch mode.
///
/// It's possible for a torch mode to override the value of a flash mode. This
/// depends on the platform.
enum TorchMode {
  /// The capture device torch is always on.
  on,

  /// The capture device torch is always off.
  off,
}

/// Streams preview frames from a camera device to a widget.
abstract class PreviewOutput extends CameraOutput {
  /// Construct a [PreviewOutput]
  factory PreviewOutput() {
    return PenguinCameraPlatform.instance.createPreviewOutput();
  }

  /// A widget that displays the preview frames of a camera device.
  ///
  /// {@template penguin_camera_ensure_controller_initialized}
  /// This should only be called after passing as a parameter to a
  /// [CameraController] and [CameraController.initialize] has been called.
  /// {@endtemplate}
  Future<Widget> previewWidget();
}

/// Takes images with a camera device.
abstract class ImageCaptureOutput extends CameraOutput {
  /// Constructs an [ImageCaptureOutput].
  factory ImageCaptureOutput() {
    return PenguinCameraPlatform.instance.createImageCaptureOutput();
  }

  /// Take a picture and return the bytes in callback.
  ///
  /// The default output is for a JPEG image.
  ///
  /// {@macro penguin_camera_ensure_controller_initialized}
  Future<void> takePicture(ImageCallback callback);

  /// Set the flash mode when taking images.
  ///
  /// Users should call [supportedFlashModes] before calling this method. Not
  /// all [FlashMode]s are supported on all devices. Some won't support any.
  ///
  /// {@macro penguin_camera_ensure_controller_initialized}
  Future<void> setFlashMode(FlashMode mode);

  /// The supported [FlashMode]s for the attached camera device.
  ///
  /// {@macro penguin_camera_ensure_controller_initialized}
  Future<List<FlashMode>> supportedFlashModes();
}

/// Recordes video and audio with a camera device.
abstract class VideoCaptureOutput extends CameraOutput {
  /// Construct a [VideoCaptureOutput].
  ///
  /// By default, audio is not included when recording video. Set [includeAudio]
  /// to true, to include audio when recording.
  factory VideoCaptureOutput({bool includeAudio = false}) {
    return PenguinCameraPlatform.instance.createVideoCaptureOutput();
  }

  /// Begin recording to the specified [fileOutput].
  ///
  /// A [PlatformException] may be thrown if [fileOutput] is invalid or
  /// an app doesn't receive write permissions.
  ///
  /// {@macro penguin_camera_ensure_controller_initialized}
  Future<void> startRecording({required String fileOutput});

  /// End recording the the file specified in [startRecording].
  ///
  /// {@macro penguin_camera_ensure_controller_initialized}
  Future<void> stopRecording();
}

/// Abstract class for output of a [CameraController].
abstract class CameraOutput {
  /// Called when an output should be attached to a [CameraController].
  ///
  /// This should not need to be called by a user directly unless implementing
  /// their own [CameraOutput].
  Future<void> attach(CameraController controller);

  /// Called when an output should be detached from a [CameraController].
  ///
  /// This should not need to be called by a user directly unless implementing
  /// their own [CameraOutput].
  Future<void> detach(CameraController controller);

  /// The size in pixels retrieved by the output.
  ///
  /// This should be called after setting AND awaiting
  /// [CameraController.setControllerPreset]. Otherwise, this value could return
  /// `null`. A `null` value indicates the output is using the default size.
  Future<Size?> outputSize();

  /// Set the rotation of the output relative to the natural orientation of the device.
  ///
  /// E.g. The natural orientation of a phone is typically portrait up.
  Future<void> setRotation(OutputRotation rotation);
}

/// Constants indicating the physical position of an [CameraDevice]'s hardware on the system.
enum CameraPosition {
  /// Indicates that the device is physically located on the front of the system hardware.
  front,

  /// Indicates that the device is physically located on the back of the system hardware.
  back,

  /// Indicates that the device's position relative to the system hardware is unspecified.
  unspecified,
}

/// Configures a [CameraController] for different output sizes.
///
/// Depending on the device, it is not guaranteed that the values of [low],
/// [medium], and [high] are different. However, it is guaranteed that [low] <=
/// [medium] <= [high].
enum CameraControllerPreset {
  /// Set the [CameraController] to configure its [CameraOutput]s with the lowest preset size available.
  low,

  /// Set the [CameraController] to configure its [CameraOutput]s with a medium preset size available.
  medium,

  /// Set the [CameraController] to configure its [CameraOutput]s with the highest preset size available.
  high,
}

/// A device that provides video for a [CameraController].
abstract class CameraDevice {
  /// The unique identifier of a camera device.
  String get name;

  /// The position of a camera on a device.
  CameraPosition get position;
}

/// Controls a device's camera and provides access to camera features.
///
/// Example usage to take a photo:
///
/// ```dart
/// final List<CameraDevice> devices =
///     await CameraController.getAllCameraDevices();
/// final CameraDevice device = devices.firstWhere(
///   (CameraDevice device) => device.position == CameraPosition.back,
/// );
///
/// final ImageCaptureOutput imageOutput = ImageCaptureOutput();
/// final CameraController controller =
/// CameraController(device: device, outputs: <CameraOutput>[PreviewOutput(), imageOutput]);
/// await controller.initialize();
/// controller.start();
///
/// imageOutput.takePicture((Uint8List data) {
///   print(data.length);
/// });
///
/// controller.stop();
/// controller.dispose();
/// ```
abstract class CameraController {
  /// Construct a [CameraController].
  factory CameraController({
    required CameraDevice device,
    required List<CameraOutput> outputs,
  }) {
    return PenguinCameraPlatform.instance.createCameraController(
      device: device,
      outputs: outputs,
    );
  }

  /// Retrieve information for available [CameraDevice]s.
  static Future<List<CameraDevice>> getAllCameraDevices() =>
      PenguinCameraPlatform.instance.getAllCameraDevices();

  /// The camera device controlled by this controller.
  CameraDevice get device;

  /// The ouptuts frame data is streamed to from [device].
  List<CameraOutput> get outputs;

  /// Initializes this controller and attaches the [outputs].
  ///
  /// This should be awaited before calling any other methods.
  Future<void> initialize();

  /// Start the flow of data from [device] to [outputs].
  ///
  /// *Note*: For some platform, this won't run if at least a [PreviewOutput]
  /// was not added to [outputs]. Specifically, Android.
  Future<void> start();

  /// Stop the flow of data from [device] to [outputs].
  Future<void> stop();

  /// Release all resources held by [device] and detach all [outputs].
  Future<void> dispose();

  /// Set the focus mode of the device.
  ///
  /// [supportedFocusModes] should be called before this.
  Future<void> setFocusMode(FocusMode mode);

  /// Retrieve all supported focus modes for a device.
  Future<List<FocusMode>> supportedFocusModes();

  /// Set the exposure mode for a device.
  ///
  /// [supportedExposureModes] should be called before this.
  Future<void> setExposureMode(ExposureMode mode);

  /// Retrieve all supported exposure modes for a device.
  Future<List<ExposureMode>> supportedExposureModes();

  /// Set a preset configuration for a [CameraController].
  ///
  /// To guarantee that a [CameraOutput] returns a value from
  /// [CameraOutput.outputSize], a user should await the future returned by
  /// this method.
  Future<void> setControllerPreset(CameraControllerPreset preset);

  /// Set the torch mode for a device.
  ///
  /// [supportedTorchModes] should be called before this.
  ///
  /// For some platforms, this can override a flash mode.
  Future<void> setTorchMode(TorchMode mode);

  /// Retrieve all supported torch modes for a device.
  Future<List<TorchMode>> supportedTorchModes();

  /// Whether a zoom value can be set.
  Future<bool> zoomSupported();

  /// Whether a device can start a smooth zoom.
  ///
  /// It is possible for a device to not support smooth zoom, but still support
  /// zoom.
  Future<bool> smoothZoomSupported();

  /// The minimum zoom value of a device.
  Future<double> minZoom();

  /// The maximum zoom value of a device.
  Future<double> maxZoom();

  /// Set a zoom value for a device.
  ///
  /// This must be >= [minZoom] and <= [maxZoom].
  ///
  /// This value is a multiplier. For example, a value of 2.0 doubles the size
  /// of an image’s subject (and halves the field of view). Allowed values
  /// typically range from 1.0 (full field of view) to the value of [maxZoom].
  /// Setting the value of this property jumps immediately to the new zoom
  /// factor. For a smooth transition, use the [smoothZoomTo].
  ///
  /// [zoomSupported] should be called before this.
  Future<void> setZoom(double value);

  /// Smoothly transition the zoom value for a device.
  ///
  /// This must be >= [minZoom] and <= [maxZoom].
  ///
  /// This value is a multiplier. For example, a value of 2.0 doubles the size
  /// of an image’s subject (and halves the field of view). Allowed values
  /// typically range from 1.0 (full field of view) to the value of [maxZoom].
  ///
  /// [smoothZoomSupported] should be called before this.
  Future<void> smoothZoomTo(double value);
}
