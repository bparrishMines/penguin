import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:reference/annotations.dart';

import 'camera.g.dart';
import 'camera_channels.dart';

/// Callback for camera error notification.
///
/// See:
///   [Camera.errorUnknown]
///   [Camera.errorServerDied]
///   [Camera.errorEvicted]
@Reference('penguin_android_camera/camera/ErrorCallback')
typedef ErrorCallback = void Function(int error);

/// Callback used to notify on completion of camera auto focus.
///
/// Devices that do not support auto-focus will receive a "fake" callback to
/// this interface. If your application needs auto-focus and should not be
/// installed on devices without auto-focus, you must declare that your app uses
/// the android.hardware.camera.autofocus feature, in the <uses-feature>
/// manifest element.
///
/// If the camera does not support auto-focus and [Camera.autoFocus] is
/// called, [onAutoFocus] will be called immediately with a fake value of
/// success set to true. The auto-focus routine does not lock auto-exposure
/// and auto-white balance after it completes.
///
/// `success`: whether the auto-focus was successful.
///
/// See: [Camera.autoFocus].
@Reference('penguin_android_camera/camera/AutoFocusCallback')
typedef AutoFocusCallback = void Function(bool success);

/// Callback used to signal the moment of actual image capture.
///
/// Called as near as possible to the moment when a photo is captured from the sensor.
///
/// This is a good opportunity to play a shutter sound or give other feedback
/// of camera operation. This may be some time after the photo was triggered,
/// but some time before the actual data is available.
///
/// See: [Camera.takePicture].
@Reference('penguin_android_camera/camera/ShutterCallback')
typedef ShutterCallback = void Function();

/// Callback when receiving a byte array.
@Reference('penguin_android_camera/camera/DataCallback')
typedef DataCallback = void Function(Uint8List data);

/// Callback for zoom changes during a smooth zoom operation.
@Reference('penguin_android_camera/camera/OnZoomChangeListener')
typedef OnZoomChangeListener = void Function(int zoomValue, bool stopped);

/// Callback used to notify on auto focus start and stop.
///
/// This is only supported in continuous autofocus modes --
/// [CameraParameters.focusModeContinuousVideo] and
/// [CameraParameters.focusModeContinuousPicture]. Applications can show
/// autofocus animation based on this.
@Reference('penguin_android_camera/camera/AutoFocusMoveCallback')
typedef AutoFocusMoveCallback = void Function(bool start);

/// Called when an error occurs while recording with [MediaRecoder].
///
/// `what`: the type of error that has occurred:
///    * [MediaRecorder.errorUnknown]
///    * [MediaRecorder.errorServerDied]
///
/// `extra`: an extra code, specific to the info type
@Reference('penguin_android_camera/camera/OnErrorListener')
typedef OnErrorListener = void Function(int what, int extra);

/// Called to indicate an info or a warning during recording with [MediaRecoder].
///
/// `what`: the type of error that has occurred:
///    * [MediaRecorder.infoUnknown]
///    * [MediaRecorder.infoMaxDurationReached]
///    * [MediaRecorder.infoMaxFilesizeReached]
///
/// `extra`: an extra code, specific to the info type
@Reference('penguin_android_camera/camera/OnInfoListener')
typedef OnInfoListener = void Function(int what, int extra);

/// Callback used to supply image data from a photo capture.
///
/// Called when image data is available after a picture is taken.
///
/// The format of the data depends on the context of the callback and
/// [CameraParameters] settings.
///
/// See: [Camera.takePicture].
@Reference('penguin_android_camera/camera/PictureCallback')
class PictureCallback implements $PictureCallback {
  /// Construct a [PictureCallback].
  PictureCallback(this.onPictureTaken, {bool create = true}) {
    ChannelRegistrar.instance.implementations.channelDataCallback.$$create(
      onPictureTaken,
      $owner: false,
    );
    if (create) {
      _channel.$$create(this, $owner: true, onPictureTaken: onPictureTaken);
    }
  }

  static $PictureCallbackChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelPictureCallback;

  /// Callback used to supply image data from a photo capture.
  ///
  /// Called when image data is available after a picture is taken.
  ///
  /// The format of the data depends on the context of the callback and
  /// [CameraParameters] settings.
  ///
  /// See: [Camera.takePicture].
  final DataCallback onPictureTaken;
}

/// Callback used to deliver copies of preview frames as they are displayed.
@Reference('penguin_android_camera/camera/PreviewCallback')
class PreviewCallback implements $PreviewCallback {
  /// Construct a [PreviewCallback].
  PreviewCallback(this.onPreviewFrame, {bool create = true}) {
    ChannelRegistrar.instance.implementations.channelDataCallback.$$create(
      onPreviewFrame,
      $owner: false,
    );
    if (create) {
      _channel.$$create(this, $owner: true, onPreviewFrame: onPreviewFrame);
    }
  }

  static $PreviewCallbackChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelPreviewCallback;

  /// Callback used to deliver copies of preview frames as they are displayed.
  final DataCallback onPreviewFrame;
}

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
  /// This should only be used when subclassing. Otherwise, an instance should
  /// be provided from [open].
  @visibleForTesting
  Camera();

  static $CameraChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCamera;

  /// Unspecified camera error.
  static const int errorUnknown = 0x00000001;

  /// Media server died.
  ///
  /// In this case, the application must release the Camera object and
  /// instantiate a new one.
  static const int errorServerDied = 0x00000064;

  /// Camera was disconnected due to use by higher priority user.
  static const int errorEvicted = 0x00000002;

  int? _currentTexture;

  /// Returns the information about each camera.
  static Future<List<CameraInfo>> getAllCameraInfo() async {
    final List<Object?> allInfo =
        await _channel.$getAllCameraInfo() as List<Object?>;
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
    return await _channel.$open(cameraId) as Camera;
  }

  /// Disconnects and releases the [Camera] object resources.
  ///
  /// You must call this as soon as you're done with the [Camera] object.
  Future<void> release() => _channel.$release(this);

  /// Starts capturing and drawing preview frames to the screen.
  ///
  /// Preview will not actually start until a texture is supplied with
  /// [addToTexture].
  Future<void> startPreview() => _channel.$startPreview(this);

  /// Stops capturing and drawing preview frames to the surface.
  ///
  /// Resets the camera for a future call to [startPreview].
  Future<void> stopPreview() => _channel.$stopPreview(this);

  /// Attach preview frames to a new Flutter texture.
  ///
  /// If the [Camera] is already using a texture, the same id will be returned.
  Future<int> attachPreviewTexture() async {
    return _currentTexture ??=
        await _channel.$attachPreviewTexture(this) as int;
  }

  /// Release the Flutter texture receiving preview frames.
  Future<void> releasePreviewTexture() async {
    _currentTexture = null;
    await _channel.$releasePreviewTexture(this);
  }

  /// Unlocks the camera to allow another process to access it.
  ///
  /// Normally, the camera is locked to the process with an active [Camera]
  /// object until [release] is called. To allow rapid handoff between
  /// processes, you can call this method to release the camera temporarily for
  /// another process to use; once the other process is done you can call
  /// [reconnect] to reclaim the camera.
  ///
  /// This must be done before calling [MediaRecorder.setCamera]. This cannot
  /// be called after recording starts.
  ///
  /// If you are not recording video, you probably do not need this method.
  Future<void> unlock() {
    return _channel.$unlock(this);
  }

  /// Installs a callback to be invoked for the next preview frame in addition to displaying it on the screen.
  ///
  /// After one invocation, the callback is cleared. This method can be called
  /// any time, even when preview is live. Any other preview callbacks are
  /// overridden.
  ///
  /// If you are using the preview data to create video or still images,
  /// strongly consider using a sound to properly indicate image capture or
  /// recording start/stop to the user.
  Future<void> setOneShotPreviewCallback(PreviewCallback callback) {
    PreviewCallback._channel.$$create(
      callback,
      $owner: false,
      onPreviewFrame: callback.onPreviewFrame,
    );
    return _channel.$setOneShotPreviewCallback(this, callback);
  }

  /// Installs a callback to be invoked for every preview frame in addition to displaying them on the screen.
  ///
  /// The callback will be repeatedly called for as long as preview is active.
  /// This method can be called at any time, even while preview is live. Any
  /// other preview callbacks are overridden.
  ///
  /// If you are using the preview data to create video or still images,
  /// strongly consider using MediaActionSound to properly indicate image
  /// capture or recording start/stop to the user.
  Future<void> setPreviewCallback(PreviewCallback callback) {
    PreviewCallback._channel.$$create(
      callback,
      $owner: false,
      onPreviewFrame: callback.onPreviewFrame,
    );
    return _channel.$setPreviewCallback(this, callback);
  }

  /// Reconnects to the camera service after another process used it.
  ///
  /// After [unlock] is called, another process may use the camera; when the
  /// process is done, you must reconnect to the camera, which will re-acquire
  /// the lock and allow you to continue using the camera.
  ///
  /// Camera is automatically locked for applications in [MediaRecorder.start].
  /// Applications can use the camera (ex: zoom) after recording starts.
  /// There is no need to call this after recording starts or stops.
  ///
  /// If you are not recording video, you probably do not need this method.
  Future<void> reconnect() => _channel.$reconnect(this);

  /// Triggers an asynchronous image capture.
  ///
  /// The camera service will initiate a series of callbacks to the application
  /// as the image capture progresses. The shutter callback occurs after the
  /// image is captured. This can be used to trigger a sound to let the user
  /// know that image has been captured. The raw callback occurs when the raw
  /// image data is available (NOTE: the data will be null if there is no raw
  /// image callback buffer available or the raw image callback buffer is not
  /// large enough to hold the raw image). The postview callback occurs when a
  /// scaled, fully processed postview image is available (NOTE: not all
  /// hardware supports this). The jpeg callback occurs when the compressed
  /// image is available. If the application does not need a particular
  /// callback, a `null` can be passed instead of a callback method.
  ///
  /// This method is only valid when preview is active (after [startPreview]).
  /// Preview will be stopped after the image is taken; callers must call
  /// [startPreview] again if they want to re-start preview or take more
  /// pictures. This should not be called between [MediaRecorder.start] and
  /// [MediaRecorder.stop].
  ///
  /// After calling this method, you must not call [startPreview] or take
  /// another picture until the JPEG callback has returned.
  Future<void> takePicture(
    ShutterCallback? shutter,
    PictureCallback? raw,
    PictureCallback? postView,
    PictureCallback? jpeg,
  ) {
    if (shutter != null) {
      ChannelRegistrar.instance.implementations.channelShutterCallback.$$create(
        shutter,
        $owner: false,
      );
    }
    return _channel.$takePicture(
      this,
      shutter,
      raw,
      postView,
      jpeg,
    );
  }

  /// Starts camera auto-focus and registers a callback function to run when the camera is focused.
  ///
  /// This method is only valid when preview is active (between [startPreview]
  /// and before [stopPreview]).
  ///
  /// Callers should check [CameraParameters.getFocusMode] to determine if
  /// this method should be called. If the camera does not support auto-focus,
  /// it is a no-op and [AutoFocusCallback.onAutoFocus] callback will be called
  /// immediately.
  ///
  /// If your application should not be installed on devices without auto-focus,
  /// you must declare that your application uses auto-focus with the
  /// <uses-feature> manifest element.
  ///
  /// If the current flash mode is not [CameraParameters.flashModeOff], flash
  /// may be fired during auto-focus, depending on the driver and camera
  /// hardware.
  ///
  /// Auto-exposure lock [CameraParameters.getAutoExposureLock] and auto-white
  /// balance locks [CameraParameters.getAutoWhiteBalanceLock] do not change
  /// during and after auto-focus. But auto-focus routine may stop auto-exposure
  /// and auto-white balance transiently during focusing.
  ///
  /// Stopping preview with [stopPreview], or triggering still image capture
  /// with [takePicture], will not change the the focus position. Applications
  /// must call [cancelAutoFocus] to reset the focus.
  ///
  /// If auto-focus is successful, consider playing back an auto-focus success
  /// sound to the user.
  Future<void> autoFocus(AutoFocusCallback callback) {
    ChannelRegistrar.instance.implementations.channelAutoFocusCallback.$$create(
      callback,
      $owner: false,
    );
    return _channel.$autoFocus(this, callback);
  }

  /// Cancels any auto-focus function in progress.
  ///
  /// Whether or not auto-focus is currently in progress, this function will
  /// return the focus position to the default. If the camera does not support
  /// auto-focus, this is a no-op.
  Future<void> cancelAutoFocus() {
    return _channel.$cancelAutoFocus(this);
  }

  /// Set the clockwise rotation of preview display in degrees.
  ///
  /// This affects the preview frames and the picture displayed after snapshot.
  /// This method is useful for portrait mode applications. Note that preview
  /// display of front-facing cameras is flipped horizontally before the
  /// rotation, that is, the image is reflected along the central vertical axis
  /// of the camera sensor. So the users can see themselves as looking into a
  /// mirror.
  ///
  /// This does not affect the order of byte array passed in
  /// [PreviewCallback], JPEG pictures, or recorded videos. This method is not
  /// allowed to be called during preview.
  ///
  /// If you want to make the camera image show in the same orientation as the
  /// display, you can use the following code.
  Future<void> setDisplayOrientation(int degrees) {
    return _channel.$setDisplayOrientation(this, degrees);
  }

  /// Registers a callback to be invoked when an error occurs.
  Future<void> setErrorCallback(ErrorCallback callback) {
    ChannelRegistrar.instance.implementations.channelErrorCallback.$$create(
      callback,
      $owner: false,
    );
    return _channel.$setErrorCallback(this, callback);
  }

  /// Zooms to the requested value smoothly.
  ///
  /// The driver will notify [OnZoomChangeListener] of the zoom value and
  /// whether zoom is stopped at the time. For example, suppose the current zoom
  /// is 0 and [startSmoothZoom] is called with value 3. The
  /// [OnZoomChangeListener.onZoomChange] method will be called three times with
  /// zoom values 1, 2, and 3. Applications can call [stopSmoothZoom] to stop
  /// the zoom earlier. Applications should not call startSmoothZoom again or
  /// change the zoom value before zoom stops. If the supplied zoom value equals
  /// to the current zoom value, no zoom callback will be generated. This method
  /// is supported if [CameraParameters.isSmoothZoomSupported] returns `true`.
  Future<void> startSmoothZoom(int value) {
    return _channel.$startSmoothZoom(this, value);
  }

  /// Stops the smooth zoom.
  ///
  /// Applications should wait for the [OnZoomChangeListener] to know when the
  /// zoom is actually stopped. This method is supported if
  /// [CameraParameters.isSmoothZoomSupported] is `true`.
  Future<void> stopSmoothZoom() {
    return _channel.$stopSmoothZoom(this);
  }

  /// Returns the current settings for this Camera service.
  ///
  /// If modifications are made to the returned Parameters, they must be passed
  /// to [setParameters] to take effect.
  Future<CameraParameters> getParameters() async {
    return await _channel.$getParameters(this) as CameraParameters;
  }

  /// Changes the settings for this Camera service.
  Future<void> setParameters(CameraParameters parameters) {
    return _channel.$setParameters(this, parameters);
  }

  /// Registers a listener to be notified when the zoom value is updated by the camera driver during smooth zoom.
  Future<void> setZoomChangeListener(OnZoomChangeListener listener) {
    ChannelRegistrar.instance.implementations.channelOnZoomChangeListener
        .$$create(
      listener,
      $owner: false,
    );
    return _channel.$setZoomChangeListener(this, listener);
  }

  /// Sets camera auto-focus move callback.
  ///
  /// If enabling the focus move callback fails; usually this would be because
  /// of a hardware or other low-level error, or because [release] has been
  /// called on this Camera instance.
  Future<void> setAutoFocusMoveCallback(AutoFocusMoveCallback callback) {
    ChannelRegistrar.instance.implementations.channelAutoFocusMoveCallback
        .$$create(
      callback,
      $owner: false,
    );
    return _channel.$setAutoFocusMoveCallback(this, callback);
  }

  /// Re-locks the camera to prevent other processes from accessing it.
  ///
  /// Camera objects are locked by default unless [unlock] is called. Normally
  /// [reconnect] is used instead.
  ///
  /// Camera is automatically locked for applications in [MediaRecorder.start].
  /// Applications can use the camera (ex: zoom) after recording starts. There
  /// is no need to call this after recording starts or stops.
  ///
  /// If you are not recording video, you probably do not need this method.
  ///
  /// If the camera cannot be re-locked (for example, if the camera is still in
  /// use by another process) throws a [PlatformException].
  Future<void> lock() {
    return _channel.$lock(this);
  }

  /// Enable or disable the default shutter sound when taking a picture.
  ///
  /// By default, the camera plays the system-defined camera shutter sound when
  /// [takePicture] is called. Using this method, the shutter sound can be
  /// disabled. It is strongly recommended that an alternative shutter sound is
  /// played in the [ShutterCallback] when the system shutter sound is disabled.
  ///
  /// Note that devices may not always allow disabling the camera shutter sound.
  /// If the shutter sound state cannot be set to the desired value, this method
  /// will return false. [CameraInfo.canDisableShutterSound] can be used to
  /// determine whether the device will allow the shutter sound to be disabled.
  ///
  /// If the call fails; usually this would be because of a hardware or other
  /// low-level error, or because [release] has been called on this Camera instance.
  ///
  /// This is only supported on Android
  /// versions >= `Build.VERSION_CODES.JELLY_BEAN_MR1`. A [PlatformException]
  /// will be thrown if the android version is below this.
  Future<bool> enableShutterSound({required bool enabled}) async {
    return await _channel.$enableShutterSound(this, enabled) as bool;
  }
}

/// Camera service settings.
///
/// To make camera parameters take effect, applications have to call
/// [Camera.setParameters]. For example, after
/// [CameraParameters.setWhiteBalance] is called, white balance is not actually
/// changed until [Camera.setParameters] is called with the changed parameters
/// object.
///
/// Different devices may have different camera capabilities, such as picture
/// size or flash modes. The application should query the camera capabilities
/// before setting parameters. For example, the application should call
/// [CameraParameters.getSupportedColorEffects] before calling
/// [CameraParameters.setColorEffect]. If the camera does not support color
/// effects, [CameraParameters.getSupportedColorEffects] will return `null`.
@Reference('penguin_android_camera/camera/CameraParameters')
class CameraParameters with $CameraParameters {
  /// Default Constructor for [CameraParameters].
  ///
  /// This should only be used for testing. Otherwise use
  /// [Camera.getParameters].
  @visibleForTesting
  CameraParameters();

  /// Flash will be fired automatically when required.
  ///
  /// The flash may be fired during preview, auto-focus, or snapshot depending
  /// on the driver.
  static const String flashModeAuto = 'auto';

  /// Flash will not be fired.
  static const String flashModeOff = 'off';

  /// Flash will always be fired during snapshot.
  ///
  /// The flash may also be fired during preview or auto-focus depending on the
  /// driver.
  static const String flashModeOn = 'on';

  /// Flash will be fired in red-eye reduction mode.
  static const String flashModeRedEye = 'red-eye';

  /// Constant emission of light during preview, auto-focus and snapshot.
  ///
  /// This can also be used for video recording.
  static const String flashModeTorch = 'torch';

  /// The array index of far focus distance for use with [getFocusDistances].
  static const int focusDistanceFarIndex = 0x00000002;

  /// The array index of near focus distance for use with [getFocusDistances].
  static const int focusDistanceNearIndex = 0x00000000;

  /// The array index of optimal focus distance for use with [getFocusDistances].
  static const int focusDistanceOptimalIndex = 0x00000001;

  /// Auto-focus mode.
  ///
  /// Applications should call [Camera.autoFocus] to start the focus in this
  /// mode.
  static const String focusModeAuto = 'auto';

  /// Continuous auto focus mode intended for taking pictures.
  ///
  /// The camera continuously tries to focus. The speed of focus change is more
  /// aggressive than [focusModeContinuousVideo]. Auto focus starts when the
  /// parameter is set.
  ///
  /// Applications can call [Camera.autoFocus] in this mode. If the autofocus is
  /// in the middle of scanning, the focus callback will return when it
  /// completes. If the autofocus is not scanning, the focus callback will
  /// immediately return with a boolean that indicates whether the focus is
  /// sharp or not. The apps can then decide if they want to take a picture
  /// immediately or to change the focus mode to auto, and run a full autoFocus
  /// cycle. The focus position is locked after autoFocus call. If applications
  /// want to resume the continuous focus, [Camera.cancelAutoFocus] must be
  /// called. Restarting the preview will not resume the continuous autoFocus.
  /// To stop continuous focus, applications should change the focus mode to
  /// other modes.
  static const String focusModeContinuousPicture = 'continuous-picture';

  /// Continuous auto focus mode intended for video recording.
  ///
  /// The camera continuously tries to focus. This is the best choice for video
  /// recording because the focus changes smoothly. Applications still can call
  /// [Camera.takePicture] in this mode but the subject may not be in focus.
  /// Auto focus starts when the parameter is set.
  ///
  /// Since API level 14, applications can call [Camera.autoFocus] in this mode.
  /// The focus callback will immediately return with a boolean that indicates
  /// whether the focus is sharp or not. The focus position is locked after
  /// autoFocus call. If applications want to resume the continuous focus,
  /// [Camera.cancelAutoFocus] must be called. Restarting the preview will not
  /// resume the continuous autoFocus. To stop continuous focus, applications
  /// should change the focus mode to other modes.
  static const String focusModeContinuousVideo = 'continuous-video';

  /// Extended depth of field (EDOF).
  ///
  /// Focusing is done digitally and continuously. Applications should not call
  /// [Camera.autoFocus] in this mode.
  static const String focusModeEDOF = 'edof';

  /// Focus is fixed.
  ///
  /// The camera is always in this mode if the focus is not adjustable.
  /// If the camera has auto-focus, this mode can fix the focus, which is
  /// usually at hyperfocal distance. Applications should not call
  /// [Camera.autoFocus] in this mode.
  static const String focusModeFixed = 'fixed';

  /// Focus is set at infinity.
  ///
  /// Applications should not call [Camera.autoFocus] in this mode.
  static const String focusModeInfinity = 'infinity';

  /// Macro (close-up) focus mode.
  ///
  /// Applications should call [Camera.autoFocus] to start the focus in this
  /// mode.
  static const String focusModeMacro = 'macro';

  /// Antibanding at 50hz.
  static const String antibanding50hz = '50hz';

  /// Antibanding at 60hz.
  static const String antibanding60hz = '60hz';

  /// Allow the sensor to detect the best setting for antibanding.
  static const String antibandingAuto = 'auto';

  /// Turns off antibanding.
  static const String antibandingOff = 'off';

  /// No color effect.
  static const String effectNone = 'none';

  /// Color effect mono.
  static const String effectMono = 'mono';

  /// Color effect negative.
  static const String effectNegative = 'negative';

  /// Color effect solarize.
  static const String effectSolarize = 'solarize';

  /// Color effect sepia.
  static const String effectSepia = 'sepia';

  /// Color effect posterize.
  static const String effectPosterize = 'posterize';

  /// Color effect whiteboard.
  static const String effectWhiteboard = 'whiteboard';

  /// Color effect blackboard.
  static const String effectBlackboard = 'blackboard';

  /// Color effect aqua.
  static const String effectAqua = 'aqua';

  /// The array index of minimum preview fps for use with [getPreviewFpsRange] or [getSupportedPreviewFpsRange].
  static const previewFpsMinIndex = 0x00000000;

  /// The array index of maximum preview fps for use with [getPreviewFpsRange] or [getSupportedPreviewFpsRange].
  static const previewFpsMaxIndex = 0x00000001;

  /// Scene mode is off.
  static const String sceneModeAuto = 'auto';

  /// Take photos of fast moving objects. Same as [sceneModeSports].
  static const String sceneModeAction = 'action';

  /// Take people pictures.
  static const String sceneModePortrait = 'portrait';

  /// Take pictures on distant objects.
  static const String sceneModeLandscape = 'landscape';

  /// Take photos at night.
  static const String sceneModeNight = 'night';

  /// Take people pictures at night.
  static const String sceneModeNightPortrait = 'night-portrait';

  /// Take photos in a theater. Flash light is off.
  static const String sceneModeTheatre = 'theatre';

  /// Take pictures on the beach.
  static const String sceneModeBeach = 'beach';

  /// Take pictures on the snow.
  static const String sceneModeSnow = 'snow';

  /// Take sunset photos.
  static const String sceneModeSunset = 'sunset';

  /// Avoid blurry pictures (for example, due to hand shake).
  static const String sceneModeSteadyPhoto = 'steadyphoto';

  /// For shooting firework displays.
  static const String sceneModeFireworks = 'fireworks';

  /// Take photos of fast moving objects. Same as [sceneModeAction].
  static const String sceneModeSports = 'sports';

  /// Take indoor low-light shot.
  static const String sceneModeParty = 'party';

  /// Capture a scene using high dynamic range imaging techniques.
  ///
  /// The camera will return an image that has an extended dynamic range
  /// compared to a regular capture. Capturing such an image may take longer
  /// than a regular capture.
  static const String sceneModeHdr = 'hdr';

  /// Capture the naturally warm color of scenes lit by candles.
  static const String sceneModeCandlelight = 'candlelight';

  /// Applications are looking for a barcode.
  ///
  /// Camera driver will be optimized for barcode reading.
  static const String sceneModeBarcode = 'barcode';

  // ignore: public_member_api_docs
  static const String whiteBalanceAuto = 'auto';

  // ignore: public_member_api_docs
  static const String whiteBalanceIncandescent = 'incandescent';

  // ignore: public_member_api_docs
  static const String whiteBalanceFluorescent = 'fluorescent';

  // ignore: public_member_api_docs
  static const String whiteBalanceWarmFluorescent = 'warm-fluorescent';

  // ignore: public_member_api_docs
  static const String whiteBalanceDaylight = 'daylight';

  // ignore: public_member_api_docs
  static const String whiteBalanceCloudyDaylight = 'cloudy-daylight';

  // ignore: public_member_api_docs
  static const String whiteBalanceTwilight = 'twilight';

  // ignore: public_member_api_docs
  static const String whiteBalanceShade = 'shade';

  static $CameraParametersChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCameraParameters;

  /// Gets the state of the auto-exposure lock.
  ///
  /// Applications should check [isAutoExposureLockSupported] before using this
  /// method. See [setAutoExposureLock] for details about the lock.
  Future<bool> getAutoExposureLock() async {
    return await _channel.$getAutoExposureLock(this) as bool;
  }

  /// Gets the current focus areas.
  ///
  /// Camera driver uses the areas to decide focus.
  ///
  /// Before using this API or [setFocusAreas], apps should call
  /// [getMaxNumFocusAreas] to know the maximum number of focus areas first. If
  /// the value is 0, focus area is not supported.
  ///
  /// Each focus area is a rectangle with specified weight. The direction is
  /// relative to the sensor orientation, that is, what the sensor sees. The
  /// direction is not affected by the rotation or mirroring of
  /// [Camera.setDisplayOrientation]. Coordinates of the rectangle range from
  /// -1000 to 1000. (-1000, -1000) is the upper left point. (1000, 1000) is the
  /// lower right point. The width and height of focus areas cannot be 0 or
  /// negative.
  ///
  /// The weight must range from 1 to 1000. The weight should be interpreted as
  /// a per-pixel weight - all pixels in the area have the specified weight.
  /// This means a small area with the same weight as a larger area will have
  /// less influence on the focusing than the larger area. Focus areas can
  /// partially overlap and the driver will add the weights in the overlap
  /// region.
  ///
  /// A special case of a `null` focus area list means the driver is free to
  /// select focus targets as it wants. For example, the driver may use more
  /// signals to select focus areas and change them dynamically. Apps can set
  /// the focus area list to `null` if they want the driver to completely
  /// control focusing.
  ///
  /// Focus areas are relative to the current field of view ([getZoom]). No
  /// matter what the zoom level is, (-1000,-1000) represents the top of the
  /// currently visible camera frame. The focus area cannot be set to be
  /// outside the current field of view, even when using zoom.
  ///
  /// Focus area only has effect if the current focus mode is
  /// [focusModeAuto], [focusModeMacro], [focusModeContinuousVideo], or
  /// [focusModeContinuousPicture].
  Future<List<CameraArea>?> getFocusAreas() async {
    final List<Object?>? focusAreas =
        await _channel.$getFocusAreas(this) as List<Object?>?;
    return focusAreas?.cast<CameraArea>();
  }

  // TODO: This can return Float.POSITIVE_INFINITY?
  /// Gets the distances from the camera to where an object appears to be in focus.
  ///
  /// The object is sharpest at the optimal focus distance. The depth of field
  /// is the far focus distance minus near focus distance.
  ///
  /// Focus distances may change after calling [Camera.autoFocus],
  /// [Camera.cancelAutoFocus], or [Camera.startPreview]. Applications can call
  /// [Camera.getParameters] and this method anytime to get the latest focus
  /// distances. If the focus mode is [focusModeContinuousVideo], focus
  /// distances may change from time to time.
  ///
  /// This method is intended to estimate the distance between the camera and
  /// the subject. After auto-focus, the subject distance may be within near
  /// and far focus distance. However, the precision depends on the camera
  /// hardware, auto-focus algorithm, the focus area, and the scene. The error
  /// can be large and it should be only used as a reference.
  ///
  /// Far focus distance >= optimal focus distance >= near focus distance. If
  /// the focus distance is infinity, the value will be
  /// Float.POSITIVE_INFINITY (Java).
  Future<List<double>> getFocusDistances() async {
    final List<Object?> distances =
        await _channel.$getFocusDistances(this) as List<Object?>;
    return distances.cast<double>();
  }

  /// Gets the maximum exposure compensation index.
  ///
  /// Maximum exposure compensation index (>=0). If both this method and
  /// [getMinExposureCompensation] return 0, exposure compensation is not
  /// supported.
  Future<int> getMaxExposureCompensation() async {
    return await _channel.$getMaxExposureCompensation(this) as int;
  }

  /// Gets the maximum number of focus areas supported.
  ///
  /// This is the maximum length of the list in [setFocusAreas] and
  /// [getFocusAreas].
  Future<int> getMaxNumFocusAreas() async {
    return await _channel.$getMaxNumFocusAreas(this) as int;
  }

  /// Gets the minimum exposure compensation index.
  Future<int> getMinExposureCompensation() async {
    return await _channel.$getMinExposureCompensation(this) as int;
  }

  /// Gets the supported focus modes.
  Future<List<String>> getSupportedFocusModes() async {
    final List<Object?> modes =
        await _channel.$getSupportedFocusModes(this) as List<Object?>;
    return modes.cast<String>();
  }

  /// Returns `true` if auto-exposure locking is supported.
  ///
  /// Applications should call this before trying to lock auto-exposure.
  /// See [setAutoExposureLock] for details about the lock.
  Future<bool> isAutoExposureLockSupported() async {
    return await _channel.$isAutoExposureLockSupported(this) as bool;
  }

  /// Returns `true` if zoom is supported.
  ///
  /// Applications should call this before using other zoom methods.
  Future<bool> isZoomSupported() async {
    return await _channel.$isZoomSupported(this) as bool;
  }

  /// Sets the auto-exposure lock state.
  ///
  /// Applications should check [isAutoExposureLockSupported] before using this
  /// method.
  ///
  /// If set to true, the camera auto-exposure routine will immediately pause
  /// until the lock is set to false. Exposure compensation settings changes
  /// will still take effect while auto-exposure is locked.
  ///
  /// If auto-exposure is already locked, setting this to true again has no
  /// effect (the driver will not recalculate exposure values).
  ///
  /// Stopping preview with [Camera.stopPreview], or triggering still image
  /// capture with [Camera.takePicture], will not change the lock.
  ///
  /// Exposure compensation, auto-exposure lock, and auto-white balance lock can
  /// be used to capture an exposure-bracketed burst of images, for example.
  ///
  /// Auto-exposure state, including the lock state, will not be maintained
  /// after camera [Camera.release] is called. Locking auto-exposure after
  /// [Camera.open] but before the first call to [Camera.startPreview] will not
  /// allow the auto-exposure routine to run at all, and may result in severely
  /// over- or under-exposed images.
  Future<void> setAutoExposureLock({required bool toggle}) {
    return _channel.$setAutoExposureLock(this, toggle);
  }

  /// Sets the exposure compensation index.
  ///
  /// The valid value range is from [getMinExposureCompensation] (inclusive) to
  /// [getMaxExposureCompensation] (inclusive). 0 means exposure is not
  /// adjusted. Application should call [getMinExposureCompensation] and
  /// [getMaxExposureCompensation] to know if exposure compensation is
  /// supported.
  Future<void> setExposureCompensation(int value) {
    return _channel.$setExposureCompensation(this, value);
  }

  /// Sets focus areas.
  ///
  /// See [getFocusAreas] for documentation.
  Future<void> setFocusAreas(covariant List<CameraArea>? focusAreas) {
    return _channel.$setFocusAreas(this, focusAreas);
  }

  /// Sets the focus mode.
  ///
  /// See: [getFocusMode].
  Future<void> setFocusMode(String value) {
    return _channel.$setFocusMode(this, value);
  }

  /// Gets the current flash mode setting.
  ///
  /// Returns `null` if flash mode setting is not supported.
  ///
  /// See:
  ///   [flashModeOff]
  ///   [flashModeAuto]
  ///   [flashModeOn]
  ///   [flashModeOff]
  ///   [flashModeTorch]
  Future<String?> getFlashMode() async {
    return await _channel.$getFlashMode(this) as String?;
  }

  /// Gets the maximum zoom value allowed for snapshot.
  ///
  /// This is the maximum value that applications can set to [setZoom].
  /// Applications should call [isZoomSupported] before using this method.
  /// This value may change in different preview size. Applications should call
  /// this again after setting preview size.
  Future<int> getMaxZoom() async {
    return await _channel.$getMaxZoom(this) as int;
  }

  /// Returns the dimension setting for pictures.
  Future<CameraSize> getPictureSize() async {
    return await _channel.$getPictureSize(this) as CameraSize;
  }

  /// Returns the dimensions setting for preview pictures.
  Future<CameraSize> getPreviewSize() async {
    return await _channel.$getPreviewSize(this) as CameraSize;
  }

  /// Gets the supported preview sizes.
  ///
  /// This method will always return a list with at least one element.
  Future<List<CameraSize>> getSupportedPreviewSizes() async {
    final List<Object?> sizes =
        await _channel.$getSupportedPreviewSizes(this) as List<Object?>;
    return sizes.cast<CameraSize>();
  }

  /// Gets the supported picture sizes.
  ///
  /// This method will always return a list with at least one element.
  Future<List<CameraSize>> getSupportedPictureSizes() async {
    final List<Object?> sizes =
        await _channel.$getSupportedPictureSizes(this) as List<Object?>;
    return sizes.cast<CameraSize>();
  }

  /// Gets the supported flash modes.
  ///
  /// Empty if flash mode setting is not supported.
  Future<List<String>> getSupportedFlashModes() async {
    final List<Object?> modes =
        await _channel.$getSupportedFlashModes(this) as List<Object?>;
    return modes.cast<String>();
  }

  /// Gets current zoom value.
  ///
  /// This also works when smooth zoom is in progress. Applications should check
  /// [isZoomSupported] before using this method.
  Future<int> getZoom() async {
    return _channel.$getZoom(this) as int;
  }

  /// Whether smooth zoom is supported.
  ///
  /// Applications should call this before using other smooth zoom methods.
  Future<bool> isSmoothZoomSupported() async {
    return await _channel.$isSmoothZoomSupported(this) as bool;
  }

  /// Sets the flash mode.
  Future<void> setFlashMode(String mode) {
    return _channel.$setFlashMode(this, mode);
  }

  /// Sets the dimensions for pictures.
  ///
  /// Applications need to consider the display orientation. See
  /// [setPreviewSize] for reference.
  ///
  /// Exception on 176x144 (QCIF) resolution: Camera devices usually have a
  /// fixed capability for downscaling from larger resolution to smaller, and
  /// the QCIF resolution sometimes is not fully supported due to this
  /// limitation on devices with high-resolution image sensors. Therefore,
  /// trying to configure a QCIF picture size with any preview or video size
  /// larger than 1920x1080 (either width or height) might not be supported,
  /// and [Camera.setParameters] might throw a RuntimeException if it is not.
  Future<void> setPictureSize(int width, int height) {
    return _channel.$setPictureSize(this, width, height);
  }

  /// Sets recording mode hint.
  ///
  /// This tells the camera that the intent of the application is to record
  /// videos [MediaRecorder.start], not to take still pictures
  /// [Camera.takePicture]. Using this hint can allow [MediaRecorder.start] to
  /// start faster or with fewer glitches on output. This should be called
  /// before starting preview for the best result, but can be changed while the
  /// preview is active. The default value is false. The app can still call
  /// [Camera.takePicture] when the hint is true or call [MediaRecorder.start]
  /// when the hint is false. But the performance may be worse.
  Future<void> setRecordingHint({required bool hint}) {
    return _channel.$setRecordingHint(this, hint);
  }

  /// Sets the clockwise rotation angle in degrees relative to the orientation of the camera.
  ///
  /// This affects the pictures returned from JPEG [PictureCallback]. The camera
  /// driver may set orientation in the EXIF header without rotating the
  /// picture. Or the driver may rotate the picture and the EXIF thumbnail. If
  /// the Jpeg picture is rotated, the orientation in the EXIF header will be
  /// missing or 1 (row #0 is top and column #0 is left side).
  ///
  /// If applications want to rotate the picture to match the orientation of
  /// what users see, apps should use OrientationBuilder and [CameraInfo].
  /// [CameraInfo.orientation] is the angle between camera orientation and
  /// natural device orientation. The sum of the two is the rotation angle for
  /// back-facing camera. The difference of the two is the rotation angle for
  /// front-facing camera. Note that the JPEG pictures of front-facing cameras
  /// are not mirrored as in preview display.
  ///
  /// For example, suppose the natural orientation of the device is portrait.
  /// The device is rotated 270 degrees clockwise, so the device orientation is
  /// 270. Suppose a back-facing camera sensor is mounted in landscape and the
  /// top side of the camera sensor is aligned with the right edge of the
  /// display in natural orientation. So the camera orientation is 90. The
  /// rotation should be set to 0 (270 + 90).
  ///
  /// The reference code is as follows for android 24+:
  ///
  /// ```dart
  /// late int result;
  /// if (cameraInfo.facing == CameraInfo.cameraFacingFront) {
  ///   result = cameraInfo.orientation % 360;
  ///   result = (360 - result) % 360;
  /// } else {
  ///   result = (cameraInfo.orientation + 360) % 360;
  /// }
  /// camera.setDisplayOrientation(result);
  /// ```
  ///
  /// [rotation] can only be 0, 90, 180 or 270.
  Future<void> setRotation(int rotation) {
    return _channel.$setRotation(this, rotation);
  }

  /// Sets current zoom value.
  ///
  /// If the camera is zoomed (value > 0), the actual picture size may be
  /// smaller than picture size setting. Applications can check the actual
  /// picture size after picture is returned from [PictureCallback]. The preview
  /// size remains the same in zoom. Applications should check [isZoomSupported]
  /// before using this method.
  ///
  /// The valid range is 0 to [getMaxZoom].
  Future<void> setZoom(int value) {
    return _channel.$setZoom(this, value);
  }

  /// Sets the dimensions for preview pictures.
  ///
  /// If the preview has already started, applications should stop the preview
  /// first before changing preview size. The sides of width and height are
  /// based on camera orientation. That is, the preview size is the size before
  /// it is rotated by display orientation. So applications need to consider the
  /// display orientation while setting preview size. For example, suppose
  /// the camera supports both 480x320 and 320x480 preview sizes.
  /// The application wants a 3:2 preview ratio. If the display orientation is
  /// set to 0 or 180, preview size should be set to 480x320. If the display
  /// orientation is set to 90 or 270, preview size should be set to 320x480.
  /// The display orientation should also be considered while setting picture
  /// size and thumbnail size. Exception on 176x144 (QCIF) resolution: Camera
  /// devices usually have a fixed capability for downscaling from larger
  /// resolution to smaller, and the QCIF resolution sometimes is not fully
  /// supported due to this limitation on devices with high-resolution image
  /// sensors. Therefore, trying to configure a QCIF preview size with any
  /// picture or video size larger than 1920x1080 (either width or height)
  /// might not be supported, and [Camera.setParameters] might throw a
  /// [PlatformException] if it is not.
  Future<void> setPreviewSize(int width, int height) {
    return _channel.$setPreviewSize(this, width, height);
  }

  /// Gets the current exposure compensation index.
  ///
  /// The range is [getMinExposureCompensation] to [getMaxExposureCompensation].
  /// 0 means exposure is not adjusted.
  Future<int> getExposureCompensation() async {
    return await _channel.$getExposureCompensation(this) as int;
  }

  /// Gets the exposure compensation step.
  ///
  /// Applications can get EV by multiplying the exposure compensation index and
  /// step. Ex: if exposure compensation index is -6 and step is 0.333333333, EV
  /// is -2.
  Future<double> getExposureCompensationStep() async {
    return await _channel.$getExposureCompensationStep(this) as double;
  }

  /// Creates a single string with all the parameters set in this Parameters object.
  ///
  /// Returns a `String` with all values from this Parameters object, in
  /// semi-colon delimited key-value pairs
  ///
  /// The [unflatten] method does the reverse.
  Future<String> flatten() async {
    return await _channel.$flatten(this) as String;
  }

  /// Returns the value of a `String` parameter.
  Future<String?> get(String key) async {
    return await _channel.$get(this, key) as String;
  }

  /// Gets the current antibanding setting.
  ///
  /// See:
  ///   [antibandingAuto]
  ///   [antibanding50hz]
  ///   [antibanding60hz]
  ///   [antibandingOff]
  Future<String> getAntibanding() async {
    return await _channel.$getAntibanding(this) as String;
  }

  /// Gets the state of the auto-white balance lock.
  ///
  /// Applications should check [isAutoWhiteBalanceLockSupported] before using
  /// this method. See [setAutoWhiteBalanceLock] for details about the lock.
  ///
  /// Returns true if auto-white balance is currently locked, and false
  /// otherwise.
  Future<bool> getAutoWhiteBalanceLock() async {
    return await _channel.$getAutoWhiteBalanceLock(this) as bool;
  }

  /// Gets the current color effect setting.
  ///
  /// See:
  ///   [effectNone]
  ///   [effectMono]
  ///   [effectNegative]
  ///   [effectSolarize]
  ///   [effectSepia]
  ///   [effectPosterize]
  ///   [effectWhiteboard]
  ///   [effectBlackboard]
  ///   [effectAqua]
  Future<String> getColorEffect() async {
    return await _channel.$getColorEffect(this) as String;
  }

  /// Gets the focal length (in millimeter) of the camera.
  ///
  /// Returns -1.0 when the device doesn't report focal length information.
  Future<double> getFocalLength() async {
    return await _channel.$getFocalLength(this) as double;
  }

  /// Gets the current focus mode setting.
  ///
  /// See:
  ///   [focusModeAuto]
  ///   [focusModeInfinity]
  ///   [focusModeMacro]
  ///   [focusModeFixed]
  ///   [focusModeEDOF]
  ///   [focusModeContinuousVideo]
  ///   [focusModeContinuousPicture]
  Future<String> getFocusMode() async {
    return await _channel.$getFocusMode(this) as String;
  }

  /// Gets the horizontal angle of view in degrees.
  ///
  /// Returns -1.0 when the device doesn't report view angle information.
  Future<double> getHorizontalViewAngle() async {
    return await _channel.$getHorizontalViewAngle(this) as double;
  }

  /// Returns the value of an integer parameter.
  Future<int> getInt(String key) async {
    return await _channel.$getInt(this, key) as int;
  }

  /// Returns the quality setting for the JPEG picture.
  Future<int> getJpegQuality() async {
    return await _channel.$getJpegQuality(this) as int;
  }

  /// Returns the quality setting for the EXIF thumbnail in Jpeg picture.
  Future<int> getJpegThumbnailQuality() async {
    return await _channel.$getJpegThumbnailQuality(this) as int;
  }

  /// Returns the dimensions for EXIF thumbnail in Jpeg picture.
  Future<CameraSize> getJpegThumbnailSize() async {
    return await _channel.$getJpegThumbnailSize(this) as CameraSize;
  }

  /// Gets the maximum number of metering areas supported.
  ///
  /// This is the maximum length of the list in [setMeteringAreas] and
  /// [getMeteringAreas].
  Future<int> getMaxNumMeteringAreas() async {
    return await _channel.$getMaxNumMeteringAreas(this) as int;
  }

  /// Gets the current metering areas.
  ///
  /// Camera driver uses these areas to decide exposure.
  ///
  /// Before using this API or [setMeteringAreas], apps should call
  /// [getMaxNumMeteringAreas] to know the maximum number of metering areas
  /// first. If the value is 0, metering area is not supported.
  ///
  /// Each metering area is a rectangle with specified weight. The direction is
  /// relative to the sensor orientation, that is, what the sensor sees. The
  /// direction is not affected by the rotation or mirroring of
  /// [Camera.setDisplayOrientation]. Coordinates of the rectangle range from
  /// -1000 to 1000. (-1000, -1000) is the upper left point. (1000, 1000) is the
  /// lower right point. The width and height of metering areas cannot be 0 or
  /// negative.
  ///
  /// The weight must range from 1 to 1000, and represents a weight for every
  /// pixel in the area. This means that a large metering area with the same
  /// weight as a smaller area will have more effect in the metering result.
  /// Metering areas can partially overlap and the driver will add the weights
  /// in the overlap region.
  ///
  /// A special case of a `null` metering area list means the driver is free to
  /// meter as it chooses. For example, the driver may use more signals to
  /// select metering areas and change them dynamically. Apps can set the
  /// metering area list to `null` if they want the driver to completely control
  /// metering.
  ///
  /// Metering areas are relative to the current field of view ([getZoom]). No
  /// matter what the zoom level is, (-1000,-1000) represents the top of the
  /// currently visible camera frame. The metering area cannot be set to be
  /// outside the current field of view, even when using zoom.
  ///
  /// No matter what metering areas are, the final exposure are compensated by
  /// [setExposureCompensation].
  Future<List<CameraArea>?> getMeteringAreas() async {
    final List<Object?>? areas =
        await _channel.$getMeteringAreas(this) as List<Object?>?;
    return areas?.cast<CameraArea>();
  }

  /// Returns the image format for pictures.
  ///
  /// See:
  ///   [ImageFormat]
  Future<int> getPictureFormat() async {
    return await _channel.$getPictureFormat(this) as int;
  }

  /// Returns the preferred or recommended preview size (width and height) in pixels for video recording.
  ///
  /// Camcorder applications should set the preview size to a value that is not
  /// larger than the preferred preview size. In other words, the product of the
  /// width and height of the preview size should not be larger than that of the
  /// preferred preview size. In addition, we recommend to choose a preview size
  /// that has the same aspect ratio as the resolution of video to be recorded.
  ///
  /// If [getSupportedVideoSizes] returns null; null is returned.
  Future<CameraSize?> getPreferredPreviewSizeForVideo() async {
    return await _channel.$getPreferredPreviewSizeForVideo(this) as CameraSize?;
  }

  /// Returns the image format for preview frames got from [PreviewCallback].
  ///
  /// See:
  ///   [ImageFormat].
  Future<int> getPreviewFormat() async {
    return await _channel.$getPreviewFormat(this) as int;
  }

  /// Returns the current minimum and maximum preview fps.
  ///
  /// The values are one of the elements returned by
  /// [getSupportedPreviewFpsRange].
  ///
  /// Returns the range of the minimum and maximum preview fps (scaled by 1000).
  Future<List<int>> getPreviewFpsRange() async {
    final List<Object?> areas =
        await _channel.$getPreviewFpsRange(this) as List<Object?>;
    return areas.cast<int>();
  }

  /// Gets the current scene mode setting.
  ///
  /// Returns `null` if scene mode setting is not supported.
  ///
  /// See:
  ///   [sceneModeAuto]
  ///   [sceneModeAction]
  ///   [sceneModePortrait]
  ///   [sceneModeLandscape]
  ///   [sceneModeNight]
  ///   [sceneModeNightPortrait]
  ///   [sceneModeTheatre]
  ///   [sceneModeBeach]
  ///   [sceneModeSnow]
  ///   [sceneModeSunset]
  ///   [sceneModeSteadyPhoto]
  ///   [sceneModeFireworks]
  ///   [sceneModeSports]
  ///   [sceneModeParty]
  ///   [sceneModeCandlelight]
  ///   [sceneModeBarcode]
  ///   [sceneModeHdr]
  Future<String?> getSceneMode() async {
    return await _channel.$getSceneMode(this) as String;
  }

  /// Gets the supported antibanding values.
  ///
  /// Returns `null` if antibanding setting is not supported.
  Future<List<String>?> getSupportedAntibanding() async {
    final List<Object?>? areas =
        await _channel.$getSupportedAntibanding(this) as List<Object?>?;
    return areas?.cast<String>();
  }

  /// A list of supported color effects.
  ///
  /// Returns `null` if color effect setting is not supported.
  ///
  /// See:
  ///   [getColorEffect]
  Future<List<String>?> getSupportedColorEffects() async {
    final List<Object?>? effects =
        await _channel.$getSupportedColorEffects(this) as List<Object?>?;
    return effects?.cast<String>();
  }

  /// Gets the supported jpeg thumbnail sizes.
  ///
  /// This method will always return a list with at least two elements. Size
  /// 0,0 (no thumbnail) is always supported.
  Future<CameraSize> getSupportedJpegThumbnailSizes() async {
    return await _channel.$getSupportedJpegThumbnailSizes(this) as CameraSize;
  }

  /// Gets the supported picture formats.
  ///
  /// This method will always return a list with at least one element.
  Future<List<int>> getSupportedPictureFormats() async {
    final List<Object?> formats =
        await _channel.$getSupportedPictureFormats(this) as List<Object?>;
    return formats.cast<int>();
  }

  /// Gets the supported preview formats.
  ///
  /// [ImageFormat.nv21] is always supported. [ImageFormat.yv12] is always
  /// supported.
  Future<List<int>> getSupportedPreviewFormats() async {
    final List<Object?> formats =
        await _channel.$getSupportedPreviewFormats(this) as List<Object?>;
    return formats.cast<int>();
  }

  /// Gets the supported preview fps (frame-per-second) ranges.
  ///
  /// Each range contains a minimum fps and maximum fps. If minimum fps equals
  /// to maximum fps, the camera outputs frames in fixed frame rate. If not,
  /// the camera outputs frames in auto frame rate. The actual frame rate
  /// fluctuates between the minimum and the maximum. The values are multiplied
  /// by 1000 and represented in integers. For example, if frame rate is 26.623
  /// frames per second, the value is 26623.
  ///
  /// This method returns a list with at least one element. Every element is an
  /// int list of two values - minimum fps and maximum fps. The list is sorted
  /// from small to large (first by maximum fps and then minimum fps).
  ///
  /// See:
  ///   [previewFpsMinIndex]
  ///   [previewFpsMaxIndex]
  Future<List<List<int>>> getSupportedPreviewFpsRange() async {
    final List<Object?> formats =
        await _channel.$getSupportedPreviewFpsRange(this) as List<Object?>;
    return formats.cast<List<int>>();
  }

  /// Gets the supported scene modes.
  ///
  /// Returns null if scene mode setting is not supported.
  Future<List<String>?> getSupportedSceneModes() async {
    final List<Object?>? modes =
        await _channel.$getSupportedSceneModes(this) as List<Object?>?;
    return modes?.cast<String>();
  }

  /// Gets the supported video frame sizes that can be used by [MediaRecorder].
  ///
  /// If the returned list is not null, the returned list will contain at least
  /// one Size and one of the sizes in the returned list must be passed to
  /// [MediaRecorder.setVideoSize] for camcorder application if camera is used
  /// as the video source. In this case, the size of the preview can be
  /// different from the resolution of the recorded video during video
  /// recording.
  ///
  /// Exception on 176x144 (QCIF) resolution: Camera devices usually have a
  /// fixed capability for downscaling from larger resolution to smaller, and
  /// the QCIF resolution sometimes is not fully supported due to this
  /// limitation on devices with high-resolution image sensors. Therefore,
  /// trying to configure a QCIF video resolution with any preview or picture
  /// size larger than 1920x1080 (either width or height) might not be
  /// supported, and [Camera.setParameters] will throw a RuntimeException if it
  /// is not.
  ///
  /// Returns a list of [CameraSize] object if camera has separate preview and
  /// video output; otherwise, null is returned.
  ///
  /// See:
  ///   [getPreferredPreviewSizeForVideo]
  Future<List<CameraSize>?> getSupportedVideoSizes() async {
    final List<Object?>? sizes =
        await _channel.$getSupportedVideoSizes(this) as List<Object?>?;
    return sizes?.cast<CameraSize>();
  }

  /// Gets the supported white balance.
  ///
  /// Returns null if white balance setting is not supported.
  ///
  /// See:
  ///   [getWhiteBalance]
  Future<List<String>?> getSupportedWhiteBalance() async {
    final List<Object?>? sizes =
        await _channel.$getSupportedWhiteBalance(this) as List<Object?>?;
    return sizes?.cast<String>();
  }

  /// Gets the vertical angle of view in degrees.
  ///
  /// Returns -1.0 when the device doesn't report view angle information.
  Future<double> getVerticalViewAngle() async {
    return await _channel.$getVerticalViewAngle(this) as double;
  }

  /// Get the current state of video stabilization.
  ///
  /// Returns `true` if video stabilization is enabled.
  Future<bool> getVideoStabilization() async {
    return await _channel.$getVideoStabilization(this) as bool;
  }

  /// Gets the current white balance setting.
  ///
  /// Returns null if white balance setting is not supported.
  ///
  /// See:
  ///   [whiteBalanceAuto]
  ///   [whiteBalanceFluorescent]
  ///   [whiteBalanceWarmFluorescent]
  ///   [whiteBalanceIncandescent]
  ///   [whiteBalanceDaylight]
  ///   [whiteBalanceCloudyDaylight]
  ///   [whiteBalanceTwilight]
  ///   [whiteBalanceShade]
  Future<String?> getWhiteBalance() async {
    return await _channel.$getWhiteBalance(this) as String?;
  }

  /// Gets the zoom ratios of all zoom values.
  ///
  /// Applications should check [isZoomSupported] before using this method.
  ///
  /// Returns the zoom ratios in 1/100 increments. Ex: a zoom of 3.2x is
  /// returned as 320. The number of elements is [getMaxZoom] + 1. The list is
  /// sorted from small to large. The first element is always 100. The last
  /// element is the zoom ratio of the maximum zoom value.
  Future<int> getZoomRatios() async {
    return await _channel.$getZoomRatios(this) as int;
  }

  /// If auto-white balance locking is supported.
  ///
  /// Applications should call this before trying to lock auto-white balance.
  /// See [setAutoWhiteBalanceLock] for details about the lock.
  Future<bool> isAutoWhiteBalanceLockSupported() async {
    return await _channel.$isAutoWhiteBalanceLockSupported(this) as bool;
  }

  /// If video snapshot is supported.
  ///
  /// That is, applications can call [Camera.takePicture] during recording.
  /// Applications do not need to call [Camera.startPreview] after taking a
  /// picture. The preview will be still active. Other than that, taking a
  /// picture during recording is identical to taking a picture normally. All
  /// settings and methods related to [takePicture] work identically. Ex:
  /// [getPictureSize], [getSupportedPictureSizes], [setJpegQuality],
  /// [setRotation], and etc. The picture will have an EXIF header.
  /// [flashModeAuto] and [flashModeOn] also still work, but the video will
  /// record the flash.
  ///
  /// Applications can set shutter callback as null to avoid the shutter sound.
  /// It is also recommended to set raw picture and post view callbacks to null
  /// to avoid the interrupt of preview display.
  ///
  /// Field-of-view of the recorded video may be different from that of the
  /// captured pictures. The maximum size of a video snapshot may be smaller
  /// than that for regular still captures. If the current picture size is set
  /// higher than can be supported by video snapshot, the picture will be
  /// captured at the maximum supported size instead.
  Future<bool> isVideoSnapshotSupported() async {
    return await _channel.$isVideoSnapshotSupported(this) as bool;
  }

  /// If video stabilization is supported.
  ///
  /// See [setVideoStabilization] for details of video stabilization.
  Future<bool> isVideoStabilizationSupported() async {
    return await _channel.$isVideoStabilizationSupported(this) as bool;
  }

  // TODO: Document
  // ignore: public_member_api_docs
  Future<void> remove(String key) {
    return _channel.$remove(this, key);
  }

  /// Removes GPS latitude, longitude, altitude, and timestamp from the parameters.
  Future<void> removeGpsData() {
    return _channel.$removeGpsData(this);
  }

  /// Sets a String parameter.
  ///
  /// [value] should be either a [String] or [int].
  Future<void> set(String key, Object value) {
    assert(value is String || value is int);
    return _channel.$set(this, key, value);
  }

  /// Sets the antibanding.
  ///
  /// See: [getAntibanding].
  Future<void> setAntibanding(String antibanding) {
    return _channel.$setAntibanding(this, antibanding);
  }

  /// Sets the auto-white balance lock state.
  ///
  /// Applications should check [isAutoWhiteBalanceLockSupported] before using
  /// this method.
  ///
  /// If set to true, the camera auto-white balance routine will immediately
  /// pause until the lock is set to false.
  ///
  /// If auto-white balance is already locked, setting this to true again has
  /// no effect (the driver will not recalculate white balance values).
  ///
  /// Stopping preview with [Camera.stopPreview], or triggering still image
  /// capture with [Camera.takePicture], will not change the the lock.
  ///
  /// Changing the white balance mode with [setWhiteBalance] will release the
  /// auto-white balance lock if it is set.
  ///
  /// Exposure compensation, AE lock, and AWB lock can be used to capture an
  /// exposure-bracketed burst of images, for example. Auto-white balance state,
  /// including the lock state, will not be maintained after camera
  /// [Camera.release] is called. Locking auto-white balance after [Camera.open]
  /// but before the first call to [Camera.startPreview] will not allow the
  /// auto-white balance routine to run at all, and may result in severely
  /// incorrect color in captured images.
  Future<void> setAutoWhiteBalanceLock({required bool toggle}) {
    return _channel.$setAutoWhiteBalanceLock(this, toggle);
  }

  /// Sets the current color effect setting.
  ///
  /// See: [getColorEffect].
  Future<void> setColorEffect(String effect) {
    return _channel.$setColorEffect(this, effect);
  }

  /// Sets GPS altitude in meters.
  ///
  /// This will be stored in JPEG EXIF header.
  Future<void> setGpsAltitude(double meters) {
    return _channel.$setGpsAltitude(this, meters);
  }

  /// Sets GPS latitude coordinate.
  ///
  /// This will be stored in JPEG EXIF header.
  Future<void> setGpsLatitude(double latitude) {
    return _channel.$setGpsLatitude(this, latitude);
  }

  /// Sets GPS longitude coordinate.
  ///
  /// This will be stored in JPEG EXIF header.
  Future<void> setGpsLongitude(double longitude) {
    return _channel.$setGpsLongitude(this, longitude);
  }

  /// Sets GPS processing method.
  ///
  /// The method will be stored in a UTF-8 string up to 31 bytes long, in the
  /// JPEG EXIF header.
  Future<void> setGpsProcessingMethod(String processingMethod) {
    return _channel.$setGpsProcessingMethod(this, processingMethod);
  }

  // TODO: In java this is actually passed to a long?
  /// Sets GPS timestamp.
  ///
  /// This will be stored in JPEG EXIF header. GPS timestamp
  /// (UTC in seconds since January 1, 1970).
  Future<void> setGpsTimestamp(int timestamp) {
    return _channel.$setGpsTimestamp(this, timestamp);
  }

  /// Sets Jpeg quality of captured picture.
  ///
  /// The range is 1 to 100, with 100 being the best.
  Future<void> setJpegQuality(int quality) {
    return _channel.$setJpegQuality(this, quality);
  }

  /// Sets the quality of the EXIF thumbnail in Jpeg picture.
  ///
  /// The range is 1 to 100, with 100 being the best.
  Future<void> setJpegThumbnailQuality(int quality) {
    return _channel.$setJpegThumbnailQuality(this, quality);
  }

  /// Sets the dimensions for EXIF thumbnail in Jpeg picture in pixels.
  ///
  /// If applications set both width and height to 0, EXIF will not contain
  /// thumbnail.
  ///
  /// Applications need to consider the display orientation. See
  /// [setPreviewSize] for reference.
  Future<void> setJpegThumbnailSize(int width, int height) {
    return _channel.$setJpegThumbnailSize(this, width, height);
  }

  /// Sets metering areas.
  ///
  /// See [getMeteringAreas] for documentation.
  Future<void> setMeteringAreas(List<CameraArea> meteringAreas) {
    return _channel.$setMeteringAreas(this, meteringAreas);
  }

  /// Sets the image format for pictures.
  ///
  /// See:
  ///   [ImageFormat]
  Future<void> setPictureFormat(int pixelFormat) {
    return _channel.$setPictureFormat(this, pixelFormat);
  }

  /// Sets the image format for preview pictures.
  ///
  /// If this is never called, the default format will be [ImageFormat.nv21],
  /// which uses the NV21 encoding format.
  ///
  /// Use [CameraParameters.getSupportedPreviewFormats] to get a list of the
  /// available preview formats.
  ///
  /// It is strongly recommended that either [ImageFormat.nv21] or
  /// [ImageFormat.yv12] is used, since they are supported by all camera devices.
  ///
  /// For YV12, the image buffer that is received is not necessarily tightly
  /// packed, as there may be padding at the end of each row of pixel data, as
  /// described in [ImageFormat.yv12]. For camera callback data, it can be
  /// assumed that the stride of the Y and UV data is the smallest possible
  /// that meets the alignment requirements. That is, if the preview size is
  /// width x height, then the following equations describe the buffer index for
  /// the beginning of row y for the Y plane and row c for the U and V planes:
  ///
  /// ```
  /// yStride   = (int) ceil(width / 16.0) * 16;
  /// uvStride  = (int) ceil( (yStride / 2) / 16.0) * 16;
  /// ySize     = yStride * height;
  /// uvSize    = uvStride * height / 2;
  /// yRowIndex = yStride * y;
  /// uRowIndex = ySize + uvSize + uvStride * c;
  /// vRowIndex = ySize + uvStride * c;
  /// size      = ySize + uvSize * 2;
  /// ```
  Future<void> setPreviewFormat(int pixelFormat) {
    return _channel.$setPreviewFormat(this, pixelFormat);
  }

  /// Sets the minimum and maximum preview fps.
  ///
  /// This controls the rate of preview frames received in [PreviewCallback].
  /// The minimum and maximum preview fps must be one of the elements from
  /// [getSupportedPreviewFpsRange].
  ///
  /// `min`: the minimum preview fps (scaled by 1000).
  /// `max`: the maximum preview fps (scaled by 1000).
  ///
  /// Throws a [PlatformException] if fps range is invalid.
  Future<void> setPreviewFpsRange({required int min, required int max}) {
    return _channel.$setPreviewFpsRange(this, min, max);
  }

  /// Sets the scene mode.
  ///
  /// Changing scene mode may override other parameters (such as flash mode,
  /// focus mode, white balance). For example, suppose originally flash mode is
  /// on and supported flash modes are on/off. In night scene mode, both flash
  /// mode and supported flash mode may be changed to off. After setting scene
  /// mode, applications should call [getParameters] to know if some parameters
  /// are changed.
  Future<void> setSceneMode(String mode) {
    return _channel.$setSceneMode(this, mode);
  }

  /// Enables and disables video stabilization.
  ///
  /// Use [isVideoStabilizationSupported] to determine if calling this method is
  /// valid.
  ///
  /// Video stabilization reduces the shaking due to the motion of the camera in
  /// both the preview stream and in recorded videos, including data received
  /// from the preview callback. It does not reduce motion blur in images
  /// captured with [Camera.takePicture].
  ///
  /// Video stabilization can be enabled and disabled while preview or recording
  /// is active, but toggling it may cause a jump in the video stream that may
  /// be undesirable in a recorded video.
  ///
  /// See:
  ///   [getVideoStabilization]
  Future<void> setVideoStabilization({required bool toggle}) {
    return _channel.$setVideoStabilization(this, toggle);
  }

  /// Sets the white balance.
  ///
  /// Changing the setting will release the auto-white balance lock. It is
  /// recommended not to change white balance and AWB lock at the same time.
  ///
  /// See:
  ///   [getWhiteBalance]
  ///   [setAutoWhiteBalanceLock]
  Future<void> setWhiteBalance(String value) {
    return _channel.$setWhiteBalance(this, value);
  }

  /// Takes a flattened string of parameters and adds each one to this [CameraParameter]s object.
  ///
  /// The [flatten] method does the reverse.
  ///
  /// [flattened] is a String of parameters (key-value paired) that are
  /// semi-colon delimited.
  Future<void> unflatten(String flattened) {
    return _channel.$unflatten(this, flattened);
  }
}

/// Used for choosing specific metering and focus areas for the camera to use when calculating auto-exposure, auto-white balance, and auto-focus.
///
/// To find out how many simultaneous areas a given camera supports, use
/// [CameraParameters.getMaxNumMeteringAreas] and
/// [CameraParameters.getMaxNumFocusAreas]. If metering or focusing area
/// selection is unsupported, these methods will return 0.
///
/// Each Area consists of a rectangle specifying its bounds, and a weight that
/// determines its importance. The bounds are relative to the camera's current
/// field of view. The coordinates are mapped so that (-1000, -1000) is always
/// the top-left corner of the current field of view, and (1000, 1000) is always
/// the bottom-right corner of the current field of view. Setting Areas with
/// bounds outside that range is not allowed. Areas with zero or negative width
/// or height are not allowed.
///
/// The weight must range from 1 to 1000, and represents a weight for every
/// pixel in the area. This means that a large metering area with the same
/// weight as a smaller area will have more effect in the metering result.
/// Metering areas can overlap and the driver will add the weights in the
/// overlap region.
@Reference('penguin_android_camera/camera/CameraArea')
class CameraArea with $CameraArea {
  /// Default constructor for [CameraArea].
  ///
  /// [createInstancePair] is whether a paired instance should be created on
  /// construction. This is only used internally and defaults to `true`.
  CameraArea(
    this.rect,
    this.weight, {
    @ignoreParam bool create = true,
  }) {
    if (create) {
      _channel.$$create(
        this,
        $owner: true,
        rect: rect,
        weight: weight,
      );
    }
  }

  static $CameraAreaChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCameraArea;

  /// Bounds of the area.
  ///
  /// (-1000, -1000) represents the top-left of the camera field of view, and
  /// (1000, 1000) represents the bottom-right of the field of view.
  /// Setting bounds outside that range is not allowed. Bounds with zero or
  /// negative width or height are not allowed.
  final CameraRect rect;

  /// Weight of the area.
  ///
  /// The weight must range from 1 to 1000, and represents a weight for every
  /// pixel in the area. This means that a large metering area with the same
  /// weight as a smaller area will have more effect in the metering result.
  /// Metering areas can overlap and the driver will add the weights in the
  /// overlap region.
  final int weight;

  @ReferenceMethod(ignore: true)
  @override
  String toString() {
    return 'CameraArea($rect, $weight)';
  }
}

/// Holds four integer coordinates for a rectangle.
///
/// The rectangle is represented by the coordinates of its 4 edges
/// (left, top, right bottom).
@Reference('penguin_android_camera/camera/CameraArea')
class CameraRect with $CameraRect {
  /// Default constructor for [CameraRect].
  ///
  /// [createInstancePair] is whether a paired instance should be created on
  /// construction. This is only used internally and defaults to `true`.
  ///
  /// left <= right and top <= bottom
  CameraRect({
    required this.top,
    required this.bottom,
    required this.right,
    required this.left,
    @ignoreParam bool create = true,
  }) {
    if (create) {
      _channel.$$create(
        this,
        $owner: true,
        top: top,
        bottom: bottom,
        right: right,
        left: left,
      );
    }
  }

  static $CameraRectChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCameraRect;

  /// The offset of the top edge of this rectangle from the y axis.
  final int top;

  /// The offset of the bottom edge of this rectangle from the y axis.
  final int bottom;

  /// The offset of the right edge of this rectangle from the x axis.
  final int right;

  /// The offset of the left edge of this rectangle from the x axis.
  final int left;

  @ReferenceMethod(ignore: true)
  @override
  String toString() {
    return 'CameraRect($top, $bottom, $right, $left)';
  }
}

/// Image size (width and height dimensions).
@Reference('penguin_android_camera/camera/CameraSize')
class CameraSize with $CameraSize {
  /// Default constructor for [CameraSize].
  CameraSize(this.width, this.height);

  /// Height of a picture.
  final int width;

  /// Width of a picture.
  final int height;

  @ReferenceMethod(ignore: true)
  @override
  String toString() {
    return 'CameraSize($width, $height)';
  }
}

/// Information about a camera.
///
/// Retrieve by calling [Camera.getAllCameraInfo].
@Reference('penguin_android_camera/camera/CameraInfo')
class CameraInfo implements $CameraInfo {
  /// Default constructor for [CameraInfo].
  CameraInfo({
    required this.cameraId,
    required this.facing,
    required this.orientation,
    required this.canDisableShutterSound,
  }) : assert(facing == cameraFacingBack || facing == cameraFacingFront);

  /// The facing of the camera is opposite to that of the screen.
  static const int cameraFacingBack = 0;

  /// The facing of the camera is the same as that of the screen.
  static const int cameraFacingFront = 1;

  /// The identifier for this camera device.
  ///
  /// This can be used in [Camera.open].
  final int cameraId;

  /// The direction that the camera faces.
  ///
  /// It should be [CameraInfo.cameraFacingBack] or
  /// [CameraInfo.cameraFacingFront].
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

  /// Whether the shutter sound can be disabled.
  ///
  /// On some devices, the camera shutter sound cannot be turned off through
  /// [Camera.enableShutterSound]. This field can be used to determine whether
  /// a call to disable the shutter sound will succeed.
  ///
  /// If this field is set to true, then a call of
  /// [Camera.enableShutterSound](false) will be successful. If set to false,
  /// then that call will fail, and the shutter sound will be played when
  /// [Camera.takePicture] is called.
  ///
  /// This is only supported on Android
  /// versions >= `Build.VERSION_CODES.JELLY_BEAN_MR1`. This value will be
  /// `null` for all version below this one.
  final bool? canDisableShutterSound;
}

/// Defines the output format.
///
/// These constants are used with [MediaRecorder.setOutputFormat].
abstract class OutputFormat {
  OutputFormat._();

  /// AAC ADTS file format.
  static const int aacAdts = 0x00000006;

  /// AMR NB file format.
  static const int amrNb = 0x00000003;

  /// AMR WB file format.
  static const int amrWb = 0x00000004;

  /// Default format used by the device.
  static const int defaultFormat = 0x00000000;

  /// H.264/AAC data encapsulated in MPEG2/TS.
  static const int mpeg2Ts = 0x00000008;

  /// MPEG4 media file format.
  static const int mpeg4 = 0x00000002;

  /// Opus data in a Ogg container.
  static const int ogg = 0x0000000b;

  /// AMR NB file format.
  @Deprecated('Please use `OutputFormat.amrNb`')
  static const int rawAmr = 0x00000003;

  /// 3GPP media file format.
  static const int threeGpp = 0x00000001;

  /// VP8/VORBIS data in a WEBM container.
  static const int webm = 0x00000009;
}

/// Defines the video encoding.
///
/// These constants are used with [MediaRecorder.setVideoEncoder].
abstract class VideoEncoder {
  /// Android MediaRecorder.VideoEncoder.MPEG_4_SP format.
  static const int mpeg4Sp = 0x00000003;

  /// Android MediaRecorder.VideoEncoder.H263 format.
  static const int h263 = 0x00000001;

  /// Android MediaRecorder.VideoEncoder.H264 format.
  static const int h264 = 0x00000002;

  /// Android MediaRecorder.VideoEncoder.HEVC format.
  static const int hevc = 0x00000005;

  /// Android MediaRecorder.VideoEncoder.VP8 format.
  static const int vp8 = 0x00000004;

  /// Android MediaRecorder.VideoEncoder.DEFAULT format.
  static const int defaultEncoding = 0x00000000;
}

/// Defines the audio source.
///
/// An audio source defines both a default physical source of audio signal, and
/// a recording configuration. These constants are for instance used in
/// [MediaRecorder.setAudioSource].
abstract class AudioSource {
  /// Microphone audio source tuned for video recording, with the same orientation as the camera if available.
  static const int camcorder = 0x00000005;

  /// Default audio source.
  static const int defaultSource = 0x00000000;

  /// Microphone audio source
  static const int mic = 0x00000001;

  /// Audio source for a submix of audio streams to be presented remotely.
  ///
  /// An application can use this audio source to capture a mix of audio streams
  /// that should be transmitted to a remote receiver such as a Wifi display.
  /// While recording is active, these audio streams are redirected to the
  /// remote submix instead of being played on the device speaker or headset.
  ///
  /// Certain streams are excluded from the remote submix, including Android
  /// AudioManager#STREAM_RING, AudioManager#STREAM_ALARM, and
  /// AudioManager#STREAM_NOTIFICATION. These streams will continue to be
  /// presented locally as usual.
  ///
  /// Capturing the remote submix audio requires the Android
  /// `Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission. This permission is
  /// reserved for use by system components and is not available to third-party
  /// applications.
  static const int remoteSubmix = 0x00000008;

  /// Microphone audio source tuned for unprocessed (raw) sound if available, behaves like [defaultSource] otherwise.
  static const int unprocessed = 0x00000009;

  /// Voice call uplink + downlink audio source.
  ///
  /// Capturing from [voiceCall] source requires the Android
  /// `Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission. This permission is
  /// reserved for use by system components and is not available to third-party
  /// applications.
  static const int voiceCall = 0x00000004;

  /// Microphone audio source tuned for voice communications such as VoIP.
  ///
  /// It will for instance take advantage of echo cancellation or automatic gain
  /// control if available.
  static const int voiceCommunication = 0x00000007;

  /// Voice call downlink (Rx) audio source.
  ///
  /// Capturing from [voiceDownlink] source requires the Android
  /// `Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission. This permission is
  /// reserved for use by system components and is not available to third-party
  /// applications.
  static const int voiceDownlink = 0x00000003;

  /// Source for capturing audio meant to be processed in real time and played back for live performance (e.g karaoke).
  ///
  /// The capture path will minimize latency and coupling with playback path.
  static const int voicePerformance = 0x0000000a;

  /// Microphone audio source tuned for voice recognition.
  static const int voiceRecognition = 0x00000006;

  /// Voice call uplink (Tx) audio source.
  ///
  /// Capturing from [voiceUplink] source requires the Android
  /// `Manifest.permission.CAPTURE_AUDIO_OUTPUT` permission. This permission is
  /// reserved for use by system components and is not available to third-party
  /// applications.
  static const int voiceUplink = 0x00000002;
}

/// Defines the audio encoding.
///
/// These constants are used with [MediaRecorder.setAudioEncoder].
abstract class AudioEncoder {
  /// AAC Low Complexity (AAC-LC) audio codec.
  static const int aac = 0x00000003;

  /// Enhanced Low Delay AAC (AAC-ELD) audio codec.
  static const int aacEld = 0x00000005;

  /// AMR (Narrowband) audio codec.
  static const int amrNb = 0x00000001;

  /// AMR (Wideband) audio codec.
  static const int amrWb = 0x00000002;

  /// Android `MediaRecorder.AudioEncoder.DEFAULT` format.
  static const int defaultEncoding = 0x00000000;

  /// High Efficiency AAC (HE-AAC) audio codec.
  static const int heAcc = 0x00000004;

  /// Opus audio codec.
  static const int opus = 0x00000007;

  /// Ogg Vorbis audio codec (Support is optional).
  static const int vorbis = 0x00000006;
}

/// Defines the video source.
///
/// These constants are used with [MediaRecorder.setVideoSource].
abstract class VideoSource {
  /// Using the Android Camera API as video source. (e.x. [Camera]).
  static const int camera = 0x00000001;

  /// Android `MediaRecorder.VideoSource.DEFAULT` source.
  static const int defaultSource = 0x00000000;
}

/// Used to record audio and video.
///
/// For a more detailed explanation:
/// https://developer.android.com/reference/android/media/MediaRecorder
@Reference('penguin_android_camera/camera/MediaRecorder')
class MediaRecorder implements $MediaRecorder {
  /// Default constructor for [MediaRecorder].
  MediaRecorder({@ignoreParam bool create = true}) {
    if (create) _channel.$$create(this, $owner: true);
  }

  /// Media server died.
  ///
  /// In this case, the application must release the [MediaRecorder] object and
  /// instantiate a new one.
  static const int errorServerDied = 0x00000064;

  /// Unspecified media recorder error.
  static const int errorUnknown = 0x00000001;

  /// A maximum duration had been setup and has now been reached.
  static const int infoMaxDurationReached = 0x00000320;

  /// A maximum filesize had been setup and has now been reached.
  ///
  /// Note: This event will not be sent if application already set next output
  /// file through [setNextOutputFile].
  static const int infoMaxFilesizeReached = 0x00000321;

  /// Unspecified media recorder info.
  static const int infoUnknown = 0x00000001;

  static $MediaRecorderChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelMediaRecorder;

  /// Gets the maximum value for audio sources.
  ///
  /// See: [AudioSource]
  static Future<int> getAudioSourceMax() async {
    return await _channel.$getAudioSourceMax() as int;
  }

  /// Sets a Camera to use for recording.
  ///
  /// Use this function to switch quickly between preview and capture mode
  /// without a teardown of the camera object. [Camera.unlock] should be called
  /// before this. Must call before [prepare].
  Future<void> setCamera(covariant Camera camera) =>
      _channel.$setCamera(this, camera);

  /// Sets the video source to be used for recording.
  ///
  /// If this method is not called, the output file will not contain a video
  /// track. The source needs to be specified before setting
  /// recording-parameters or encoders. Call this only before [setOutputFormat].
  ///
  /// Throws [PlatformException] if it is called after [setOutputFormat].
  Future<void> setVideoSource(int source) =>
      _channel.$setVideoSource(this, source);

  /// Sets the path of the output file to be produced.
  ///
  /// Call this after [setOutputFormat] but before [prepare].
  Future<void> setOutputFilePath(String path) =>
      _channel.$setOutputFilePath(this, path);

  /// Sets the format of the output file produced during recording. Call this
  /// after [setAudioSource]/[setVideoSource] but before [prepare].
  ///
  /// It is recommended to always use 3GP format when using the H.263 video
  /// encoder and AMR audio encoder. Using an MPEG-4 container format may
  /// confuse some desktop players.
  Future<void> setOutputFormat(int format) =>
      _channel.$setOutputFormat(this, format);

  /// Sets the video encoder to be used for recording.
  ///
  /// If this method is not called, the output file will not contain an video
  /// track. Call this after [setOutputFormat] and before [prepare].
  Future<void> setVideoEncoder(int encoder) =>
      _channel.$setVideoEncoder(this, encoder);

  /// Sets the audio source to be used for recording.
  ///
  /// If this method is not called, the output file will not contain an audio
  /// track. The source needs to be specified before setting
  /// recording-parameters or encoders. Call this only before [setOutputFormat].
  Future<void> setAudioSource(int source) =>
      _channel.$setAudioSource(this, source);

  /// Sets the audio encoder to be used for recording.
  ///
  /// If this method is not called, the output file will not contain an audio
  /// track. Call this after [setOutputFormat] but before [prepare].
  Future<void> setAudioEncoder(int encoder) =>
      _channel.$setAudioEncoder(this, encoder);

  /// Prepares the recorder to begin capturing and encoding data.
  ///
  /// This method must be called after setting up the desired audio and video
  /// sources, encoders, file format, etc., but before [start].
  Future<void> prepare() => _channel.$prepare(this);

  /// Begins capturing and encoding data to the file specified with [setOutputFile].
  ///
  /// Call this after [prepare].
  ///
  /// If applications set a camera via [setCamera], the apps can use the camera
  /// after this method call. The apps do not need to lock the camera again.
  /// However, if this method fails, the apps should still lock the camera back.
  /// The apps should not start another recording session during recording.
  Future<void> start() => _channel.$start(this);

  /// Stops recording.
  ///
  /// Call this after [start]. Once recording is stopped, you will have to
  /// configure it again as if it has just been constructed. Note that a
  /// [PlatformException] is intentionally thrown to the application, if no
  /// valid audio/video data has been received when [stop] is called. This
  /// happens if [stop] is called immediately after start(). The failure lets
  /// the application take action accordingly to clean up the output file
  /// (delete the output file, for instance), since the output file is not
  /// properly constructed when this happens.
  Future<void> stop() => _channel.$stop(this);

  /// Releases resources associated with this MediaRecorder object.
  ///
  /// It is good practice to call this method when you're done using the
  /// [MediaRecorder]. In particular, whenever a user leaves the application,
  /// this method should be invoked to release the [MediaRecorder] object,
  /// unless the application has a special need to keep the object around. In
  /// addition to unnecessary resources (such as memory and instances of codecs)
  /// being held, failure to call this method immediately if a [MediaRecorder]
  /// object is no longer needed may also lead to continuous battery consumption
  /// for mobile devices, and recording failure for other applications if no
  /// multiple instances of the same codec are supported on a device. Even if
  /// multiple instances of the same codec are supported, some performance
  /// degradation may be expected when unnecessary multiple instances are used
  /// at the same time.
  Future<void> release() => _channel.$release(this);

  /// Pauses recording.
  ///
  /// Call this after [start]. You may resume recording with [resume] without
  /// reconfiguration, as opposed to [stop]. It does nothing if the recording
  /// is already paused. When the recording is paused and resumed, the resulting
  /// output would be as if nothing happened during paused period, immediately
  /// switching to the resumed scene.
  ///
  /// This is only supported on Android versions >= `Build.VERSION_CODES.N`. A
  /// [PlatformException] will be thrown on lower versions.
  Future<void> pause() => _channel.$pause(this);

  /// Resumes recording.
  ///
  /// Call this after [start]. It does nothing if the recording is not paused.
  ///
  /// This is only supported on Android versions >= `Build.VERSION_CODES.N`. A
  /// [PlatformException] will be thrown on lower versions.
  Future<void> resume() => _channel.$resume(this);

  /// Returns the maximum absolute amplitude that was sampled since the last call to this method.
  ///
  /// Call this only after the [setAudioSource].
  ///
  /// Returns 0 when called for the first time.
  ///
  /// Throws [PlatformException] if called before audio source has been set.
  Future<int> getMaxAmplitude() async {
    return await _channel.$getMaxAmplitude(this) as int;
  }

  /// Restarts the MediaRecorder to its idle state.
  ///
  /// After calling this method, you will have to configure it again as if it
  /// had just been constructed.
  Future<void> reset() {
    return _channel.$reset(this);
  }

  /// Sets the number of audio channels for recording.
  ///
  /// Call this method before [prepare]. [prepare] may perform additional checks
  /// on the parameter to make sure whether the specified number of audio
  /// channels are applicable.
  ///
  /// Usually it is either 1 (mono) or 2 (stereo).
  Future<void> setAudioChannels(int numChannels) {
    return _channel.$setAudioChannels(this, numChannels);
  }

  /// Sets the audio encoding bit rate for recording in bits per second.
  ///
  /// Call this method before [prepare]. [prepare] may perform additional checks
  /// on the parameter to make sure whether the specified bit rate is
  /// applicable, and sometimes the passed bitRate will be clipped internally to
  /// ensure the audio recording can proceed smoothly based on the capabilities
  /// of the platform.
  Future<void> setAudioEncodingBitRate(int bitRate) {
    return _channel.$setAudioEncodingBitRate(this, bitRate);
  }

  /// Sets the audio sampling rate for recording in samples per second.
  ///
  /// Call this method before [prepare]. [prepare] may perform additional checks
  /// on the parameter to make sure whether the specified audio sampling rate is
  /// applicable. The sampling rate really depends on the format for the audio
  /// recording, as well as the capabilities of the platform. For instance, the
  /// sampling rate supported by AAC audio coding standard ranges from 8 to 96
  /// kHz, the sampling rate supported by AMRNB is 8kHz, and the sampling rate
  /// supported by AMRWB is 16kHz. Please consult with the related audio coding
  /// standard for the supported audio sampling rate.
  Future<void> setAudioSamplingRate(int samplingRate) {
    return _channel.$setAudioSamplingRate(this, samplingRate);
  }

  /// Set video frame capture rate.
  ///
  /// This can be used to set a different video frame capture rate than the
  /// recorded video's playback rate. This method also sets the recording mode
  /// to time lapse. In time lapse video recording, only video is recorded.
  /// Audio related parameters are ignored when a time lapse recording session
  /// starts, if an application sets them.
  ///
  /// `fps`: Rate at which frames should be captured in frames per second.
  /// The fps can go as low as desired. However the fastest fps will be limited
  /// by the hardware. For resolutions that can be captured by the video camera,
  /// the fastest fps can be computed using
  /// [CameraParameters.getPreviewFpsRange] For higher resolutions the fastest
  /// fps may be more restrictive. Note that the recorder cannot guarantee that
  /// frames will be captured at the given rate due to camera/encoder
  /// limitations. However it tries to be as close as possible.
  Future<void> setCaptureRate(double fps) {
    return _channel.$setCaptureRate(this, fps);
  }

  /// Set and store the geodata (latitude and longitude) in the output file.
  ///
  /// This method should be called before [prepare]. The geodata is stored in
  /// udta box if the output format is [OutputFormat.threeGpp] or
  /// [OutputFormat.mpeg4], and is ignored for other output formats. The geodata
  /// is stored according to ISO-6709 standard.
  ///
  /// `latitude`: latitude in degrees. Its value must be in the range [-90, 90].
  /// `longitude`: longitude in degrees. Its value must be in the range
  /// [-180, 180].
  ///
  /// Throws a [PlatformException] if latitude or longitude are out of range.
  Future<void> setLocation(double latitude, double longitude) {
    return _channel.$setLocation(this, latitude, longitude);
  }

  /// Sets the maximum duration (in ms) of the recording session.
  ///
  /// Call this after [setOutputFormat] but before [prepare]. After recording
  /// reaches the specified duration, a notification will be sent to the
  /// [OnInfoListener] with a "what" code of [infoMaxDurationReached] and
  /// recording will be stopped. Stopping happens asynchronously, there is no
  /// guarantee that the recorder will have stopped by the time the listener is
  /// notified.
  ///
  /// When using MPEG-4 container ([setOutputFormat] with [OutputFormat.mpeg4]),
  /// it is recommended to set maximum duration that fits the use case. Setting
  /// a larger than required duration may result in a larger than needed output
  /// file because of space reserved for MOOV box expecting large movie data in
  /// this recording session. Unused space of MOOV box is turned into FREE box
  /// in the output file.
  Future<void> setMaxDuration(int maxDurationMs) {
    return _channel.$setMaxDuration(this, maxDurationMs);
  }

  /// Sets the maximum filesize (in bytes) of the recording session.
  ///
  /// Call this after [setOutputFormat] but before [prepare]. After recording
  /// reaches the specified filesize, a notification will be sent to the
  /// [OnInfoListener] with a "what" code of [infoMaxFilesizeReached] and
  /// recording will be stopped. Stopping happens asynchronously, there is no
  /// guarantee that the recorder will have stopped by the time the listener is
  /// notified.
  ///
  /// When using MPEG-4 container ([setOutputFormat] with [OutputFormat.mpeg4]),
  /// it is recommended to set maximum filesize that fits the use case. Setting
  /// a larger than required filesize may result in a larger than needed output
  /// file because of space reserved for MOOV box expecting large movie data in
  /// this recording session. Unused space of MOOV box is turned into FREE box
  /// in the output file.
  Future<void> setMaxFileSize(int maxFilesizeBytes) {
    return _channel.$setMaxFileSize(this, maxFilesizeBytes);
  }

  /// Register a callback to be invoked when an error occurs while recording.
  Future<void> setOnErrorListener({required OnErrorListener onError}) {
    ChannelRegistrar.instance.implementations.channelOnErrorListener.$$create(
      onError,
      $owner: false,
    );
    return _channel.$setOnErrorListener(this, onError);
  }

  /// Register a callback to be invoked when an informational event occurs while recording.
  Future<void> setOnInfoListener({required OnInfoListener onInfo}) {
    ChannelRegistrar.instance.implementations.channelOnInfoListener.$$create(
      onInfo,
      $owner: false,
    );
    return _channel.$setOnInfoListener(this, onInfo);
  }

  /// Sets the orientation hint for output video playback.
  ///
  /// This method should be called before [prepare]. This method will not
  /// trigger the source video frame to rotate during video recording, but to
  /// add a composition matrix containing the rotation angle in the output video
  /// if the output format is [OutputFormat.threeGpp] or [OutputFormat.mpeg4] so
  /// that a video player can choose the proper orientation for playback. Note
  /// that some video players may choose to ignore the compostion matrix in a
  /// video during playback.
  ///
  /// The supported angles are 0, 90, 180, and 270 degrees.
  ///
  /// Throws a [PlatformException] is the angle is not supported.
  Future<void> setOrientationHint(int degrees) {
    return _channel.$setOrientationHint(this, degrees);
  }

  /// Sets the video encoding bit rate for recording in bits per seconds.
  ///
  /// Call this method before [prepare]. [prepare] may perform additional checks
  /// on the parameter to make sure whether the specified bit rate is
  /// applicable, and sometimes the passed bitRate will be clipped internally to
  /// ensure the video recording can proceed smoothly based on the capabilities
  /// of the platform.
  Future<void> setVideoEncodingBitRate(int bitRate) {
    return _channel.$setVideoEncodingBitRate(this, bitRate);
  }

  /// Sets the frame rate of the video to be captured in frames per second.
  ///
  /// Must be called after [setVideoSource]. Call this after [setOutputFormat]
  /// but before [prepare].
  ///
  /// Throws [PlatformException] if it is called after [prepare] or before
  /// [setOutputFormat]. NOTE: On some devices that have auto-frame rate, this
  /// sets the maximum frame rate, not a constant frame rate. Actual frame rate
  /// will vary according to lighting conditions.
  Future<void> setVideoFrameRate(int rate) {
    return _channel.$setVideoFrameRate(this, rate);
  }

  /// Sets the width and height of the video to be captured.
  ///
  /// Must be called after [setVideoSource]. Call this after [setOutputFormat]
  /// but before [prepare].
  ///
  /// Throws [PlatformException] if it is called after [prepare] or before
  /// [setOutputFormat].
  Future<void> setVideoSize(int width, int height) {
    return _channel.$setVideoSize(this, width, height);
  }

  /// Uses the settings from a [CamcorderProfile] object for recording.
  ///
  /// This method should be called after the video AND audio sources are set,
  /// and before [setOutputFile]. If a time lapse CamcorderProfile is used,
  /// audio related source or recording parameters are ignored.
  Future<void> setProfile(CamcorderProfile profile) {
    return _channel.$setProfile(this, profile);
  }
}

/// Image format constants.
@Reference('penguin_android_camera/camera/ImageFormat')
abstract class ImageFormat {
  ImageFormat._();

  static $ImageFormatChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelImageFormat;

  /// Android dense depth image format.
  ///
  /// Each pixel is 16 bits, representing a depth ranging measurement from a
  /// depth camera or similar sensor. The 16-bit sample consists of a confidence
  /// value and the actual ranging measurement.
  ///
  /// The confidence value is an estimate of correctness for this sample. It is
  /// encoded in the 3 most significant bits of the sample, with a value of 0
  /// representing 100% confidence, a value of 1 representing 0% confidence, a
  /// value of 2 representing 1/7, a value of 3 representing 2/7, and so on.
  ///
  /// This format assumes
  ///   * an even width
  ///   * an even height
  ///   * a horizontal stride multiple of 16 pixels
  ///
  /// `y_size = stride * height`
  ///
  /// When produced by a camera, the units for the range are millimeters.
  ///
  /// See:
  ///   https://developer.android.com/reference/android/graphics/ImageFormat#DEPTH16
  static const int depth16 = 0x44363159;

  /// Depth augmented compressed JPEG format.
  ///
  /// JPEG compressed main image along with XMP embedded depth metadata
  /// following ISO 16684-1:2011(E).
  static const int depthJpeg = 0x69656963;

  /// Compressed HEIC format.
  ///
  /// This format defines the HEIC brand of High Efficiency Image File Format as
  /// described in ISO/IEC 23008-12.
  static const int heic = 0x48454946;

  /// Compressed JPEG format.
  ///
  /// This format is always supported as an output format for the
  /// android.hardware.camera2 API, and as a picture format for the older
  /// Camera API.
  static const int jpeg = 0x00000100;

  /// YCbCr format, used for video.
  ///
  /// Whether this format is supported by the old camera API can be determined
  /// by [CameraParameters.getSupportedPreviewFormats].
  static const int nv16 = 0x00000010;

  /// YCrCb format used for images, which uses the NV21 encoding format.
  ///
  /// This is the default format for Camera preview images, when not otherwise
  /// set with [CameraParameters.setPreviewFormat].
  static const int nv21 = 0x00000011;

  /// Private raw camera sensor image format, a single channel image with implementation depedent pixel layout.
  ///
  /// [rawPrivate] is a format for unprocessed raw image buffers coming from an
  /// image sensor. The actual structure of buffers of this format is
  /// implementation-dependent.
  static const int rawPrivate = 0x00000024;

  /// RGB format used for pictures encoded as RGB_565.
  ///
  /// See [CameraParameters.setPictureFormat].
  static const int rgb565 = 0x00000004;

  // ignore: public_member_api_docs
  static const int unknown = 0x00000000;

  /// YCbCr format used for images, which uses YUYV (YUY2) encoding format.
  ///
  /// This is an alternative format for Camera preview images. Whether this
  /// format is supported by the camera hardware can be determined by
  /// [CameraParameters.getSupportedPreviewFormats].
  static const int yuy2 = 0x00000014;

  /// Android YUV format.
  ///
  /// This format is exposed to software decoders and applications.
  ///
  /// YV12 is a 4:2:0 YCrCb planar format comprised of a WxH Y plane followed by
  /// (W/2) x (H/2) Cr and Cb planes.
  ///
  /// This format assumes:
  ///   * an even width
  ///   * an even height
  ///   * a horizontal stride multiple of 16 pixels
  ///   * a vertical stride equal to the height
  ///
  /// ```dart
  ///  y_size = stride * height
  ///  c_stride = ALIGN(stride/2, 16)
  ///  c_size = c_stride * height/2
  ///  size = y_size + c_size * 2
  ///  cr_offset = y_size
  ///  cb_offset = y_size + c_size
  /// ``
  ///
  /// This format is guaranteed to be supported for Camera preview images; for
  /// earlier API versions.
  ///
  /// Note that for camera preview callback use (see
  /// [Camera.setPreviewCallback]), the stride value is the smallest possible;
  /// that is, it is equal to:
  ///
  /// `stride = ALIGN(width, 16)`
  ///
  /// See:
  ///   https://developer.android.com/reference/android/graphics/ImageFormat#YV12
  static const int yv12 = 0x32315659;

  /// Use this function to retrieve the number of bits per pixel of an [ImageFormat].
  ///
  /// Returns the number of bits per pixel of the given format or -1 if the
  /// format doesn't exist or is not supported.
  static Future<int> getBitsPerPixel(int format) async {
    return await _channel.$getBitsPerPixel(format) as int;
  }
}

/// Retrieves the predefined camcorder profile settings for camcorder applications.
///
/// These settings are read-only.
///
/// The compressed output from a recording session with a given CamcorderProfile
/// contains two tracks: one for audio and one for video.
///
/// Each profile specifies the following set of parameters:
///   * File output format
///   * Video codec format
///   * Video bit rate in bits per second
///   * Video frame rate in frames per second
///   * Video frame width and height,
///   * Audio codec format
///   * Audio bit rate in bits per second,
///   * Audio sample rate
///   * Number of audio channels for recording
@Reference('penguin_android_camera/camera/ImageFormat')
class CamcorderProfile implements $CamcorderProfile {
  /// Default constructor for [CamcorderProfile].
  ///
  /// See:
  ///   [MediaRecorder]
  ///   [CamcorderProfile.get]
  @visibleForTesting
  CamcorderProfile({
    required this.audioBitRate,
    required this.audioChannels,
    required this.audioCodec,
    required this.audioSampleRate,
    required this.duration,
    required this.fileFormat,
    required this.quality,
    required this.videoBitRate,
    required this.videoCodec,
    required this.videoFrameHeight,
    required this.videoFrameRate,
    required this.videoFrameWidth,
  });

  /// Quality level corresponding to the 1080p (1920 x 1080) resolution.
  ///
  /// Note that the vertical resolution for 1080p can also be 1088, instead of
  /// 1080 (used by some vendors to avoid cropping during video playback).
  static const int quality1080p = 0x00000006;

  /// Quality level corresponding to the 2160p (3840x2160) resolution.
  static const int quality2160p = 0x00000008;

  /// Quality level corresponding to the 480p (720 x 480) resolution.
  ///
  /// Note that the horizontal resolution for 480p can also be other values,
  /// such as 640 or 704, instead of 720.
  static const int quality480p = 0x00000004;

  /// Quality level corresponding to the 720p (1280 x 720) resolution.
  static const int quality720p = 0x00000005;

  /// Quality level corresponding to the cif (352 x 288) resolution.
  static const int qualityCif = 0x00000003;

  /// Quality level corresponding to the highest available resolution.
  static const int qualityHigh = 0x00000001;

  /// High speed ( >= 100fps) quality level corresponding to the 1080p (1920 x 1080 or 1920x1088) resolution.
  static const int qualityHighSpeed1080p = 0x000007d4;

  /// High speed ( >= 100fps) quality level corresponding to the 2160p (3840 x 2160) resolution.
  static const int qualityHighSpeed2160p = 0x000007d5;

  /// High speed ( >= 100fps) quality level corresponding to the 480p (720 x 480) resolution.
  ///
  /// Note that the horizontal resolution for 480p can also be other values,
  /// such as 640 or 704, instead of 720.
  static const int qualityHighSpeed480p = 0x000007d2;

  /// High speed ( >= 100fps) quality level corresponding to the 720p (1280 x 720) resolution.
  static const int qualityHighSpeed720p = 0x000007d3;

  /// High speed ( >= 100fps) quality level corresponding to the highest available resolution.
  static const int qualityHighSpeedHigh = 0x000007d1;

  /// High speed ( >= 100fps) quality level corresponding to the lowest available resolution.
  ///
  /// For all the high speed profiles defined below
  /// ((from [qualityHighSpeedLow] to [qualityHighSpeed2160p]), they are similar
  /// as normal recording profiles, with just higher output frame rate and bit
  /// rate. Therefore, setting these profiles with [MediaRecorder.setProfile]
  /// without specifying any other encoding parameters will produce high speed
  /// videos rather than slow motion videos that have different capture and
  /// output (playback) frame rates. To record slow motion videos, the
  /// application must set video output (playback) frame rate and bit rate
  /// appropriately via [MediaRecorder.setVideoFrameRate] and
  /// [MediaRecorder.setVideoEncodingBitRate] based on the slow motion factor.
  ///
  /// In native code:
  /// If the application intends to do the video recording with MediaCodec
  /// encoder, it must set each individual field of MediaFormat similarly
  /// according to this [CamcorderProfile].
  static const int qualityHighSpeedLow = 0x000007d0;

  /// High speed ( >= 100fps) quality level corresponding to the VGA (640 x 480).
  static const int qualityHighSpeedVga = 0x000007d7;

  /// Quality level corresponding to the lowest available resolution.
  static const int qualityLow = 0x00000000;

  /// Quality level corresponding to the qcif (176 x 144) resolution.
  static const int qualityQcif = 0x00000002;

  /// Quality level corresponding to the QVGA (320x240) resolution.
  static const int qualityQvga = 0x00000007;

  /// Time lapse quality level corresponding to the 1080p (1920 x 1088) resolution.
  static const int qualityTimeLapse1080p = 0x000003ee;

  /// Time lapse quality level corresponding to the 2160p (3840 x 2160) resolution.
  static const int qualityTimeLapse2160p = 0x000003f0;

  /// Time lapse quality level corresponding to the 480p (720 x 480) resolution.
  static const int qualityTimeLapse480p = 0x000003ec;

  /// Time lapse quality level corresponding to the 720p (1280 x 720) resolution.
  static const int qualityTimeLapse720p = 0x000003ed;

  /// Time lapse quality level corresponding to the cif (352 x 288) resolution.
  static const int qualityTimeLapseCif = 0x000003eb;

  /// Time lapse quality level corresponding to the highest available resolution.
  static const int qualityTimeLapseHigh = 0x000003e9;

  /// Time lapse quality level corresponding to the lowest available resolution.
  static const int qualityTimeLapseLow = 0x000003e8;

  /// Time lapse quality level corresponding to the qcif (176 x 144) resolution.
  static const int qualityTimeLapseQcif = 0x000003ea;

  /// Time lapse quality level corresponding to the QVGA (320 x 240) resolution.
  static const int qualityTimeLapseQvga = 0x000003ef;

  static $CamcorderProfileChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelCamcorderProfile;

  /// The target audio output bit rate in bits per second.
  final int audioBitRate;

  /// The number of audio channels used for the audio track.
  final int audioChannels;

  /// The audio encoder being used for the audio track.
  final int audioCodec;

  /// The audio sampling rate used for the audio track.
  final int audioSampleRate;

  /// Default recording duration in seconds before the session is terminated.
  ///
  /// This is useful for applications like MMS has limited file size requirement.
  final int duration;

  /// The file output format of the camcorder profile.
  final int fileFormat;

  /// The quality level of the camcorder profile.
  final int quality;

  /// The target video output bit rate in bits per second.
  ///
  /// This is the target recorded video output bit rate if the application
  /// configures the video recording via [MediaRecorder.setProfile] without
  /// specifying any other [MediaRecorder] encoding parameters. For example, for
  /// high speed quality profiles (from [qualityHighSpeedLow] to
  /// [qualityHighSpeed2160p]), this is the bit rate where the video is recorded
  /// with. If the application intends to record slow motion videos with the
  /// high speed quality profiles, it must set a different video bit rate that
  /// is corresponding to the desired recording output bit rate (i.e., the
  /// encoded video bit rate during normal playback) via
  /// [MediaRecorder.setVideoEncodingBitRate]. For example, if
  /// [qualityHighSpeed720p] advertises 240fps [videoFrameRate] and 64Mbps
  /// [videoBitRate] in the high speed [CamcorderProfile], and the application
  /// intends to record 1/8 factor slow motion recording videos, the application
  /// must set 30fps via [MediaRecorder.setVideoFrameRate] and 8Mbps
  /// (`videoBitRate * slow motion factor`) via
  /// [MediaRecorder.setVideoEncodingBitRate]. Failing to do so will result in
  /// videos with unexpected frame rate and bit rate, or [MediaRecorder] error
  /// if the output bit rate exceeds the encoder limit.
  ///
  /// In native Android code:
  /// If the application intends to do the video recording with MediaCodec
  /// encoder, it must set each individual field of MediaFormat similarly
  /// according to this [CamcorderProfile].
  final int videoBitRate;

  /// The video encoder being used for the video track.
  final int videoCodec;

  /// The target video frame height in pixels.
  final int videoFrameHeight;

  /// The target video frame rate in frames per second.
  ///
  /// This is the target recorded video output frame rate per second if the
  /// application configures the video recording via [MediaRecorder.setProfile]
  /// without specifying any other [MediaRecorder] encoding parameters. For
  /// example, for high speed quality profiles (from [qualityHighSpeedLow] to
  /// [qualityHighSpeed2160p]), this is the frame rate where the video is
  /// recorded and played back with. If the application intends to create slow
  /// motion use case with the high speed quality profiles, it must set a
  /// different video frame rate that is corresponding to the desired output
  /// (playback) frame rate via [MediaRecorder.setVideoFrameRate]. For example,
  /// if [qualityHighSpeed720p] advertises 240fps [videoFrameRate] in the
  /// [CamcorderProfile], and the application intends to create 1/8 factor slow
  /// motion recording videos, the application must set 30fps via
  /// [MediaRecorder.setVideoFrameRate]. Failing to do so will result in high
  /// speed videos with normal speed playback frame rate (240fps for above
  /// example).
  ///
  /// In Android native code:
  /// If the application intends to do the video recording with MediaCodec
  /// encoder, it must set each individual field of MediaFormat similarly
  /// according to this [CamcorderProfile].
  final int videoFrameRate;

  /// The target video frame width in pixels.
  final int videoFrameWidth;

  /// Returns the default camcorder profile for the given camera at the given quality level.
  ///
  /// Quality levels [qualityLow], [qualityHigh] are guaranteed to be supported,
  /// while other levels may or may not be supported. The supported levels can
  /// be checked using [CamcorderProfile.hasProfile]. [qualityLow] refers to the
  /// lowest quality available, while [qualityHigh] refers to the highest
  /// quality available. [qualityLow]/[qualityHigh] have to match one of
  /// qcif, cif, 480p, 720p, 1080p or 2160p. E.g. if the device supports 480p,
  /// 720p, 1080p and 2160p, then low is 480p and high is 2160p. The same is
  /// true for time lapse quality levels, i.e. [qualityTimeLapseLow],
  /// [qualityTimeLapseHigh] are guaranteed to be supported and have to match
  /// one of qcif, cif, 480p, 720p, 1080p, or 2160p. For high speed quality
  /// levels, they may or may not be supported. If a subset of the levels are
  /// supported, [qualityHighSpeedLow] and [qualityHighSpeedHigh] are guaranteed
  /// to be supported and have to match one of 480p, 720p, or 1080p. A camcorder
  /// recording session with higher quality level usually has higher output bit
  /// rate, better video and/or audio recording quality, larger video frame
  /// resolution and higher audio sampling rate, etc, than those with lower
  /// quality level.
  ///
  /// `cameraId`: id from [CameraInfo] from [Camera.getAllCameraInfo].
  ///
  /// Throws an [PlatformException] if  quality is not one of the defined
  /// `quality...` const values.
  static Future<CamcorderProfile> get(int cameraId, int quality) async {
    return await _channel.$get(cameraId, quality) as CamcorderProfile;
  }

  /// Returns true if a camcorder profile exists for the given camera at the given quality level.
  static Future<bool> hasProfile(int cameraId, int quality) async {
    return await _channel.$hasProfile(cameraId, quality) as bool;
  }
}
