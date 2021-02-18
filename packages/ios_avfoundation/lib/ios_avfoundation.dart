import 'channels.dart';

// ignore_for_file: unnecessary_statements

export 'src/avfoundation.dart';

class AvFoundation {
  /// Initialize communication with the platform API.
  static void initialize() {
    Channels.captureDeviceChannel;
    Channels.captureSessionChannel;
    Channels.captureDeviceChannel;
    Channels.previewControllerInputChannel;
  }
}
