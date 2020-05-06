import 'dart:async';

import 'package:reference/reference.dart';

import 'template_interface.dart';

part 'template.g.dart';

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
    return await (referencePairManager.executeRemoteMethodFor(
      this,
      GeneratedMethodNames.methodTemplate,
      <dynamic>[parameterTemplate],
    )) as String;
  }
}
