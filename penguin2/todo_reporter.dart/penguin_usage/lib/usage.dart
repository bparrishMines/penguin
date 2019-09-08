import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_usage/penguin_usage.dart';

part 'usage.g.dart';

@Class('yolo polo')
class Usage1 extends _$Usage1 {
  Usage1() : super('uniqueId');

  @Method()
  Future<void> method() => PenguinUsage.channel.invokeMethod(
        _$method().method,
        _$method().arguments,
      );

  void m() {
    _$invoke([_$method(), _$method()]);
  }
}

@Class('yolo polo')
class Usage2 extends _$Usage2 {
  Usage2() : super('uniqueId');
}
