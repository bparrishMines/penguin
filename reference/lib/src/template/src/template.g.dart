// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

Object _replaceIfUnpaired(
  ReferenceChannelManager manager,
  String handlerChannel,
  Object instance,
) {
  return manager.isPaired(instance)
      ? instance
      : manager.createUnpairedReference(handlerChannel, instance);
}

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

class $ClassTemplateChannel extends ReferenceChannel<$ClassTemplate> {
  $ClassTemplateChannel(
    ReferenceChannelManager manager, {
    $ClassTemplateHandler handler,
  }) : super(manager, 'github.penguin/template/template/ClassTemplate') {
    registerHandler(handler);
  }

  Future<Object> $invokeStaticMethodTemplate(
      String parameterTemplate, $ClassTemplate2 referenceParameterTemplate) {
    return invokeStaticMethod(
      'staticMethodTemplate',
      <Object>[
        parameterTemplate,
        _replaceIfUnpaired(
          manager,
          'github.penguin/template/template/ClassTemplate2',
          referenceParameterTemplate,
        )
      ],
    );
  }

  Future<Object> $invokeMethodTemplate($ClassTemplate instance,
      String parameterTemplate, $ClassTemplate2 referenceParameterTemplate) {
    final String $methodName = 'methodTemplate';
    final List<Object> $arguments = <Object>[
      parameterTemplate,
      _replaceIfUnpaired(
        manager,
        'github.penguin/template/template/ClassTemplate2',
        referenceParameterTemplate,
      )
    ];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $ClassTemplate2Channel extends ReferenceChannel<$ClassTemplate2> {
  $ClassTemplate2Channel(
    ReferenceChannelManager manager, {
    $ClassTemplate2Handler handler,
  }) : super(manager, 'github.penguin/template/template/ClassTemplate2') {
    registerHandler(handler);
  }
}

class $ClassTemplateHandler implements ReferenceChannelHandler<$ClassTemplate> {
  $ClassTemplateHandler(
      {this.onCreateClassTemplate,
      this.onDisposeClassTemplate,
      this.$onStaticMethodTemplate});

  final $ClassTemplate Function(
          ReferenceChannelManager manager, $ClassTemplateCreationArgs args)
      onCreateClassTemplate;

  final void Function(ReferenceChannelManager manager, $ClassTemplate instance)
      onDisposeClassTemplate;

  final double Function(
      ReferenceChannelManager manager,
      String parameterTemplate,
      $ClassTemplate2 referenceParameterTemplate) $onStaticMethodTemplate;

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
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
  ) {
    return <Object>[
      instance.fieldTemplate,
      _replaceIfUnpaired(
        manager,
        'github.penguin/template/template/ClassTemplate2',
        instance.referenceParameterTemplate,
      )
    ];
  }

  @override
  $ClassTemplate createInstance(
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
  Object invokeMethod(
    ReferenceChannelManager manager,
    $ClassTemplate instance,
    String methodName,
    List<Object> arguments,
  ) {
    switch (methodName) {
      case 'methodTemplate':
        return instance.methodTemplate(arguments[0], arguments[1]);
    }

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
    onDisposeClassTemplate(manager, instance);
  }
}

class $ClassTemplate2Handler
    implements ReferenceChannelHandler<$ClassTemplate2> {
  $ClassTemplate2Handler({
    this.onCreateClassTemplate2,
    this.onDisposeClassTemplate2,
  });

  final $ClassTemplate2 Function(
          ReferenceChannelManager manager, $ClassTemplate2CreationArgs args)
      onCreateClassTemplate2;

  final void Function(ReferenceChannelManager manager, $ClassTemplate2 instance)
      onDisposeClassTemplate2;

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
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $ClassTemplate2 instance,
  ) {
    return <Object>[];
  }

  @override
  $ClassTemplate2 createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreateClassTemplate2(
      manager,
      $ClassTemplate2CreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $ClassTemplate2 instance,
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
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $ClassTemplate2 instance,
  ) {
    onDisposeClassTemplate2(manager, instance);
  }
}
