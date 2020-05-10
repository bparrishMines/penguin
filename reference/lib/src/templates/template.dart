import 'dart:async';

import 'package:reference/reference.dart';

import 'template_interface.dart';

part 'template.g.dart';

MethodChannelReferencePairManager referencePairManager;

class PlatformInterfaceTemplateImpl extends PlatformInterfaceTemplate {
  @override
  ClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  ) {
    return LocalReferenceCommunicationHandlerTemplate().createClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
    );
  }
}

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  PlatformClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  ) {
    return PlatformClassTemplate(fieldTemplate, referenceFieldTemplate);
  }
}

class PlatformClassTemplate with LocalReference implements ClassTemplate {
  PlatformClassTemplate(this.fieldTemplate, this.referenceFieldTemplate);

  @override
  final int fieldTemplate;

  @override
  final ClassTemplate referenceFieldTemplate;

  @override
  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
  ) async {
    return await (referencePairManager.executeRemoteMethodFor(
      this,
      GeneratedMethodNames.methodTemplate,
      <dynamic>[parameterTemplate, referenceParameterTemplate],
    )) as String;
  }

  // TODO: Remove and add to reference_matcher.dart.
  @override
  bool operator ==(dynamic other) =>
      other is ClassTemplate &&
      other.fieldTemplate == fieldTemplate &&
      referenceFieldTemplate == other.referenceFieldTemplate;

  @override
  int get hashCode => fieldTemplate.hashCode;
}
