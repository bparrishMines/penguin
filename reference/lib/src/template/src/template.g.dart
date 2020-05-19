part of 'template.dart';

class GeneratedReferencePairManager extends MethodChannelReferencePairManager {
  GeneratedReferencePairManager(
    String channelName,
    GeneratedLocalReferenceCommunicationHandler localHandler, {
    GeneratedRemoteReferenceCommunicationHandler remoteHandler,
    ReferenceMessageCodec referenceMessageCodec = const ReferenceMessageCodec(),
  }) : super(
          channelName: channelName,
          localHandler: localHandler,
          remoteHandler:
              remoteHandler ?? GeneratedRemoteReferenceCommunicationHandler(),
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

abstract class GeneratedLocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const GeneratedLocalReferenceCommunicationHandler();

  ClassTemplate createClassTemplate(
    ReferencePairManager referencePairManager,
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  );

  @override
  LocalReference createLocalReferenceFor(
    TypeReference typeReference,
    ReferencePairManager referencePairManager,
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

  // TODO(bmparr): separate methods by double mapping from type reference to methodName
  @override
  dynamic executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    if (localReference is ClassTemplate && methodName == 'methodTemplate') {
      return localReference.methodTemplate(
        arguments[0],
        arguments[1],
        arguments[2]?.cast<ClassTemplate>(),
        arguments[3]?.cast<String, ClassTemplate>(),
      );
    } else if (localReference is ClassTemplate &&
        methodName == 'returnsReference') {
      return localReference.returnsReference();
    }

    throw StateError(
      'Could not call $methodName on ${localReference.runtimeType}.',
    );
  }
}

class GeneratedRemoteReferenceCommunicationHandler
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

mixin ClassTemplateMethods {
  Future<dynamic> _methodTemplate(
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

  Future<dynamic> _returnsReference(ReferencePairManager referencePairManager) {
    return referencePairManager.executeRemoteMethodFor(
      this as ClassTemplate,
      'returnsReference',
    );
  }
}
