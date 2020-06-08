package github.penguin.reference;

import com.google.common.collect.ImmutableMap;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;
import org.junit.Test;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.PoolableReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager.*;
import github.penguin.reference.reference.ReferencePairManagerPool;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedRemoteReference;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

@SuppressWarnings("rawtypes")
public class ReferenceTest {
  private static class TestClass implements LocalReference {
    @Override
    public Class<? extends LocalReference> getReferenceClass() {
      return TestClass.class;
    }
  }

  private static class TestClass2 extends TestClass {
    @Override
    public Class<? extends LocalReference> getReferenceClass() {
      return TestClass2.class;
    }
  }

  private static class TestReferencePairManager extends PoolableReferencePairManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final RemoteReferenceCommunicationHandler remoteHandler;

    private TestReferencePairManager(List<Class<? extends LocalReference>> supportedClasses,
                                     String poolId,
                                     LocalReferenceCommunicationHandler localHandler,
                                     RemoteReferenceCommunicationHandler remoteHandler) {
      super(supportedClasses, poolId);
      this.localHandler = localHandler;
      this.remoteHandler = remoteHandler;
    }

    @Override
    public RemoteReferenceCommunicationHandler getRemoteHandler() {
      return remoteHandler;
    }

    @Override
    public LocalReferenceCommunicationHandler getLocalHandler() {
      return localHandler;
    }
  }

  @Test
  public void referencePairManager_createLocalReferenceFor() throws Exception {
    final List<List<Object>> allArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "test_id",
        new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) {
        allArguments.add(arguments);
        return new TestClass();
      }

      @Override
      public Object executeLocalMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) {
        return null;
      }

      @Override
      public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
        // Do nothing.
      }
    }, null);
    manager.initialize();

    final TestClass result = (TestClass) manager.createLocalReferenceFor(
        new RemoteReference("apple"),
        0,
        Arrays.asList("Hello",
            new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"),
            Collections.singletonList(new UnpairedRemoteReference(0, Collections.emptyList(), "test_id")),
            ImmutableMap.of(1.1, new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"))
        )
    );

    assertEquals(manager.localReferenceFor(new RemoteReference("apple")), result);
    assertEquals(manager.remoteReferenceFor(result), new RemoteReference("apple"));
    assertThat(
        allArguments,
        contains(empty(), empty(), empty(),
        contains(
            (Matcher) equalTo("Hello"),
            Matchers.<String>instanceOf(TestClass.class),
            contains(Matchers.<String>instanceOf(TestClass.class)),
            hasEntry(equalTo(1.1), Matchers.<String>instanceOf(TestClass.class)))));
  }


  @Test
  public void referencePairManager_executeLocalMethodFor() throws Exception {
    final List<Object> methodArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "test_id",
        new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) {
        return new TestClass();
      }

      @Override
      public Object executeLocalMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) {
        methodArguments.addAll(arguments);
        return null;
      }

      @Override
      public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
        // Do nothing.
      }
    }, null);
    manager.initialize();

    manager.createLocalReferenceFor(new RemoteReference("chi") , 0);
    manager.executeLocalMethodFor(new RemoteReference("chi"), "aMethod",
        Arrays.asList("Hello",
            new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"),
            Collections.singletonList(new UnpairedRemoteReference(0, Collections.emptyList(), "test_id")),
            ImmutableMap.of(1.1, new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"))
        ));

    assertThat(
        methodArguments,
            contains(
                (Matcher) equalTo("Hello"),
                Matchers.<String>instanceOf(TestClass.class),
                contains(Matchers.<String>instanceOf(TestClass.class)),
                hasEntry(equalTo(1.1), Matchers.<String>instanceOf(TestClass.class))));
  }

  @Test
  public void referencePairManager_disposeLocalReferenceFor() throws Exception {
    final ReferencePairManager manager = new TestReferencePairManager(Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "test_id",
        new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) {
        return new TestClass();
      }

      @Override
      public Object executeLocalMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) {
        return null;
      }

      @Override
      public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
        // Do nothing.
      }
    }, null);
    manager.initialize();

    final TestClass result = (TestClass) manager.createLocalReferenceFor(new RemoteReference("tea") ,0);
    manager.disposeLocalReferenceFor(new RemoteReference("tea"));

    assertNull(manager.localReferenceFor(new RemoteReference("tea")));
    assertNull(manager.remoteReferenceFor(result));
  }

  @Test
  public void referencePairManager_createRemoteReferenceFor() {
    final List<Object> creationArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id",
        null, new RemoteReferenceCommunicationHandler() {
      boolean firstCall = true;

      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        if (localReference instanceof TestClass && firstCall) {
          firstCall = false;
          return Arrays.asList("Hello",
              new TestClass(),
              Collections.singletonList(new TestClass()),
              ImmutableMap.of(1.1, new TestClass())
          );
        }

        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, int classId, List<Object> arguments) {
        creationArguments.addAll(arguments);
        final CompletableRunnable<Void> runnable =  new CompletableRunnable<Void>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Object> executeRemoteMethod(RemoteReference remoteReference, String methodName, List<Object> arguments) {
        return null;
      }

      @Override
      public CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference) {
        return null;
      }
    });
    manager.initialize();

    final TestClass testClass = new TestClass();

    final List<RemoteReference> remoteReferences =  new ArrayList<>();
    manager.createRemoteReferenceFor(testClass).setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
      @Override
      public void onComplete(Object result) {
        remoteReferences.add((RemoteReference) result);
      }

      @Override
      public void onError(Throwable throwable) {

      }
    });

    assertThat(remoteReferences, Matchers.<RemoteReference>hasSize(1));
    assertEquals(manager.localReferenceFor(remoteReferences.get(0)), testClass);
    assertEquals(manager.remoteReferenceFor(testClass), remoteReferences.get(0));
    assertThat(creationArguments, contains(
        equalTo("Hello"),
        isUnpairedRemoteReference(0, empty(), "test_id"),
        contains(isUnpairedRemoteReference(0, empty(), "test_id")),
        hasEntry(equalTo(1.1), isUnpairedRemoteReference(0, empty(), "test_id"))
    ));
  }

  @Test
  public void referencePairManager_executeRemoteMethodFor() {
    final List<Object> methodArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "test_id",
        null, new RemoteReferenceCommunicationHandler() {
      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, int classId, List<Object> arguments) {
        final CompletableRunnable<Void> runnable =  new CompletableRunnable<Void>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Object> executeRemoteMethod(RemoteReference remoteReference, String methodName, List<Object> arguments) {
        methodArguments.addAll(arguments);
        final CompletableRunnable<Object> runnable =  new CompletableRunnable<Object>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference) {
        return null;
      }
    });
    manager.initialize();

    final TestClass testClass = new TestClass();
    manager.createRemoteReferenceFor(testClass);
    manager.executeRemoteMethodFor(testClass, "aMethod", Arrays.asList( "Hello",
        new TestClass(),
        Collections.singletonList(new TestClass()),
        ImmutableMap.of(1.1, new TestClass())
    ));

    assertThat(methodArguments, contains(
        equalTo("Hello"),
        isUnpairedRemoteReference(0, empty(), "test_id"),
        contains(isUnpairedRemoteReference(0, empty(), "test_id")),
        hasEntry(equalTo(1.1), isUnpairedRemoteReference(0, empty(), "test_id"))
    ));
  }

  @Test
  public void referencePairManager_disposeRemoteReferenceFor() {
    final ReferencePairManager manager = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id",
        null, new RemoteReferenceCommunicationHandler() {
      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, int classId, List<Object> arguments) {
        final CompletableRunnable<Void> runnable =  new CompletableRunnable<Void>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Object> executeRemoteMethod(RemoteReference remoteReference, String methodName, List<Object> arguments) {
        final CompletableRunnable<Object> runnable =  new CompletableRunnable<Object>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference) {
        return null;
      }
    });
    manager.initialize();

    final TestClass testClass = new TestClass();
    final List<RemoteReference> remoteReferences =  new ArrayList<>();
    manager.createRemoteReferenceFor(testClass).setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
      @Override
      public void onComplete(Object result) {
        remoteReferences.add((RemoteReference) result);
      }

      @Override
      public void onError(Throwable throwable) {

      }
    });
    manager.disposeRemoteReferenceFor(testClass);

    assertThat(remoteReferences, Matchers.<RemoteReference>hasSize(1));
    assertNull(manager.localReferenceFor(remoteReferences.get(0)));
    assertNull(manager.remoteReferenceFor(testClass));
  }

  @Test
  public void poolableReferencePairManager_add() {
    final ReferencePairManagerPool pool = new ReferencePairManagerPool();

    final PoolableReferencePairManager manager1 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id", null, null);
    final PoolableReferencePairManager manager2 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class),
        "test_id2", null, null);
    final PoolableReferencePairManager manager3 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id3", null, null);

    assertTrue(pool.add(manager1));
    assertFalse(pool.add(manager1));
    assertFalse(pool.add(manager3));
    assertTrue(pool.add(manager2));
  }

  @Test
  public void poolableReferencePairManager_remove() {
    final ReferencePairManagerPool pool = new ReferencePairManagerPool();

    final PoolableReferencePairManager manager1 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id", null, null);
    final PoolableReferencePairManager manager2 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class),
        "test_id2", null, null);

    pool.add(manager1);
    pool.add(manager2);

    pool.remove(manager1);
    pool.remove(manager2);

    assertTrue(pool.add(manager1));
    assertTrue(pool.add(manager2));
  }

  @Test
  public void poolableReferencePairManager_createLocalReferenceFor() throws Exception {
    final List<List<Object>> allArguments = new ArrayList<>();

    final PoolableReferencePairManager manager1 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "test_id",
        new LocalReferenceCommunicationHandler() {
          @Override
          public LocalReference createLocalReference(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) {
            allArguments.add(arguments);
            return new TestClass();
          }

          @Override
          public Object executeLocalMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) {
            return null;
          }

          @Override
          public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
            // Do nothing.
          }
        }, null);
    manager1.initialize();

    final PoolableReferencePairManager manager2 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class), "test_id2",
        new LocalReferenceCommunicationHandler() {
          @Override
          public LocalReference createLocalReference(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) {
            return new TestClass2();
          }

          @Override
          public Object executeLocalMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) {
            return null;
          }

          @Override
          public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) {
            // Do nothing.
          }
        }, null);
    manager2.initialize();

    final ReferencePairManagerPool pool = new ReferencePairManagerPool();
    pool.add(manager1);
    pool.add(manager2);

    manager1.createLocalReferenceFor(
        new RemoteReference("apple"),
        0,
        Arrays.asList("Hello",
            new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"),
            new UnpairedRemoteReference(0, Collections.emptyList(), "test_id2"),
            Collections.singletonList(new UnpairedRemoteReference(0, Collections.emptyList(), "test_id")),
            ImmutableMap.of(1.1, new UnpairedRemoteReference(0, Collections.emptyList(), "test_id"))
        )
    );

    assertThat(
        allArguments,
        contains(empty(), empty(), empty(),
            contains(
                (Matcher) equalTo("Hello"),
                Matchers.<String>instanceOf(TestClass.class),
                Matchers.<String>instanceOf(TestClass2.class),
                contains(Matchers.<String>instanceOf(TestClass.class)),
                hasEntry(equalTo(1.1), Matchers.<String>instanceOf(TestClass.class)))));
  }

  @Test
  public void poolableReferencePairManager_createRemoteReferenceFor() {
    final List<Object> creationArguments = new ArrayList<>();

    final PoolableReferencePairManager manager1 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "test_id",
        null, new RemoteReferenceCommunicationHandler() {
      boolean firstCall = true;

      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        if (localReference instanceof TestClass && firstCall) {
          firstCall = false;
          return Arrays.asList("Hello",
              new TestClass(),
              new TestClass2(),
              Collections.singletonList(new TestClass()),
              ImmutableMap.of(1.1, new TestClass())
          );
        }

        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, int classId, List<Object> arguments) {
        creationArguments.addAll(arguments);
        final CompletableRunnable<Void> runnable =  new CompletableRunnable<Void>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Object> executeRemoteMethod(RemoteReference remoteReference, String methodName, List<Object> arguments) {
        return null;
      }

      @Override
      public CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference) {
        return null;
      }
    });
    manager1.initialize();

    final PoolableReferencePairManager manager2 = new TestReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class),
        "test_id2",
        null, new RemoteReferenceCommunicationHandler() {
      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, int classId, List<Object> arguments) {
        final CompletableRunnable<Void> runnable =  new CompletableRunnable<Void>() {
          @Override
          public void run() {
            complete(null);
          }
        };
        runnable.run();
        return runnable;
      }

      @Override
      public CompletableRunnable<Object> executeRemoteMethod(RemoteReference remoteReference, String methodName, List<Object> arguments) {
        return null;
      }

      @Override
      public CompletableRunnable<Void> disposeRemoteReference(RemoteReference remoteReference) {
        return null;
      }
    });
    manager2.initialize();

    final ReferencePairManagerPool pool = new ReferencePairManagerPool();
    pool.add(manager1);
    pool.add(manager2);

    final TestClass testClass = new TestClass();
    manager1.createRemoteReferenceFor(testClass);

    assertThat(creationArguments, contains(
        equalTo("Hello"),
        isUnpairedRemoteReference(0, empty(), "test_id"),
        isUnpairedRemoteReference(0, empty(), "test_id2"),
        contains(isUnpairedRemoteReference(0, empty(), "test_id")),
        hasEntry(equalTo(1.1), isUnpairedRemoteReference(0, empty(), "test_id"))
    ));
  }
}
