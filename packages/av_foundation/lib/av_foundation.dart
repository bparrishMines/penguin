
import 'dart:async';

import 'package:flutter/services.dart';

class AvFoundation {
  static const MethodChannel _channel = MethodChannel('av_foundation');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
