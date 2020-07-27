package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;
import java.util.Collections;
import java.util.List;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.PoolableReferencePairManager;
import github.penguin.reference.reference.ReferenceConverter;
import github.penguin.reference.reference.ReferenceConverter.StandardReferenceConverter;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManagerPool;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.ArgumentMatchers.notNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.spy;
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
    private final StandardReferenceConverter converter;

    private TestReferencePairManager() {
      super(Collections.<Class<? extends LocalReference>>singletonList(TestClass.class));
      this.localHandler = mock(LocalReferenceCommunicationHandler.class);
      this.remoteHandler = mock(RemoteReferenceCommunicationHandler.class);
      this.converter = spy(new StandardReferenceConverter());
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
    public ReferenceConverter getConverter() {
      return converter;
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
        0
    );

    assertEquals(testManager.getPairedLocalReference(new RemoteReference("apple")), result);
    assertEquals(testManager.getPairedRemoteReference(result), new RemoteReference("apple"));

    verify(testManager.converter).convertReferencesForLocalManager(eq(testManager), anyList());
    verify(testManager.localHandler).create(eq(testManager), eq(TestClass.class), anyList());
  }

  @Test
  public void referencePairManager_pairWithNewLocalReference_returnsNull() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0);
    assertNull(testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0));
  }

  @Test
  public void referencePairManager_invokeLocalMethod() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final LocalReference localReference =
        testManager.pairWithNewLocalReference(new RemoteReference("chi") , 0);
    reset(testManager.converter);

    testManager.invokeLocalMethod(localReference, "aMethod");

    verify(testManager.converter).convertReferencesForLocalManager(eq(testManager), anyList());
    verify(testManager.localHandler).invokeMethod(eq(testManager),
        eq(localReference),
        eq("aMethod"),
        anyList()
    );
    verify(testManager.converter).convertReferencesForRemoteManager(eq(testManager), isNull());
  }

  @Test
  public void referencePairManager_invokeLocalMethodOnUnpairedReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    testManager.invokeLocalMethodOnUnpairedReference(new UnpairedReference(0, Collections.emptyList()), "aMethod");

    verify(testManager.localHandler).invokeMethod(eq(testManager), (LocalReference) notNull(), eq("aMethod"), anyList());
  }

  @Test
  public void referencePairManager_disposePairWithRemoteReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenAnswer(new Answer<Object>() {
          @Override
          public Object answer(InvocationOnMock invocation) {
            return new TestClass();
          }
        });

    final TestClass testClass = (TestClass) testManager.pairWithNewLocalReference(new RemoteReference("tea") ,0);
    testManager.disposePairWithRemoteReference(new RemoteReference("tea"));

    verify(testManager.localHandler).dispose(testManager, testClass);
    assertNull(testManager.getPairedLocalReference(new RemoteReference("tea")));
    assertNull(testManager.getPairedRemoteReference(testClass));
  }

  @SuppressWarnings("unchecked")
  @Test
  public void referencePairManager_pairWithNewRemoteReference() {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.getCreationArguments(testClass))
        .thenReturn(Collections.emptyList());

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    final Completable.OnCompleteListener mockListener = mock(Completable.OnCompleteListener.class);
    testManager.pairWithNewRemoteReference(testClass).setOnCompleteListener(mockListener);
    final RemoteReference remoteReference = testManager.getPairedRemoteReference(testClass);

    verify(mockListener).onComplete(remoteReference);
    assertEquals(testManager.getPairedLocalReference(remoteReference), testClass);
    assertEquals(testManager.getPairedRemoteReference(testClass), remoteReference);

    verify(testManager.converter).convertReferencesForRemoteManager(eq(testManager), anyList());
    verify(testManager.remoteHandler).create(eq(remoteReference), eq(0), anyList());
  }

  @SuppressWarnings("unchecked")
  @Test
  public void referencePairManager_pairWithNewRemoteReference_returnsNull() {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.getCreationArguments(testClass))
        .thenReturn(Collections.emptyList());

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    testManager.pairWithNewRemoteReference(testClass);

    final Completable.OnCompleteListener mockListener = mock(Completable.OnCompleteListener.class);
    testManager.pairWithNewRemoteReference(testClass).setOnCompleteListener(mockListener);
    verify(mockListener).onComplete(null);
  }

  @Test
  public void referencePairManager_invokeRemoteMethod() throws Exception {
    final TestClass testClass = new TestClass();

    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testManager.remoteHandler.invokeMethod(any(RemoteReference.class), eq("aMethod"), anyList()))
        .thenReturn(new Completer<>().complete(null).completable);

    testManager.pairWithNewRemoteReference(testClass);
    reset(testManager.converter);

    final RemoteReference remoteReference = testManager.getPairedRemoteReference(testClass);
    testManager.invokeRemoteMethod(remoteReference, "aMethod");

    verify(testManager.converter).convertReferencesForRemoteManager(eq(testManager), anyList());
    verify(testManager.remoteHandler).invokeMethod(eq(remoteReference), eq("aMethod"), anyList());
    verify(testManager.converter).convertReferencesForLocalManager(eq(testManager), isNull());
  }

  @Test
  public void referencePairManager_invokeRemoteMethodOnUnpairedReference() throws Exception {
    when(testManager.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testManager.remoteHandler.invokeMethodOnUnpairedReference(any(UnpairedReference.class), eq("aMethod"), anyList()))
        .thenReturn(new Completer<>().complete(null).completable);

    testManager.invokeRemoteMethodOnUnpairedReference(new TestClass(), "aMethod");

    verify(testManager.converter, times(2)).convertReferencesForRemoteManager(eq(testManager), anyList());
    verify(testManager.remoteHandler).invokeMethodOnUnpairedReference(any(UnpairedReference.class),
        eq("aMethod"),
        anyList()
    );
    verify(testManager.converter).convertReferencesForLocalManager(eq(testManager), isNull());
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

    final PoolableReferencePairManager manager = new TestPoolableReferencePairManager(
        Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
        "id1");

    assertTrue(pool.add(manager));
  }
}
