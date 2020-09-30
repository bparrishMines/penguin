package github.penguin.reference.templates;

import github.penguin.reference.templates.$TemplateReferencePairManager.$ClassTemplate;

public class ClassTemplate extends $ClassTemplate {
  private final Integer fieldTemplate;

  public static Double staticMethodTemplate(String parameterTemplate) {
    return parameterTemplate.length() / 1.0;
  }

  public ClassTemplate(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public Object methodTemplate(final String parameterTemplate) {
    return parameterTemplate + " World!";
  }
}
