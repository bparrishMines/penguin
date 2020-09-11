import 'dart:async';

import 'package:e2e/e2e.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference_example/reference_example.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    //await MyTester.waitForTestSetup();
  });

  testWidgets("testMyClass", (WidgetTester tester) async {
    MyClass myClass = MyClass('woiefj');
    await myClass.myMethod(23, MyOtherClass(23));

    expect(true, isTrue);

    //expect(MyTester.verify('testMyClass'), completes);
  });
}

class MyTester {
  static final MethodChannel channel = MethodChannel('test_channel');

  static Future<void> verify(String methodName) {
    return channel.invokeMethod<void>('verify', methodName);
  }
}
