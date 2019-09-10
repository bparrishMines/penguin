import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_usage/penguin_usage.dart';

part 'usage.penguin.g.dart';

@Class(AndroidPlatform(AndroidType('start.now', 'Banana')))
class Usage1 extends _$Usage1 {
  Usage1() : super('uniqueId');

  @Method()
  Future<void> method() => PenguinUsage.channel.invokeMethod(
        _$method().method,
        _$method().arguments,
      );

  void m() {
    _$invoke(null, [_$method(), _$method()]);
  }
}

@Class(AndroidPlatform(AndroidType('start.now', 'Apple')))
class Usage2 extends _$Usage2 {
  Usage2() : super('uniqueId');
}
