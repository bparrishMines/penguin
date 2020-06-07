part of 'template.dart';

class _$TemplateReferencePairManager extends MethodChannelReferencePairManager {
  _$TemplateReferencePairManager(
    String channelName,
    _$LocalReferenceCommunicationHandler localHandler, {
    _$RemoteReferenceCommunicationHandler remoteHandler,
    ReferenceMessageCodec referenceMessageCodec = const ReferenceMessageCodec(),
  }) : super(
          <Type>[ClassTemplate],
          channelName,
          localHandler: localHandler,
          remoteHandler:
              remoteHandler ?? _$RemoteReferenceCommunicationHandler(),
          referenceMessageCodec: referenceMessageCodec,
        );
}

class _$LocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const _$LocalReferenceCommunicationHandler({this.createClassTemplate});

  static final Map<Type, Map<String, Function>> _methods =
      <Type, Map<String, Function>>{
    ClassTemplate: <String, Function>{
      'methodTemplate': (ClassTemplate value, List<dynamic> arguments) {
        return value.methodTemplate(arguments[0]);
      },
    },
  };

  static final Map<Type, Function> _creators = <Type, Function>{
    ClassTemplate: (
        _$LocalReferenceCommunicationHandler localHandler,
      ReferencePairManager manager,
      int fieldTemplate,
    ) {
      return localHandler.createClassTemplate(manager, fieldTemplate);
    },
  };

  final ClassTemplate Function(
    ReferencePairManager manager,
    int fieldTemplate,
  ) createClassTemplate;

  @override
  LocalReference createLocalReference(
    ReferencePairManager manager,
    Type referenceType,
    List<dynamic> arguments,
  ) {
    return _creators[referenceType](this, manager, arguments[0]);
  }

  @override
  dynamic executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return _methods[localReference.referenceType][methodName](
      localReference,
      arguments,
    );
  }
}

class _$RemoteReferenceCommunicationHandler
    extends MethodChannelRemoteReferenceCommunicationHandler {
  // TODO: to map like methods and creators
  @override
  List<dynamic> creationArgumentsFor(LocalReference localReference) {
    if (localReference is ClassTemplate) {
      return <dynamic>[localReference.fieldTemplate];
    }

    throw StateError(
      'Could not get creation arguments for a ${localReference.runtimeType}.',
    );
  }
}

mixin _$ClassTemplateMethods {
  Future<dynamic> _$methodTemplate(
    ReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    return referencePairManager.executeRemoteMethodFor(
      this as ClassTemplate,
      'methodTemplate',
      <dynamic>[parameterTemplate],
    );
  }
}
