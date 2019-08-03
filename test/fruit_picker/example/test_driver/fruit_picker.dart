import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_picker/basket.dart';
import 'package:fruit_picker/apple.dart';
import 'package:fruit_picker/banana.dart';
import 'package:fruit_picker/orange.dart';
import 'package:fruit_picker/strawberry.dart';
import 'package:fruit_picker/empty.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('fruit_picker plugin', () {
    group('$Basket', () {
      Basket basket;

      setUp(() {
        basket = Basket();
      });

      test('takeApple', () async {
        final Apple apple = basket.takeApple();
        await pumpEventQueue();
      });
    });

    group('$Apple', () {
      Apple apple;

      setUp(() {
        final Basket basket = Basket();
        apple = basket.takeApple();
      });

      test('areApplesGood', () async {
        expect(Apple.areApplesGood(), completion(true));
      });
    });

    group('$Banana', () {
      Banana banana;

      setUp(() {
        banana = Basket.ripestBanana;
      });

      test('length', () async {
        expect(banana.length, completion(30.0));
      });
    });

    group('$Orange', () {
      Orange orange;

      setUp(() {
        orange = Orange(13);
      });

      test('squeeze', () {
        expect(orange.squeeze(13), completes);
      });
    });

    group('$Strawberry', () {
      Strawberry strawberry;

      setUp(() {
        strawberry = Strawberry();
      });

      test('seeds', () {
        expect(Strawberry.averageNumberOfSeeds, completion(50));
      });
    });
  });
}
