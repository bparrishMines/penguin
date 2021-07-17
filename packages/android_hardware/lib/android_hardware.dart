
import 'dart:async';

import 'package:flutter/services.dart';

class AndroidHardware {
  static const MethodChannel _channel = MethodChannel('android_hardware');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
