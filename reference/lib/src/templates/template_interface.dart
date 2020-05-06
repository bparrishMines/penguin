import 'dart:async';

class ClassTemplateInterface {
  const ClassTemplateInterface(this.fieldTemplate);

  final int fieldTemplate;

  FutureOr<String> methodTemplate(String parameterTemplate) {
    throw UnimplementedError();
  }

  @override
  bool operator ==(dynamic other) =>
      other is ClassTemplateInterface && other.fieldTemplate == fieldTemplate;

  @override
  int get hashCode => fieldTemplate.hashCode;
}
