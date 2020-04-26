package com.example.reference.reference;

abstract public class CompletableRunnable<T> implements Runnable {
  private T result;
  private Throwable error;
  private OnCompleteListener listener;
  private boolean isCompletedWithResult = false;
  private boolean isCompletedWithError = false;

  public interface OnCompleteListener {
    void onComplete(Object result);
    void onError(Throwable throwable);
  }

  public void complete(T result) {
    if (isCompletedWithResult || isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    this.result = result;
    isCompletedWithResult = true;
    tryPassResultToListener();
  }

  public void completeWithError(Throwable error) {
    if (isCompletedWithResult || isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    this.error = error;
    isCompletedWithError = true;
    tryPassResultToListener();
  }

  public void setOnCompleteListener(final OnCompleteListener listener) {
    this.listener = listener;
    tryPassResultToListener();
  }

  private void tryPassResultToListener() {
    if (listener != null && isCompletedWithResult) {
      this.listener.onComplete(result);
    } else if (listener != null && isCompletedWithError) {
      this.listener.onError(error);
    }
  }
}
