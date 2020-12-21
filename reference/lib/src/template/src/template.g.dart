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

class $ClassTemplateChannel extends ReferenceChannel<$ClassTemplate> {
  $ClassTemplateChannel(ReferenceChannelManager manager)
      : super(manager, 'github.penguin/template/template/ClassTemplate');

  Future<Object?> $invokeStaticMethodTemplate(String parameterTemplate) {
    return invokeStaticMethod(
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object?> $invokeMethodTemplate(
      $ClassTemplate instance, String parameterTemplate) {
    return invokeMethod(
      instance,
      'methodTemplate',
      <Object>[parameterTemplate],
    );
  }
}

class $ClassTemplateHandler implements ReferenceChannelHandler<$ClassTemplate> {
  $ClassTemplateHandler(
      {this.onCreate, this.onDispose, this.$onStaticMethodTemplate});

  final $ClassTemplate Function(
          ReferenceChannelManager manager, $ClassTemplateCreationArgs args)?
      onCreate;

  final void Function(ReferenceChannelManager manager, $ClassTemplate instance)?
      onDispose;

  final double Function(
          ReferenceChannelManager manager, String parameterTemplate)?
      $onStaticMethodTemplate;

  @override
  Object? invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    late Function method;
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

    return method();
  }

  @override
  List<Object?> getCreationArguments(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    return <Object>[instance.fieldTemplate];
  }

  @override
  $ClassTemplate createInstance(
    ReferenceChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $ClassTemplateCreationArgs()..fieldTemplate = arguments[0] as int,
    );
  }

  @override
  Object? invokeMethod(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
    String methodName,
    List<Object?> arguments,
  ) {
    late Function method;
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

    return method();
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}
