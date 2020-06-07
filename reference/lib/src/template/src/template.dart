import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reference/reference.dart';

part 'template.g.dart';

// TODO: Somewhere talk about how to use OwnerCounter for using other plugin's code
@visibleForTesting
ReferencePairManagerTemplate referencePairManager;

class ReferencePairManagerTemplate extends _$TemplateReferencePairManager {
  ReferencePairManagerTemplate()
      : super(
          'github.penguin/reference/template',
          _$LocalReferenceCommunicationHandler(
            createClassTemplate: (
              ReferencePairManager referencePairManager,
              int fieldTemplate,
            ) =>
                ClassTemplate(fieldTemplate),
          ),
        );
}

class ClassTemplate with LocalReference, _$ClassTemplateMethods {
  ClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  FutureOr<String> methodTemplate(String parameterTemplate) async {
    return (await _$methodTemplate(
      referencePairManager,
      parameterTemplate,
    )) as String;
  }

  @override
  String toString() {
    return '$ClassTemplate($fieldTemplate)';
  }

  @override
  Type get referenceType => ClassTemplate;
}
