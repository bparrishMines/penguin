import 'dart:async';

import '../annotations.dart';

typedef CallbackTemplate = FutureOr<String> Function(double testParameter);

@Interface()
class ClassTemplateInterface {
  const ClassTemplateInterface(this.fieldTemplate, this.callbackTemplate);

  final int fieldTemplate;
  final CallbackTemplate callbackTemplate;

  FutureOr<String> methodTemplate(String parameterTemplate) {
    throw UnimplementedError();
  }

  @override
  bool operator ==(dynamic other) =>
      other is ClassTemplateInterface && other.fieldTemplate == fieldTemplate;

  @override
  int get hashCode => fieldTemplate.hashCode;
}
