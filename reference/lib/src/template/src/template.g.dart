part of 'template.dart';

typedef _LocalCreatorHandler = LocalReference Function(
  _$LocalReferenceCommunicationHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _LocalMethodHandler = Object Function(
  LocalReference localReference,
  List<Object> arguments,
);

typedef _CreationArgumentsHandler = List<Object> Function(
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
        );

  @override
  _$LocalReferenceCommunicationHandler get localHandler;

  @override
  MethodChannelRemoteHandler get remoteHandler =>
      _$RemoteReferenceCommunicationHandler(channel.name);
}

class _$LocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const _$LocalReferenceCommunicationHandler({this.createClassTemplate});

  static final Map<Type, Map<String, _LocalMethodHandler>> _methods =
      <Type, Map<String, _LocalMethodHandler>>{
    ClassTemplate: <String, _LocalMethodHandler>{
      'methodTemplate': (
        LocalReference localReference,
        List<Object> arguments,
      ) {
        return (localReference as ClassTemplate).methodTemplate(arguments[0]);
      },
    },
  };

  static final Map<Type, _LocalCreatorHandler> _creators =
      <Type, _LocalCreatorHandler>{
    ClassTemplate: (
      _$LocalReferenceCommunicationHandler localHandler,
      ReferencePairManager manager,
      List<Object> arguments,
    ) {
      return localHandler.createClassTemplate(manager, arguments[0]);
    },
  };

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
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    return _methods[localReference.referenceType][methodName](
      localReference,
      arguments,
    );
  }
}

class _$RemoteReferenceCommunicationHandler extends MethodChannelRemoteHandler {
  static final Map<Type, _CreationArgumentsHandler> _creationArguments =
      <Type, _CreationArgumentsHandler>{
    ClassTemplate: (LocalReference localReference) {
      return <Object>[(localReference as ClassTemplate).fieldTemplate];
    },
  };

  _$RemoteReferenceCommunicationHandler(String channelName)
      : super(channelName);

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return _creationArguments[localReference.referenceType](localReference);
  }
}

mixin _$ClassTemplateMethods implements LocalReference {
  Future<Object> _$methodTemplate(
    ReferencePairManager referencePairManager,
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
