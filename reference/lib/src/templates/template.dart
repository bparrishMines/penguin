import 'dart:async';

import 'package:reference/reference.dart';

import 'template_interface.dart';

part 'template.g.dart';

// TODO: rename template files
MethodChannelReferencePairManager referencePairManager;

class PlatformInterfaceTemplateImpl extends PlatformInterfaceTemplate {
  @override
  ClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
  ) {
    return LocalReferenceCommunicationHandlerTemplate().createClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
    );
  }
}

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  PlatformClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<dynamic> referenceListTemplate,
  ) {
    return PlatformClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
    );
  }
}

class PlatformClassTemplate with LocalReference implements ClassTemplate {
  PlatformClassTemplate(
    this.fieldTemplate,
    this.referenceFieldTemplate,
    this.referenceListTemplate,
  );

  @override
  final int fieldTemplate;

  @override
  final ClassTemplate referenceFieldTemplate;

  @override
  final List<ClassTemplate> referenceListTemplate;

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

  @override
  String toString() {
    return '$PlatformClassTemplate($fieldTemplate, $referenceFieldTemplate, $referenceListTemplate)';
  }
}
