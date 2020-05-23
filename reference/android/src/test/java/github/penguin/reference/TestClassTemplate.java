package github.penguin.reference;

import github.penguin.reference.templates.$ReferencePairManager;
import github.penguin.reference.templates.$ReferencePairManager.ClassTemplate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class TestClassTemplate implements ClassTemplate {
  final List<Object> lastMethodTemplateArguments = new ArrayList<>(4);

  @Override
  public String methodTemplate(
      String parameterTemplate,
      ClassTemplate referenceParameterTemplate,
      List<ClassTemplate> referenceListTemplate,
      Map<String, ClassTemplate> referenceMapTemplate) {
    lastMethodTemplateArguments.clear();
    lastMethodTemplateArguments.addAll(
        Arrays.asList(
            parameterTemplate,
            referenceParameterTemplate,
            referenceListTemplate,
            referenceMapTemplate));
    return "tornado";
  }

  @Override
  public ClassTemplate returnsReference() {
    return new ClassTemplateImpl(11, null, null, null);
  }

  @Override
  public Integer getFieldTemplate() {
    return 0;
  }

  @Override
  public $ReferencePairManager.ClassTemplate getReferenceFieldTemplate() {
    return null;
  }

  @Override
  public List<$ReferencePairManager.ClassTemplate> getReferenceListTemplate() {
    return null;
  }

  @Override
  public Map<String, $ReferencePairManager.ClassTemplate> getReferenceMapTemplate() {
    return null;
  }
}
