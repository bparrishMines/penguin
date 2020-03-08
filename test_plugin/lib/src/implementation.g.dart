part of 'implementation.dart';

abstract class _MethodChannelTestClass with MethodChannelReferenceHolder {
  MethodCall _testMethod(String testParameter) {
    return MethodCall(
      'METHODCALL',
      <dynamic>[this, 'testMethod', testParameter],
    );
  }
}

class TestPluginMessageCodec extends StandardMessageCodec {
  const TestPluginMessageCodec();

  static const int _valueTestClass = 128;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is TestClass) {
      buffer.putUint8(_valueTestClass);
      writeValue(buffer, value.testField);
      writeValue(buffer, (value as MethodChannelReferenceHolder).referenceId);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    dynamic readNextValue() => readValueOfType(buffer.getUint8(), buffer);

    switch (type) {
      case _valueTestClass:
        return (TestClass(readNextValue()) as MethodChannelReferenceHolder)
          ..setReferenceId(readNextValue());
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
