import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_usage/penguin.g.dart';
import 'package:penguin_usage/penguin_usage.dart';

@Class(
  AndroidPlatform(
    AndroidType('com.example.penguin_usage.test_package', 'TestClass'),
  ),
)
class Usage1 extends $Usage1 {
  @Constructor()
  Usage1() : super('uniqueId');

  @Method()
  Future<void> aMethod() => PenguinUsage.channel.invokeMethod(
        $aMethod().method,
        $aMethod().arguments,
      );

  void anotherMethod() {
    print($invoke(null, [$aMethod(), $aMethod()]));
  }
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.penguin_usage.test_package',
    'TestClassTwo',
  ),
))
class Usage2 extends $Usage2 {
  Usage2() : super('uniqueId');
}
