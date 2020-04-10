import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:uuid/uuid.dart';

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
    final TestClass testClass = TestClass(1, null);

    testManager.retain(testClass);
    testManager.retain(testClass);

    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        testManager.getReferenceId(testClass),
        TestClass(1, null),
      ]),
    ]);
  });

  test('release', () async {
    final TestClass testClass = TestClass(2, null);

    testManager.retain(testClass);
    final String referenceId = testManager.getReferenceId(testClass);
    log.clear();

    testManager.release(testClass);
    expect(log, <Matcher>[
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: Reference(referenceId),
      ),
    ]);
  });

  test('sendMethodCall', () async {
    final TestClass testClass = TestClass(3, null);
    testManager.retain(testClass);
    log.clear();

    final String result = await testClass.testMethod('Goodbye!');

    expect(result, equals('Hello!'));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        Reference(testManager.getReferenceId(testClass)),
        'testMethod',
        <dynamic>['Goodbye!'],
      ]),
    ]);
  });

  test('receiveLocalMethodCall', () async {
    final Completer<double> callbackCompleter = Completer<double>();
    final TestClass testClass = TestClass(3, (double testParameter) {
      callbackCompleter.complete(testParameter);
    });

    testManager.retain(testClass);

    testManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      testManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_METHOD',
          <dynamic>[
            Reference(testManager.getReferenceId(testClass)),
            'testCallbackMethod',
            <dynamic>[46.0],
          ],
        ),
      ),
      (ByteData data) {},
    );

    expect(callbackCompleter.future, completion(46.0));
  });

  test('createLocalReference', () async {
    final String referenceId = Uuid().v4();
    testManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      testManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_CREATE',
          <dynamic>[
            referenceId,
            TestClass(45, null),
          ],
        ),
      ),
      (ByteData data) {},
    );

    final TestClass testClass = testManager.getHolder(referenceId);
    expect(testClass.testField, equals(45));
    expect(testClass.testCallbackMethod, isNotNull);
  });

  test('sendMethodCall for callback', () async {
    final String referenceId = Uuid().v4();
    testManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      testManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_CREATE',
          <dynamic>[
            referenceId,
            TestClass(45, null),
          ],
        ),
      ),
      (ByteData data) {},
    );

    final TestClass testClass = testManager.getHolder(referenceId);
    testClass.testCallbackMethod(34.4);

    expect(log, <Matcher>[
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        Reference(referenceId),
        'testCallbackMethod',
        <dynamic>[34.4],
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
    switch (methodName) {
      case 'testCallbackMethod':
        (holder as dynamic).testCallbackMethod(arguments[0]);
        break;
    }
    throw StateError('receiveLocalMethodCall');
  }

  ReferenceHolder createLocalReference(String referenceId, dynamic arguments) {
    if (arguments is TestClass) {
      return TestClass(
        arguments.testField,
        (double testParameter) {
          testManager.sendMethodCall(
            testManager.getHolder(referenceId),
            'testCallbackMethod',
            <dynamic>[testParameter],
          );
        },
      );
    }
    throw StateError('createLocalReference');
  }
}

class TestClass with ReferenceHolder {
  const TestClass(this.testField, this.testCallbackMethod);

  final int testField;
  final void Function(double testParameter) testCallbackMethod;

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
        return TestClass(readValueOfType(buffer.getUint8(), buffer), null);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
