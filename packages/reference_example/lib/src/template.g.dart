// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $ClassTemplate {}

class $ClassTemplateChannel extends TypeChannel<$ClassTemplate> {
  $ClassTemplateChannel(TypeChannelMessenger messenger)
      : super(messenger, 'github.penguin/template/template/ClassTemplate');

  Future<PairedInstance?> $create(
    $ClassTemplate $instance, {
    required bool $owner,
    required int fieldTemplate,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[fieldTemplate],
      owner: $owner,
    );
  }

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
  $ClassTemplate $create(TypeChannelMessenger messenger, int fieldTemplate) {
    throw UnimplementedError();
  }

  Object? $onStaticMethodTemplate(
      TypeChannelMessenger messenger, String parameterTemplate) {
    throw UnimplementedError();
  }

  Object? $onMethodTemplate(
      $ClassTemplate $instance, String parameterTemplate) {
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
  $ClassTemplate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $create(messenger, arguments[0] as int);
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
        method = () => $onMethodTemplate(instance, arguments[0] as String);
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

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  $ClassTemplateChannel get classTemplateChannel =>
      $ClassTemplateChannel(messenger);
  $ClassTemplateHandler get classTemplateHandler => $ClassTemplateHandler();
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
