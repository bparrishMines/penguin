part of 'implementation.dart';

abstract class _TestClass extends MethodChannelReferenceHolder {
  _TestClass() : super(_channel);

  MethodCall _testMethod(String testParameter) {
    return reference.createMethodCall('testMethod', <dynamic>[testParameter]);
  }

  void _onTestCallbackCallback(List<dynamic> parameters) =>
      (this as dynamic).onTestCallback(parameters[0]);
}

MethodChannel _initializeReferenceMethodChannel(
  String name, {
  _GeneratedMessageCodec messageCodec = const _GeneratedMessageCodec(),
  BinaryMessenger binaryMessenger,
  ReferenceManager referenceManager,
}) {
  assert(name != null);
  assert(messageCodec != null);
  referenceManager ??= ReferenceManager.globalInstance;
  return MethodChannel(
    name,
    StandardMethodCodec(messageCodec),
    binaryMessenger,
  )..setMethodCallHandler(
      (MethodCall call) async {
        final MethodChannelReference reference =
            referenceManager.getReference(call.arguments[0]);

        Function callbackFunction;
        switch (call.method) {
          case 'onTestCallback':
            callbackFunction =
                reference.creationParameters._onTestCallbackCallback;
            break;
        }

        callbackFunction(MethodChannelReference.getCallbackArguments(
          referenceManager,
          call,
        ));
        return null;
      },
    );
}

class _GeneratedMessageCodec extends StandardMessageCodec {
  const _GeneratedMessageCodec();

  static const int _valueTestClass = 128;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is TestClass) {
      buffer.putUint8(_valueTestClass);
      writeValue(buffer, value.testField);
      writeValue(buffer, value.reference.referenceId);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    dynamic readNextValue() => readValueOfType(buffer.getUint8(), buffer);

    switch (type) {
      case _valueTestClass:
        final value = TestClass(readNextValue(), (_) => null);
        return value
          ..reference = MethodChannelReference(
            channel: _channel,
            referenceId: readNextValue(),
            initialReferenceCount: 1,
            useGlobalReferenceManager: false,
          )
          ..reference.autoReleasePool();
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
