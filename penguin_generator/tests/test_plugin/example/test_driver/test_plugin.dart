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
    }, skip: !Platform.isAndroid);
  });
}
