part of 'template.dart';

class GeneratedReferencePairManager extends MethodChannelReferencePairManager {
  GeneratedReferencePairManager(
    String channelName,
    GeneratedLocalReferenceCommunicationHandler localHandler, {
    GeneratedRemoteReferenceCommunicationHandler remoteHandler,
    ReferenceMessageCodec referenceMessageCodec,
  }) : super(
          channelName: channelName,
          localHandler: localHandler,
          remoteHandler:
              remoteHandler ?? GeneratedRemoteReferenceCommunicationHandler(),
          referenceMessageCodec:
              referenceMessageCodec ?? const ReferenceMessageCodec(),
        );

  static const TypeReference _classTemplateType = TypeReference(0);
}

abstract class GeneratedLocalReferenceCommunicationHandler
    with LocalReferenceCommunicationHandler {
  const GeneratedLocalReferenceCommunicationHandler();

  ClassTemplate createClassTemplate(
    RemoteReference remoteReference,
    int fieldTemplate,
  );

  @override
  LocalReference createLocalReferenceFor(
    RemoteReference remoteReference,
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    if (typeReference == GeneratedReferencePairManager._classTemplateType) {
      return createClassTemplate(remoteReference, arguments[0]);
    }

    throw StateError(
      'Could not instantiate an object with arguments: $arguments.',
    );
  }

  @override
  Future<dynamic> executeLocalMethod(
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) async {
    if (localReference is ClassTemplate &&
        methodName == GeneratedMethodName.methodTemplate.toString()) {
      return await localReference.methodTemplate(arguments[0]);
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
      return <dynamic>[localReference.fieldTemplate];
    }

    throw StateError('a;oweijf;');
  }
}

class GeneratedMethodName {
  const GeneratedMethodName._(this.name);

  final String name;

  static final GeneratedMethodName methodTemplate =
      GeneratedMethodName._('methodTemplate');

  @override
  String toString() => name;
}
