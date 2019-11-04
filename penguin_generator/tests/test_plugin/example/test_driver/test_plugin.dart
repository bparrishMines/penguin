// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('test_plugin', () {
    group('android', () {
      test('staticField', () {
        expect(AndroidTestClass1.staticField, completion(12));
      });

      test('staticMethod', () {
        expect(AndroidTestClass1.staticMethod(), completion(13));
      });

      test('objectField', () {
        expect(AndroidTestClass1().objectField, completion('32'));

        final AndroidTestClass1 class1 = AndroidTestClass1();
        class1.objectField = '64';
        expect(class1.objectField, completion('64'));
      });

      test('dynamicField', () {
        expect(AndroidTestClass1().dynamicField, completion(42));
      });

      test('stringField', () {
        expect(AndroidTestClass1().stringField, completion('Macintosh'));
      });

      test('intField', () {
        expect(AndroidTestClass1().intField, completion(43));
      });

      test('doubleField', () {
        expect(AndroidTestClass1().doubleField, completion(44.0));
      });

      test('numField', () {
        expect(AndroidTestClass1().numField, completion(0));
      });

      test('boolField', () {
        expect(AndroidTestClass1().boolField, completion(true));
      });

      test('listField', () {
        expect(
          AndroidTestClass1().listField,
          completion(<bool>[true, false, true]),
        );
      });

      test('mapField', () {
        expect(
          AndroidTestClass1().mapField,
          completion(<String, double>{'true': 1.0, 'false': 0.0}),
        );
      });

      test('noParametersMethod', () {
        expect(AndroidTestClass1().noParametersMethod(), completion(72));
      });

      test('singleParameterMethod', () {
        expect(AndroidTestClass1().singleParameterMethod('Hello'),
            completion('Hello, World!'));
      });

      test('returnVoid', () {
        expect(AndroidTestClass1().returnVoid(), completes);
      });

      test('returnObject', () {
        expect(AndroidTestClass1().returnObject(), completion('Hello'));
      });

      test('returnDynamic', () {
        expect(AndroidTestClass1().returnDynamic(), completion(3));
      });

      test('returnString', () {
        expect(AndroidTestClass1().returnString(), completion('Amigo'));
      });

      test('returnInt', () {
        expect(AndroidTestClass1().returnInt(), completion(69));
      });

      test('returnDouble', () {
        expect(AndroidTestClass1().returnDouble(), completion(70.0));
      });

      test('returnBool', () {
        expect(AndroidTestClass1().returnBool(), completion(false));
      });

      test('returnList', () {
        expect(
          AndroidTestClass1().returnList(),
          completion(<double>[1.0, 2.0]),
        );
      });

      test('returnMap', () {
        expect(
          AndroidTestClass1().returnMap(),
          completion(<String, int>{'one': 1, 'two': 2}),
        );
      });

      test('nestedClassField', () {
        expect(AndroidNestedClass().nestedClassField, completion(4));
      });

      test('nestedClassMethod', () {
        expect(AndroidNestedClass().nestedClassMethod(), completion(5));
      });
    }, skip: !Platform.isAndroid);

    group('ios', () {
      test('returnVoid', () {
        expect(IosTestClass1().returnVoid(), completes);
      });

      test('returnObject', () {
        expect(IosTestClass1().returnObject(), completion('PoPo'));
      });

      test('returnDynamic', () {
        expect(IosTestClass1().returnDynamic(), completion(45));
      });

      test('returnString', () {
        expect(IosTestClass1().returnString(), completion('PoPo?'));
      });

      test('returnInt', () {
        expect(IosTestClass1().returnInt(), completion(12));
      });

      test('returnInt32', () {
        expect(IosTestClass1().returnInt32(), completion(56));
      });

      test('returnDouble', () {
        expect(IosTestClass1().returnDouble(), completion(70.0));
      });

      test('returnBool', () {
        expect(IosTestClass1().returnBool(), completion(true));
      });

      test('returnList', () {
        expect(
          IosTestClass1().returnList(),
          completion(<double>[3.0, 4.0]),
        );
      });

      test('returnMap', () {
        expect(
          IosTestClass1().returnMap(),
          completion(<String, int>{'three': 3, 'four': 4}),
        );
      });

      test('noParametersMethod', () {
        expect(IosTestClass1().noParametersMethod(), completion(4));
      });

      test('singleParameterMethod', () {
        expect(IosTestClass1().singleParameterMethod('four'),
            completion('fourtwo'));
      });

      test('allParameterTypesMethod', () {
        expect(IosTestClass1().allParameterTypesMethod(41), completion('41'));
      });
    }, skip: !Platform.isIOS);
  });
}
