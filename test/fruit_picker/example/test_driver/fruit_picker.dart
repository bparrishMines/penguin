import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_picker/android/basket.dart';
import 'package:fruit_picker/android/apple.dart';
import 'package:fruit_picker/android/banana.dart';
import 'package:fruit_picker/android/channel.dart';
import 'package:fruit_picker/android/orange.dart';
import 'package:fruit_picker/android/strawberry.dart';
import 'package:fruit_picker/android/lemon.dart';
import 'package:fruit_picker/android/peach.dart';
import 'package:fruit_picker/android/grape.dart';
import 'package:fruit_picker/android/apricot.dart';
import 'package:fruit_picker/android/pear.dart';
import 'package:fruit_picker/android/cherry.dart';
import 'package:fruit_picker/android/pineapple.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('fruit_picker plugin', () {
    test('$MissingPluginException thrown when method is missing', () async {
      expect(
        () => Channel.channel.invokeMethod('NotAMethod'),
        throwsA(isInstanceOf<MissingPluginException>()),
      );
    });

    test(
      '$MissingPluginException thrown when Invoker method is missing',
      () async {
        expect(
          () => Channel.channel.invokeMethod(
            'Invoke',
            <Map<String, dynamic>>[
              <String, dynamic>{
                'method': 'Not a method',
                'arguments': <String, dynamic>{},
              },
              <String, dynamic>{
                'method': 'Basket()',
                'arguments': <String, dynamic>{
                  'basketHandle': 'oppa',
                }
              }
            ],
          ),
          throwsA(isInstanceOf<MissingPluginException>()),
        );
      },
    );

    group('$Basket', () {
      Basket basket;

      setUp(() {
        basket = Basket();
      });

      test('$Basket(List<String>)', () async {
        final Basket basket = Basket.nicknames(<String>['Mr. Basket']);
        final Grape grape = await basket.aRedGrape;
        expect(grape.color, "red");
        expect(grape.hasSeed, isFalse);
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

      test('namesOfAllMyBananas', () {
        expect(
          basket.namesOfAllMyBananas(),
          completion(containsAllInOrder(<String>['charlie', 'wanda'])),
        );
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
        expect(grape.color, 'red');
        expect(grape.hasSeed, false);

        Basket.aGreenGrape = grape..color = 'pink';
        expect(Basket.aGreenGrape.color, 'pink');
        expect(pumpEventQueue(), completes);
      });

      test('takeApricot', () async {
        final Apricot apricot = await basket.takeApricot();
        expect(apricot.shape, 'square');
      });

      test('sweetestPear', () async {
        final Pear pear = await basket.sweetestPear;
        expect(pear.closestApple, isNotNull);
      });

      test('addAndTakeSomeFruit', () async {
        final Grape grape = await basket.addAndTakeSomeFruit(
          basket.takeApple(),
          Apricot(),
          basket.takeApple(),
        );

        expect(grape.hasSeed, isFalse);
        expect(grape.color, 'orange');
      });

      test('basketWithBanana', () async {
        Basket.basketWithBananas(Basket.ripestBanana, Basket.ripestBanana);
        await pumpEventQueue();
      });

      test('destroyBasket', () {
        expect(Basket.destroyBasket(Basket()), completes);
      });

      test('getCherry', () async {
        final Cherry cherry = await basket.getCherry();
        expect(cherry.seed.length, 14.0);
      });

      test('saveSeed', () async {
        final Cherry cherry = await basket.getCherry();
        expect(basket.saveSeed(cherry.seed), completes);
      });
    });

    group('$Pineapple', () {
      Pineapple pineapple;

      setUp(() {
        pineapple = Pineapple();
      });

      test('startEating', () {
        expect(pineapple.startEating(), completes);
        expect(pineapple.startEating(), completes);
      });

      test('takeSmallBite', () {
        expect(pineapple.takeSmallBite(), completion(isFalse));
      });

      test('Returns a value after allocation', () {
        pineapple.startEating();
        expect(pineapple.takeSmallBite(), completion(isFalse));
      });

      test('stopEating', () {
        expect(pineapple.startEating(), completes);
        expect(pineapple.stopEating(), completes);

        expect(
          () => pineapple.startEating(),
          throwsA(isInstanceOf<AssertionError>()),
        );

        expect(
          () => pineapple.stopEating(),
          throwsA(isInstanceOf<AssertionError>()),
        );

        expect(
          () => pineapple.startEating(),
          throwsA(isInstanceOf<AssertionError>()),
        );

        expect(
          () => pineapple.takeSmallBite(),
          throwsA(isInstanceOf<AssertionError>()),
        );

        expect(
          () => pineapple.save(),
          throwsA(isInstanceOf<AssertionError>()),
        );
      });

      test('doILikePineapple', () {
        expect(
          Pineapple.doILikePineapple(),
          completion('Not on pizza! But in general, yes.'),
        );
      });

      test('save', () {
        expect(pineapple.save(), completion(isTrue));
        expect(pineapple.takeSmallBite(), completion(isFalse));
        expect(pineapple.stopEating(), completes);

        expect(
          () => pineapple.startEating(),
          throwsA(isInstanceOf<AssertionError>()),
        );
      });
    });

    group('$Apple', () {
      test('areApplesGood', () async {
        expect(Apple.areApplesGood(), completion(true));
      });

      test('areApplesBetterThanThis', () {
        final Apricot apricot = Apricot();
        expect(Apple.areApplesBetterThanThis(apricot), completion(true));
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

      test('getDiameter', () async {
        expect(orange.getDiameter(), completion(3147483647));
      });
    });

    group('$Strawberry', () {
      Strawberry strawberry;

      setUp(() {
        strawberry = Strawberry();
      });

      test('giveMeAMap', () {
        final Strawberry strawberry = Strawberry.giveMeAMap(<bool, double>{
          true: 0,
          false: 1,
        });
      });

      test('seeds', () {
        expect(Strawberry.averageNumberOfSeeds, completion(50));
      });

      test('namingSucksSoHereIsAMap', () {
        expect(
          strawberry.namingSucksSoHereIsAMap(),
          completion(allOf(containsPair('one', 1), containsPair('two', 2))),
        );
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

    group('$Apricot', () {
      test('shape from constructor', () {
        final Apricot apricot = Apricot();
        expect(apricot.shape, isNull);
      });
    });

    group('$Pear', () {
      Pear pear;

      setUp(() async {
        pear = await Basket().sweetestPear;
      });

      test('closestApple', () {
        final Apple apple = Basket().takeApple();
        pear.closestApple = apple;

        expect(pear.closestApple, equals(apple));
        expect(pear.closestApple, isNotNull);
      });

      test('aPearForAnApple', () async {
        final Apple apple = Basket().takeApple();
        final Pear pear = await Pear.aPearForAnApple(apple);
        expect(pear.closestApple, isNotNull);
      });
    });
  });
}
