// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $ClassTemplate {
  int get fieldTemplate;
  $ClassTemplate2 get referenceParameterTemplate;
  Future<String> methodTemplate(
    String parameterTemplate,
    $ClassTemplate2 referenceParameterTemplate,
  );
}

mixin $ClassTemplate2 {}

class $ClassTemplateCreationArgs {
  int fieldTemplate;
  $ClassTemplate2 referenceParameterTemplate;
}

class $ClassTemplate2CreationArgs {}

class $ClassTemplateHandler implements ReferenceChannelHandler {
  $ClassTemplateHandler(
      {this.onCreateClassTemplate,
      this.onDisposeClassTemplate,
      this.$onStaticMethodTemplate});

  static const $handlerChannel =
      'github.penguin/template/template/ClassTemplate';

  final $ClassTemplate Function(
          ReferenceChannelManager manager, $ClassTemplateCreationArgs args)
      onCreateClassTemplate;

  final void Function(ReferenceChannelManager manager, $ClassTemplate instance)
      onDisposeClassTemplate;

  final double Function(
      ReferenceChannelManager manager,
      String parameterTemplate,
      $ClassTemplate2 referenceParameterTemplate) $onStaticMethodTemplate;

  static Future<void> $createPair(
      MethodChannelReferenceChannelManager manager, $ClassTemplate instance) {
    return manager.createNewPair($handlerChannel, instance);
  }

  static Future<Object> $invokeStaticMethodTemplate(
      MethodChannelReferenceChannelManager manager,
      String parameterTemplate,
      $ClassTemplate2 referenceParameterTemplate) {
    final String $methodName = 'staticMethodTemplate';
    final List<Object> $arguments = <Object>[
      parameterTemplate,
      manager.referencePairs
                  .getPairedRemoteReference(referenceParameterTemplate) !=
              null
          ? referenceParameterTemplate
          : manager.createUnpairedReference(
              'github.penguin/template/template/ClassTemplate2',
              referenceParameterTemplate,
            )
    ];

    return manager.invokeStaticMethod($handlerChannel, $methodName, $arguments);
  }

  static Future<Object> $invokeMethodTemplate(
      MethodChannelReferenceChannelManager manager,
      $ClassTemplate instance,
      String parameterTemplate,
      $ClassTemplate2 referenceParameterTemplate) {
    final RemoteReference $remoteReference =
        manager.referencePairs.getPairedRemoteReference(instance);
    final String $methodName = 'methodName';
    final List<Object> $arguments = <Object>[
      parameterTemplate,
      manager.referencePairs
                  .getPairedRemoteReference(referenceParameterTemplate) !=
              null
          ? referenceParameterTemplate
          : manager.createUnpairedReference(
              'github.penguin/template/template/ClassTemplate2',
              referenceParameterTemplate,
            )
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
        manager,
        $ClassTemplateCreationArgs()
          ..fieldTemplate = arguments[0]
          ..referenceParameterTemplate = arguments[1]);
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    Object instance,
  ) {
    return <Object>[
      (instance as $ClassTemplate).fieldTemplate,
      manager.referencePairs.getPairedRemoteReference(
                  (instance as $ClassTemplate).referenceParameterTemplate) !=
              null
          ? (instance as $ClassTemplate).referenceParameterTemplate
          : manager.createUnpairedReference(
              'github.penguin/template/template/ClassTemplate2',
              (instance as $ClassTemplate).referenceParameterTemplate,
            )
    ];
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
        return (instance as $ClassTemplate)
            .methodTemplate(arguments[0], arguments[1]);
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
        return $onStaticMethodTemplate(manager, arguments[0], arguments[1]);
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

class $ClassTemplate2Handler implements ReferenceChannelHandler {
  $ClassTemplate2Handler({
    this.onCreateClassTemplate2,
    this.onDisposeClassTemplate2,
  });

  static const $handlerChannel =
      'github.penguin/template/template/ClassTemplate2';

  final $ClassTemplate2 Function(
          ReferenceChannelManager manager, $ClassTemplate2CreationArgs args)
      onCreateClassTemplate2;

  final void Function(ReferenceChannelManager manager, $ClassTemplate2 instance)
      onDisposeClassTemplate2;

  static Future<void> $createPair(
      MethodChannelReferenceChannelManager manager, $ClassTemplate2 instance) {
    return manager.createNewPair($handlerChannel, instance);
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
    return onCreateClassTemplate2(
      manager,
      $ClassTemplate2CreationArgs(),
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    Object instance,
  ) {
    return <Object>[];
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    Object instance,
    String methodName,
    List<Object> arguments,
  ) {
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
    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  void onInstanceDisposed(ReferenceChannelManager manager, Object instance) {
    onDisposeClassTemplate2(manager, instance);
  }
}
