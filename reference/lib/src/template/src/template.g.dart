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
  int fieldTemplate;
}

class $ClassTemplateChannel extends ReferenceChannel<$ClassTemplate> {
  $ClassTemplateChannel(ReferenceChannelManager manager)
      : super(manager, 'github.penguin/template/template/ClassTemplate');

  Future<Object> $invokeStaticMethodTemplate(String parameterTemplate) {
    return invokeStaticMethod(
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object> $invokeMethodTemplate(
      $ClassTemplate instance, String parameterTemplate) {
    final String $methodName = 'methodTemplate';
    final List<Object> $arguments = <Object>[parameterTemplate];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $ClassTemplateHandler implements ReferenceChannelHandler<$ClassTemplate> {
  $ClassTemplateHandler(
      {this.onCreate, this.onDispose, this.$onStaticMethodTemplate});

  final $ClassTemplate Function(
          ReferenceChannelManager manager, $ClassTemplateCreationArgs args)
      onCreate;

  final void Function(ReferenceChannelManager manager, $ClassTemplate instance)
      onDispose;

  final double Function(
          ReferenceChannelManager manager, String parameterTemplate)
      $onStaticMethodTemplate;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'staticMethodTemplate':
        method = () => $onStaticMethodTemplate(manager, arguments[0]);
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    return <Object>[instance.fieldTemplate];
  }

  @override
  $ClassTemplate createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $ClassTemplateCreationArgs()..fieldTemplate = arguments[0],
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'methodTemplate':
        method = () => instance.methodTemplate(arguments[0]);
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}
