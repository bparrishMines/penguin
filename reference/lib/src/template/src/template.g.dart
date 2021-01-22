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
  $ClassTemplateChannel(TypeChannelManager manager)
      : super(manager, 'github.penguin/template/template/ClassTemplate');

  Future<Object?> $invokeStaticMethodTemplate(String parameterTemplate) {
    return invokeStaticMethod(
      'staticMethodTemplate',
      <Object?>[parameterTemplate],
    );
  }

  Future<Object?> $invokeMethodTemplate(
      $ClassTemplate instance, String parameterTemplate) {
    return invokeMethod(
      instance,
      'methodTemplate',
      <Object?>[parameterTemplate],
    );
  }
}

class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
  $ClassTemplateHandler(
      {this.onCreate, this.onDispose, this.$onStaticMethodTemplate});

  final $ClassTemplate Function(
      TypeChannelManager manager, $ClassTemplateCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $ClassTemplate instance)?
      onDispose;

  final double Function(TypeChannelManager manager, String parameterTemplate)?
      $onStaticMethodTemplate;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'staticMethodTemplate':
        method =
            () => $onStaticMethodTemplate!(manager, arguments[0] as String);
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
    TypeChannelManager manager,
    $ClassTemplate instance,
  ) {
    return <Object?>[instance.fieldTemplate];
  }

  @override
  $ClassTemplate createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $ClassTemplateCreationArgs()..fieldTemplate = arguments[0] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
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

  @override
  void onInstanceDisposed(TypeChannelManager manager, $ClassTemplate instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}
