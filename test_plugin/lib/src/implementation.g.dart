part of 'implementation.dart';

abstract class _MethodChannelTestClass extends TestPluginReference {
  Future<dynamic> _testMethod(String testParameter) {
    return _channel.invokeMethod<dynamic>(
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
        return TestClass(readNextValue()).._changeReferenceId(readNextValue());
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestPluginReference {
  TestPluginReference() {
    _reference = MethodChannelReference(object: this, channel: _channel);
  }

  MethodChannelReference _reference;
  MethodChannel get _channel;

  void _retain() => _reference.retain();

  void _release() => _reference.release();

  void _autoReleasePool() => _reference.autoReleasePool();

  void _changeReferenceId(String referenceId) =>
      _reference.changeReferenceId(referenceId);
}
