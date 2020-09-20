part of 'template.dart';

typedef _$LocalCreatorHandler = LocalReference Function(
  _$LocalHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _$LocalStaticMethodHandler = Object Function(
  _$LocalHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _$LocalMethodHandler = Object Function(
  LocalReference localReference,
  List<Object> arguments,
);

typedef _$CreationArgumentsHandler = List<Object> Function(
  LocalReference localReference,
);

abstract class _$TemplateReferencePairManager
    extends MethodChannelReferencePairManager {
  _$TemplateReferencePairManager(
    String channelName, {
    ReferenceMessageCodec messageCodec,
  }) : super(
          <Type>[ClassTemplate],
          channelName,
          messageCodec: messageCodec,
          poolId: channelName,
        );

  @override
  _$LocalHandler get localHandler;

  @override
  MethodChannelRemoteHandler get remoteHandler =>
      _$RemoteHandler(channel.name);
}

class _$LocalHandler
    with LocalReferenceCommunicationHandler {
  const _$LocalHandler({
    this.createClassTemplate,
    this.classTemplate$staticMethodTemplate,
  });

  static final Map<Type, _$LocalCreatorHandler> _creators =
      <Type, _$LocalCreatorHandler>{
    ClassTemplate: (
      _$LocalHandler localHandler,
      ReferencePairManager manager,
      List<Object> arguments,
    ) {
      return localHandler.createClassTemplate(manager, arguments[0]);
    },
  };

  static final Map<Type, Map<String, _$LocalStaticMethodHandler>>
      _staticMethods = <Type, Map<String, _$LocalStaticMethodHandler>>{
    ClassTemplate: <String, _$LocalStaticMethodHandler>{
      'staticMethodTemplate': (
        _$LocalHandler localHandler,
        ReferencePairManager manager,
        List<Object> arguments,
      ) {
        return localHandler.classTemplate$staticMethodTemplate(
          manager,
          arguments[0],
        );
      },
    },
  };

  static final Map<Type, Map<String, _$LocalMethodHandler>> _methods =
      <Type, Map<String, _$LocalMethodHandler>>{
    ClassTemplate: <String, _$LocalMethodHandler>{
      'methodTemplate': (
        LocalReference localReference,
        List<Object> arguments,
      ) {
        return (localReference as ClassTemplate).methodTemplate(arguments[0]);
      },
    },
  };

  final double Function(
    ReferencePairManager manager,
    String parameterTemplate,
  ) classTemplate$staticMethodTemplate;

  final ClassTemplate Function(
    ReferencePairManager manager,
    int fieldTemplate,
  ) createClassTemplate;

  @override
  LocalReference create(
    ReferencePairManager manager,
    Type referenceType,
    List<Object> arguments,
  ) {
    return _creators[referenceType](this, manager, arguments);
  }

  @override
  Object invokeStaticMethod(
    ReferencePairManager referencePairManager,
    Type referenceType,
    String methodName,
    List<Object> arguments,
  ) {
    return _staticMethods[referenceType][methodName](
      this,
      referencePairManager,
      arguments,
    );
  }

  @override
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    final _$LocalMethodHandler handler =
        _methods[localReference.referenceType][methodName];
    if (handler != null) return handler(localReference, arguments);

    // Based on inheritance.
    if (localReference is ClassTemplate) {
      switch (methodName) {
        case 'methodTemplate':
          return localReference.methodTemplate(arguments[0]);
      }
    }

    throw ArgumentError.value(
      localReference,
      'localReference',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class _$RemoteHandler extends MethodChannelRemoteHandler {
  static final Map<Type, _$CreationArgumentsHandler> _creationArguments =
      <Type, _$CreationArgumentsHandler>{
    ClassTemplate: (LocalReference localReference) {
      return <Object>[(localReference as ClassTemplate).fieldTemplate];
    },
  };

  _$RemoteHandler(String channelName)
      : super(channelName);

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return _creationArguments[localReference.referenceType](localReference);
  }
}

mixin _$ClassTemplateMethods implements LocalReference {
  static Future<Object> _$staticMethodTemplate(
    _$TemplateReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    return referencePairManager.invokeRemoteStaticMethod(
      ClassTemplate,
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object> _$methodTemplate(
    _$TemplateReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    if (referencePairManager.getPairedRemoteReference(this) == null) {
      return referencePairManager.invokeRemoteMethodOnUnpairedReference(
        this,
        'methodTemplate',
        <Object>[parameterTemplate],
      );
    }

    return referencePairManager.invokeRemoteMethod(
      referencePairManager.getPairedRemoteReference(this),
      'methodTemplate',
      <Object>[parameterTemplate],
    );
  }
}
