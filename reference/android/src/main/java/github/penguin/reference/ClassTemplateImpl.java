package github.penguin.reference;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager.ClassTemplate;

@SuppressWarnings("RedundantThrows")
public class ClassTemplateImpl implements GeneratedReferencePairManager.ClassTemplate {
  private final int fieldTemplate;
  private final ClassTemplate referenceFieldTemplate;
  private final List<ClassTemplate> referenceListTemplate;
  private final Map<String, ClassTemplate> referenceMapTemplate;

  private ReferencePairManager referencePairManager;

  ClassTemplateImpl(int fieldTemplate,
                           ClassTemplate referenceFieldTemplate,
                       List<ClassTemplate> referenceListTemplate,
                       Map<String,
                           ClassTemplate> referenceMapTemplate) {
    this.fieldTemplate = fieldTemplate;
    this.referenceFieldTemplate = referenceFieldTemplate;
    this.referenceListTemplate = referenceListTemplate;
    this.referenceMapTemplate = referenceMapTemplate;
  }

  @Override
  public int getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public ClassTemplate getReferenceFieldTemplate() {
    return referenceFieldTemplate;
  }

  @Override
  public List<ClassTemplate> getReferenceListTemplate() {
    return referenceListTemplate;
  }

  @Override
  public Map<String, ClassTemplate> getReferenceMapTemplate() {
    return referenceMapTemplate;
  }

  @Override
  public CompletableRunnable<String> methodTemplate(final String parameterTemplate, final ClassTemplate referenceParameterTemplate, final List<ClassTemplate> referenceListTemplate, final Map<String, ClassTemplate> referenceMapTemplate) throws Exception {
    final CompletableRunnable<String> completer = new CompletableRunnable<String>() {
      @Override
      public void run() {
        referencePairManager.executeRemoteMethodFor(
            ClassTemplateImpl.this,
            GeneratedReferencePairManager.GeneratedMethodNames.methodTemplate,
            Arrays.asList(parameterTemplate, referenceParameterTemplate, referenceListTemplate,  referenceMapTemplate)
        ).setOnCompleteListener(new OnCompleteListener() {
          @Override
          public void onComplete(Object result) {
            complete((String) result);
          }

          @Override
          public void onError(Throwable throwable) {
            completeWithError(throwable);
          }
        });
      }
    };

    completer.run();
    return completer;
  }

  @Override
  public CompletableRunnable<ClassTemplate> returnsReference() throws Exception {
    final CompletableRunnable<ClassTemplate> completer = new CompletableRunnable<ClassTemplate>() {
      @Override
      public void run() {
        referencePairManager.executeRemoteMethodFor(
            ClassTemplateImpl.this,
            GeneratedReferencePairManager.GeneratedMethodNames.returnsReference
        ).setOnCompleteListener(new OnCompleteListener() {
          @Override
          public void onComplete(Object result) {
            complete((ClassTemplate) result);
          }

          @Override
          public void onError(Throwable throwable) {
            completeWithError(throwable);
          }
        });
      }
    };

    completer.run();
    return completer;
  }

  ClassTemplateImpl setReferencePairManager(final ReferencePairManager referencePairManager) {
    this.referencePairManager = referencePairManager;
    return this;
  }
}
