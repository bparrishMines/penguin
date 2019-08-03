import 'channel.dart';
import 'dart:async';

class Orange {
  Orange(double juiciness) {
    Channel.channel.invokeMethod<void>('Orange(double)',
        <String, dynamic>{'juiciness': juiciness, 'orangeHandle': handle});
  }

  final int handle = Channel.nextHandle++;

  Future<void> squeeze(double pressure) {
    return Channel.channel.invokeMethod<void>('Orange#squeeze',
        <String, dynamic>{'pressure': pressure, 'handle': handle});
  }
}
