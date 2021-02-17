
import 'dart:async';

import 'package:flutter/services.dart';

class IosAvfoundation {
  static const MethodChannel _channel =
      const MethodChannel('ios_avfoundation');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
