part of 'implementation.dart';

abstract class _TestClass extends _GeneratedReference {
  MethodCall _testMethod(String testParameter) {
    return _reference.createMethodCall('testMethod', <dynamic>[testParameter]);
  }
}

class _GeneratedMessageCodec extends StandardMessageCodec {
  const _GeneratedMessageCodec();

  static const int _valueTestClass = 128;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is TestClass) {
      buffer.putUint8(_valueTestClass);
      writeValue(buffer, value.testField);
      writeValue(buffer, value._reference.referenceId);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    dynamic readNextValue() => readValueOfType(buffer.getUint8(), buffer);

    switch (type) {
      case _valueTestClass:
        final value = TestClass(readNextValue());
        return value
          .._reference = MethodChannelReference(
            channel: value._channel,
            referenceId: readNextValue(),
            initialReferenceCount: 1,
          )
          .._reference.autoReleasePool();
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class _GeneratedReference {
  _GeneratedReference() {
    _reference = MethodChannelReference(
      channel: _channel,
      creationParameters: this,
    );
  }

  MethodChannelReference _reference;
  MethodChannelReference get reference => _reference;

  MethodChannel get _channel;
}
