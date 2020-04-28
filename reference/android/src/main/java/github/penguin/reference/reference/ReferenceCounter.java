package github.penguin.reference.reference;

public class ReferenceCounter {
  public interface LifecycleListener {
    void onCreate(final String referenceId, final ReferenceManager.ReferenceHolder holder);

    void onDispose(final String referenceId, final ReferenceManager.ReferenceHolder holder);
  }

  private int referenceCount = 0;
  public final LifecycleListener lifecycleListener;

  public ReferenceCounter(final LifecycleListener lifecycleListener) {
    if (lifecycleListener == null) throw new IllegalArgumentException();
    this.lifecycleListener = lifecycleListener;
  }

  public ReferenceCounter(final LifecycleListener lifecycleListener, int initialReferenceCount) {
    this(lifecycleListener);
    if (initialReferenceCount < 0) throw new IllegalArgumentException();
    referenceCount = initialReferenceCount;
  }

  public void retain(final String referenceId, final ReferenceManager.ReferenceHolder holder) {
    referenceCount++;
    if (referenceCount == 1) lifecycleListener.onCreate(referenceId, holder);
  }

  public void release(final String referenceId, final ReferenceManager.ReferenceHolder holder) {
    if (referenceCount < 1) {
      final String message =
          "`release()` was called without calling `retain()` first. In other words, `release()` was called while `referenceCount == 0`. Reference count ="
              + referenceCount;
      throw new IllegalStateException("");
    }

    referenceCount--;
    if (referenceCount == 0) lifecycleListener.onDispose(referenceId, holder);
  }

  public int getReferenceCount() {
    return referenceCount;
  }
}
