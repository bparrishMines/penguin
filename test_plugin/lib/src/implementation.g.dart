part of 'implementation.dart';

class GeneratedReferenceManager extends MethodChannelReferenceManager {
  GeneratedReferenceManager(String channelName)
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

class GeneratedMessageCodec extends ReferenceMessageCodec {
  const GeneratedMessageCodec();

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
    dynamic readNextValue() => readValueOfType(buffer.getUint8(), buffer);

    switch (type) {
      case _valueTestClass:
        return TestClass(readNextValue(), null);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
