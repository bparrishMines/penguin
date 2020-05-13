package github.penguin.reference.templates;

import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.Log;

public class ClassTemplate implements GeneratedReferencePairManager.ClassTemplate {
  private final ReferencePairManager referencePairManager;
  private int fieldTemplate;

  public ClassTemplate(final ReferencePairManager referencePairManager, final int fieldTemplate) {
    this.referencePairManager = referencePairManager;
    this.fieldTemplate = fieldTemplate;
    if (fieldTemplate != 54) throw new IllegalArgumentException();
  }

  @Override
  public CompletableRunnable<String> methodTemplate(final String parameterTemplate) {
    callbackTemplate(15.0);
    return new CompletableRunnable<String>() {
      @Override
      public void run() {
        complete("Apple" + parameterTemplate);
      }
    };
  }

  @Override
  public CompletableRunnable<String> callbackTemplate(final double testParameter) {
    final CompletableRunnable<String> completer =
        referencePairManager.sendMethodCall(this, "callbackTemplate", new Object[] {testParameter});

    return completer.setOnCompleteListener(
        new CompletableRunnable.OnCompleteListener() {
          @Override
          public void onComplete(Object result) {
            if (result != "loco") throw new IllegalArgumentException();
          }

          @Override
          public void onError(Throwable throwable) {
            Log.d(throwable.getClass().getName(), throwable.getLocalizedMessage());
          }
        });
  }

  @Override
  public int getFieldTemplate() {
    return fieldTemplate;
  }
}
