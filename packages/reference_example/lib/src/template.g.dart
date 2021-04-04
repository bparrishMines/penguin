// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $ClassTemplate {
  int get fieldTemplate;
  Future<String> methodTemplate(String parameterTemplate);
}

class $ClassTemplateCreationArgs {
  late int fieldTemplate;
}

class $ClassTemplateChannel extends TypeChannel<$ClassTemplate> {
  $ClassTemplateChannel(TypeChannelMessenger messenger)
      : super(messenger, 'github.penguin/template/template/ClassTemplate');

  Future<Object?> $invokeStaticMethodTemplate(String parameterTemplate) {
    return sendInvokeStaticMethod(
      'staticMethodTemplate',
      <Object?>[parameterTemplate],
    );
  }

  Future<Object?> $invokeMethodTemplate(
      $ClassTemplate instance, String parameterTemplate) {
    return sendInvokeMethod(
      instance,
      'methodTemplate',
      <Object?>[parameterTemplate],
    );
  }
}

class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
  $ClassTemplate onCreate(
    TypeChannelMessenger messenger,
    $ClassTemplateCreationArgs args,
  ) {
    throw UnimplementedError();
  }

  double $onStaticMethodTemplate(
      TypeChannelMessenger messenger, String parameterTemplate) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'staticMethodTemplate':
        method =
            () => $onStaticMethodTemplate(messenger, arguments[0] as String);
        break;
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelMessenger messenger,
    $ClassTemplate instance,
  ) {
    return <Object?>[instance.fieldTemplate];
  }

  @override
  $ClassTemplate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $ClassTemplateCreationArgs()..fieldTemplate = arguments[0] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ClassTemplate instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'methodTemplate':
        method = () => instance.methodTemplate(arguments[0] as String);
        break;
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }
}

abstract class $LibraryImplementations {
  $ClassTemplateChannel get classTemplateChannel;
  $ClassTemplateHandler get classTemplateHandler;
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.classTemplateChannel.setHandler(
      implementations.classTemplateHandler,
    );
  }

  void unregisterHandlers() {
    implementations.classTemplateChannel.removeHandler();
  }
}
