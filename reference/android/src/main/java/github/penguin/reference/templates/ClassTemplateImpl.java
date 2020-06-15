package github.penguin.reference.templates;

import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.templates.$TemplateReferencePairManager.ClassTemplate;

@SuppressWarnings("RedundantThrows")
public class ClassTemplateImpl implements ClassTemplate {
  private final Integer fieldTemplate;

  public ClassTemplateImpl(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public Object methodTemplate(final String parameterTemplate) throws Exception {
    return parameterTemplate + " World!";
  }

  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return ClassTemplate.class;
  }
}
