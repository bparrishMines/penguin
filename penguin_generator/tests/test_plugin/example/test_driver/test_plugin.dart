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
    TestClass1 testClass;
    TestClass2 testClass2;

    setUpAll(() {
      print('Platform: ${Platform.isAndroid ? 'Android' : 'Ios'}');
      testClass = Platform.isAndroid ? AndroidTestClass1() : IosTestClass1();
      testClass2 = Platform.isAndroid ? AndroidTestClass2() : IosTestClass2();
    });

    test('intField', () {
      expect(testClass.intField, completion(43));
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
      final TestClass1 testClass = Platform.isAndroid
          ? AndroidTestClass1.namedConstructor(
              'hello',
              45,
              (testClass2 as AndroidTestClass2),
              AndroidNestedClass(),
            )
          : IosTestClass1.initNamedConstructor(
              'goodbye',
              23,
              (testClass2 as IosTestClass2),
            );
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
  });
//  group('test_plugin', () {
//    group('android', () {
//      group('enum', () {
//        test('enumMethod', () {
//          expect(AndroidTestEnum.ONE.enumMethod(), completion(2));
//          expect(AndroidTestEnum.ONE.enumMethod(), completion(2));
//        });
//      });
//
//      test('namedConstructor', () {
//        expect(
//          AndroidTestClass1.namedConstructor('Amigo').constructorValue,
//          completion('Amigo'),
//        );
//      });
//
//      test('staticField', () {
//        expect(AndroidTestClass1.staticField, completion(12));
//      });
//
//      test('objectField', () {
//        expect(AndroidTestClass1().objectField, completion('32'));
//
//        final AndroidTestClass1 class1 = AndroidTestClass1();
//        class1.objectField = '64';
//        expect(class1.objectField, completion('64'));
//      });
//
//      test('dynamicField', () {
//        expect(AndroidTestClass1().dynamicField, completion(42));
//      });
//
//      test('stringField', () {
//        expect(AndroidTestClass1().stringField, completion('Macintosh'));
//      });
//
//      test('doubleField', () {
//        expect(AndroidTestClass1().doubleField, completion(44.0));
//      });
//
//      test('numField', () {
//        expect(AndroidTestClass1().numField, completion(0));
//      });
//
//      test('boolField', () {
//        expect(AndroidTestClass1().boolField, completion(true));
//      });
//
//      test('listField', () {
//        expect(
//          AndroidTestClass1().listField,
//          completion(<bool>[true, false, true]),
//        );
//      });
//
//      test('mapField', () {
//        expect(
//          AndroidTestClass1().mapField,
//          completion(<String, double>{'true': 1.0, 'false': 0.0}),
//        );
//      });
//
//      test('callbackMethod', () async {
//        final MockAndroidTestClass1 mockClass = MockAndroidTestClass1();
//        await mockClass.callCallbackMethod();
//        await Future.delayed(Duration(seconds: 1));
//        expect(mockClass.callbackValue, 'I love callbacks.');
//      });
//    }, skip: !Platform.isAndroid);
//  });
}

//class MockAndroidTestClass1 extends AndroidTestClass1 {
//  String callbackValue;
//
//  @override
//  Future<void> callbackMethod(
//    AndroidTestClass3 wrapper,
//    String supported,
//  ) async {
//    super.callbackMethod(wrapper, supported);
//    callbackValue = supported;
//  }
//}
