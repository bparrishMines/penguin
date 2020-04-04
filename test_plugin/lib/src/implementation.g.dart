part of 'implementation.dart';

abstract class _TestClass extends _ReferenceHolder {
  MethodCall _testMethod(String testParameter) {
    return reference.createMethodCall('testMethod', <dynamic>[testParameter]);
  }

  void _onTestCallbackCallback(List<dynamic> parameters) =>
      (this as dynamic).onTestCallback(parameters[0]);
}

MethodChannel _initializeReferenceMethodChannel(
  String name, [
  _GeneratedMessageCodec messageCodec = const _GeneratedMessageCodec(),
  BinaryMessenger binaryMessenger,
]) {
  assert(name != null);
  assert(messageCodec != null);
  return MethodChannel(
    name,
    StandardMethodCodec(messageCodec),
    binaryMessenger,
  )..setMethodCallHandler(
      (MethodCall call) async {
        final MethodChannelReference reference =
            ReferenceManager.globalInstance.getReference(call.arguments[0]);

        Function callbackFunction;
        switch (call.method) {
          case 'onTestCallback':
            callbackFunction =
                reference.creationParameters._onTestCallbackCallback;
            break;
        }

        callbackFunction(MethodChannelReference.getCallbackArguments(
          ReferenceManager.globalInstance,
          call,
        ));
        return null;
      },
    );
}

abstract class _ReferenceHolder extends ReferenceHolder {
  _ReferenceHolder() {
    _reference = MethodChannelReference(
      channel: _channel,
      creationParameters: this,
      useGlobalReferenceManager: true,
    );
  }

  MethodChannelReference _reference;

  @override
  MethodChannelReference get reference => _reference;

  MethodChannel get _channel;
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
        final value = TestClass(readNextValue(), null);
        return value
          .._reference = MethodChannelReference(
            channel: value._channel,
            referenceId: readNextValue(),
            initialReferenceCount: 1,
            useGlobalReferenceManager: true,
          )
          .._reference.autoReleasePool();
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
