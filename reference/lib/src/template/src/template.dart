import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reference/reference.dart';

part 'template.g.dart';

@visibleForTesting
MethodChannelReferencePairManager referencePairManager =
    GeneratedReferencePairManager(
  'github.penguin/reference',
  LocalReferenceCommunicationHandlerTemplate(),
)..initialize();

class LocalReferenceCommunicationHandlerTemplate
    extends GeneratedLocalReferenceCommunicationHandler {
  @override
  ClassTemplate createClassTemplate(
    ReferencePairManager referencePairManager,
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) {
    return ClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
      referenceMapTemplate,
    );
  }
}

class ClassTemplate with LocalReference, ClassTemplateMethods {
  ClassTemplate(
    this.fieldTemplate,
    this.referenceFieldTemplate,
    this.referenceListTemplate,
    this.referenceMapTemplate,
  );

  final int fieldTemplate;
  final ClassTemplate referenceFieldTemplate;
  final List<ClassTemplate> referenceListTemplate;
  final Map<String, ClassTemplate> referenceMapTemplate;

  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) async {
    return (await _methodTemplate(
      referencePairManager,
      parameterTemplate,
      referenceParameterTemplate,
      referenceListTemplate,
      referenceMapTemplate,
    )) as String;
  }

  FutureOr<ClassTemplate> returnsReference() async {
    return await (_returnsReference(referencePairManager)) as ClassTemplate;
  }

  @override
  String toString() {
    return '$ClassTemplate($fieldTemplate, $referenceFieldTemplate, $referenceListTemplate, $referenceMapTemplate)';
  }
}
