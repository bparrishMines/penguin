package com.example.reference.templates;

import com.example.reference.reference.CompletableRunnable;
import com.example.reference.reference.ReferenceManager;

import io.flutter.Log;

public class ClassTemplate implements GeneratedReferenceManager.ClassTemplate {
  private final ReferenceManager referenceManager;
  private int fieldTemplate;

  public ClassTemplate(final ReferenceManager referenceManager, final int fieldTemplate) {
    this.referenceManager = referenceManager;
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
    final CompletableRunnable<String> completer = referenceManager.sendMethodCall(this,
        "callbackTemplate",
        new Object[]{testParameter});

    return completer.setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
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
