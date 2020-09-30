import 'package:reference/reference.dart';

// Helper Typedefs
typedef _$LocalCreatorHandler = LocalReference Function(
  $LocalHandler localHandler,
  ReferencePairManager manager,
  List<Object> arguments,
);

typedef _$LocalStaticMethodHandler = Object Function(
  $LocalHandler localHandler,
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

// Classes
abstract class $ClassTemplate implements LocalReference {
  int get fieldTemplate;

  Future<String> methodTemplate(String parameterTemplate);

  @override
  Type get referenceType => $ClassTemplate;

  @override
  String toString() {
    return '${$ClassTemplate}($fieldTemplate)';
  }
}

// Class Extensions
extension $ClassTemplateMethods on $ClassTemplate {
  static Future<Object> $staticMethodTemplate(
    $ReferencePairManager referencePairManager,
    String parameterTemplate,
  ) {
    return referencePairManager.invokeRemoteStaticMethod(
      $ClassTemplate,
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    );
  }

  Future<Object> $methodTemplate(
    $ReferencePairManager referencePairManager,
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

// Reference Pair Manager
abstract class $ReferencePairManager extends MethodChannelReferencePairManager {
  $ReferencePairManager(
    String channelName, {
    ReferenceMessageCodec messageCodec,
  }) : super(
          <Type>[$ClassTemplate],
          channelName,
          messageCodec: messageCodec,
          poolId: channelName,
        );

  @override
  $LocalHandler get localHandler;

  @override
  MethodChannelRemoteHandler get remoteHandler => $RemoteHandler(channel.name);
}

// LocalReferenceCommunicationHandler
class $LocalHandler with LocalReferenceCommunicationHandler {
  const $LocalHandler({
    this.createClassTemplate,
    this.classTemplate$staticMethodTemplate,
  });

  static final Map<Type, _$LocalCreatorHandler> _creators =
      <Type, _$LocalCreatorHandler>{
    $ClassTemplate: (
      $LocalHandler localHandler,
      ReferencePairManager manager,
      List<Object> arguments,
    ) {
      return localHandler.createClassTemplate(manager, arguments[0]);
    },
  };

  static final Map<Type, Map<String, _$LocalStaticMethodHandler>>
      _staticMethods = <Type, Map<String, _$LocalStaticMethodHandler>>{
    $ClassTemplate: <String, _$LocalStaticMethodHandler>{
      'staticMethodTemplate': (
        $LocalHandler localHandler,
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
    $ClassTemplate: <String, _$LocalMethodHandler>{
      'methodTemplate': (
        LocalReference localReference,
        List<Object> arguments,
      ) {
        return (localReference as $ClassTemplate).methodTemplate(arguments[0]);
      },
    },
  };

  final double Function(
    ReferencePairManager manager,
    String parameterTemplate,
  ) classTemplate$staticMethodTemplate;

  final $ClassTemplate Function(
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
    if (localReference is $ClassTemplate) {
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

// MethodChannelRemoteHandler
class $RemoteHandler extends MethodChannelRemoteHandler {
  static final Map<Type, _$CreationArgumentsHandler> _creationArguments =
      <Type, _$CreationArgumentsHandler>{
    $ClassTemplate: (LocalReference localReference) {
      return <Object>[(localReference as $ClassTemplate).fieldTemplate];
    },
  };

  $RemoteHandler(String channelName) : super(channelName);

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return _creationArguments[localReference.referenceType](localReference);
  }
}
