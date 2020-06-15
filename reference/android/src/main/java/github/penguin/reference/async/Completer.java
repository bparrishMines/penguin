package github.penguin.reference.async;

public class Completer<T> {
  public final Completable<T> completable = new Completable<>();

  public Completer<T> complete(final T result) {
    if (completable.isCompletedWithResult || completable.isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    completable.result = result;
    completable.isCompletedWithResult = true;
    completable.tryPassResultToListener();
    return this;
  }

  @SuppressWarnings("UnusedReturnValue")
  public Completer<T> completeWithError(final Throwable error) {
    if (completable.isCompletedWithResult || completable.isCompletedWithError) {
      throw new IllegalStateException("This has already been completed.");
    }
    completable.error = error;
    completable.isCompletedWithError = true;
    completable.tryPassResultToListener();
    return this;
  }
}
