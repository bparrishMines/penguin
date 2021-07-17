
import 'dart:async';

import 'package:flutter/services.dart';

class AndroidMedia {
  static const MethodChannel _channel = MethodChannel('android_media');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
