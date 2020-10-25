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

class $ClassTemplateHandler implements ReferenceChannelHandler {
  $ClassTemplateHandler(
      {this.onCreateClassTemplate,
      this.onDisposeClassTemplate,
      this.$onStaticMethodTemplate});

  static const $handlerChannel = 'github.penguin/reference/template';

  final $ClassTemplate Function(
          ReferenceChannelManager manager, $ClassTemplateCreationArgs args)
      onCreateClassTemplate;

  final void Function(ReferenceChannelManager manager, $ClassTemplate instance)
      onDisposeClassTemplate;

  final double Function(
          ReferenceChannelManager manager, String parameterTemplate)
      $onStaticMethodTemplate;

  static Future<void> $createPair(
      MethodChannelReferenceChannelManager manager, $ClassTemplate instance) {
    return manager.createNewPair($handlerChannel, instance);
  }

  static Future<Object> $invokeStaticMethodTemplate(
      MethodChannelReferenceChannelManager manager, String parameterTemplate) {
    final String $methodName = 'staticMethodTemplate';
    final List<Object> $arguments = <Object>[parameterTemplate];

    return manager.invokeStaticMethod($handlerChannel, $methodName, $arguments);
  }

  // TODO: handle difference between an instance vs regular
  static Future<Object> $invokeMethodTemplate(
      MethodChannelReferenceChannelManager manager,
      $ClassTemplate instance,
      String parameterTemplate) {
    final RemoteReference $remoteReference =
        manager.referencePairs.getPairedRemoteReference(instance);
    final String $methodName = 'methodName';
    final List<Object> $arguments = <Object>[
      manager.referencePairs.getPairedRemoteReference(parameterTemplate) == null
          ? parameterTemplate
          : manager.createUnpairedReference('channel', parameterTemplate)
    ];

    if ($remoteReference == null) {
      return manager.invokeMethodOnUnpairedReference(
        $handlerChannel,
        instance,
        $methodName,
        $arguments,
      );
    }

    return manager.invokeMethod(
      $handlerChannel,
      $remoteReference,
      $methodName,
      $arguments,
    );
  }

  static Future<void> $disposePair(
    MethodChannelReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    return manager.disposePair($handlerChannel, instance);
  }

  @override
  Object createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreateClassTemplate(
        manager, $ClassTemplateCreationArgs()..fieldTemplate = arguments[0]);
  }

  @override
  List<Object> getCreationArguments(Object instance) {
    return <Object>[(instance as $ClassTemplate).fieldTemplate];
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    Object instance,
    String methodName,
    List<Object> arguments,
  ) {
    switch (methodName) {
      case 'methodTemplate':
        return (instance as $ClassTemplate).methodTemplate(arguments[0]);
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    switch (methodName) {
      case 'staticMethodTemplate':
        return $onStaticMethodTemplate(manager, arguments[0]);
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  void onInstanceDisposed(ReferenceChannelManager manager, Object instance) {
    onDisposeClassTemplate(manager, instance);
  }
}
