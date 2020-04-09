import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  final List<MethodCall> log = <MethodCall>[];
  MethodChannelReferenceManager testManager;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    testManager = TestReferenceManager('test_channel')..initialize();
    testManager.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        log.add(methodCall);
      },
    );
  });

  tearDown(() {
    testManager = null;
    log.clear();
  });

  test('create', () async {
    final TestClass testClass = TestClass();

    testManager.retain(testClass);
    testManager.retain(testClass);

    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        testManager.getReferenceId(testClass),
        TestClass(),
      ]),
    ]);
  });

  test('dispose', () async {
    final TestClass testClass = TestClass();

    testManager.retain(testClass);
    final String referenceId = testManager.getReferenceId(testClass);
    testManager.release(testClass);

    expect(log, <Matcher>[
      isMethodCall(
        'REFERENCE_CREATE',
        arguments: <dynamic>[referenceId, TestClass()],
      ),
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: Reference(referenceId),
      ),
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
    if (arguments is TestClass) return TestClass();
    throw StateError('createLocalReference');
  }
}

class TestClass with ReferenceHolder {
  @override
  bool operator ==(other) => true;

  @override
  int get hashCode => 0;
}

class TestMessageCodec extends ReferenceMessageCodec {
  const TestMessageCodec();

  static const int _valueTestClass = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is TestClass) {
      buffer.putUint8(_valueTestClass);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueTestClass:
        return TestClass();
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
