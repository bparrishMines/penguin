package github.penguin.reference.reference;

public class Completable<T> {
  T result;
  Throwable error;
  OnCompleteListener<T> listener;
  boolean isCompletedWithResult = false;
  boolean isCompletedWithError = false;

  public interface OnCompleteListener<S> {
    void onComplete(S result);
    void onError(Throwable throwable);
  }

  @SuppressWarnings("UnusedReturnValue")
  public void setOnCompleteListener(final OnCompleteListener<T> listener) {
    this.listener = listener;
    tryPassResultToListener();
  }

  void tryPassResultToListener() {
    if (listener != null && isCompletedWithResult) {
      this.listener.onComplete(result);
    } else if (listener != null && isCompletedWithError) {
      this.listener.onError(error);
    }
  }
}
