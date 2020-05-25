part of 'template.dart';

class _$ReferencePairManager extends MethodChannelReferencePairManager {
  _$ReferencePairManager(
    String channelName,
    _$LocalReferenceCommunicationHandler localHandler, {
    _$RemoteReferenceCommunicationHandler remoteHandler,
    ReferenceMessageCodec referenceMessageCodec = const ReferenceMessageCodec(),
  }) : super(
          channelName,
          localHandler: localHandler,
          remoteHandler:
              remoteHandler ?? _$RemoteReferenceCommunicationHandler(),
          referenceMessageCodec: referenceMessageCodec,
        );

  @override
  TypeReference typeReferenceFor(LocalReference localReference) {
    if (localReference is ClassTemplate) return TypeReference(0);
    throw StateError(
      'Could not find a $TypeReference for ${localReference.runtimeType}.',
    );
  }
}

class _$LocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const _$LocalReferenceCommunicationHandler({this.createClassTemplate});

  static final Map<TypeReference, Map<String, Function>> _methods =
      <TypeReference, Map<String, Function>>{
    TypeReference(0): <String, Function>{
      'methodTemplate': (ClassTemplate value, List<dynamic> arguments) {
        return value.methodTemplate(
          arguments[0],
          arguments[1],
          arguments[2]?.cast<ClassTemplate>(),
          arguments[3]?.cast<String, ClassTemplate>(),
        );
      },
      'returnsReference': (ClassTemplate value, List<dynamic> arguments) {
        return value.returnsReference();
      },
    },
  };

  final ClassTemplate Function(
    ReferencePairManager referencePairManager,
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) createClassTemplate;

  @override
  LocalReference createLocalReference(
    ReferencePairManager referencePairManager,
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    if (typeReference == TypeReference(0)) {
      return createClassTemplate(
        referencePairManager,
        arguments[0],
        arguments[1],
        arguments[2]?.cast<ClassTemplate>(),
        arguments[3]?.cast<String, ClassTemplate>(),
      );
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
      return <dynamic>[
        localReference.fieldTemplate,
        localReference.referenceFieldTemplate,
        localReference.referenceListTemplate,
        localReference.referenceMapTemplate,
      ];
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
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) {
    return referencePairManager.executeRemoteMethodFor(
      this as ClassTemplate,
      'methodTemplate',
      <dynamic>[
        parameterTemplate,
        referenceParameterTemplate,
        referenceListTemplate,
        referenceMapTemplate,
      ],
    );
  }

  Future<dynamic> _$returnsReference(
      ReferencePairManager referencePairManager) {
    return referencePairManager.executeRemoteMethodFor(
      this as ClassTemplate,
      'returnsReference',
    );
  }
}
