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

  Usage1._fromUniqueId(String uniqueId) : super(uniqueId);

  @Method()
  Future<void> aMethod() async {
    await $invoke(
      PenguinUsage.channel,
      [$aMethod(null)],
    );
  }

  @Method()
  Future<String> getStringMethod() async {
    final List<dynamic> value = await $invoke(
      PenguinUsage.channel,
      [$getStringMethod(null)],
    );
    return value[0];
  }

  @Method()
  Future<int> addTwo(int value) {
    return PenguinUsage.channel.invokeMethod(
      $addTwo(null, value).method,
      $addTwo(null, value).arguments,
    );
  }

  @Method()
  Future<double> divide(int one, int two) {
    return PenguinUsage.channel.invokeMethod(
      $divide(null, one, two).method,
      $divide(null, one, two).arguments,
    );
  }

  @Method()
  Future<List<String>> getList(Map<int, int> addThese) {
    return PenguinUsage.channel.invokeListMethod(
      $getList(null, addThese).method,
      $getList(null, addThese).arguments,
    );
  }

  @Method()
  Future<String> giveUsage2(Usage2 usage2) {
    return PenguinUsage.channel.invokeMethod(
      $giveUsage2(null, usage2).method,
      $giveUsage2(null, usage2).arguments,
    );
  }

  @Method()
  Future<Usage2> getUsage2() {
    return PenguinUsage.channel.invokeMethod(
      $getUsage2('woeifj').method,
      $getUsage2('woeifj').arguments,
    );
  }

  Future<void> anotherMethod() async {
    print(await $invoke(
      PenguinUsage.channel,
      [$aMethod(null), $aMethod(null)],
    ));
  }

  @Method()
  static Future<bool> arePenguinsAwesome() {
    return PenguinUsage.channel.invokeMethod(
      $Usage1.$arePenguinsAwesome(null).method,
      $Usage1.$arePenguinsAwesome(null).arguments,
    );
  }
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.penguin_usage.test_package',
    'TestClassTwo',
  ),
))
class Usage2 extends $Usage2 {
  @Constructor()
  Usage2() : super(Random().nextDouble().toString()) {
    $invoke(
      PenguinUsage.channel,
      [$Usage2Default(), $allocate()],
    );
  }
}

@Class(AndroidPlatform(
  AndroidType(
    'com.example.penguin_usage.test_package',
    'TestGenericClass',
  ),
))
class GenericUsage<T> extends $GenericUsage<T> {
  @Constructor()
  GenericUsage() : super(Random().nextDouble().toString()) {
    $invoke(
      PenguinUsage.channel,
      [$GenericUsageDefault(), $allocate()],
    );
  }

  @Method()
  Future<void> setValue(T value) {
    return PenguinUsage.channel.invokeMethod(
      $setValue(null, value).method,
      $setValue(null, value).arguments,
    );
  }

  @Method()
  FutureOr<T> get() {
    if (runtimeType.toString() == 'GenericUsage<Usage1>') {
      final String id = Random().nextDouble().toString();
      PenguinUsage.channel.invokeMethod($get(id).method, $get(id).arguments);

      final Usage1 u = Usage1._fromUniqueId(id);
      $invoke(PenguinUsage.channel, [$get(id), u.$allocate()]);
      return u as T;
    }

    return PenguinUsage.channel.invokeMethod(
      $get(null).method,
      $get(null).arguments,
    );
  }
}
