import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

MethodChannelReferenceManager testManager;

void main() {
  final List<MethodCall> log = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    testManager = TestReferenceManager('test_channel')..initialize();
    testManager.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == MethodChannelReferenceManager.methodMethod) {
          return 'Hello!';
        }
        return null;
      },
    );
  });

  tearDown(() {
    testManager = null;
    log.clear();
  });

  test('retain', () async {
    final TestClass testClass = TestClass(1);

    testManager.retain(testClass);
    testManager.retain(testClass);

    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        testManager.getReferenceId(testClass),
        TestClass(1),
      ]),
    ]);
  });

  test('release', () async {
    final TestClass testClass = TestClass(2);

    testManager.retain(testClass);
    final String referenceId = testManager.getReferenceId(testClass);
    testManager.release(testClass);

    expect(log, <Matcher>[
      isMethodCall(
        'REFERENCE_CREATE',
        arguments: <dynamic>[referenceId, TestClass(2)],
      ),
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: Reference(referenceId),
      ),
    ]);
  });

  test('sendMethodCall', () async {
    final TestClass testClass = TestClass(3);
    testManager.retain(testClass);

    final String result = await testClass.testMethod('Goodbye!');

    expect(result, equals('Hello!'));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        testManager.getReferenceId(testClass),
        TestClass(3),
      ]),
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        Reference(testManager.getReferenceId(testClass)),
        'testMethod',
        <dynamic>['Goodbye!'],
      ]),
    ]);
  });
}

class TestReferenceManager extends MethodChannelReferenceManager {
  TestReferenceManager(String channelName)
      : super(channelName, TestMessageCodec());

  @override
  LocalReferenceFactory get localFactory => this;

  @override
  ReferenceMethodReceiver get methodReceiver => this;

  @override
  FutureOr<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) {
    return null;
  }

  ReferenceHolder createLocalReference(String referenceId, dynamic arguments) {
    if (arguments is TestClass) return TestClass(arguments.testField);
    throw StateError('createLocalReference');
  }
}

class TestClass with ReferenceHolder {
  const TestClass(this.testField);

  final int testField;

  Future<String> testMethod(String testParameter) async {
    return (await testManager.sendMethodCall(
      this,
      'testMethod',
      <dynamic>[testParameter],
    )) as String;
  }

  @override
  bool operator ==(other) => other is TestClass && testField == other.testField;

  @override
  int get hashCode => testField.hashCode;
}

class TestMessageCodec extends ReferenceMessageCodec {
  const TestMessageCodec();

  static const int _valueTestClass = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is TestClass) {
      buffer.putUint8(_valueTestClass);
      writeValue(buffer, value.testField);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueTestClass:
        return TestClass(readValueOfType(buffer.getUint8(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
