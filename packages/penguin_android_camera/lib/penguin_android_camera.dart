import 'package:penguin_android_camera/channels.dart';

// ignore_for_file: unnecessary_statements

export 'src/camera.dart'
    hide
        Channels,
        CameraChannel,
        CameraInfoChannel,
        CameraHandler,
        CameraInfoHandler;

class PenguinAndroidCamera {
  /// Initialize communication with the platform API.
  static void initialize() {
    Channels.cameraChannel;
    Channels.cameraInfoChannel;
  }
}
