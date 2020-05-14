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

  // TODO: separate methods by double mapping from type reference to methodName
  @override
  dynamic executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    if (localReference is ClassTemplate &&
        methodName == GeneratedMethodNames.methodTemplate) {
      return localReference.methodTemplate(
        arguments[0],
        arguments[1],
        arguments[2]?.cast<ClassTemplate>(),
        arguments[3]?.cast<String, ClassTemplate>(),
      );
    } else if (localReference is ClassTemplate &&
        methodName == GeneratedMethodNames.returnsReference) {
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

mixin GeneratedMethodNames {
  static const String methodTemplate = 'methodTemplate';
  static const String returnsReference = 'returnsReference';
}
