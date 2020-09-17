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
          classTemplate$staticMethodTemplate:
              (ReferencePairManager referencePairManager,
                  String parameterTemplate) {
            return 62.0;
          });
}

class ClassTemplate with LocalReference, _$ClassTemplateMethods {
  ClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return (await _referencePairManager.invokeRemoteStaticMethod(
      ClassTemplate,
      'staticMethodTemplate',
      <Object>[parameterTemplate],
    )) as double;
  }

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
