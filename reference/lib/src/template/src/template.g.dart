part of 'template.dart';

// TODO(bparrishMines): replace generated with _$
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

  ClassTemplate createClassTemplate(
    ReferencePairManager referencePairManager,
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  );

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
