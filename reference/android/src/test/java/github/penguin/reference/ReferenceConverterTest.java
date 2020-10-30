package github.penguin.reference;

import static github.penguin.reference.ReferenceMatchers.isUnpairedReference;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.empty;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.ReferenceConverter.StandardReferenceConverter;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.hamcrest.Matcher;
import org.junit.Before;
import org.junit.Test;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

public class ReferenceConverterTest {
  private static final StandardReferenceConverter converter = new StandardReferenceConverter();
  private static TestReferencePairManager testManager;

  private static TestPoolableReferencePairManager testPoolableManager1;
  private static TestPoolableReferencePairManager testPoolableManager2;
  private static PoolableReferenceConverter poolableConverter;

  private static class TestClass {
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

  private static class TestReferencePairManager {
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

  private static class TestPoolableReferencePairManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final RemoteReferenceCommunicationHandler remoteHandler;

    private TestPoolableReferencePairManager(
        List<Class<? extends LocalReference>> supportedClasses, String poolId) {
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

    testPoolableManager1 =
        new TestPoolableReferencePairManager(
            Collections.<Class<? extends LocalReference>>singletonList(TestClass.class), "id1");
    testPoolableManager1.initialize();

    testPoolableManager2 =
        new TestPoolableReferencePairManager(
            Collections.<Class<? extends LocalReference>>singletonList(TestClass2.class), "id2");
    testPoolableManager2.initialize();

    final ReferencePairManagerPool pool = new ReferencePairManagerPool();
    pool.add(testPoolableManager1);
    pool.add(testPoolableManager2);

    poolableConverter = new PoolableReferenceConverter();
  }

  @Test
  public void
      standardReferenceConverter_convertReferencesForRemoteManager_handlesPairedLocalReference()
          throws Exception {
    final TestClass testClass = new TestClass();

    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(testClass);

    testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0);

    assertEquals(
        converter.convertForRemoteManager(testManager, testClass), new RemoteReference("apple"));
  }

  @Test
  public void
      standardReferenceConverter_convertReferencesForRemoteManager_handlesUnpairedLocalReference() {
    assertThat(
        converter.convertForRemoteManager(testManager, new TestClass()),
        isUnpairedReference(0, empty(), null));
  }

  @Test
  public void standardReferenceConverter_convertReferencesForRemoteManager_handlesList() {
    final List<List<TestClass>> creationArguments = new ArrayList<>();
    creationArguments.add(Collections.singletonList(new TestClass()));
    creationArguments.add(Collections.<TestClass>emptyList());

    when(testManager.remoteHandler.getCreationArguments(any(LocalReference.class)))
        .thenAnswer(
            new Answer<Object>() {
              @Override
              public Object answer(InvocationOnMock invocation) {
                return creationArguments.remove(0);
              }
            });

    assertThat(
        converter.convertForRemoteManager(testManager, Collections.singletonList(new TestClass())),
        contains(isUnpairedReference(0, contains(isUnpairedReference(0, empty(), null)), null)));
  }

  @Test
  public void standardReferenceConverter_convertReferencesForRemoteManager_handlesMap() {
    final List<List<TestClass>> creationArguments = new ArrayList<>();
    creationArguments.add(Collections.singletonList(new TestClass()));
    creationArguments.add(Collections.<TestClass>emptyList());
    creationArguments.add(Collections.singletonList(new TestClass()));
    creationArguments.add(Collections.<TestClass>emptyList());

    when(testManager.remoteHandler.getCreationArguments(any(LocalReference.class)))
        .thenAnswer(
            new Answer<Object>() {
              @Override
              public Object answer(InvocationOnMock invocation) {
                return creationArguments.remove(0);
              }
            });

    @SuppressWarnings("unchecked")
    final Map<Object, Object> result =
        (Map<Object, Object>)
            converter.convertForRemoteManager(
                testManager,
                new HashMap<Object, Object>() {
                  {
                    put(new TestClass(), new TestClass());
                  }
                });

    assertThat(
        result,
        hasEntry(
            isUnpairedReference(0, contains(isUnpairedReference(0, empty(), null)), null),
            isUnpairedReference(0, contains(isUnpairedReference(0, empty(), null)), null)));
  }

  @Test
  public void
      standardReferenceConverter_convertReferencesForRemoteManager_handlesNonLocalReference() {
    assertEquals(converter.convertForRemoteManager(testManager, "apple"), "apple");
  }

  @Test
  public void standardReferenceConverter_convertReferencesForLocalManager_handlesRemoteReference()
      throws Exception {
    final TestClass testClass = new TestClass();

    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(testClass);

    testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0);

    assertEquals(
        converter.convertForLocalManager(testManager, new RemoteReference("apple")), testClass);
  }

  @Test
  public void standardReferenceConverter_convertReferencesForLocalManager_handlesUnpairedReference()
      throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    assertThat(
        converter.convertForLocalManager(
            testManager, new UnpairedReference(0, Collections.emptyList())),
        isA(TestClass.class));
  }

  @Test
  public void standardReferenceConverter_convertReferencesForLocalManager_handlesList()
      throws Exception {
    final TestClass testClass = new TestClass();

    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(testClass);

    testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0);

    assertThat(
        converter.convertForLocalManager(
            testManager, Collections.singletonList(new RemoteReference("apple"))),
        (Matcher) contains(testClass));
  }

  @Test
  public void standardReferenceConverter_convertReferencesForLocalManager_handlesMap()
      throws Exception {
    final TestClass testClass1 = new TestClass();
    final TestClass testClass2 = new TestClass();

    final List<TestClass> testClasses = new ArrayList<>();
    testClasses.add(testClass1);
    testClasses.add(testClass2);

    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenAnswer(
            new Answer<Object>() {
              @Override
              public Object answer(InvocationOnMock invocation) {
                return testClasses.remove(0);
              }
            });

    testManager.pairWithNewLocalReference(new RemoteReference("apple"), 0);
    testManager.pairWithNewLocalReference(new RemoteReference("banana"), 0);

    final Map<Object, Object> result =
        (Map<Object, Object>)
            converter.convertForLocalManager(
                testManager,
                new HashMap<Object, Object>() {
                  {
                    put(new RemoteReference("apple"), new RemoteReference("banana"));
                  }
                });

    assertThat(result, (Matcher) hasEntry(testClass1, testClass2));
  }

  @Test
  public void
      poolableReferenceConverter_convertReferencesForRemoteManager_handlesPairedLocalReference()
          throws Exception {
    final TestClass testClass1 = new TestClass();
    final TestClass2 testClass2 = new TestClass2();

    when(testPoolableManager1.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testPoolableManager2.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    testPoolableManager1.pairWithNewRemoteReference(testClass1);
    testPoolableManager2.pairWithNewRemoteReference(testClass2);

    assertEquals(
        poolableConverter.convertForRemoteManager(testPoolableManager1, testClass1),
        testPoolableManager1.getPairedRemoteReference(testClass1));
    assertEquals(
        poolableConverter.convertForRemoteManager(testPoolableManager1, testClass2),
        testPoolableManager2.getPairedRemoteReference(testClass2));
  }

  @Test
  public void
      poolableReferenceConverter_convertReferencesForRemoteManager_handlesUnpairedLocalReference()
          throws Exception {
    assertThat(
        poolableConverter.convertForRemoteManager(testPoolableManager1, new TestClass()),
        isUnpairedReference(0, empty(), "id1"));

    assertThat(
        poolableConverter.convertForRemoteManager(testPoolableManager1, new TestClass2()),
        isUnpairedReference(0, empty(), "id2"));
  }

  @Test
  public void poolableReferenceConverter_convertReferencesForLocalManager_handlesRemoteReference()
      throws Exception {
    final TestClass testClass1 = new TestClass();
    final TestClass2 testClass2 = new TestClass2();

    when(testPoolableManager1.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    when(testPoolableManager2.remoteHandler.create(any(RemoteReference.class), eq(0), anyList()))
        .thenReturn(new Completer<Void>().complete(null).completable);

    testPoolableManager1.pairWithNewRemoteReference(testClass1);
    testPoolableManager2.pairWithNewRemoteReference(testClass2);

    assertEquals(
        poolableConverter.convertForLocalManager(
            testPoolableManager1, testPoolableManager1.getPairedRemoteReference(testClass1)),
        testClass1);
    assertEquals(
        poolableConverter.convertForLocalManager(
            testPoolableManager1, testPoolableManager2.getPairedRemoteReference(testClass2)),
        testClass2);
  }

  @Test
  public void poolableReferenceConverter_convertReferencesForLocalManager_handlesUnpairedReference()
      throws Exception {
    when(testPoolableManager1.localHandler.create(
            eq(testPoolableManager1), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    when(testPoolableManager2.localHandler.create(
            eq(testPoolableManager2), eq(TestClass2.class), anyList()))
        .thenReturn(new TestClass2());

    assertThat(
        poolableConverter.convertForLocalManager(
            testPoolableManager1, new UnpairedReference(0, Collections.emptyList(), "id1")),
        isA(TestClass.class));

    assertThat(
        poolableConverter.convertForLocalManager(
            testPoolableManager1, new UnpairedReference(0, Collections.emptyList(), "id2")),
        isA(TestClass2.class));
  }
}
