import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:reference/annotations.dart';

import 'camera.g.dart';
import 'camera_channels.dart';

/// The [Camera] class is used to set image capture settings, start/stop preview, snap pictures, and retrieve frames for encoding for video.
///
/// This class is a client for the Camera service, which manages the actual
/// camera hardware.
///
/// This uses the [Camera](https://developer.android.com/reference/android/hardware/Camera)
/// API and is deprecated for Android versions 21+.
@Reference('penguin_android_camera/camera/Camera')
class Camera with $Camera {
  @visibleForTesting
  /// Default constructor for [Camera].
  ///
  /// This should only be used when subclassing. Otherwise, an instance should
  /// be provided from [open].
  Camera();

  static CameraChannel get _channel =>
      ChannelRegistrar.instance.implementations.cameraChannel as CameraChannel;

  int? _currentTexture;

  /// Returns the information about each camera.
  static Future<List<CameraInfo>> getAllCameraInfo() async {
    final List<Object?> allInfo =
        await _channel.$invokeGetAllCameraInfo() as List<Object?>;
    return allInfo.cast<CameraInfo>();
  }

  /// Creates a new [Camera] object to access a particular hardware camera.
  ///
  /// If the same camera is opened by other applications, this will throw a
  /// [PlatformException].
  ///
  /// You must call [Camera.release] when you are done using the camera, otherwise it
  /// will remain locked and be unavailable to other applications. Your
  /// application should only have one [Camera] object active at a time for a
  /// particular hardware camera.
  static Future<Camera> open(int cameraId) async {
    return await _channel.$invokeOpen(cameraId) as Camera;
  }

  /// Disconnects and releases the [Camera] object resources.
  ///
  /// You must call this as soon as you're done with the [Camera] object.
  @override
  Future<void> release() => _channel.$invokeRelease(this);

  /// Starts capturing and drawing preview frames to the screen.
  ///
  /// Preview will not actually start until a texture is supplied with
  /// [addToTexture].
  @override
  Future<void> startPreview() => _channel.$invokeStartPreview(this);

  /// Stops capturing and drawing preview frames to the surface.
  ///
  /// Resets the camera for a future call to [startPreview].
  @override
  Future<void> stopPreview() => _channel.$invokeStopPreview(this);

  @override
  Future<int> attachPreviewTexture() async {
    return _currentTexture ??=
        await _channel.$invokeAttachPreviewTexture(this) as int;
  }

  @override
  Future<void> releasePreviewTexture() async {
    _currentTexture = null;
    await _channel.$invokeReleasePreviewTexture(this);
  }

  @override
  Future<void> unlock() {
    return _channel.$invokeUnlock(this);
  }

  @override
  Future<void> takePicture(
    covariant ShutterCallback? shutter,
    covariant PictureCallback? raw,
    covariant PictureCallback? postView,
    covariant PictureCallback? jpeg,
  ) async {
    assert(raw == null || (raw != postView && raw != jpeg));
    assert(postView == null || (postView != raw && postView != jpeg));
    assert(jpeg == null || (jpeg != raw && jpeg != postView));

    await _channel.$invokeTakePicture(
      this,
      shutter,
      raw,
      postView,
      jpeg,
    );
  }
}

@Reference('penguin_android_camera/camera/ShutterCallback')
abstract class ShutterCallback with $ShutterCallback {
  ShutterCallback() {
    ChannelRegistrar.instance.implementations.shutterCallbackChannel
        .createNewInstancePair(this, owner: false);
  }

  @override
  void onShutter();
}

@Reference('penguin_android_camera/camera/PictureCallback')
abstract class PictureCallback with $PictureCallback {
  PictureCallback() {
    ChannelRegistrar.instance.implementations.pictureCallbackChannel
        .createNewInstancePair(this, owner: false);
  }

  @override
  void onPictureTaken(Uint8List data);
}

/// Information about a camera.
///
/// Retrieve by calling [Camera.getAllCameraInfo].
@Reference('penguin_android_camera/camera/CameraInfo')
class CameraInfo with $CameraInfo {
  CameraInfo({
    required this.cameraId,
    required this.facing,
    required this.orientation,
  }) : assert(facing == cameraFacingBack || facing == cameraFacingFront);

  /// The facing of the camera is opposite to that of the screen.
  static const int cameraFacingBack = 0;

  /// The facing of the camera is the same as that of the screen.
  static const int cameraFacingFront = 1;

  /// The identifier for this camera device.
  ///
  /// This can be used in [Camera.open].
  @override
  final int cameraId;

  /// The direction that the camera faces.
  ///
  /// It should be [CameraInfo.cameraFacingBack] or
  /// [CameraInfo.cameraFacingFront].
  @override
  final int facing;

  /// The orientation of the camera image.
  ///
  /// The value is the angle that the camera image needs to be rotated clockwise
  /// so it shows correctly on the display in its natural orientation. It should
  /// be 0, 90, 180, or 270.
  ///
  /// For example, suppose a device has a naturally tall screen. The back-facing
  /// camera sensor is mounted in landscape. You are looking at the screen.
  /// If the top side of the camera sensor is aligned with the right edge of the
  /// screen in natural orientation, the value should be 90. If the top side of
  /// a front-facing camera sensor is aligned with the right of the screen,
  /// the value should be 270.
  @override
  final int orientation;
}

abstract class OutputFormat {
  OutputFormat._();

  static const int mpeg4 = 0x00000002;
}

abstract class VideoEncoder {
  static const int mpeg4Sp = 0x00000003;
}

abstract class AudioSource {
  static const int defaultSource = 0x00000000;
}

abstract class AudioEncoder {
  static const int amrNb = 0x00000001;
}

abstract class VideoSource {
  static const int camera = 0x00000001;
}

@Reference('penguin_android_camera/camera/MediaRecorder')
class MediaRecorder implements $MediaRecorder {
  MediaRecorder() {
    _channel.createNewInstancePair(this, owner: true);
  }

  static MediaRecorderChannel get _channel =>
      ChannelRegistrar.instance.implementations.mediaRecorderChannel
          as MediaRecorderChannel;

  @override
  Future<void> setCamera(covariant Camera camera) =>
      _channel.$invokeSetCamera(this, camera);

  @override
  Future<void> setVideoSource(int source) =>
      _channel.$invokeSetVideoSource(this, source);

  @override
  Future<void> setOutputFilePath(String path) =>
      _channel.$invokeSetOutputFilePath(this, path);

  @override
  Future<void> setOutputFormat(int format) =>
      _channel.$invokeSetOutputFormat(this, format);

  @override
  Future<void> setVideoEncoder(int encoder) =>
      _channel.$invokeSetVideoEncoder(this, encoder);

  @override
  Future<void> setAudioSource(int source) =>
      _channel.$invokeSetAudioSource(this, source);

  @override
  Future<void> setAudioEncoder(int encoder) =>
      _channel.$invokeSetAudioEncoder(this, encoder);

  @override
  Future<void> prepare() => _channel.$invokePrepare(this);

  @override
  Future<void> start() => _channel.$invokeStart(this);

  @override
  Future<void> stop() => _channel.$invokeStop(this);

  @override
  Future<void> release() => _channel.$invokeRelease(this);
}
