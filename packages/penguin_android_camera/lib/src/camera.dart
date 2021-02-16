import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'camera.g.dart';

/// The [Camera] class is used to set image capture settings, start/stop preview, snap pictures, and retrieve frames for encoding for video.
///
/// This class is a client for the Camera service, which manages the actual
/// camera hardware.
///
/// This uses the [Camera](https://developer.android.com/reference/android/hardware/Camera)
/// API and is deprecated for Android versions 21+.
@Reference('penguin_android_camera/camera/Camera')
class Camera with $Camera {
  /// Default constructor for [Camera].
  ///
  /// This should only be used when subclassing. Otherwise, an instance will be
  /// provided from [open].
  Camera();

  int? _currentTexture;

  /// Returns the information about each camera.
  static Future<List<CameraInfo>> getAllCameraInfo() async {
    final List<Object> allInfo =
        await Channels.cameraChannel.$invokeGetAllCameraInfo() as List<Object>;
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
    return await Channels.cameraChannel.$invokeOpen(cameraId) as Camera;
  }

  /// Disconnects and releases the [Camera] object resources.
  ///
  /// You must call this as soon as you're done with the [Camera] object.
  @override
  Future<void> release() {
    if (!Channels.cameraChannel.messenger.isPaired(this)) {
      return Future<void>.value();
    }

    Channels.cameraChannel.$invokeRelease(this);
    return Channels.cameraChannel.disposeInstancePair(this);
  }

  /// Starts capturing and drawing preview frames to the screen.
  ///
  /// Preview will not actually start until a texture is supplied with
  /// [addToTexture].
  @override
  Future<void> startPreview() async {
    assert(Channels.cameraChannel.messenger.isPaired(this));
    await Channels.cameraChannel.$invokeStartPreview(this);
  }

  /// Stops capturing and drawing preview frames to the surface.
  ///
  /// Resets the camera for a future call to [startPreview].
  @override
  Future<void> stopPreview() async {
    assert(Channels.cameraChannel.messenger.isPaired(this));
    await Channels.cameraChannel.$invokeStopPreview(this);
  }

  @override
  Future<int> attachPreviewTexture() async {
    assert(Channels.cameraChannel.messenger.isPaired(this));
    return _currentTexture ??=
        await Channels.cameraChannel.$invokeAttachPreviewTexture(this) as int;
  }

  @override
  Future<void> releasePreviewTexture() async {
    assert(Channels.cameraChannel.messenger.isPaired(this));
    _currentTexture = null;
    await Channels.cameraChannel.$invokeReleasePreviewTexture(this);
  }

  @override
  Future<void> unlock() {
    return Channels.cameraChannel.$invokeUnlock(this);
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

    if (shutter != null) {
      Channels.shutterCallbackChannel.createNewInstancePair(shutter);
    }
    if (raw != null) {
      Channels.pictureCallbackChannel.createNewInstancePair(raw);
    }
    if (postView != null) {
      Channels.pictureCallbackChannel.createNewInstancePair(postView);
    }
    if (jpeg != null) {
      Channels.pictureCallbackChannel.createNewInstancePair(jpeg);
    }

    await Channels.cameraChannel.$invokeTakePicture(
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
  @override
  void onShutter();
}

@Reference('penguin_android_camera/camera/PictureCallback')
abstract class PictureCallback with $PictureCallback {
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

@Reference('penguin_android_camera/camera/MediaRecorder')
class MediaRecorder implements $MediaRecorder {
  MediaRecorder({
    required this.camera,
    required this.outputFormat,
    required this.outputFilePath,
    required this.videoEncoder,
  });

  @override
  final Camera camera;

  @override
  final String outputFilePath;

  @override
  final int outputFormat;

  @override
  final int videoEncoder;

  @override
  Future<void> prepare() {
    Channels.mediaRecorderChannel.createNewInstancePair(this);
    return Channels.mediaRecorderChannel.$invokePrepare(this);
  }

  @override
  Future<void> start() {
    assert(Channels.mediaRecorderChannel.messenger.isPaired(this));
    return Channels.mediaRecorderChannel.$invokeStart(this);
  }

  @override
  Future<void> stop() {
    assert(Channels.mediaRecorderChannel.messenger.isPaired(this));
    return Channels.mediaRecorderChannel.$invokeStop(this);
  }

  @override
  Future<void> release() async {
    if (!Channels.mediaRecorderChannel.messenger.isPaired(this)) return;

    Channels.mediaRecorderChannel.$invokeRelease(this);
    await Channels.mediaRecorderChannel.disposeInstancePair(this);
  }
}

abstract class Channels {
  Channels._();

  static CameraChannel cameraChannel = CameraChannel(
    MethodChannelMessenger.instance,
  )..setHandler(CameraHandler());

  static CameraInfoChannel cameraInfoChannel = CameraInfoChannel(
    MethodChannelMessenger.instance,
  )..setHandler(CameraInfoHandler());

  static ShutterCallbackChannel shutterCallbackChannel = ShutterCallbackChannel(
    MethodChannelMessenger.instance,
  )..setHandler(ShutterCallbackHandler());

  static PictureCallbackChannel pictureCallbackChannel = PictureCallbackChannel(
    MethodChannelMessenger.instance,
  )..setHandler(PictureCallbackHandler());

  static MediaRecorderChannel mediaRecorderChannel = MediaRecorderChannel(
    MethodChannelMessenger.instance,
  )..setHandler(MediaRecorderHandler());
}

class CameraChannel extends $CameraChannel {
  CameraChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CameraInfoChannel extends $CameraInfoChannel {
  CameraInfoChannel(TypeChannelMessenger messenger) : super(messenger);
}

class ShutterCallbackChannel extends $ShutterCallbackChannel {
  ShutterCallbackChannel(TypeChannelMessenger messenger) : super(messenger);
}

class PictureCallbackChannel extends $PictureCallbackChannel {
  PictureCallbackChannel(TypeChannelMessenger messenger) : super(messenger);
}

class MediaRecorderChannel extends $MediaRecorderChannel {
  MediaRecorderChannel(TypeChannelMessenger messenger) : super(messenger);
}

class CameraHandler extends $CameraHandler {
  CameraHandler() : super(onCreate: (_, $CameraCreationArgs args) => Camera());
}

class CameraInfoHandler extends $CameraInfoHandler {
  CameraInfoHandler()
      : super(
          onCreate: (_, $CameraInfoCreationArgs args) {
            return CameraInfo(
              cameraId: args.cameraId,
              facing: args.facing,
              orientation: args.orientation,
            );
          },
        );
}

class ShutterCallbackHandler extends $ShutterCallbackHandler {}

class PictureCallbackHandler extends $PictureCallbackHandler {}

class MediaRecorderHandler extends $MediaRecorderHandler {}
