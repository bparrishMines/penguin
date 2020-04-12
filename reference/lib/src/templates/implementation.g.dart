part of 'implementation.dart';

class GeneratedReferenceManager extends MethodChannelReferenceManager {
  GeneratedReferenceManager(
    String channelName, [
    GeneratedMessageCodec messageCodec = const GeneratedMessageCodec(),
  ]) : super(channelName, messageCodec);

  @override
  LocalReferenceFactory get localFactory => this;

  @override
  ReferenceMethodReceiver get methodReceiver => this;

  @override
  FutureOr<dynamic> receiveLocalMethodCall(
    ReferenceHolder holder,
    String methodName,
    List<dynamic> arguments,
  ) async {
    if (holder is ClassTemplate && methodName == 'callbackTemplate') {
      holder.callbackTemplate(arguments[0]);
    } else {
      throw StateError('Could not call $methodName on ${holder.runtimeType}.');
    }
  }

  ReferenceHolder createLocalReference(String referenceId, dynamic arguments) {
    if (arguments is ClassTemplateInterface) {
      return ClassTemplate(
        arguments.fieldTemplate,
        (double testParameter) {
          sendMethodCall(
            getHolder(referenceId),
            'callbackTemplate',
            <dynamic>[testParameter],
          );
        },
      );
    }
    throw StateError(
      'Could not instantiate an object with arguments: $arguments.',
    );
  }
}

class GeneratedMessageCodec extends ReferenceMessageCodec {
  const GeneratedMessageCodec();

  static const int _valueClassTemplateInterface = 129;

  @override
  void writeValue(WriteBuffer buffer, dynamic value) {
    if (value is ClassTemplateInterface) {
      buffer.putUint8(_valueClassTemplateInterface);
      writeValue(buffer, value.fieldTemplate);
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  dynamic readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case _valueClassTemplateInterface:
        return ClassTemplateInterface(
          readValueOfType(buffer.getUint8(), buffer),
          null,
        );
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
