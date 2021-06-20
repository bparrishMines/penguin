import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:reference/annotations.dart';

import 'camera.g.dart';
import 'camera_channels.dart';

/// Callback for camera error notification.
///
/// See:
///   [Camera.cameraErrorUnknown]
///   [Camera.cameraErrorServerDied]
///   [Camera.cameraErrorEvicted]
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

/// Callback used to supply image data from a photo capture.
///
/// Called when image data is available after a picture is taken.
///
/// The format of the data depends on the context of the callback and
/// [CameraParameters] settings.
///
/// See: [Camera.takePicture].
@Reference('penguin_android_camera/camera/PictureCallback')
typedef PictureCallback = void Function(Uint8List data);

/// Callback used to deliver copies of preview frames as they are displayed.
@Reference('penguin_android_camera/camera/PreviewCallback')
typedef PreviewCallback = void Function(Uint8List data);

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
  static const int cameraErrorUnknown = 0x00000001;

  /// Media server died.
  ///
  /// In this case, the application must release the Camera object and
  /// instantiate a new one.
  static const int cameraErrorServerDied = 0x00000064;

  /// Camera was disconnected due to use by higher priority user.
  static const int cameraErrorEvicted = 0x00000002;

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
    ChannelRegistrar.instance.implementations.channelPreviewCallback.$$create(
      callback,
      $owner: false,
    );
    return _channel.$setOneShotPreviewCallback(this, callback);
  }

  /// Installs a callback to be invoked for every preview frame in addition to displaying them on the screen.
  ///
  /// The callback will be repeatedly called for as long as preview is active
  /// . This method can be called at any time, even while preview is live. Any
  /// other preview callbacks are overridden.
  ///
  /// If you are using the preview data to create video or still images,
  /// strongly consider using MediaActionSound to properly indicate image
  /// capture or recording start/stop to the user.
  Future<void> setPreviewCallback(PreviewCallback callback) {
    ChannelRegistrar.instance.implementations.channelPreviewCallback.$$create(
      callback,
      $owner: false,
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
      ChannelRegistrar.instance.implementations.channelShutterCallback
          .$$create(shutter, $owner: false);
    }

    final $PictureCallbackChannel pictureCallbackChannel =
        ChannelRegistrar.instance.implementations.channelPictureCallback;
    if (jpeg != null) pictureCallbackChannel.$$create(jpeg, $owner: false);
    if (raw != null) pictureCallbackChannel.$$create(raw, $owner: false);
    if (postView != null) {
      pictureCallbackChannel.$$create(postView, $owner: false);
    }

    return _channel.$takePicture(
      this,
      shutter,
      raw,
      postView,
      jpeg,
    );
  }

  // TODO: CameraParameters.getAutoWhiteBalanceLock
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

  // TODO: PreviewCallback.onPreviewFrame
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
  /// [PreviewCallback.onPreviewFrame], JPEG pictures, or recorded videos. This
  /// method is not allowed to be called during preview.
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

  //TODO: OnZoomChangeListener
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
}

// TODO: CameraParameters.setWhiteBalance
// TODO: Color set and get effects
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
  /// recording because the focus changes smoothly . Applications still can call
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
  /// the focus distance is infinity, the value will be Float.POSITIVE_INFINITY.
  Future<List<double>> getFocusDistances() async {
    final List<Object?> distances =
        await _channel.$getFocusDistances(this) as List<Object?>;
    return distances.cast<double>();
  }

  /// Gets the maximum exposure compensation index.
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
}

/// Used for choosing specific metering and focus areas for the camera to use when calculating auto-exposure, auto-white balance, and auto-focus.
///
/// To find out how many simultaneous areas a given camera supports, use
/// *Unsupported*[Parameters.getMaxNumMeteringAreas] and
/// *Unsupported*[Parameters.getMaxNumFocusAreas]. If metering or focusing area
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
    @ignoreParam bool create = false,
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
    @ignoreParam bool create = false,
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
  /// Android MediaRecorder.VideoEncoder.MPEG_4_SP format
  static const int mpeg4Sp = 0x00000003;
}

/// Defines the audio source.
///
/// An audio source defines both a default physical source of audio signal, and
/// a recording configuration. These constants are for instance used in
/// [MediaRecorder.setAudioSource].
abstract class AudioSource {
  /// Default audio source *
  static const int defaultSource = 0x00000000;
}

/// Defines the audio encoding.
///
/// These constants are used with [MediaRecorder.setAudioEncoder].
abstract class AudioEncoder {
  /// AMR (Narrowband) audio codec.
  static const int amrNb = 0x00000001;
}

/// Defines the video source.
///
/// These constants are used with [MediaRecorder.setVideoSource].
abstract class VideoSource {
  /// Using the Camera API as video source.
  static const int camera = 0x00000001;
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

  static $MediaRecorderChannel get _channel =>
      ChannelRegistrar.instance.implementations.channelMediaRecorder;

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
  /// This is only supported on Android versions 24+.
  Future<void> pause() => _channel.$pause(this);

  /// Resumes recording.
  ///
  /// Call this after [start]. It does nothing if the recording is not paused.
  Future<void> resume() => _channel.$resume(this);
}
