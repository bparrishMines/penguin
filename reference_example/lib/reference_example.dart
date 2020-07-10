
import 'dart:async';

import 'package:flutter/services.dart';

class ReferenceExample {
  static const MethodChannel _channel =
      const MethodChannel('reference_example');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
