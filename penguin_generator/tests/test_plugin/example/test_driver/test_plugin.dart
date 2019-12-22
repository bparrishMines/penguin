// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugin/android.dart';
import 'package:test_plugin/ios.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);
  tearDownAll(() => completer.complete(null));

  group('test_plugin', () {
    TestClass1 testClass;
    TestClass2 testClass2;
    GenericClass genericClass;
    dynamic callbackClass1;
    dynamic callbackClass2;

    setUpAll(() {
      print('Platform: ${Platform.isAndroid ? 'Android' : 'Ios'}');
      if (Platform.isAndroid) {
        testClass = AndroidTestClass1();
        testClass2 = AndroidTestClass2();
      } else if (Platform.isIOS) {
        testClass = IosTestClass1();
        testClass2 = IosTestClass2();
      }
      callbackClass1 =
          Platform.isAndroid ? AndroidCallbackClass() : IosCallbackClass();
      callbackClass2 =
          Platform.isAndroid ? AndroidCallbackClass() : IosCallbackClass();
    });

    test('intField', () {
      expect(testClass.intField, completion(43));
    });

    test('mutableField', () {
      TestClass1 mutableTestClass;
      if (Platform.isAndroid) {
        mutableTestClass = AndroidTestClass1();
      } else if (Platform.isIOS) {
        mutableTestClass = IosTestClass1();
      }
      mutableTestClass.mutableField = 23.4;
      expect(mutableTestClass.mutableField, completion(23.4));
    });

    test('stringField', () {
      expect(testClass.stringField, completion("Macintosh"));
    });

    test('doubleField', () {
      expect(testClass.doubleField, completion(44.0));
    });

    test('boolField', () {
      expect(testClass.boolField, completion(isTrue));
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
      TestClass1 testClass;
      if (Platform.isAndroid) {
        testClass = AndroidTestClass1.namedConstructor(
          'hello',
          45,
          (testClass2 as AndroidTestClass2),
          AndroidNestedClass(),
        );
      } else if (Platform.isIOS) {
        testClass = IosTestClass1.initNamedConstructor(
          'goodbye',
          23,
          (testClass2 as IosTestClass2),
        );
      }
      expect(testClass.returnBool(), completion(isFalse));
    });

    test('returnVoid', () {
      expect(testClass.returnVoid(), completes);
    });

    test('returnString', () {
      expect(testClass.returnString(), completion('Amigo'));
    });

    test('returnInt', () {
      expect(testClass.returnInt(), completion(69));
    });

    test('returnDouble', () {
      expect(testClass.returnDouble(), completion(70.0));
    });

    test('returnBool', () {
      expect(testClass.returnBool(), completion(false));
    });

    test('returnList', () {
      expect(
        testClass.returnList(),
        completion(<double>[1.0, 2.0]),
      );
    });

    test('returnMap', () {
      expect(
        testClass.returnMap(),
        completion(<String, int>{'one': 1, 'two': 2}),
      );
    });

    test('returnObject', () {
      expect(testClass.returnObject(), completion('Hello'));
    });

    test('returnDynamic', () {
      expect(testClass.returnDynamic(), completion(3));
    });

    test('returnInt32', () {
      expect((testClass as IosTestClass1).returnInt32(), completion(56));
    }, skip: !Platform.isIOS);

    test('parameterMethod', () {
      if (Platform.isAndroid) {
        expect(
          (testClass as AndroidTestClass1).parameterMethod(
            'woeif',
            32,
            (testClass2 as AndroidTestClass2),
            AndroidNestedClass(),
          ),
          completes,
        );
      } else if (Platform.isIOS) {
        expect(
          (testClass as IosTestClass1).parameterMethod(
            'woeif',
            32,
            (testClass2 as IosTestClass2),
          ),
          completes,
        );
      }
    });

    test('callbackMethod', () async {
      expect(callbackClass1.callbackCalled, isFalse);
      callbackClass1.callCallbackMethod();
      await Future<void>.delayed(Duration(seconds: 2));
      expect(callbackClass1.callbackCalled, isTrue);

      expect(callbackClass2.callbackCalled, isFalse);
      callbackClass2.callCallbackMethod();
      await Future<void>.delayed(Duration(seconds: 2));
      expect(callbackClass2.callbackCalled, isTrue);
    });

    test('$TestStruct', () {
      expect(TestStruct().intField, completion(isA<int>()));
    }, skip: !Platform.isIOS);
  });
}

class AndroidCallbackClass extends AndroidAbstractClass {
  bool callbackCalled = false;

  @override
  void callbackMethod() {
    callbackCalled = true;
  }

  void callCallbackMethod() {
    super.callbackMethod();
  }
}

class IosCallbackClass extends IosProtocol {
  bool callbackCalled = false;

  @override
  void callbackMethod() {
    callbackCalled = true;
  }

  void callCallbackMethod() {
    super.callbackMethod();
  }
}
