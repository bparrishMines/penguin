import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'avfoundation.g.dart';
import 'avfoundation_channels.dart';

/// Callback when a photo finishes processing.
///
/// `photo` is always non-null: if an error prevented successful capture,
/// this object still contains metadata for the intended capture.
///
/// See: [CapturePhotoCaptureDelegate.didFinishProcessingPhoto]
@Reference('ios_avfoundation/avfoundation/FinishProcessingPhotoCallback')
typedef FinishProcessingPhotoCallback = Function(CapturePhoto photo);

/// [CaptureSessionPreset] string constants.
///
/// Clients may use an [CaptureSessionPreset] to set the format for output on an
/// [CaptureSession].
abstract class CaptureSessionPreset {
  CaptureSessionPreset._();

  /// A [CaptureSession] preset suitable for high resolution photo quality output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.Photo] for full resolution photo quality output.
  static const String photo = 'AVCaptureSessionPresetPhoto';

  /// A [CaptureSession] preset suitable for high quality video and audio output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.high] to achieve high quality video and audio
  /// output. [CaptureSessionPreset.high] is the default `sessionPreset` value.
  static const String high = 'AVCaptureSessionPresetHigh';

  /// A [CaptureSession] preset suitable for medium quality output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.medium] to achieve output video and audio bitrates
  /// suitable for sharing over WiFi.
  static const String medium = 'AVCaptureSessionPresetMedium';

  /// A [CaptureSession] preset suitable for low quality output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.low] to achieve output video and audio bitrates
  /// suitable for sharing over 3G.
  static const String low = 'AVCaptureSessionPresetLow';

  /// A [CaptureSession] preset suitable for 320x240 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset320x240] to achieve 320x240 output.
  ///
  /// This is only supported on macos.
  static const String preset320x240 = 'AVCaptureSessionPreset320x240';

  /// A [CaptureSession] preset suitable for 352x288 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset352x288] to achieve CIF quality (352x288)
  /// output.
  static const String preset352x288 = 'AVCaptureSessionPreset352x288';

  /// A [CaptureSession] preset suitable for 640x480 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset640x480] to achieve VGA quality (640x480)
  /// output.
  static const String preset640x480 = 'AVCaptureSessionPreset640x480';

  /// A [CaptureSession] preset suitable for 960x540 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset960x540] to achieve quarter HD quality
  /// (960x540) output.
  ///
  /// This is only supported on macos.
  static const String preset960x540 = 'AVCaptureSessionPreset960x540';

  /// A [CaptureSession] preset suitable for 1280x720 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset1280x720] to achieve 1280x720 output.
  static const String preset1280x720 = 'AVCaptureSessionPreset1280x720';

  /// A [CaptureSession] preset suitable for 1920x1080 video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset1920x1080] to achieve 1920x1080 output.
  static const String preset1920x1080 = 'AVCaptureSessionPreset1920x1080';

  /// A [CaptureSession] preset suitable for 3840x2160 (UHD 4K) video output.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.preset3840x2160] to achieve 3840x2160 output.
  ///
  /// Only supported on macos.
  static const String preset3840x2160 = 'AVCaptureSessionPreset3840x2160';

  /// A [CaptureSession] preset producing 960x540 Apple iFrame video and audio content.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.iFrame960x540] to achieve 960x540 quality iFrame
  /// H.264 video at ~30 Mbits/sec with AAC audio. QuickTime movies captured in
  /// iFrame format are optimal for editing applications.
  static const String iFrame960x540 = 'AVCaptureSessionPresetiFrame960x540';

  /// A [CaptureSession] preset producing 1280x720 Apple iFrame video and audio content.
  ///
  /// Clients may set a [CaptureSession] instance's `sessionPreset` to
  /// [CaptureSessionPreset.iFrame1280x720] to achieve 1280x720 quality iFrame
  /// H.264 video at ~40 Mbits/sec with AAC audio. QuickTime movies captured in
  /// iFrame format are optimal for editing applications.
  static const String iFrame1280x720 = 'AVCaptureSessionPresetiFrame1280x720';

  // TODO: CaptureDevice.setActiveFormat
  /// A [CaptureSession] preset indicating that the formats of the session's inputs are being given priority.
  ///
  /// By calling [CaptureSession.setSessionPreset], clients can easily
  /// configure a [CaptureSession] to produce a desired quality of service
  /// level. The session configures its inputs and outputs optimally to produce
  /// the QoS level indicated. Clients who need to ensure a particular input
  /// format is chosen can use [CaptureDevice.setActiveFormat] method. When a
  /// client sets the active format on a device, the associated session's
  /// `setSessionPreset` method automatically changes to
  /// [CaptureSessionPreset.inputPriority]. This change indicates that the input
  /// format selected by the client now dictates the quality of service level
  /// provided at the outputs. When a client sets the session preset to anything
  /// other than [CaptureSessionPreset.inputPriority], the session resumes
  /// responsibility for configuring inputs and outputs, and is free to change
  /// its inputs' `activeFormat` as needed.
  static const String inputPriority = 'AVCaptureSessionPresetInputPriority';
}

// TODO: keys in kCVPixelBuffer* keys in <CoreVideo/CVPixelBuffer.h>
// TODO: videoPixelAspectRatio
// TODO: videoCleanAperture
// TODO: videoScalingMode
// TODO: videoColorProperties
// TODO: videoAllowWideColor
/// Map keys for configuring output video format.
///
/// A video settings map may take one of two forms:
///
///   1. For compressed video output, use only the keys in [VideoSettingsKeys].
///   2. For uncompressed video output, start with kCVPixelBuffer* keys in <CoreVideo/CVPixelBuffer.h>.
///
/// In addition to the keys in CVPixelBuffer.h, uncompressed video settings dictionaries may also contain the following keys:
///
/// [videoPixelAspectRatio]
/// [videoCleanAperture]
/// [videoScalingMode]
/// [videoColorProperties]
/// [videoAllowWideColor]
///
/// It is an error to add any other keys to an uncompressed video settings
/// map.
abstract class VideoSettingsKeys {
  const VideoSettingsKeys._();

  /// Key used to set the video codec.
  static const String videoCodec = 'AVVideoCodecKey';
}

/// CaptureDeviceType string constants.
///
/// The [CaptureDeviceType] string constants are intended to be used in
/// combination with the [CaptureDeviceDiscoverySession] class to obtain a list
/// of devices matching certain search criteria.
abstract class CaptureDeviceType {
  /// A built-in microphone.
  static const String builtInMicrophone =
      'AVCaptureDeviceTypeBuiltInMicrophone';

  /// A built-in wide angle camera device.
  ///
  /// These devices are suitable for general purpose use.
  static const String builtInWideAngleCamera =
      'AVCaptureDeviceTypeBuiltInWideAngleCamera';

  /// A built-in camera device with a longer focal length than a wide angle camera.
  ///
  /// Note that devices of this type may only be discovered using an
  /// [CaptureDeviceDiscoverySession].
  static const String builtInTelephotoCamera =
      'AVCaptureDeviceTypeBuiltInTelephotoCamera';

  /// A built-in camera device with a shorter focal length than a wide angle camera.
  ///
  /// Note that devices of this type may only be discovered using an
  /// [CaptureDeviceDiscoverySession].
  static const String builtInUltraWideCamera =
      'AVCaptureDeviceTypeBuiltInUltraWideCamera';

  // TODO: AVCaptureExposureModeCustom
  // TODO: AVCaptureLensPositionCurrent
  // TODO: AVCaptureWhiteBalanceGainsCurrent
  // TODO: AVCaptureDevice.defaultDeviceWithDeviceType
  /// A device that consists of two fixed focal length cameras, one wide and one telephoto.
  ///
  /// Note that devices of this type may only be discovered using an
  /// [CaptureDeviceDiscoverySession] or
  /// [CaptureDevice.defaultDeviceWithDeviceType].
  ///
  /// A device of this device type supports the following features:
  ///  - Auto switching from one camera to the other when zoom factor, light level,
  /// and focus position allow this.
  ///  - Higher quality zoom for still captures by fusing images from both
  /// cameras.
  ///  - Depth data delivery by measuring the disparity of matched features
  /// between the wide and telephoto cameras.
  ///  - Delivery of photos from constituent devices (wide and telephoto
  /// cameras) via a single photo capture request.
  ///
  /// A device of this device type does not support the following features:
  ///  - [CaptureExposureModeCustom] and manual exposure bracketing.
  ///  - Locking focus with a lens position other than
  /// [CaptureLensPositionCurrent].
  ///  - Locking auto white balance with device white balance gains other than
  /// [CaptureWhiteBalanceGainsCurrent].
  ///
  /// Even when locked, exposure duration, ISO, aperture, white balance gains,
  /// or lens position may change when the device switches from one camera to
  /// the other. The overall exposure, white balance, and focus position however
  /// should be consistent.
  static const String builtInDualCamera =
      'AVCaptureDeviceTypeBuiltInDualCamera';

  // TODO: AVCaptureExposureModeCustom
  // TODO: AVCaptureLensPositionCurrent
  // TODO: AVCaptureWhiteBalanceGainsCurrent
  // TODO: AVCaptureDevice.defaultDeviceWithDeviceType
  /// A device that consists of two fixed focal length cameras, one ultra wide and one wide angle.
  ///
  /// Note that devices of this type may only be discovered using an
  /// [CaptureDeviceDiscoverySession] or
  /// [AVCaptureDevice.defaultDeviceWithDeviceType].
  ///
  /// A device of this device type supports the following features:
  ///  - Auto switching from one camera to the other when zoom factor, light
  /// level, and focus position allow this.
  ///  - Depth data delivery by measuring the disparity of matched features
  /// between the ultra wide and wide cameras.
  ///  - Delivery of photos from constituent devices (ultra wide and wide) via a
  /// single photo capture request.
  ///
  /// A device of this device type does not support the following features:
  ///  - [CaptureExposureModeCustom] and manual exposure bracketing.
  ///  - Locking focus with a lens position other than
  /// [CaptureLensPositionCurrent].
  ///  - Locking auto white balance with device white balance gains other than
  /// [CaptureWhiteBalanceGainsCurrent].
  ///
  /// Even when locked, exposure duration, ISO, aperture, white balance gains,
  /// or lens position may change when the device switches from one camera to
  /// the other. The overall exposure, white balance, and focus position however
  /// should be consistent.
  static const String builtInDualWideCamera =
      'AVCaptureDeviceTypeBuiltInDualWideCamera';

  // TODO: AVCaptureExposureModeCustom
  // TODO: AVCaptureLensPositionCurrent
  // TODO: AVCaptureWhiteBalanceGainsCurrent
  // TODO: AVCaptureDevice.defaultDeviceWithDeviceType
  /// A device that consists of three fixed focal length cameras, one ultra wide, one wide angle, and one telephoto.
  ///
  /// Note that devices of this type may only be discovered using an
  /// [CaptureDeviceDiscoverySession] or
  /// [AVCaptureDevice.defaultDeviceWithDeviceType].
  ///
  /// A device of this device type supports the following features:
  ///  - Auto switching from one camera to the other when zoom factor, light
  /// level, and focus position allow this.
  ///  - Delivery of photos from constituent devices (ultra wide, wide and
  /// telephoto cameras) via a single photo capture request.
  ///
  /// A device of this device type does not support the following features:
  ///  - [CaptureExposureModeCustom] and manual exposure bracketing.
  ///  - Locking focus with a lens position other than
  /// [CaptureLensPositionCurrent].
  ///  - Locking auto white balance with device white balance gains other than
  /// [CaptureWhiteBalanceGainsCurrent].
  ///
  /// Even when locked, exposure duration, ISO, aperture, white balance gains,
  /// or lens position may change when the device switches from one camera to
  /// the other. The overall exposure, white balance, and focus position however
  /// should be consistent.
  static const String builtInTripleCamera =
      'AVCaptureDeviceTypeBuiltInTripleCamera';

  // TODO: AVCaptureDevice.defaultDeviceWithDeviceType
  /// A device that consists of two cameras, one YUV and one Infrared.
  ///
  /// The infrared camera provides high quality depth information that is
  /// synchronized and perspective corrected to frames produced by the YUV
  /// camera. While the resolution of the depth data and YUV frames may differ,
  /// their field of view and aspect ratio always match. Note that devices of
  /// this type may only be discovered using an [CaptureDeviceDiscoverySession]
  /// or [AVCaptureDevice.defaultDeviceWithDeviceType].
  static const String builtInTrueDepthCamera =
      'AVCaptureDeviceTypeBuiltInTrueDepthCamera';
}

/// An identifier for various media types.
abstract class MediaType {
  const MediaType._();

  /// The media contains video.
  static const String video = 'vide';
}

/// Constants indicating the physical position of an AVCaptureDevice's hardware on the system.
abstract class CaptureDevicePosition {
  const CaptureDevicePosition._();

  /// Indicates that the device's position relative to the system hardware is unspecified.
  static const int unspecified = 0;

  /// Indicates that the device is physically located on the back of the system hardware.
  static const int back = 1;

  /// Indicates that the device is physically located on the front of the system hardware.
  static const int front = 2;
}

/// The type of the strings used to specify a video codec type.
///
/// For instance, as values for the [VideoSettingsKeys.videoCodec] key in a
/// video settings dictionary.
abstract class VideoCodecType {
  const VideoCodecType._();

  /// The JPEG video codec.
  static const String jpeg = 'jpeg';
}

// TODO: AVCaptureResolvedPhotoSettings
// TODO: CapturePhotoSettings.uniqueId
// TODO: setHighResolutionCaptureEnabled
// TODO: setLivePhotoCaptureEnabled
// TODO: setLivePhotoAutoTrimmingEnabled
// TODO: AVCaptureMovieFileOutput
// TODO: AVCaptureVideoDataOutput
// TODO: CaptureStillImageOutput
// TODO: CaptureDevice.activeColorSpace
// TODO: AVCaptureColorSpace_P3_D65
/// A capture output for still image, Live Photo, and other photography workflows.
///
/// [CapturePhotoOutput] provides an interface for capture workflows related to
/// still photography. In addition to basic capture of still images, a photo
/// output supports RAW-format capture, bracketed capture of multiple images,
/// Live Photos, and wide-gamut color. You can output captured photos in a
/// variety of formats and codecs, including RAW format DNG files, HEVC format
/// HEIF files, and JPEG files.
///
/// To capture photos with the [CapturePhotoOutput] class, follow these steps:
///
/// 1. Create an [CapturePhotoOutput] object. Use its properties to determine
/// supported capture settings and to enable certain features (for example,
/// whether to capture Live Photos).
///
/// 2. Create and configure an [CapturePhotoSettings] object to choose features
/// and settings for a specific capture (for example, whether to enable image
/// stabilization or flash).
///
/// 3. Capture an image by passing your photo settings object to the
/// [capturePhoto] method along with a delegate object implementing the
/// [CapturePhotoCaptureDelegate] class. The photo capture output then calls
/// your delegate to notify you of significant events during the capture
/// process.
///
/// Some photo capture settings, such as the flashMode property, include options
/// for automatic behavior. For such settings, the photo output determines
/// whether to use that feature at the moment of capture—you don’t know when
/// requesting a capture whether the feature will be enabled when the captur
/// completes. When the photo capture output calls your
/// [CapturePhotoCaptureDelegate] callbacks with information about the completed
/// or in-progress capture, it also provides an [CaptureResolvedPhotoSettings]
/// object that details which automatic features are set for that capture. The
/// resolved settings object’s uniqueID property matches the uniqueID value of
/// the [CapturePhotoSettings] object you used to request capture.
///
/// Enabling certain photo features (Live Photo capture and high resolution
/// capture) requires a reconfiguration of the capture render pipeline. To opt
/// into these features, set the [setHighResolutionCaptureEnabled],
/// [setLivePhotoCaptureEnabled], and [setLivePhotoAutoTrimmingEnabled]
/// properties before calling your [CaptureSession.startRunning] method.
/// Changing any of these properties while the session is running disrupts the
/// capture render pipeline: Live Photo captures in progress end immediately,
/// unfulfilled photo requests abort, and video preview temporarily freezes.
///
/// Using a photo capture output adds other requirements to your
/// [CaptureSession] object:
///
/// A capture session can’t support both Live Photo capture and movie file
/// output. If your capture session includes an [CaptureMovieFileOutput] object,
/// the [setLivePhotoCaptureSupported] value becomes false. (As an alternative,
/// you can use the [CaptureVideoDataOutput] class to output video buffers at
/// the same resolution as a simultaneous Live Photo capture).
///
/// A capture session can’t contain both an [CapturePhotoOutput] object and an
/// [CaptureStillImageOutput] object. The [CapturePhotoOutput] class includes
/// all functionality of (and deprecates) the [CaptureStillImageOutput] class.
///
/// The [CapturePhotoOutput] class implicitly supports wide-gamut color
/// photography. If the source [CaptureDevice.activeColorSpace] value is
/// [AVCaptureColorSpace_P3_D65], the capture output produces photos with wide
/// color information (unless your [CapturePhotoSettings] object specifies an
/// output format that doesn’t support wide color).
@Reference('ios_avfoundation/avfoundation/CapturePhotoOutput')
class CapturePhotoOutput extends CaptureOutput with $CapturePhotoOutput {
  /// Constructs a [CapturePhotoOutput].
  CapturePhotoOutput() {
    _channel.$$create(this, $owner: true);
  }

  static $CapturePhotoOutputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCapturePhotoOutput;

  // TODO: supportedFlashModes
  // TODO: CapturePhotoSettings.uniqueID
  /// Initiates a photo capture using the specified settings.
  ///
  /// Use this method for all variations of still photography, including single
  /// photo capture, RAW format capture (with or without a secondary format such
  /// as JPEG), bracketed capture of multiple images, and Live Photo capture.
  ///
  /// When you call this method, the photo output validates the properties of
  /// your settings object to ensure deterministic behavior. For example, the
  /// flashMode setting must specify a value that is present in the photo
  /// output’s [getSupportedFlashModes] list. See each property’s description in
  /// the [CapturePhotoSettings] class reference for detailed validation rules.
  ///
  /// It is illegal to reuse a [CapturePhotoSettings] instance for multiple
  /// captures. Calling this method throws an exception
  /// ([PlatformException]) if the settings object’s `uniqueID` value matches
  /// that of any previously used settings object.
  Future<void> capturePhotoWithSettings(
    CapturePhotoSettings settings,
    CapturePhotoCaptureDelegate delegate,
  ) {
    return _channel.$capturePhotoWithSettings(this, settings, delegate);
  }
}

// TODO: Create with static async methods?
// TODO: CapturePhotoOutput.supportedFlashModes
// TODO: CapturePhotoSettings.uniqueID
// TODO: photoSettingsFromPhotoSettings
/// A specification of the features and settings to use for a single photo capture request.
///
/// To take a photo, you create and configure a [CapturePhotoSettings] object,
/// then pass it to the [CapturePhotoOutput.capturePhoto] method.
///
/// A [CapturePhotoSettings] instance can include any combination of settings,
/// regardless of whether that combination is valid for a given capture session.
/// When you initiate a capture by passing a photo settings object to the
/// [CapturePhotoOutput.capturePhoto] method, the photo capture output validate
/// s your settings to ensure deterministic behavior. For example, the flashMode
/// setting must specify a value that is present in the photo output’s
/// [CapturePhotoOutput.getSupportedFlashModes] list. For detailed validation
/// rules, see each field's description below.
///
/// It is illegal to reuse a [CapturePhotoSettings] instance for multiple
/// captures. Calling the [CapturePhotoOutput.capturePhoto] method throws an
/// exception (PlatformException) if the settings object’s `uniqueID` value
/// matches that of any previously used settings object.
///
/// To reuse a specific combination of settings, use the
/// [photoSettingsFromPhotoSettings] initializer to create a new, unique
/// [CapturePhotoSettings] instance from an existing photo settings object.
@Reference('ios_avfoundation/avfoundation/CapturePhotoSettings')
class CapturePhotoSettings with $CapturePhotoSettings {
  /// Construct a [CapturePhotoSettings].
  CapturePhotoSettings(this.processedFormat) {
    _channel.$$create(this, $owner: true, processedFormat: processedFormat);
  }

  static $CapturePhotoSettingsChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCapturePhotoSettings;

  // TODO: rename to format?
  // TODO: static methods photoSettings, photoSettingsWithFormat, photoSettingsWithRawPixelFormatType
  // TODO: kCVPixelBufferPixelFormatTypeKey (not from avfoundation. from core video)
  // TODO: CapturePhotoOutput.getAvailablePhotoPixelFormatTypes
  // TODO: CapturePhotoOutput.getAvailablePhotoCodecTypes
  // TODO: CapturePhotoCaptureDelegate.didFinishProcessingPhotoSampleBuffer:previewPhotoSampleBuffer:resolvedSettings:bracketSettings:error:
  /// A dictionary describing the processed format (for example, JPEG) to deliver captured photos in.
  ///
  /// This property is read-only—you specify a processed format when creating a
  /// settings object with the [photoSettings], [photoSettingsWithFormat], or
  /// [photoSettingsWithRawPixelFormatType] initializer.
  ///
  /// When capturing images in processed formats, the following requirements
  /// apply:
  ///
  /// This dictionary must contain a value for either the
  /// [kCVPixelBufferPixelFormatTypeKey] (to request an uncompressed format) or
  /// [VideoCodecType] (to request a compressed format such as JPEG) key, but
  /// not both.
  ///
  /// If this dictionary has the [kCVPixelBufferPixelFormatTypeKey] key, the
  /// value for that key must be listed in the photo output’s
  /// [CapturePhotoOutput.getAvailablePhotoPixelFormatTypes] list.
  ///
  /// If this dictionary has the [VideoCodecType] key, the value for that key
  /// must be listed in the photo output’s
  /// [CapturePhotoOutput.getAvailablePhotoCodecTypes] list.
  ///
  /// Your delegate method must implement the
  /// [CapturePhotoCaptureDelegate.captureOutput] method.
  ///
  /// The capture output validates these requirements when you call the
  /// [CapturePhotoOutput.capturePhoto] method. If your settings and delegate do
  /// not meet these requirements, that method raises an exception.
  final Map<String, Object> processedFormat;
}

// TODO: CapturePhotoSettings.livePhotoMovieFileURL
// TODO: didFinishProcessingLivePhotoToMovieFile
// TODO: CaptureResolvedPhotoSettings
// TODO: CaptureResolvedPhotoSettings.uniqueID
/// Methods for monitoring progress and receiving results from a photo capture output.
///
/// You add callbacks to [CapturePhotoCaptureDelegate] to be notified of
/// progress and results when capturing photos with the [CapturePhotoOutput]
/// class.
///
/// To capture a photo, you pass an instance of this class to the
/// [CapturePhotoOutput.capturePhoto] method, along with a settings object that
/// describes the capture to be performed. As the capture proceeds, the photo
/// output calls several of the callbacks in this protocol on your delegate
/// object, providing information about the capture’s progress and delivering
/// the resulting photos.
///
/// Which callbacks methods the photo output calls depends on the photo settings
/// you initiate capture with. All callbacks in this class are optional at
/// compile time, but at run time your delegate object must respond to certain
/// methods depending on your photo settings:
///
///  * If you request a still photo capture (by specifying image formats or file
/// types), your delegate either must implement the [didFinishProcessingPhoto]
/// callback, or must implement callbacks in the class corresponding to whether
/// you request capture in RAW format, processed format, or both.
///
///  * If you request Live Photo capture (by setting the
/// [CapturePhotoSettings.livePhotoMovieFileURL] property to a non-nil value),
/// your delegate must implement the [didFinishProcessingLivePhotoToMovieFile]
/// callback.
///
/// The capture output validates these requirements when you call the
/// [CaptureOutput.capturePhoto] method. If your delegate does not meet these
/// requirements, that method raises an exception.
///
/// You must use a unique [CapturePhotoSettings] object for each capture
/// request. When the photo output calls your delegate methods, it provides an
/// [CaptureResolvedPhotoSettings] object whose `uniqueID` property matches that
/// of the photo settings you requested capture with. When making multiple
/// captures, use this unique ID to determine which delegate method calls
/// correspond to which requests.
///
/// The photo output may call a callback more than once, or not at all,
/// depending on your photo settings. See the description of each callback for
/// details.
@Reference('ios_avfoundation/avfoundation/CapturePhotoCaptureDelegate')
class CapturePhotoCaptureDelegate with $CapturePhotoCaptureDelegate {
  /// Construct a [CapturePhotoCaptureDelegate].
  CapturePhotoCaptureDelegate({required this.didFinishProcessingPhoto}) {
    ChannelRegistrar
        .instance.implementations.channelFinishProcessingPhotoCallback
        .$$create(
      didFinishProcessingPhoto,
      $owner: false,
    );
    _channel.$$create(
      this,
      $owner: true,
      didFinishProcessingPhoto: didFinishProcessingPhoto,
    );
  }

  static $CapturePhotoCaptureDelegateChannel get _channel => ChannelRegistrar
      .instance.implementations.channelCapturePhotoCaptureDelegate;

  // TODO: Create AvFoundationError?
  /// Provides the delegate with the captured image and associated metadata resulting from a photo capture.
  ///
  /// An object containing the captured image pixel buffer, along with any
  /// metadata and attachments captured along with the photo (such as a preview
  /// image or depth map).
  final FinishProcessingPhotoCallback didFinishProcessingPhoto;
}

// TODO: CaptureConnection
/// The abstract superclass for objects that output the media recorded in a capture session.
///
/// [CaptureOutput] provides an abstract interface for connecting capture output
/// destinations, such as files and video previews, to a capture session (an
/// instance of [CaptureSession]). A capture output can have multiple
/// connections represented by [CaptureConnection] objects, one for each stream
/// of media that it receives from an [CaptureInput]. A capture output does not
/// have any connections when it is first created. When you add an output to a
/// capture session, the capture session creates connects that map media data
/// from that session’s inputs to its outputs.
///
/// You can add concrete [CaptureOutput] instances to a capture session using
/// [CaptureSession.addOutput].
@Reference('ios_avfoundation/avfoundation/CaptureOutput')
abstract class CaptureOutput with $CaptureOutput {}

/// A container for image data collected by a photo capture output.
///
/// When you capture photos with the [CapturePhotoOutput] class, your delegate
/// object receives each resulting image and related data in the form of an
/// [CapturePhoto] object. This object is an immutable wrapper from which you
/// can retrieve various results of the photo capture.
///
/// In addition to the photo image pixel buffer, an [CapturePhoto] object can
/// also contain a preview-sized pixel buffer, capture metadata, and, on
/// supported devices, depth data and camera calibration data. From an
/// [CapturePhoto] object, you can generate data appropriate for writing to a
/// file, such as HEVC encoded image data containerized in the HEIC file format
/// and including a preview image, depth data and other attachments.
///
/// An [CapturePhoto] instance wraps a single image result. For example, if you
/// request a bracketed capture of three images, your callback is called three
/// times, each time delivering a single [CapturePhoto] object.
@Reference('ios_avfoundation/avfoundation/CapturePhoto')
class CapturePhoto with $CapturePhoto {
  /// Construct a [CapturePhoto].
  @visibleForTesting
  CapturePhoto(this.fileDataRepresentation);

  /// Generates and returns a flat data representation of the photo and its attachments.
  ///
  /// Data appropriate for writing to a file of the type specified when
  /// requesting photo capture, or null if the photo and attachment data cannot
  /// be flattened.
  ///
  /// When you request a photo capture with the
  /// [CapturePhotoOutput.capturePhotoWithSettings] method, the
  /// [CapturePhotoSettings] object you provide specifies image data formats
  /// (such as JPEG and HEVC) and container file formats (such as JFIF and HEIF)
  /// for the resulting image file. Calling this method formats and packages the
  /// image pixel buffer, along with metadata and other attachments created
  /// during capture (such as preview photos and depth maps), into data
  /// appropriate for writing to a file of that type.
  final Uint8List? fileDataRepresentation;
}

// TODO: should construct error check and await
/// A capture input that provides media from a capture device to a capture session.
///
/// [CaptureDeviceInput] is a concrete subclass of [CaptureInput] that you use
/// to capture data from an [CaptureDevice] object.
@Reference('ios_avfoundation/avfoundation/CaptureDeviceInput')
class CaptureDeviceInput extends CaptureInput with $CaptureDeviceInput {
  /// Construct a [CaptureDeviceInput].
  CaptureDeviceInput(this.device) {
    _channel.$$create(this, $owner: true, device: device);
  }

  static $CaptureDeviceInputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureDeviceInput;

  /// The input’s associated capture device.
  final CaptureDevice device;
}

// TODO: CaptureInputPort
/// The abstract superclass for objects that provide input data to a capture session.
///
/// To associate an [CaptureInput] object with a session, call
/// [CaptureSession.addInput] on the session.
///
/// [CaptureInput] objects have one or more ports (instances of
/// [CaptureInputPort]), one for each data stream they can produce. For example,
/// a [CaptureDevice] object presenting one video data stream has one port.
@Reference('ios_avfoundation/avfoundation/CaptureInput')
abstract class CaptureInput with $CaptureInput {}

// TODO: CaptureDevice.defaultDeviceWithMediaType(
// TODO: MediaType.audio
// TODO: fix example code
// TODO: captureSession.canAddInput
// TODO: sessionPreset
/// An object that manages capture activity and coordinates the flow of data from input devices to capture outputs.
///
/// To perform real-time capture, you instantiate an [CaptureSession] object and
/// add appropriate inputs and outputs. The following code fragment illustrates
/// how to configure a capture device to record audio.
///
/// ```dart
/// // Create the capture session.
/// final CaptureSession captureSession = CaptureSession();
///
/// // Lookup the default audio device.
/// final CaptureDevice audioDevice =
///     CaptureDevice.defaultDeviceWithMediaType(MediaType.audio);
///
/// final CaptureDeviceInput audioInput = CaptureDeviceInput(audioDevice);
///
/// if (await captureSession.canAddInput(audioInput)) {
///   captureSession.addInput(audioInput);
/// }
/// ```
///
/// You invoke [startRunning] to start the flow of data from the inputs to the
/// outputs, and invoke [stopRunning] to stop the flow.
///
/// You use the [setSessionPreset] method to customize the quality level,
/// bitrate, or other settings for the output. Most common capture
/// configurations are available through session presets; however, some
/// specialized options (such as high frame rate) require directly setting a
/// capture format on an [CaptureDevice] instance.
@Reference('ios_avfoundation/avfoundation/CaptureSession')
class CaptureSession with $CaptureSession {
  /// Construct a [CaptureSession].
  CaptureSession() {
    _channel.$$create(this, $owner: true);
  }

  static $CaptureSessionChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureSession;

  // TODO: can add input
  /// Adds a given input to the session.
  ///
  /// You can only add an input to a session using this method if [canAddInput]
  /// returns true. This method throws an exception when invoked and
  /// [canAddInput] returns false.
  ///
  /// You can invoke this method while the session is running.
  Future<void> addInput(covariant CaptureInput input) {
    return _channel.$addInput(this, input);
  }

  // TODO: can add output
  /// Adds a given output to the session.
  ///
  /// You can only add an output to a session using this method if
  /// [canAddOutput] returns true. This method throws an exception when invoked
  /// and [canAddOutput] returns false.
  ///
  /// You can invoke this method while the session is running.
  Future<void> addOutput(covariant CaptureOutput output) {
    return _channel.$addOutput(this, output);
  }

  /// Tells the receiver to start running.
  ///
  /// This method is used to start the flow of data from the inputs to the
  /// outputs connected to the [CaptureSession] instance that is the receiver.
  // If an error occurs during this process and the receiver fails to start
  // running, you receive an AVCaptureSessionRuntimeErrorNotification.
  Future<void> startRunning() => _channel.$startRunning(this);

  /// Tells the receiver to stop running.
  ///
  /// This method is used to stop the flow of data from the inputs to the
  /// outputs connected to the [CaptureSession] instance that is the receiver.
  Future<void> stopRunning() => _channel.$stopRunning(this);

  /// A constant value indicating the quality level or bit rate of the output.
  ///
  /// You use this property to customize the quality level or bit rate of the
  /// output. For possible values of `sessionPreset`, see
  /// [CaptureSessionPreset]. The default value is [CaptureSessionPreset.high].
  ///
  /// You can set this value while the session is running.
  ///
  /// You can only set a preset if [canSetSessionPresets] contains that preset.
  Future<void> setSessionPreset(String preset) {
    return _channel.$setSessionPreset(this, preset);
  }

  /// Returns a subset of preset values that indicates which presets can be used by the session.
  Future<List<String>> canSetSessionPresets(List<String> presets) async {
    final List<Object?> returnedPresets =
        await _channel.$canSetSessionPresets(this, presets) as List<Object?>;
    return returnedPresets.cast<String>();
  }
}

// TODO: lockForConfiguration
// TODO: unlockForConfiguration
// TODO: all methods in code sample
// TODO: setActiveFormat
// TODO: AVCaptureSessionPresetInputPriority
// TODO: CaptureSession.commitConfiguration
/// A device that provides input (such as audio or video) for capture sessions and offers controls for hardware-specific capture features.
///
/// A [CaptureDevice] object represents a physical capture device and the
/// properties associated with that device. You use a capture device to
/// configure the properties of the underlying hardware. A capture device also
/// provides input data (such as audio or video) to an [CaptureSession] object.
///
/// You use the methods of the [CaptureDevice] class to enumerate the available
/// devices, query their capabilities, and be informed about when devices come
/// and go. Before you attempt to set properties of a capture device
/// (its focus mode, exposure mode, and so on), you must first acquire a lock on
/// the device using the [lockForConfiguration] method. You should also query
/// the device’s capabilities to ensure that the new modes you intend to set are
/// valid for that device. You can then set the properties and release the lock
/// using the [unlockForConfiguration] method. You may hold the lock if you want
/// all settable device properties to remain unchanged. However, holding the
/// device lock unnecessarily may degrade capture quality in other applications
/// sharing the device and is not recommended.
///
/// Most common configurations of capture settings are available through the
/// [CaptureSession] object and its available presets. However, on iOS devices,
/// some specialized options (such as high frame rate) require directly setting
/// a capture format on an [CaptureDevice] instance. The following code example
/// illustrates how to select an iOS device’s highest possible frame rate:
///
/// ```dart
/// func configureCameraForHighestFrameRate(device: AVCaptureDevice) {
///
///   var bestFormat: AVCaptureDevice.Format?
///   var bestFrameRateRange: AVFrameRateRange?
///
///   for format in device.formats {
///       for range in format.videoSupportedFrameRateRanges {
///           if range.maxFrameRate > bestFrameRateRange?.maxFrameRate ?? 0 {
///               bestFormat = format
///               bestFrameRateRange = range
///           }
///       }
///   }
///
///   if let bestFormat = bestFormat,
///      let bestFrameRateRange = bestFrameRateRange {
///       do {
///           try device.lockForConfiguration()
///
///           // Set the device's active format.
///           device.activeFormat = bestFormat
///
///           // Set the device's min/max frame duration.
///           let duration = bestFrameRateRange.minFrameDuration
///           device.activeVideoMinFrameDuration = duration
///           device.activeVideoMaxFrameDuration = duration
///
///           device.unlockForConfiguration()
///       } catch {
///           // Handle error.
///       }
///   }
/// }
/// ```
///
/// In iOS, directly configuring a capture device’s [setActiveFormat] changes
/// the capture session’s preset to [CaptureSessionPreset.inputPriority]. Upon
/// making this change, the capture session no longer automatically configures
/// the capture format when you call the [startRunning] method or call the
/// [CaptureSession.commitConfiguration] method after changing the session
/// topology.
///
/// In macOS, a capture session can still automatically configure the capture
/// format after you make changes. To prevent automatic changes to the capture
/// format in macOS, follow the advice listed under the [lockForConfiguration]
/// method.
@Reference('ios_avfoundation/avfoundation/CaptureDevice')
class CaptureDevice with $CaptureDevice {
  /// Construct a [CaptureDevice].
  ///
  // ignore: deprecated_member_use_from_same_package
  /// This is only visible for testing. See [devicesWithMediaType].
  @visibleForTesting
  CaptureDevice({required this.uniqueId, required this.position});

  static $CaptureDeviceChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureDevice;

  /// An ID unique to the model of device corresponding to the receiver.
  ///
  /// Every available capture device has a unique ID that persists on one system
  /// across device connections and disconnections, application restarts, and
  /// reboots of the system itself. You can store the value returned by this
  /// property to recall or track the status of a specific device in the future.
  final String uniqueId;

  /// Indicates the physical position of the device hardware on the system.
  ///
  /// You can observe changes to the value of this property using Key-value
  /// observing.
  ///
  /// See [CaptureDevicePosition] for possible values.
  final int position;

  // TODO: defaultDeviceWithDeviceType
  /// Returns the default device used to capture data of a given media type.
  ///
  /// `mediaType`: A media type identifier. See [MediaType].
  ///
  /// When you use this method to request a camera (using the [MediaType.video]
  /// media type), the returned device is always of the
  /// [CaptureDeviceType.builtInWideAngleCamera] device type. To request other
  /// device types, use the [CaptureDevice.defaultDeviceWithDeviceType]
  /// method instead.
  static Future<CaptureDevice?> defaultDeviceWithMediaType(
    String mediaType,
  ) async {
    return await _channel.$defaultDeviceWithMediaType(mediaType)
        as CaptureDevice?;
  }

  @ReferenceMethod(ignore: true)
  @override
  String toString() {
    return 'CaptureDevice(uniqueId: $uniqueId, position: $position)';
  }
}

/// A query for finding and monitoring available capture devices.
///
/// Use this class to find all available capture devices matching a specific
/// device type (such as microphone or wide-angle camera), supported media types
/// for capture (such as audio, video, or both), and position (front- or
/// back-facing).
///
/// After creating a device discovery session, you can inspect its devices list
/// to choose a device for capture.
@Reference('ios_avfoundation/avfoundation/CaptureDeviceDiscoverySession')
class CaptureDeviceDiscoverySession with $CaptureDeviceDiscoverySession {
  /// Construct a [CaptureDeviceDiscoverySession].
  ///
  /// This only visible for testing. See [discoverySessionWithDeviceTypes].
  @visibleForTesting
  CaptureDeviceDiscoverySession({
    required this.devices,
    required this.supportedMultiCamDeviceSets,
  });

  static $CaptureDeviceDiscoverySessionChannel get _channel => ChannelRegistrar
      .instance.implementations.channelCaptureDeviceDiscoverySession;

  /// Creates a discovery session for finding devices with the specified criteria.
  ///
  /// `deviceTypes`: A list of device types to search for, such as
  /// [CaptureDeviceType.builtInMicrophone] and
  /// [CaptureDeviceType.builtInWideAngleCamera]. This list must contain at
  /// least one valid [CaptureDeviceType] value.
  ///
  /// `mediaType`: The media type to capture, such as [MediaType.audio]. Pass
  /// `null` to search for devices regardless of supported media types.
  ///
  /// `position`: The position of capture device to search for, relative to
  /// system hardware (front- or back-facing). See [CaptureDevicePosition]. Pass
  /// [CaptureDevicePosition.unspecified] to search for devices regardless of
  /// position.
  ///
  /// After creating a device discovery session, read its devices array to
  /// examine matching devices and choose one for capture.
  static Future<CaptureDeviceDiscoverySession> discoverySessionWithDeviceTypes({
    required List<String> deviceTypes,
    String? mediaType,
    required int position,
  }) async {
    assert(deviceTypes.isNotEmpty);
    return await _channel.$discoverySessionWithDeviceTypes(
      deviceTypes,
      mediaType,
      position,
    ) as CaptureDeviceDiscoverySession;
  }

  /// A list of currently available devices matching the session’s criteria.
  ///
  /// This property contains only capture devices that are currently available
  /// and that meet the criteria you specified when creating the device
  /// discovery session with [discoverySessionWithDeviceTypes].
  ///
  /// In iOS 11.0 and later, the order of this list matches that of the
  /// deviceTypes parameter that you used to create the discovery session, so
  /// you can quickly choose a device matching your preferred types (see Sort
  /// and Filter Devices with a Discovery Session). In older iOS versions,
  /// search the entire array to find preferred devices.
  final List<CaptureDevice> devices;

  // TODO: [CaptureMultiCamSession]
  /// A list of lists of capture devices that you can use simultaneously in a multi-camera session.
  ///
  /// You may use multiple cameras as device inputs to an
  /// [CaptureMultiCamSession], as long as one of the supported multi-camera
  /// device sets includes the device.
  ///
  /// This is only supported on iOS 13+. This list will always be empty for
  /// iOS version < 13.
  final List<Set<CaptureDevice>> supportedMultiCamDeviceSets;
}

/// Widget for displaying preview frames from a [CaptureSession].
class Preview extends UiKitReferenceWidget {
  /// Construct a [Preview].
  Preview({Key? key, required this.controller})
      : super(key: key, instance: controller);

  /// Controls the underlying iOS UIView that displays the preview frames.
  final PreviewController controller;
}

/// Controls an iOS UIView that displays frames from a [CaptureSession].
///
/// See: [Preview]
@Reference('ios_avfoundation/avfoundation/PreviewController')
class PreviewController with $PreviewController {
  /// Construct a [PreviewController].
  PreviewController(this.captureSession) {
    _channel.$$create(this, $owner: true, captureSession: captureSession);
  }

  static $PreviewControllerChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelPreviewController;

  /// The [CaptureSession] that provides preview frames to the iOS UiView.
  final CaptureSession captureSession;
}

// TODO: CaptureFileOutputDelegate.captureOutput is for MacOS
// TODO: CaptureAudioFileOutput
/// The abstract superclass for capture outputs that can record captured data to a file.
///
/// This abstract superclass defines the interface for outputs that record media
/// samples to files. File outputs can start recording to a new file using the
/// [startRecordingToOutputFileURL] method. On successive
/// invocations of this method on Mac OS X, the output file can by changed
/// dynamically without losing media samples. A file output can stop recording
/// using the stopRecording method. Because files are recorded in the
/// background, applications will need to specify a delegate for each new file
/// so that they can be notified when recorded files are finished.
///
/// On Mac OS X, clients can also set a delegate on the file output itself that
/// can be used to control recording along exact media sample boundaries using
/// the [CaptureFileOutputDelegate.captureOutput] method.
///
/// The concrete subclasses of [CaptureFileOutput] are [CaptureMovieFileOutput],
/// which records media to a QuickTime movie file, and [CaptureAudioFileOutput],
/// which writes audio media to a variety of audio file formats.
@Reference('ios_avfoundation/avfoundation/CaptureFileOutput')
abstract class CaptureFileOutput extends CaptureOutput with $CaptureFileOutput {
  static $CaptureFileOutputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureFileOutput;

  // TODO: support URL is ReferenceMessageCodec in reference plugin
  /// The file URL of the file to which the receiver is currently recording incoming buffers.
  Future<Uri> outputFileURL() async {
    return Uri.dataFromString(await _channel.$outputFileURL(this) as String);
  }

  // TODO: CaptureFileOutputRecordingDelegate.captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
  /// Specifies the maximum size, in bytes, of the data that should be recorded by the receiver.
  ///
  /// This property specifies a hard limit on the data size of recorded files.
  /// Recording is stopped when the limit is reached and the
  /// [CaptureFileOutputRecordingDelegate.captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:]
  /// delegate method is invoked with an appropriate error. The default value of
  /// this property is 0, which indicates no limit.
  Future<void> setMaxRecordedFileSize(int fileSize) {
    return _channel.$setMaxRecordedFileSize(this, fileSize);
  }

  /// Indicates whether recording is in progress.
  ///
  /// The value of this property is true when the file output currently has a
  /// file to which it is writing new samples, false otherwise.
  Future<bool> isRecording() async {
    return await _channel.$isRecording(this) as bool;
  }

  // TODO: MacOS -> captureOutput:didOutputSampleBuffer:fromConnection:
  // TODO: delegate.captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
  /// Starts recording media to the specified output URL.
  ///
  /// [outputFileURL]: This method throws aa [PlatformException] if the argument
  /// isn’t a valid file URL.
  ///
  /// [delegate]: A delegate object that’s notified of changes to the recording
  /// state.
  ///
  /// A failure occurs if you attempt to record to a URL where a file exists. To
  /// overwrite the content, delete the old file before calling this method.
  ///
  /// In macOS, calling this method from within the
  /// captureOutput:didOutputSampleBuffer:fromConnection: method guarantees that
  /// the first samples written to the new file are those passed to the delegate
  /// method.
  ///
  /// When you stop recording by calling [stopRecording], by changing files
  /// using this method, or because of an error, the framework writes any
  /// remaining file data in the background. Therefore, for the system to notify
  /// you upon completion, you must adopt the
  /// captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
  /// delegate method. The recording delegate can also optionally implement
  /// methods that inform it when the output object starts writing data, when it
  /// pauses or resumes recording, and when it’s about to finish recording.
  ///
  /// In macOS, you don’t need to call [stopRecording] before calling this
  /// method while another recording is in progress. If you call this method
  /// while the output object is recording, the framework preserves media
  /// samples between the old file and the new file. In iOS, to avoid any
  /// errors, you must call [stopRecording] before calling this method again.
  Future<void> startRecordingToOutputFileURL(
    String outputFileURL,
    CaptureFileOutputRecordingDelegate delegate,
  ) {
    return _channel.$startRecordingToOutputFileURL(
      this,
      outputFileURL,
      delegate,
    );
  }

  // TODO: delegate.captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
  /// Tells the receiver to stop recording to the current file.
  ///
  /// You can call this method when they want to stop recording new samples to
  /// the current file, and do not want to continue recording to another file.
  /// If you want to switch from one file to another, you should not call this
  /// method. Instead you should simply call [startRecordingToOutputFileURL]
  /// with the new file URL.
  ///
  /// When recording is stopped either by calling this method, by changing files
  /// using [startRecordingToOutputFileURL], or because of an error, the
  /// remaining data that needs to be included to the file will be written in
  /// the background. Therefore, before using the file, you must wait until the
  /// delegate that was specified in [startRecordingToOutputFileURL] is notified
  /// when all data has been written to the file using the
  /// [captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:]
  /// method.
  ///
  /// In macOS, if this method is called within the
  /// [captureOutput:didOutputSampleBuffer:fromConnection:] delegate method, the
  /// last samples written to the current file are guaranteed to be those that
  /// were output immediately before those in the sample buffer passed to that
  /// method.
  Future<void> stopRecording() {
    return _channel.$stopRecording(this);
  }
}

// TODO: kCMTimeZero
// TODO: timeMapping.target.start?
// TODO: CMTimeRangeGetEnd
// TODO: AVCompositionTrackSegment
// TODO: MutableCompositionTrack.validateTrackSegments:error:
// TODO: CaptureVideoDataOutput
// TODO: CaptureSession.automaticallyConfiguresCaptureDeviceForWideColor
/// A capture output that records video and audio to a QuickTime movie file.
///
/// This class is the movie file equivalent of [CapturePhotoOutput]. Use it to
/// export or save movie files from capture session content.
///
/// The timeMapping.target.start of the first track segment must be kCMTimeZero,
/// and the timeMapping.target.start of each subsequent track segment must equal
/// [CMTimeRangeGetEnd], when passing in the previous [CompositionTrackSegment]'s
/// timeMapping.target. You can use validateTrackSegments:error: to ensure that
/// an array of track segments conforms to this rule.
///
/// Starting in iOS 12, photo formats no longer list the
/// [CaptureMovieFileOutput] as being unsupported. If you construct a session
/// with a photo format as input and a movie file output, you can record movies.
/// The resolution of the video track in the movie follows the conventions
/// established by the [CaptureVideoDataOutput]; namely, when using the photo
/// preset, you receive video buffers with size approximating the screen size.
/// Video outputs are a proxy for photo preview in this configuration.
///
/// If you set the [CaptureDevice] format to a high-resolution photo format, you
/// receive full-resolution (5, 8, or 12 MP depending on the device) video
/// buffers into your movie. If the capture session’s
/// [automaticallyConfiguresCaptureDeviceForWideColor] property is true, the
/// session selects sRGB as the video colorspace in your movie. You can override
/// this behavior by adding an [CapturePhotoOutput] to your session and
/// configuring its photo format or [CaptureSessionPreset.photo] preset for a
/// photo output.
@Reference('ios_avfoundation/avfoundation/CaptureMovieFileOutput')
class CaptureMovieFileOutput extends CaptureFileOutput
    with $CaptureMovieFileOutput {
  static $CaptureMovieFileOutputChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCaptureMovieFileOutput;

  // TODO: setOutputSettings
  /// The video codec types currently supported for recording movie files.
  ///
  /// The first codec in this list is the default for recording movie files. To
  /// record using a different codec, call the [setOutputSettings] method,
  /// passing a video settings dictionary with a value for
  /// [VideoSettingsKeys.videoCodec] that matches one of the other values in
  /// this list.
  Future<List<String>> availableVideoCodecTypes() async {
    final List<Object?> codecTypes =
        await _channel.$availableVideoCodecTypes(this) as List<Object?>;
    return codecTypes.cast<String>();
  }
}

/// Methods for responding to events that occur while recording captured media to a file.
///
/// Defines an interface for delegates of [CaptureFileOutput] to respond to
/// events that occur in the process of recording a single file.
///
/// The delegate of an [CaptureFileOutput] object must adopt the
/// [CaptureFileOutputRecordingDelegate] protocol.
@Reference('ios_avfoundation/avfoundation/CaptureFileOutputRecordingDelegate')
class CaptureFileOutputRecordingDelegate
    with $CaptureFileOutputRecordingDelegate {
  // ignore: unused_element
  static $CaptureFileOutputRecordingDelegateChannel get _channel =>
      ChannelRegistrar
          .instance.implementations.channelCaptureFileOutputRecordingDelegate;
}
