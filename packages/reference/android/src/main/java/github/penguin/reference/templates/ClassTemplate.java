package github.penguin.reference.templates;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  private final Integer fieldTemplate;

  public ClassTemplate(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  public static Double staticMethodTemplate(String parameterTemplate) {
    return parameterTemplate.length() / 1.0;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public Object methodTemplate(String parameterTemplate) {
    return parameterTemplate + " World!";
  }
}
