import 'channels.dart';

// ignore_for_file: unnecessary_statements

export 'src/avfoundation.dart'
    hide
        Channels,
        CaptureDeviceInputChannel,
        CaptureSessionChannel,
        CaptureDeviceChannel,
        PreviewControllerChannel,
        CaptureDeviceInputHandler,
        CaptureSessionHandler,
        CaptureDeviceHandler,
        PreviewControllerHandler;

class Avfoundation {
  /// Initialize communication with the platform API.
  static void initialize() {
    Channels.captureDeviceInputChannel;
    Channels.captureSessionChannel;
    Channels.captureDeviceChannel;
    Channels.previewControllerInputChannel;
  }
}
