import 'dart:async';

import 'package:flutter/services.dart';

class PenguinUsage {
  static const MethodChannel channel = const MethodChannel('penguin_usage');

  static Future<String> get platformVersion async {
    final String version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
