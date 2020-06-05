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
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager.*;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.TypeReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedRemoteReference;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

@SuppressWarnings("rawtypes")
public class ReferenceTest {
  private static class TestClass implements LocalReference {}

  private static class TestReferencePairManager extends ReferencePairManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final RemoteReferenceCommunicationHandler remoteHandler;

    private TestReferencePairManager(LocalReferenceCommunicationHandler localHandler,
                                     RemoteReferenceCommunicationHandler remoteHandler) {
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

    @Override
    public TypeReference typeReferenceFor(LocalReference localReference) {
      return new TypeReference(0);
    }
  }

  @Test
  public void referencePairManager_createLocalReferenceFor() throws Exception {
    final List<List<Object>> allArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, TypeReference typeReference, List<Object> arguments) {
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
        new TypeReference(0),
        Arrays.asList("Hello",
            new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList()),
            Collections.singletonList(new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList())),
            ImmutableMap.of(1.1, new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList()))
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

    final ReferencePairManager manager = new TestReferencePairManager(new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, TypeReference typeReference, List<Object> arguments) {
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

    manager.createLocalReferenceFor(new RemoteReference("chi") , new TypeReference(0));
    manager.executeLocalMethodFor(new RemoteReference("chi"), "aMethod",
        Arrays.asList("Hello",
            new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList()),
            Collections.singletonList(new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList())),
            ImmutableMap.of(1.1, new UnpairedRemoteReference(new TypeReference(0), Collections.emptyList()))
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
    final ReferencePairManager manager = new TestReferencePairManager(new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference createLocalReference(ReferencePairManager referencePairManager, TypeReference typeReference, List<Object> arguments) {
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

    final TestClass result = (TestClass) manager.createLocalReferenceFor(new RemoteReference("tea") , new TypeReference(0));
    manager.disposeLocalReferenceFor(new RemoteReference("tea"));

    assertNull(manager.localReferenceFor(new RemoteReference("tea")));
    assertNull(manager.remoteReferenceFor(result));
  }

  @Test
  public void referencePairManager_createRemoteReferenceFor() {
    final List<Object> creationArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(null, new RemoteReferenceCommunicationHandler() {
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
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, TypeReference typeReference, List<Object> arguments) {
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
    System.out.println("" + creationArguments.get(0));
    assertThat(creationArguments, contains(
        equalTo("Hello"),
        isUnpairedRemoteReference(new TypeReference(0), empty()),
        contains(isUnpairedRemoteReference(new TypeReference(0), empty())),
        hasEntry(equalTo(1.1), isUnpairedRemoteReference(new TypeReference(0), empty()))
    ));
  }

  @Test
  public void referencePairManager_executeRemoteMethodFor() {
    final List<Object> methodArguments = new ArrayList<>();

    final ReferencePairManager manager = new TestReferencePairManager(null, new RemoteReferenceCommunicationHandler() {
      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, TypeReference typeReference, List<Object> arguments) {
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
        isUnpairedRemoteReference(new TypeReference(0), empty()),
        contains(isUnpairedRemoteReference(new TypeReference(0), empty())),
        hasEntry(equalTo(1.1), isUnpairedRemoteReference(new TypeReference(0), empty()))
    ));
  }

  @Test
  public void referencePairManager_disposeRemoteReferenceFor() {
    final ReferencePairManager manager = new TestReferencePairManager(null, new RemoteReferenceCommunicationHandler() {
      @Override
      public List<Object> creationArgumentsFor(LocalReference localReference) {
        return Collections.emptyList();
      }

      @Override
      public CompletableRunnable<Void> createRemoteReference(RemoteReference remoteReference, TypeReference typeReference, List<Object> arguments) {
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
}
