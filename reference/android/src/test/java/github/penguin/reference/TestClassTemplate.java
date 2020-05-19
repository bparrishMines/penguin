package github.penguin.reference;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import github.penguin.reference.templates.GeneratedReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager.ClassTemplate;

public class TestClassTemplate implements ClassTemplate {
  final List<Object> lastMethodTemplateArguments = new ArrayList<>(4);

  @Override
  public String methodTemplate(String parameterTemplate, ClassTemplate referenceParameterTemplate, List<ClassTemplate> referenceListTemplate, Map<String, ClassTemplate> referenceMapTemplate) throws Exception {
    lastMethodTemplateArguments.clear();
    lastMethodTemplateArguments.addAll(Arrays.asList(parameterTemplate, referenceParameterTemplate, referenceListTemplate, referenceMapTemplate));
    return "tornado";
  }

  @Override
  public ClassTemplate returnsReference() throws Exception {
    return new ClassTemplateImpl(null, 11, null, null, null);
  }

  @Override
  public int getFieldTemplate() {
    return 0;
  }

  @Override
  public GeneratedReferencePairManager.ClassTemplate getReferenceFieldTemplate() {
    return null;
  }

  @Override
  public List<GeneratedReferencePairManager.ClassTemplate> getReferenceListTemplate() {
    return null;
  }

  @Override
  public Map<String, GeneratedReferencePairManager.ClassTemplate> getReferenceMapTemplate() {
    return null;
  }
}
