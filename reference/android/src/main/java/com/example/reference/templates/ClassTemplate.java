package com.example.reference.templates;

import com.example.reference.reference.CompletableRunnable;
import com.example.reference.reference.ReferenceManager;

public class ClassTemplate implements GeneratedReferenceManager.ClassTemplate {
  private final ReferenceManager referenceManager;
  private int fieldTemplate;

  public ClassTemplate(final ReferenceManager referenceManager, final int fieldTemplate) {
    this.referenceManager = referenceManager;
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public CompletableRunnable<String> methodTemplate(final String parameterType) {
    return new CompletableRunnable<String>() {
      @Override
      public void run() {
        complete("Onion!");
      }
    };
  }

  @Override
  public CompletableRunnable<String> callbackTemplate(final double testParameter) {
    return referenceManager.sendMethodCall(this,
        "callbackTemplate",
        new Object[]{testParameter});
  }

  @Override
  public int getFieldTemplate() {
    return fieldTemplate;
  }
}
