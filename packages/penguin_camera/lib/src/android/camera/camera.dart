import 'dart:async';

import 'package:flutter/services.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'camera.g.dart';

void initializeChannels() {
  Camera._channel; // ignore: unnecessary_statements
  CameraInfo._channel; // ignore: unnecessary_statements
}

/// The [Camera] class is used to set image capture settings, start/stop preview, snap pictures, and retrieve frames for encoding for video.
///
/// This class is a client for the Camera service, which manages the actual
/// camera hardware.
///
/// This uses the [Camera](https://developer.android.com/reference/android/hardware/Camera)
/// API and is deprecated for Android versions 21+.
@Reference('penguin_camera/android/camera/Camera')
class Camera with $Camera {
  Camera();

  static final $CameraChannel _channel = $CameraChannel(
    MethodChannelMessenger.instance,
  )..setHandler($CameraHandler(onCreate: (_, __) => Camera()));

  int? _currentTexture;

  /// Returns the information about each camera.
  static Future<List<CameraInfo>> getAllCameraInfo() async {
    final List<Object> allInfo =
        await _channel.$invokeGetAllCameraInfo() as List<Object>;
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
  Future<void> release() {
    if (!_channel.messenger.isPaired(this)) return Future<void>.value();

    _channel.$invokeRelease(this);
    return _channel.disposeInstancePair(this);
  }

  /// Starts capturing and drawing preview frames to the screen.
  ///
  /// Preview will not actually start until a texture is supplied with
  /// [addToTexture].
  Future<void> startPreview() async {
    assert(_channel.messenger.isPaired(this));
    _channel.$invokeStartPreview(this);
  }

  /// Stops capturing and drawing preview frames to the surface.
  ///
  /// Resets the camera for a future call to [startPreview].
  Future<void> stopPreview() async {
    assert(_channel.messenger.isPaired(this));
    await _channel.$invokeStopPreview(this);
  }

  Future<int> attachPreviewToTexture() async {
    assert(_channel.messenger.isPaired(this));
    return _currentTexture ??=
        await _channel.$invokeAttachPreviewToTexture(this) as int;
  }

  Future<void> releaseTexture() async {
    assert(_channel.messenger.isPaired(this));
    _currentTexture = null;
    await _channel.$invokeReleaseTexture(this);
  }
}

/// Information about a camera.
///
/// Retrieve by calling [Camera.getAllCameraInfo].
@Reference('penguin_camera/android/camera/CameraInfo')
class CameraInfo with $CameraInfo {
  CameraInfo({
    required this.cameraId,
    required this.facing,
    required this.orientation,
  }) : assert(facing == CAMERA_FACING_BACK || facing == CAMERA_FACING_FRONT);

  static final $CameraInfoChannel _channel = $CameraInfoChannel(
    MethodChannelMessenger.instance,
  )..setHandler($CameraInfoHandler(
      onCreate: (_, $CameraInfoCreationArgs args) {
        return CameraInfo(
          cameraId: args.cameraId,
          facing: args.facing,
          orientation: args.orientation,
        );
      },
    ));

  /// The facing of the camera is opposite to that of the screen.
  static const int CAMERA_FACING_BACK = 0;

  /// The facing of the camera is the same as that of the screen.
  static const int CAMERA_FACING_FRONT = 1;

  /// The identifier for this camera device.
  ///
  /// This can be used in [Camera.open].
  final int cameraId;

  /// The direction that the camera faces.
  ///
  /// It should be [CameraInfo.CAMERA_FACING_BACK] or
  /// [CameraInfo.CAMERA_FACING_FRONT].
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
  final int orientation;
}
