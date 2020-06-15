package github.penguin.reference;

import static org.junit.Assert.assertEquals;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.OwnerCounter;
import org.junit.Before;
import org.junit.Test;

public class OwnerCounterTest {
  private int callCount;

  @Before
  public void setUp() {
    callCount = 0;
  }

  @Test
  public void ownerCounter_increment() {
    final OwnerCounter counter =
        new OwnerCounter(
            new OwnerCounter.LifecycleListener() {
              @Override
              public Completable<Void> onCreate() {
                callCount++;
                return null;
              }

              @Override
              public Completable<Void> onDispose() {
                return null;
              }
            });

    counter.increment();
    counter.increment();

    assertEquals(callCount, 1);
    assertEquals(counter.getOwnerCount(), 2);
  }

  @Test(expected = AssertionError.class)
  public void ownerCounter_decrement() {
    final OwnerCounter counter =
        new OwnerCounter(
            new OwnerCounter.LifecycleListener() {
              @Override
              public Completable<Void> onCreate() {
                return null;
              }

              @Override
              public Completable<Void> onDispose() {
                callCount++;
                return null;
              }
            },
            2);

    counter.decrement();
    counter.decrement();

    assertEquals(callCount, 1);
    assertEquals(counter.getOwnerCount(), 0);
    counter.decrement();
  }
}
