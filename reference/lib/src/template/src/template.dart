import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:reference/reference.dart';

import 'platform_interface_template.dart';

part 'template.g.dart';

@visibleForTesting
MethodChannelReferencePairManager referencePairManager =
    GeneratedReferencePairManager(
  'github.penguin/reference',
  LocalReferenceCommunicationHandlerTemplate(),
);

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  PlatformClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) {
    return PlatformClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
      referenceMapTemplate,
    );
  }
}

class PlatformInterfaceTemplateImpl extends PlatformInterfaceTemplate {
  @override
  ClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) {
    return LocalReferenceCommunicationHandlerTemplate().createClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
      referenceMapTemplate,
    );
  }
}

class PlatformClassTemplate with LocalReference implements ClassTemplate {
  const PlatformClassTemplate(
    this.fieldTemplate,
    this.referenceFieldTemplate,
    this.referenceListTemplate,
    this.referenceMapTemplate,
  );

  @override
  final int fieldTemplate;

  @override
  final ClassTemplate referenceFieldTemplate;

  @override
  final List<ClassTemplate> referenceListTemplate;

  @override
  final Map<String, ClassTemplate> referenceMapTemplate;

  @override
  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
  ) async {
    return await (referencePairManager.executeRemoteMethodFor(
      this,
      GeneratedMethodNames.methodTemplate,
      <dynamic>[
        parameterTemplate,
        referenceParameterTemplate,
        referenceListTemplate,
      ],
    )) as String;
  }

  @override
  String toString() {
    return '$PlatformClassTemplate($fieldTemplate, $referenceFieldTemplate, $referenceListTemplate, $referenceMapTemplate)';
  }
}
