import 'dart:async';

abstract class ClassTemplateInterface {
  const ClassTemplateInterface();

  int get fieldTemplate;
  ClassTemplateInterface get referenceFieldTemplate;

  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplateInterface referenceParameterTemplate,
  );

  @override
  bool operator ==(dynamic other) =>
      other is ClassTemplateInterface &&
      other.fieldTemplate == fieldTemplate &&
      referenceFieldTemplate == other.referenceFieldTemplate;

  @override
  int get hashCode => fieldTemplate.hashCode;
}
