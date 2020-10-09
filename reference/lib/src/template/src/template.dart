import 'dart:async';

import 'package:reference/reference.dart';

import 'template.g.dart';

_ManagerTemplate _referencePairManager = _ManagerTemplate()..initialize();

class _ManagerTemplate extends $ReferencePairManager {
  _ManagerTemplate() : super('github.penguin/reference/template');

  @override
  $LocalHandler get localHandler => $LocalHandler(
        createClassTemplate: (
          ReferencePairManager referencePairManager,
          $ClassTemplateCreationArgs args,
        ) =>
            ClassTemplate(args.fieldTemplate),
      );
}

@Reference()
class ClassTemplate extends $ClassTemplate {
  ClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return (await $ClassTemplateMethods.$staticMethodTemplate(
      _referencePairManager,
      parameterTemplate,
    )) as double;
  }

  Future<String> methodTemplate(String parameterTemplate) async {
    return (await $methodTemplate(
      _referencePairManager,
      parameterTemplate,
    )) as String;
  }
}
