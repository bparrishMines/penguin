import 'dart:async';

import 'package:reference/reference.dart';

import 'template_interface.dart';

part 'template.g.dart';

MethodChannelReferencePairManager referencePairManager;

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  ClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  ) {
    return ClassTemplate(fieldTemplate, referenceFieldTemplate);
  }
}

class ClassTemplate extends ClassTemplateInterface with LocalReference {
  const ClassTemplate(this.fieldTemplate, this.referenceFieldTemplate);

  @override
  final int fieldTemplate;

  @override
  final ClassTemplate referenceFieldTemplate;

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) async {
    return await (referencePairManager.executeRemoteMethodFor(
      this,
      GeneratedMethodNames.methodTemplate,
      <dynamic>[parameterTemplate],
    )) as String;
  }
}
