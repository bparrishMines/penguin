import 'dart:async';
import 'dart:math';

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
  Usage1() : super(Random().nextDouble().toString()) {
    $invoke(
      PenguinUsage.channel,
      [$Usage1Default(), $allocate()],
    );
  }

  @Method()
  Future<void> aMethod() async {
    await $invoke(
      PenguinUsage.channel,
      [$aMethod()],
    );
  }

  @Method()
  Future<String> getStringMethod() async {
    final List<dynamic> value = await $invoke(
      PenguinUsage.channel,
      [$getStringMethod()],
    );
    return value[0];
  }

  Future<void> anotherMethod() async {
    print(await $invoke(
      PenguinUsage.channel,
      [$aMethod(), $aMethod()],
    ));
  }
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.penguin_usage.test_package',
    'TestClassTwo',
  ),
))
class Usage2 extends $Usage2 {
  Usage2() : super(Random().nextDouble().toString());
}
