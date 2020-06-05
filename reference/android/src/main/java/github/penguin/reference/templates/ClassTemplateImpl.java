package github.penguin.reference.templates;

import java.util.Collections;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.templates.$TemplateReferencePairManager.ClassTemplate;

@SuppressWarnings("RedundantThrows")
public class ClassTemplateImpl implements ClassTemplate {
  private final Integer fieldTemplate;

  private ReferencePairManager referencePairManager;

  public ClassTemplateImpl(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public CompletableRunnable<String> methodTemplate(final String parameterTemplate) throws Exception {
    final CompletableRunnable<String> completer =
        new CompletableRunnable<String>() {
          @Override
          public void run() {
            referencePairManager
                .executeRemoteMethodFor(
                    ClassTemplateImpl.this,
                    $TemplateReferencePairManager.$MethodNames.methodTemplate,
                    Collections.singletonList((Object) parameterTemplate))
                .setOnCompleteListener(
                    new OnCompleteListener() {
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

  public ClassTemplateImpl setReferencePairManager(final ReferencePairManager referencePairManager) {
    this.referencePairManager = referencePairManager;
    return this;
  }
}
