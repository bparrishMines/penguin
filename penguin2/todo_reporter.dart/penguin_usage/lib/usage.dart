import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_usage/penguin.g.dart';
import 'package:penguin_usage/penguin_usage.dart';

@Class(AndroidPlatform(AndroidType('start.now', 'Banana')))
class Usage1 extends $Usage1 {
  Usage1() : super('uniqueId');

  @Method()
  Future<void> method() => PenguinUsage.channel.invokeMethod(
        $method().method,
        $method().arguments,
      );

  void m() {
    $invoke(null, [$method(), $method()]);
  }
}

@Class(AndroidPlatform(AndroidType('start.now', 'Apple')))
class Usage2 extends $Usage2 {
  Usage2() : super('uniqueId');
}
