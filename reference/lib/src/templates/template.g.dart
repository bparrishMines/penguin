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
    if (localReference is PlatformClassTemplate) return TypeReference(0);
    throw StateError('aoiej;a');
  }
}

abstract class GeneratedLocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const GeneratedLocalReferenceCommunicationHandler();

  PlatformClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  );

  @override
  LocalReference createLocalReferenceFor(
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    if (typeReference == TypeReference(0)) {
      return createClassTemplate(arguments[0], arguments[1]);
    }

    throw StateError(
      'Could not instantiate a $TypeReference: $typeReference with arguments: $arguments.',
    );
  }

  @override
  Future<dynamic> executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) async {
    if (localReference is PlatformClassTemplate &&
        methodName == GeneratedMethodNames.methodTemplate) {
      return await localReference.methodTemplate(arguments[0], arguments[1]);
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
    if (localReference is PlatformClassTemplate) {
      return <dynamic>[
        localReference.fieldTemplate,
        localReference.referenceFieldTemplate,
      ];
    }

    throw StateError(
      'Could not get creation arguments for a ${localReference.runtimeType}.',
    );
  }
}

mixin GeneratedMethodNames {
  static const String methodTemplate = 'methodTemplate';
}
