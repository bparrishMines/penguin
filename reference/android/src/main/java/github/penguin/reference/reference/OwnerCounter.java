package github.penguin.reference.reference;

public class OwnerCounter {
  public interface LifecycleListener {
    CompletableRunnable<Void> onCreate();
    CompletableRunnable<Void> onDispose();
  }

  private int ownerCount = 0;
  public final LifecycleListener lifecycleListener;

  public OwnerCounter(final LifecycleListener lifecycleListener) {
    if (lifecycleListener == null) throw new IllegalArgumentException();
    this.lifecycleListener = lifecycleListener;
  }

  public OwnerCounter(final LifecycleListener lifecycleListener, int initialReferenceCount) {
    this(lifecycleListener);
    if (initialReferenceCount < 0) throw new IllegalArgumentException();
    ownerCount = initialReferenceCount;
  }

  public CompletableRunnable<Void> increment() {
    ownerCount++;
    if (ownerCount == 1) return lifecycleListener.onCreate();
    return null;
  }

  public CompletableRunnable<Void> decrement() {
    if (ownerCount < 1) {
      final String message =
          "`decrement()` was called without calling `increment()` first. In other words, `decrement()` was called while `ownerCount == 0`. Owner count ="
              + ownerCount;
      throw new IllegalStateException(message);
    }

    ownerCount--;
    if (ownerCount == 0) return lifecycleListener.onDispose();
    return null;
  }

  public int getOwnerCount() {
    return ownerCount;
  }
}
