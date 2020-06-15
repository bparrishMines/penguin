package github.penguin.reference;

import com.google.common.collect.ImmutableMap;
import org.hamcrest.Matcher;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.PoolableReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManagerPool;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedReference;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.notNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.any;

@SuppressWarnings("rawtypes")
public class ReferenceTest {
  private static TestReferencePairManager testManager;
  private static TestPoolableReferencePairManager testPoolableManager1;
  private static TestPoolableReferencePairManager testPoolableManager2;
  private static ReferencePairManagerPool pool;

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

  private static class TestReferencePairManager extends ReferencePairManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final RemoteReferenceCommunicationHandler remoteHandler;

    private TestReferencePairManager() {
      super(Collections.<Class<? extends LocalReference>>singletonList(TestClass.class));
      this.localHandler = mock(LocalReferenceCommunicationHandler.class);
      this.remoteHandler = mock(RemoteReferenceCommunicationHandler.class);
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

  private static class TestPoolableReferencePairManager extends PoolableReferencePairManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final RemoteReferenceCommunicationHandler remoteHandler;

    private TestPoolableReferencePairManager(List<Class<? extends LocalReference>> supportedClasses, String poolId) {
      super(supportedClasses, poolId);
      this.localHandler = mock(LocalReferenceCommunicationHandler.class);
      this.remoteHandler = mock(RemoteReferenceCommunicationHandler.class);
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

  @Before
  public void setUp() {
    testManager = new TestReferencePairManager();
    testManager.initialize();

    pool = new ReferencePairManagerPool();

    testPoolableManager1 = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "id1");
    testPoolableManager1.initialize();

    testPoolableManager2 = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class),
        "id2");
    testPoolableManager2.initialize();
  }

  @Test
  public void referencePairManager_pairWithNewLocalReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final TestClass result = (TestClass) testManager.pairWithNewLocalReference(
        new RemoteReference("apple"),
        0,
        Arrays.asList("Hello",
            new UnpairedReference(0, Collections.emptyList(), null),
            Collections.singletonList(new UnpairedReference(0, Collections.emptyList(), null)),
            ImmutableMap.of(1.1, new UnpairedReference(0, Collections.emptyList(), null))
        )
    );

    assertEquals(testManager.getPairedLocalReference(new RemoteReference("apple")), result);
    assertEquals(testManager.getPairedRemoteReference(result), new RemoteReference("apple"));

    final ArgumentCaptor<List> creationArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.localHandler, times(4)).create(eq(testManager), eq(TestClass.class), creationArguments.capture());

    assertThat(
        creationArguments.getAllValues(),
        contains(empty(), empty(), empty(),
        contains(
            (Matcher) equalTo("Hello"),
            instanceOf(TestClass.class),
            contains(instanceOf(TestClass.class)),
            hasEntry(equalTo(1.1), instanceOf(TestClass.class)))));
  }

  @Test
  public void referencePairManager_invokeLocalMethod() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final LocalReference localReference =
        testManager.pairWithNewLocalReference(new RemoteReference("chi") , 0);

    testManager.invokeLocalMethod(localReference, "aMethod",
        Arrays.asList("Hello",
            new UnpairedReference(0, Collections.emptyList(), null),
            Collections.singletonList(new UnpairedReference(0, Collections.emptyList(), null)),
            ImmutableMap.of(1.1, new UnpairedReference(0, Collections.emptyList(), null))
        ));

    final ArgumentCaptor<List> methodArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.localHandler).invokeMethod(eq(testManager),
        eq(localReference),
        eq("aMethod"),
        methodArguments.capture()
    );

    assertThat(
        methodArguments.getValue(),
            contains(
                (Matcher) equalTo("Hello"),
                instanceOf(TestClass.class),
                contains(instanceOf(TestClass.class)),
                hasEntry(equalTo(1.1), instanceOf(TestClass.class))));
  }

  @Test
  public void referencePairManager_invokeLocalMethodOnUnpairedReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    testManager.invokeLocalMethodOnUnpairedReference(new UnpairedReference(0, Collections.emptyList()), "aMethod",
        Arrays.asList("Hello",
            new UnpairedReference(0, Collections.emptyList(), null),
            Collections.singletonList(new UnpairedReference(0, Collections.emptyList(), null)),
            ImmutableMap.of(1.1, new UnpairedReference(0, Collections.emptyList(), null))
        ));

    final ArgumentCaptor<List> methodArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.localHandler).invokeMethod(eq(testManager),
        (LocalReference) notNull(),
        eq("aMethod"),
        methodArguments.capture()
    );

    assertThat(
        methodArguments.getValue(),
        contains(
            (Matcher) equalTo("Hello"),
            instanceOf(TestClass.class),
            contains(instanceOf(TestClass.class)),
            hasEntry(equalTo(1.1), instanceOf(TestClass.class))));
  }

  @Test
  public void referencePairManager_disposePairWithRemoteReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final TestClass testClass = (TestClass) testManager.pairWithNewLocalReference(new RemoteReference("tea") ,0);
    testManager.disposePairWithRemoteReference(new RemoteReference("tea"));

    verify(testManager.localHandler).dispose(testManager, testClass);
    assertNull(testManager.getPairedLocalReference(new RemoteReference("tea")));
    assertNull(testManager.getPairedRemoteReference(testClass));
  }

  @Test
  public void referencePairManager_pairWithNewRemoteReference() {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.getCreationArguments(testClass))
        .thenReturn(Arrays.asList("Hello",
            new TestClass(),
            Collections.singletonList(new TestClass()),
            ImmutableMap.of(1.1, new TestClass())
        ));

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    final Completable.OnCompleteListener mockListener = mock(Completable.OnCompleteListener.class);
    testManager.pairWithNewRemoteReference(testClass).setOnCompleteListener(mockListener);
    final RemoteReference remoteReference = testManager.getPairedRemoteReference(testClass);

    verify(mockListener).onComplete(remoteReference);
    assertEquals(testManager.getPairedLocalReference(remoteReference), testClass);
    assertEquals(testManager.getPairedRemoteReference(testClass), remoteReference);

    final ArgumentCaptor<List> creationArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.remoteHandler).create(eq(remoteReference),
        eq(0),
        creationArguments.capture()
    );

    assertThat(creationArguments.getValue(), contains(
        equalTo("Hello"),
        isUnpairedReference(0, empty(), null),
        contains(isUnpairedReference(0, empty(), null)),
        hasEntry(equalTo(1.1), isUnpairedReference(0, empty(), null))
    ));
  }

  @Test
  public void referencePairManager_invokeRemoteMethod() {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testManager.remoteHandler.invokeMethod(any(RemoteReference.class), eq("aMethod"), anyList()))
        .thenReturn(new Completer<>().complete(null).completable);

    testManager.pairWithNewRemoteReference(testClass);
    final RemoteReference remoteReference = testManager.getPairedRemoteReference(testClass);
    testManager.invokeRemoteMethod(remoteReference, "aMethod", Arrays.asList( "Hello",
        new TestClass(),
        Collections.singletonList(new TestClass()),
        ImmutableMap.of(1.1, new TestClass())
    ));

    final ArgumentCaptor<List> methodArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.remoteHandler).invokeMethod(eq(remoteReference),
        eq("aMethod"),
        methodArguments.capture()
    );

    assertThat(methodArguments.getValue(), contains(
        equalTo("Hello"),
        isUnpairedReference(0, empty(), null),
        contains(isUnpairedReference(0, empty(), null)),
        hasEntry(equalTo(1.1), isUnpairedReference(0, empty(), null))
    ));
  }

  @Test
  public void referencePairManager_invokeRemoteMethodOnUnpairedReference() {
    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testManager.remoteHandler.invokeMethodOnUnpairedReference(any(UnpairedReference.class), eq("aMethod"), anyList()))
        .thenReturn(new Completer<>().complete(null).completable);

    testManager.invokeRemoteMethodOnUnpairedReference(new TestClass(), "aMethod", Arrays.asList( "Hello",
        new TestClass(),
        Collections.singletonList(new TestClass()),
        ImmutableMap.of(1.1, new TestClass())
    ));

    final ArgumentCaptor<List> methodArguments = ArgumentCaptor.forClass(List.class);
    verify(testManager.remoteHandler).invokeMethodOnUnpairedReference(any(UnpairedReference.class),
        eq("aMethod"),
        methodArguments.capture()
    );

    assertThat(methodArguments.getValue(), contains(
        equalTo("Hello"),
        isUnpairedReference(0, empty(), null),
        contains(isUnpairedReference(0, empty(), null)),
        hasEntry(equalTo(1.1), isUnpairedReference(0, empty(), null))
    ));
  }

  @Test
  public void referencePairManager_disposePairWithLocalReference() {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    testManager.pairWithNewRemoteReference(testClass);
    final RemoteReference remoteReference = testManager.getPairedRemoteReference(testClass);

    testManager.disposePairWithLocalReference(testClass);

    verify(testManager.remoteHandler).dispose(remoteReference);

    assertNull(testManager.getPairedLocalReference(remoteReference));
    assertNull(testManager.getPairedRemoteReference(testClass));
  }

  @Test
  public void poolableReferencePairManager_add() {
    final PoolableReferencePairManager sameClassManager = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "id3");

    final PoolableReferencePairManager sameIdManager = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class),
        "id1");

    assertTrue(pool.add(testPoolableManager1));
    assertTrue(pool.add(testPoolableManager1));
    assertFalse(pool.add(sameClassManager));
    assertFalse(pool.add(sameIdManager));
    assertTrue(pool.add(testPoolableManager2));
  }

  @Test
  public void poolableReferencePairManager_remove() {
    pool.add(testPoolableManager1);
    pool.remove(testPoolableManager1);

    final PoolableReferencePairManager sameClassManager = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "id1");

    assertTrue(pool.add(sameClassManager));
  }

  @Test
  public void poolableReferencePairManager_pairWithNewLocalReference() throws Exception {
    pool.add(testPoolableManager1);
    pool.add(testPoolableManager2);

    when(testPoolableManager1.localHandler.create(eq(testPoolableManager1), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    when(testPoolableManager2.localHandler.create(eq(testPoolableManager2), eq(TestClass2.class), anyList()))
        .thenReturn(new TestClass2());

    testPoolableManager1.pairWithNewLocalReference(
        new RemoteReference("apple"),
        0,
        Arrays.asList("Hello",
            new UnpairedReference(0, Collections.emptyList(), "id1"),
            new UnpairedReference(0, Collections.emptyList(), "id2"),
            Collections.singletonList(new UnpairedReference(0, Collections.emptyList(), "id1")),
            ImmutableMap.of(1.1, new UnpairedReference(0, Collections.emptyList(), "id1"))
        )
    );

    final ArgumentCaptor<List> creationArguments = ArgumentCaptor.forClass(List.class);
    verify(testPoolableManager1.localHandler,
        times(4)).create(eq(testPoolableManager1),
        eq(TestClass.class),
        creationArguments.capture());

    verify(testPoolableManager2.localHandler).create(eq(testPoolableManager2), eq(TestClass2.class), anyList());

    assertThat(
        creationArguments.getAllValues(),
        contains(empty(), empty(), empty(),
            contains(
                (Matcher) equalTo("Hello"),
                instanceOf(TestClass.class),
                instanceOf(TestClass2.class),
                contains(instanceOf(TestClass.class)),
                hasEntry(equalTo(1.1), instanceOf(TestClass.class)))));
  }

  @Test
  public void poolableReferencePairManager_pairWithNewRemoteReference() {
    pool.add(testPoolableManager1);
    pool.add(testPoolableManager2);

    final TestClass testClass = new TestClass();

    when(testPoolableManager1.remoteHandler.getCreationArguments(testClass))
        .thenReturn(Arrays.asList("Hello",
            new TestClass(),
            new TestClass2(),
            Collections.singletonList(new TestClass()),
            ImmutableMap.of(1.1, new TestClass())
        ));

    when(testPoolableManager2.remoteHandler.getCreationArguments(any(TestClass2.class)))
        .thenReturn(Collections.emptyList());

    when(testPoolableManager1.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    testPoolableManager1.pairWithNewRemoteReference(testClass);
    final RemoteReference remoteReference = testPoolableManager1.getPairedRemoteReference(testClass);

    final ArgumentCaptor<List> creationArguments = ArgumentCaptor.forClass(List.class);
    verify(testPoolableManager1.remoteHandler).create(eq(remoteReference),
        eq(0),
        creationArguments.capture()
    );

    assertThat(creationArguments.getValue(), contains(
        equalTo("Hello"),
        isUnpairedReference(0, empty(), "id1"),
        isUnpairedReference(0, empty(), "id2"),
        contains(isUnpairedReference(0, empty(), "id1")),
        hasEntry(equalTo(1.1), isUnpairedReference(0, empty(), "id1"))
    ));
  }
}
