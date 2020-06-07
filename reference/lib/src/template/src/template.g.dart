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

  static final Map<TypeReference, Map<String, Function>> _methods =
      <TypeReference, Map<String, Function>>{
    TypeReference(0): <String, Function>{
      'methodTemplate': (ClassTemplate value, List<dynamic> arguments) {
        return value.methodTemplate(arguments[0]);
      },
    },
  };

  final ClassTemplate Function(
    ReferencePairManager manager,
    int fieldTemplate,
  ) createClassTemplate;

  @override
  LocalReference createLocalReference(
    ReferencePairManager manager,
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {


    if (typeReference == TypeReference(0)) {
      return createClassTemplate(manager, arguments[0]);
    }

    throw StateError(
      'Could not instantiate a $LocalReference: for $typeReference with arguments: $arguments.',
    );
  }

  @override
  dynamic executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return _methods[referencePairManager.typeReferenceFor(localReference)]
        [methodName](
      localReference,
      arguments,
    );
  }
}

class _$RemoteReferenceCommunicationHandler
    extends MethodChannelRemoteReferenceCommunicationHandler {
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
