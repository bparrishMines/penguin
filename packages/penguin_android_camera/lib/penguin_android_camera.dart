
import 'dart:async';

import 'package:flutter/services.dart';

class PenguinAndroidCamera {
  static const MethodChannel _channel =
      const MethodChannel('penguin_android_camera');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
