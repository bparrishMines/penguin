import 'dart:async';

import 'package:flutter/foundation.dart';

import '../reference.dart';

// Set to run tests with test class.
MethodChannelReferenceManager testManager;

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
          sendMethodCall(
            getHolder(referenceId),
            'testCallbackMethod',
            <dynamic>[testParameter],
          );
        },
      );
    }
    throw StateError('createLocalReference');
  }
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
