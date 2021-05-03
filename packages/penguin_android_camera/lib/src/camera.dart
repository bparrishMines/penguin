import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';
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
  /// Default constructor for [Camera].
  ///
  /// This should only be used when subclassing. Otherwise, an instance should
  /// be provided from [open].
  @visibleForTesting
  Camera();

  static $CameraChannel get _channel =>
      ChannelRegistrar.instance.implementations.cameraChannel;

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

  /// Attach preview frames to a new Flutter texture.
  ///
  /// If the [Camera] is already using a texture, the same id will be returned.
  @override
  Future<int> attachPreviewTexture() async {
    return _currentTexture ??=
        await _channel.$invokeAttachPreviewTexture(this) as int;
  }

  /// Release the Flutter texture receiving preview frames.
  @override
  Future<void> releasePreviewTexture() async {
    _currentTexture = null;
    await _channel.$invokeReleasePreviewTexture(this);
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
  @override
  Future<void> unlock() {
    return _channel.$invokeUnlock(this);
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
  @override
  Future<void> reconnect() => _channel.$invokeReconnect(this);

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
  @override
  Future<void> autoFocus(covariant AutoFocusCallback callback) {
    return _channel.$invokeAutoFocus(this, callback);
  }

  /// Cancels any auto-focus function in progress.
  ///
  /// Whether or not auto-focus is currently in progress, this function will
  /// return the focus position to the default. If the camera does not support
  /// auto-focus, this is a no-op.
  @override
  Future<void> cancelAutoFocus() {
    return _channel.$invokeCancelAutoFocus(this);
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
  @override
  Future<void> setDisplayOrientation(int degrees) {
    return _channel.$invokeSetDisplayOrientation(this, degrees);
  }

  /// Registers a callback to be invoked when an error occurs.
  @override
  Future<void> setErrorCallback(covariant ErrorCallback callback) {
    return _channel.$invokeSetErrorCallback(this, callback);
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
  @override
  Future<void> startSmoothZoom(int value) {
    return _channel.$invokeStartSmoothZoom(this, value);
  }

  /// Stops the smooth zoom.
  ///
  /// Applications should wait for the [OnZoomChangeListener] to know when the
  /// zoom is actually stopped. This method is supported if
  /// [CameraParameters.isSmoothZoomSupported] is `true`.
  @override
  Future<void> stopSmoothZoom() {
    return _channel.$invokeStopSmoothZoom(this);
  }

  /// Returns the current settings for this Camera service.
  ///
  /// If modifications are made to the returned Parameters, they must be passed
  /// to [setParameters] to take effect.
  @override
  Future<CameraParameters> getParameters() async {
    return await _channel.$invokeGetParameters(this) as CameraParameters;
  }

  /// Changes the settings for this Camera service.
  @override
  Future<void> setParameters(covariant CameraParameters parameters) {
    return _channel.$invokeSetParameters(this, parameters);
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
      ChannelRegistrar.instance.implementations.cameraParametersChannel;

  /// Gets the state of the auto-exposure lock.
  ///
  /// Applications should check [isAutoExposureLockSupported] before using this
  /// method. See [setAutoExposureLock] for details about the lock.
  @override
  Future<bool> getAutoExposureLock() async {
    return await _channel.$invokeGetAutoExposureLock(this) as bool;
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
  @override
  Future<List<CameraArea>> getFocusAreas() async {
    final List<Object?> focusAreas =
        await _channel.$invokeGetFocusAreas(this) as List<Object?>;
    return focusAreas.cast<CameraArea>();
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
  @override
  Future<List<double>> getFocusDistances() async {
    final List<Object?> distances =
        await _channel.$invokeGetFocusDistances(this) as List<Object?>;
    return distances.cast<double>();
  }

  /// Gets the maximum exposure compensation index.
  @override
  Future<int> getMaxExposureCompensation() async {
    return await _channel.$invokeGetMaxExposureCompensation(this) as int;
  }

  /// Gets the maximum number of focus areas supported.
  ///
  /// This is the maximum length of the list in [setFocusAreas] and
  /// [getFocusAreas].
  @override
  Future<int> getMaxNumFocusAreas() async {
    return await _channel.$invokeGetMaxNumFocusAreas(this) as int;
  }

  /// Gets the minimum exposure compensation index.
  @override
  Future<int> getMinExposureCompensation() async {
    return await _channel.$invokeGetMinExposureCompensation(this) as int;
  }

  /// Gets the supported focus modes.
  @override
  Future<List<String>> getSupportedFocusModes() async {
    final List<Object?> modes =
        await _channel.$invokeGetSupportedFocusModes(this) as List<Object?>;
    return modes.cast<String>();
  }

  /// Returns `true` if auto-exposure locking is supported.
  ///
  /// Applications should call this before trying to lock auto-exposure.
  /// See [setAutoExposureLock] for details about the lock.
  @override
  Future<bool> isAutoExposureLockSupported() async {
    return await _channel.$invokeIsAutoExposureLockSupported(this) as bool;
  }

  /// Returns `true` if zoom is supported.
  ///
  /// Applications should call this before using other zoom methods.
  @override
  Future<bool> isZoomSupported() async {
    return await _channel.$invokeIsZoomSupported(this) as bool;
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
  @override
  Future<void> setAutoExposureLock(bool toggle) {
    return _channel.$invokeSetAutoExposureLock(this, toggle);
  }

  /// Sets the exposure compensation index.
  @override
  Future<void> setExposureCompensation(int value) {
    return _channel.$invokeSetExposureCompensation(this, value);
  }

  /// Sets focus areas.
  ///
  /// See [getFocusAreas] for documentation.
  @override
  Future<void> setFocusAreas(covariant List<CameraArea>? focusAreas) {
    return _channel.$invokeSetFocusAreas(this, focusAreas);
  }

  /// Sets the focus mode.
  @override
  Future<void> setFocusMode(String value) {
    return _channel.$invokeSetFocusMode(this, value);
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
  @override
  Future<String?> getFlashMode() async {
    return await _channel.$invokeGetFlashMode(this) as String;
  }

  /// Gets the maximum zoom value allowed for snapshot.
  ///
  /// This is the maximum value that applications can set to [setZoom].
  /// Applications should call [isZoomSupported] before using this method.
  /// This value may change in different preview size. Applications should call
  /// this again after setting preview size.
  @override
  Future<int> getMaxZoom() async {
    return await _channel.$invokeGetMaxZoom(this) as int;
  }

  /// Returns the dimension setting for pictures.
  @override
  Future<CameraSize> getPictureSize() async {
    return await _channel.$invokeGetPictureSize(this) as CameraSize;
  }

  /// Returns the dimensions setting for preview pictures.
  @override
  Future<CameraSize> getPreviewSize() async {
    return await _channel.$invokeGetPreviewSize(this) as CameraSize;
  }

  /// Gets the supported preview sizes.
  ///
  /// This method will always return a list with at least one element.
  @override
  Future<List<CameraSize>> getSupportedPreviewSizes() async {
    final List<Object?> sizes =
        await _channel.$invokeGetSupportedPreviewSizes(this) as List<Object?>;
    return sizes.cast<CameraSize>();
  }

  /// Gets the supported picture sizes.
  ///
  /// This method will always return a list with at least one element.
  @override
  Future<List<CameraSize>> getSupportedPictureSizes() async {
    final List<Object?> sizes =
        await _channel.$invokeGetSupportedPictureSizes(this) as List<Object?>;
    return sizes.cast<CameraSize>();
  }

  /// Gets the supported flash modes.
  ///
  /// Empty if flash mode setting is not supported.
  @override
  Future<List<String>> getSupportedFlashModes() async {
    final List<Object?> modes =
        await _channel.$invokeGetSupportedFlashModes(this) as List<Object?>;
    return modes.cast<String>();
  }

  /// Gets current zoom value.
  ///
  /// This also works when smooth zoom is in progress. Applications should check
  /// [isZoomSupported] before using this method.
  @override
  Future<int> getZoom() async {
    return _channel.$invokeGetZoom(this) as int;
  }

  /// Whether smooth zoom is supported.
  ///
  /// Applications should call this before using other smooth zoom methods.
  @override
  Future<bool> isSmoothZoomSupported() async {
    return await _channel.$invokeIsSmoothZoomSupported(this) as bool;
  }

  /// Sets the flash mode.
  @override
  Future<void> setFlashMode(String mode) {
    return _channel.$invokeSetFlashMode(this, mode);
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
  @override
  Future<void> setPictureSize(int width, int height) {
    return _channel.$invokeSetPictureSize(this, width, height);
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
  @override
  Future<void> setRecordingHint(bool hint) {
    return _channel.$invokeSetRecordingHint(this, hint);
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
  /// ```
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
  @override
  Future<void> setRotation(int rotation) {
    return _channel.$invokeSetRotation(this, rotation);
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
  @override
  Future<void> setZoom(int value) {
    return _channel.$invokeSetZoom(this, value);
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
  @override
  Future<void> setPreviewSize(int width, int height) {
    return _channel.$invokeSetPreviewSize(this, width, height);
  }

  /// Gets the current exposure compensation index.
  ///
  /// The range is [getMinExposureCompensation] to [getMaxExposureCompensation].
  /// 0 means exposure is not adjusted.
  @override
  Future<int> getExposureCompensation() async {
    return await _channel.$invokeGetExposureCompensation(this) as int;
  }

  /// Gets the exposure compensation step.
  ///
  /// Applications can get EV by multiplying the exposure compensation index and
  /// step. Ex: if exposure compensation index is -6 and step is 0.333333333, EV
  /// is -2.
  @override
  Future<double> getExposureCompensationStep() async {
    return await _channel.$invokeGetExposureCompensationStep(this) as double;
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
  CameraArea(this.rect, this.weight, {bool createInstancePair = true}) {
    if (createInstancePair) _channel.createNewInstancePair(this, owner: true);
  }

  static $CameraAreaChannel get _channel =>
      ChannelRegistrar.instance.implementations.cameraAreaChannel;

  @override
  final CameraRect rect;

  @override
  final int weight;
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
  CameraRect({
    required this.top,
    required this.bottom,
    required this.right,
    required this.left,
    bool createInstancePair = true,
  }) {
    if (createInstancePair) _channel.createNewInstancePair(this, owner: true);
  }

  static $CameraRectChannel get _channel =>
      ChannelRegistrar.instance.implementations.cameraRectChannel;

  @override
  final int top;

  @override
  final int bottom;

  @override
  final int right;

  @override
  final int left;
}

/// Image size (width and height dimensions).
@Reference('penguin_android_camera/camera/CameraSize')
class CameraSize with $CameraSize {
  /// Default constructor for [CameraSize].
  CameraSize(this.width, this.height);

  /// Height of a picture.
  @override
  final int width;

  /// Width of a picture.
  @override
  final int height;

  @override
  String toString() {
    return 'CameraSize($width, $height)';
  }
}

/// Callback interface for camera error notification.
@Reference('penguin_android_camera/camera/ErrorCallback')
abstract class ErrorCallback with $ErrorCallback {
  /// Default constructor for an [ErrorCallback].
  ErrorCallback() {
    _channel.createNewInstancePair(this, owner: true);
  }

  static $ErrorCallbackChannel get _channel =>
      ChannelRegistrar.instance.implementations.errorCallbackChannel;

  /// Callback for camera errors.
  ///
  /// See:
  ///   [Camera.cameraErrorUnknown]
  ///   [Camera.cameraErrorServerDied]
  ///   [Camera.cameraErrorEvicted]
  @override
  void onError(int error);
}

/// Callback interface used to notify on completion of camera auto focus.
///
/// Devices that do not support auto-focus will receive a "fake" callback to
/// this interface. If your application needs auto-focus and should not be
/// installed on devices without auto-focus, you must declare that your app use
/// s the android.hardware.camera.autofocus feature, in the <uses-feature>
/// manifest element.
///
/// See: [Camera.autoFocus].
@Reference('penguin_android_camera/camera/AutoFocusCallback')
abstract class AutoFocusCallback with $AutoFocusCallback {
  /// Default constructor for [AutoFocusCallback].
  AutoFocusCallback() {
    _channel.createNewInstancePair(this, owner: true);
  }

  static $AutoFocusCallbackChannel get _channel =>
      ChannelRegistrar.instance.implementations.autoFocusCallbackChannel;

  /// Called when the camera auto focus completes.
  ///
  /// If the camera does not support auto-focus and [Camera.autoFocus] is
  /// called, [onAutoFocus] will be called immediately with a fake value of
  /// success set to true. The auto-focus routine does not lock auto-exposure
  /// and auto-white balance after it completes.
  ///
  /// Returns whether the auto-focus was successful.
  @override
  void onAutoFocus(bool success);
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

  static $MediaRecorderChannel get _channel =>
      ChannelRegistrar.instance.implementations.mediaRecorderChannel;

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

  @override
  Future<void> pause() => _channel.$invokePause(this);

  @override
  Future<void> resume() => _channel.$invokeResume(this);
}
