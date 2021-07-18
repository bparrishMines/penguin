import 'package:android_hardware/android_hardware.dart';
import 'package:flutter/foundation.dart';
import 'package:reference/annotations.dart';

import 'media_recorder.g.dart';
import 'media_recorder_channels.dart';

/// Called when an error occurs while recording with [MediaRecoder].
///
/// `what`: the type of error that has occurred:
///    * [MediaRecorder.errorUnknown]
///    * [MediaRecorder.errorServerDied]
///
/// `extra`: an extra code, specific to the info type
@Reference('android_media/media_recorder/OnErrorListener')
typedef OnErrorListener = void Function(int what, int extra);

/// Called to indicate an info or a warning during recording with [MediaRecoder].
///
/// `what`: the type of error that has occurred:
///    * [MediaRecorder.infoUnknown]
///    * [MediaRecorder.infoMaxDurationReached]
///    * [MediaRecorder.infoMaxFilesizeReached]
///
/// `extra`: an extra code, specific to the info type
@Reference('android_media/media_recorder/OnInfoListener')
typedef OnInfoListener = void Function(int what, int extra);

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
@Reference('android_media/media_recorder/MediaRecorder')
class MediaRecorder implements $MediaRecorder {
  /// Default constructor for [MediaRecorder].
  MediaRecorder({@ignoreParam bool create = true}) {
    if (create) _channel.$create$(this, $owner: true);
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
  Future<void> setCamera(Camera camera) => _channel.$setCamera(this, camera);

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
@Reference('android_media/media_recorder/CamcorderProfile')
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
