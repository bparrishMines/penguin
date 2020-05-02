import 'dart:async';

import 'package:reference/reference.dart';

import 'interface.dart';

part 'implementation.g.dart';

MethodChannelReferencePairManager referencePairManager;

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  ClassTemplate createClassTemplate(
    RemoteReference remoteReference,
    int fieldTemplate,
  ) {
    return ClassTemplate(fieldTemplate);
  }
}

class ClassTemplate extends ClassTemplateInterface with LocalReference {
  const ClassTemplate(int fieldTemplate) : super(fieldTemplate);

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) async {
    return await (referencePairManager.executeRemoteMethod(
      this,
      GeneratedMethodName.methodTemplate.toString(),
      <dynamic>[parameterTemplate],
    )) as String;
  }

  @override
  FutureOr<String> callbackTemplate(double parameterTemplate) async {
    return (await referencePairManager.executeRemoteMethod(
      this,
      GeneratedMethodName.callbackTemplate.toString(),
      <dynamic>[parameterTemplate],
    )) as String;
  }
}
