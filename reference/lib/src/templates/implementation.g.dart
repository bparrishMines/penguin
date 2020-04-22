part of 'implementation.dart';

abstract class GeneratedReferenceManager extends MethodChannelReferenceManager {
  GeneratedReferenceManager(
    String channelName, [
    GeneratedMessageCodec messageCodec = const GeneratedMessageCodec(),
  ]) : super(
          channelName: channelName,
          messageCodec: messageCodec,
        );

  ClassTemplate createClassTemplate(String referenceId, int fieldTemplate);

  @override
  Future<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) async {
    if (holder is ClassTemplate && methodName == 'callbackTemplate') {
      return holder.callbackTemplate(arguments[0]);
    } else if (holder is ClassTemplate && methodName == 'methodTemplate') {
      return holder.methodTemplate(arguments[0]);
    } else {
      throw StateError('Could not call $methodName on ${holder.runtimeType}.');
    }
  }

  @override
  ReferenceHolder createLocalReference(String referenceId, dynamic arguments) {
    if (arguments[0] == GeneratedMessageCodec._valueClassTemplate) {
      return createClassTemplate(referenceId, arguments[1][0]);
    }
    throw StateError(
      'Could not instantiate an object with arguments: $arguments.',
    );
  }
}

class GeneratedMessageCodec extends ReferenceMessageCodec {
  const GeneratedMessageCodec();

  static const int _valueClassTemplate = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is ClassTemplate) {
      buffer.putUint8(_valueClassTemplate);
      writeValue(buffer, <dynamic>[
        _valueClassTemplate,
        <dynamic>[value.fieldTemplate],
      ]);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueClassTemplate:
        return readValueOfType(buffer.getUint8(), buffer);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
