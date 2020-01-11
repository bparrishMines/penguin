// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/src/android.dart';
import 'package:test_plugin/src/ios.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  initialize();
  group('test_plugin', () {
    final TestClass1Controller testClass1 = TestClass1Controller();
    final TestClass2Controller testClass2 = TestClass2Controller();
    final GenericClassController genericClass = GenericClassController<int>();

    group('interface', () {
      test('intField', () {
        expect(testClass1.intField, completion(43));
      });

      test('mutableField', () {
        testClass1.mutableField = 23.4;
        expect(testClass1.mutableField, completion(23.4));
      });

      test('stringField', () {
        expect(testClass1.stringField, completion("Macintosh"));
      });

      test('doubleField', () {
        expect(testClass1.doubleField, completion(44.0));
      });

      test('boolField', () {
        expect(testClass1.boolField, completion(isTrue));
      });

      test('staticfield', () {
        if (Platform.isAndroid) {
          expect(
            AndroidTestClass1.staticField,
            completion(<bool>[true, false, true]),
          );
        } else if (Platform.isIOS) {
          expect(
            IosTestClass1.staticField,
            completion(<bool>[true, false, true]),
          );
        }
      });

      test('staticMethod', () {
        if (Platform.isAndroid) {
          expect(
            AndroidTestClass1.staticMethod(),
            completes,
          );
        } else if (Platform.isIOS) {
          expect(
            IosTestClass1.staticMethod(),
            completes,
          );
        }
      });

      test('namedConstructor', () {
        expect(
          TestClass1Controller.namedConstructor().returnBool(),
          completion(isFalse),
        );
      });

      test('returnVoid', () {
        expect(testClass1.returnVoid(), completes);
      });

      test('returnString', () {
        expect(testClass1.returnString(), completion('Amigo'));
      });

      test('returnInt', () {
        expect(testClass1.returnInt(), completion(69));
      });

      test('returnDouble', () {
        expect(testClass1.returnDouble(), completion(70.0));
      });

      test('returnBool', () {
        expect(testClass1.returnBool(), completion(false));
      });

      test('returnList', () {
        expect(
          testClass1.returnList(),
          completion(<double>[1.0, 2.0]),
        );
      });

      test('returnMap', () {
        expect(
          testClass1.returnMap(),
          completion(<String, int>{'one': 1, 'two': 2}),
        );
      });

      test('returnObject', () {
        expect(testClass1.returnObject(), completion('Hello'));
      });

      test('returnDynamic', () {
        expect(testClass1.returnDynamic(), completion(3));
      });

      test('nameOverrideField', () {
        expect(testClass1.notAField, completion(12.10));
      });
    });

    group('android', () {
      test('parameterMethod', () {
        expect(
          (testClass1.testClass1 as AndroidTestClass1).parameterMethod(
            'woeif',
            32,
            (testClass2.testClass2 as AndroidTestClass2),
            AndroidNestedClass(),
          ),
          completes,
        );
      });

      test('$AndroidGenericClass', () async {
        genericClass.add(56);
        expect(await genericClass.get('eoij'), 56);

        final AndroidTestClass2 testClass2 = AndroidTestClass2();
        final AndroidGenericClass<AndroidTestClass2> androidGenericClass =
            AndroidGenericClass<AndroidTestClass2>();
        androidGenericClass.add(testClass2);

        final AndroidTestClass2 result = await androidGenericClass.get('woie');
        expect(result, allOf(isNotNull, isA<AndroidTestClass2>()));
      });

      test('returnWrapper', () async {
        final AndroidTestClass1 result =
            await (testClass1.testClass1 as AndroidTestClass1).returnWrapper();

        expect(result, isNotNull);
        expect((result as dynamic).uniqueId, isNotNull);
        expect(result.returnInt(), completion(69));
      });

      test('callbackMethod', () async {
        final AndroidCallbackClass callbackClass = AndroidCallbackClass();
        expect(callbackClass.callbackCalled, isFalse);

        callbackClass.callCallbackMethod();
        await Future<void>.delayed(Duration(seconds: 2));
        expect(callbackClass.callbackCalled, isTrue);
      });
    }, skip: !Platform.isAndroid);

    group('ios', () {
      test('returnInt32', () {
        expect(IosTestClass1(), completion(56));
      });

      test('parameterMethod', () {
        expect(
          (testClass1.testClass1 as IosTestClass1).parameterMethod(
            'woeif',
            32,
            (testClass2.testClass2 as IosTestClass2),
          ),
          completes,
        );
      });

      test('$TestStruct', () {
        expect(TestStruct().intField, completion(isA<int>()));
      });

      test('$IosGenericClass', () async {
        genericClass.add(56);
        expect(await genericClass.get('eoij'), 56);

        final IosTestClass2 testClass2 = IosTestClass2();
        final IosGenericClass<IosTestClass2> iosGenericClass =
            IosGenericClass<IosTestClass2>();
        iosGenericClass.add(testClass2);

        final IosTestClass2 result = await iosGenericClass.get('woie');
        expect(result, allOf(isNotNull, isA<IosTestClass2>()));
      });

      test('returnWrapper', () async {
        final IosTestClass1 result =
            await (testClass1.testClass1 as IosTestClass1).returnWrapper();

        expect(result, isNotNull);
        expect((result as dynamic).uniqueId, isNotNull);
        expect(result.returnInt(), completion(69));
      });

      test('callbackMethod', () async {
        final IosCallbackClass callbackClass = IosCallbackClass();
        expect(callbackClass.callbackCalled, isFalse);

        callbackClass.callCallbackMethod();
        await Future<void>.delayed(Duration(seconds: 2));
        expect(callbackClass.callbackCalled, isTrue);
      });
    }, skip: !Platform.isIOS);
  });
}

class AndroidCallbackClass extends AndroidAbstractClass {
  bool callbackCalled = false;

  Future<void> callbackMethod(
    String supported,
    int primitive,
    AndroidTestClass2 wrapper,
    AndroidNestedClass nested,
  ) {
    callbackCalled = true;
    return Future<void>.value();
  }

  void callCallbackMethod() {
    super.callbackMethod('wofeij', 34, null, null);
  }
}

class IosCallbackClass extends IosProtocol {
  bool callbackCalled = false;

  @override
  Future<void> callbackMethod() {
    callbackCalled = true;
    return Future<void>.value();
  }

  void callCallbackMethod() {
    super.callbackMethod();
  }
}
