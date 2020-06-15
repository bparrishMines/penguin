import 'dart:async';

import 'package:reference/reference.dart';

part 'template.g.dart';

_ReferencePairManagerTemplate _referencePairManager =
    _ReferencePairManagerTemplate()..initialize();

class _ReferencePairManagerTemplate extends _$TemplateReferencePairManager {
  _ReferencePairManagerTemplate() : super('github.penguin/reference/template');

  @override
  _$LocalReferenceCommunicationHandler get localHandler =>
      _$LocalReferenceCommunicationHandler(
        createClassTemplate: (
          ReferencePairManager referencePairManager,
          int fieldTemplate,
        ) =>
            ClassTemplate(fieldTemplate),
      );
}

class ClassTemplate with LocalReference, _$ClassTemplateMethods {
  ClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  Future<String> methodTemplate(String parameterTemplate) async {
    return (await _$methodTemplate(
      _referencePairManager,
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
