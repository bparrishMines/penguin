package github.penguin.reference.templates;

import java.util.List;
import java.util.Map;

import github.penguin.reference.reference.CompletableRunnable;

public class ClassTemplate implements GeneratedReferencePairManager.PlatformClassTemplate {
  @Override
  public int getFieldTemplate() {
    return 0;
  }

  @Override
  public ClassTemplate getReferenceFieldTemplate() {
    return null;
  }

  @Override
  public List<ClassTemplate> getReferenceListTemplate() {
    return null;
  }

  @Override
  public Map<String, ClassTemplate> getReferenceMapTemplate() {
    return null;
  }

  @Override
  public CompletableRunnable<String> methodTemplate(String parameterTemplate, ClassTemplate referenceParameterTemplate, List<ClassTemplate> referenceListTemplate, Map<String, ClassTemplate> referenceMapTemplate) throws Exception {
    return null;
  }

  @Override
  public CompletableRunnable<ClassTemplate> returnsReference() throws Exception {
    return null;
  }
}
