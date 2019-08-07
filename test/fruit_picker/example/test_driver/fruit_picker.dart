import 'dart:async';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_picker/basket.dart';
import 'package:fruit_picker/apple.dart';
import 'package:fruit_picker/banana.dart';
import 'package:fruit_picker/orange.dart';
import 'package:fruit_picker/strawberry.dart';
import 'package:fruit_picker/lemon.dart';
import 'package:fruit_picker/peach.dart';
import 'package:fruit_picker/grape.dart';

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

      test('$Basket(Apple)', () async {
        final Basket basket = Basket();
        final Apple apple = basket.takeApple();
        Basket.appleBasket(apple);
        await pumpEventQueue();
      });

      test('takeApple', () async {
        final Apple apple = basket.takeApple();
        await pumpEventQueue();
      });

      test('ripestBanana', () async {
        final Banana banana = Basket.ripestBanana;
        await pumpEventQueue();
      });

      test('favoritePeach', () async {
        final Peach peach = Basket.favoritePeach;

        expect(peach, isNull);

        final Peach newPeach = Peach();
        Basket.favoritePeach = newPeach;

        expect(Basket.favoritePeach, newPeach);

        await pumpEventQueue();
      });

      test('addApple', () {
        final Apple apple = basket.takeApple();
        expect(basket.addApple(apple), completes);
      });

      test('takeOrange', () async {
        final Orange orange = basket.takeOrange();
        await pumpEventQueue();
      });

      test('takeGrape', () async {
        final Grape grape = await basket.takeGrape();
        expect(grape.color, "yellow");
        expect(grape.hasSeed, isTrue);
      });

      test('aRedGrape', () async {
        final Grape grape = await basket.aRedGrape;
        expect(grape.color, "red");
        expect(grape.hasSeed, isFalse);
      });

      test('aGreenGrape', () async {
        final Grape grape = await basket.aRedGrape;
        Basket.aGreenGrape = grape..color = 'pink';
        expect(Basket.aGreenGrape.color, 'pink');
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

    group('$Lemon', () {
      Lemon lemon;

      setUp(() {
        lemon = Lemon('Yellow', 42.0);
      });

      test('makeLemonade', () {
        expect(lemon.makeLemonade(true, false), completes);
      });

      test('isBigger', () {
        expect(lemon.isBigger(Orange(32.0)), completion(isFalse));
      });
    });

    group('$Peach', () {
      Peach peach;

      setUp(() {
        peach = Peach();
      });

      test('isRipe', () async {
        peach.isRipe = true;
        expect(peach.isRipe, isTrue);

        peach.isRipe = false;
        expect(peach.isRipe, isFalse);

        await pumpEventQueue();
      });
    });

    group('$Grape', () {
      Grape grape;

      setUp(() async {
        final Basket basket = Basket();
        grape = await basket.takeGrape();
      });
    });
  });
}
