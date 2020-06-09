package github.penguin.reference.reference;

// TODO: empty values and auto run and complete values and tryGetResult
public abstract class CompletableRunnable<T> implements Runnable {
  private T result;
  private Throwable error;
  private OnCompleteListener listener;
  private boolean isCompletedWithResult = false;
  private boolean isCompletedWithError = false;

  public interface OnCompleteListener {
    void onComplete(Object result);

    void onError(Throwable throwable);
  }

  public void complete(final T result) {
    if (isCompletedWithResult || isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    this.result = result;
    isCompletedWithResult = true;
    tryPassResultToListener();
  }

  public void completeWithError(final Throwable error) {
    if (isCompletedWithResult || isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    this.error = error;
    isCompletedWithError = true;
    tryPassResultToListener();
  }

  @SuppressWarnings("UnusedReturnValue")
  public CompletableRunnable<T> setOnCompleteListener(final OnCompleteListener listener) {
    this.listener = listener;
    tryPassResultToListener();
    return this;
  }

  private void tryPassResultToListener() {
    if (listener != null && isCompletedWithResult) {
      this.listener.onComplete(result);
    } else if (listener != null && isCompletedWithError) {
      this.listener.onError(error);
    }
  }
}
