package github.penguin.reference.reference;

import github.penguin.reference.async.Completable;

public class OwnerCounter {
//  public interface LifecycleListener {
//    Completable<Void> onCreate();
//
//    Completable<Void> onDispose();
//  }
//
//  private int ownerCount = 0;
//  private final LifecycleListener lifecycleListener;
//
//  public OwnerCounter(final LifecycleListener lifecycleListener) {
//    if (lifecycleListener == null) throw new IllegalArgumentException();
//    this.lifecycleListener = lifecycleListener;
//  }
//
//  public OwnerCounter(final LifecycleListener lifecycleListener, int initialOwnerCount) {
//    this(lifecycleListener);
//    if (initialOwnerCount < 0) throw new IllegalArgumentException();
//    ownerCount = initialOwnerCount;
//  }
//
//  @SuppressWarnings("UnusedReturnValue")
//  public Completable<Void> increment() {
//    ownerCount++;
//    if (ownerCount == 1) return lifecycleListener.onCreate();
//    return null;
//  }
//
//  @SuppressWarnings("UnusedReturnValue")
//  public Completable<Void> decrement() {
//    if (ownerCount < 1) {
//      final String message =
//          "`decrement()` was called without calling `increment()` first. In other words, `decrement()` was called while `ownerCount == 0`. Owner count ="
//              + ownerCount;
//      throw new AssertionError(message);
//    }
//
//    ownerCount--;
//    if (ownerCount == 0) return lifecycleListener.onDispose();
//    return null;
//  }
//
//  @SuppressWarnings("unused")
//  public int getOwnerCount() {
//    return ownerCount;
//  }
}
