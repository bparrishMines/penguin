package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelManager;
import github.penguin.reference.reference.TypeChannelMessenger;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;

public class TypeChannelTest {
  private static TestManager testManager;
  private static TypeChannel<TestClass> testChannel;

  private static class TestManager extends TypeChannelManager {
    private final TestMessenger testMessenger = new TestMessenger();

    private TestManager() {
      registerHandler("test_channel", new TestHandler(this));
    }

    @Override
    public TypeChannelMessenger getMessenger() {
      return testMessenger;
    }

    @Override
    public String generateUniqueReferenceId() {
      return "test_reference_id";
    }
  }
  
  private static class TestMessenger implements TypeChannelMessenger {
    @Override
    public Completable<Void> sendCreateNewInstancePair(String channelName, PairedInstance pairedInstance, List<Object> arguments) {
      return new Completer<Void>().complete(null).completable;
    }

    @Override
    public Completable<Object> sendInvokeStaticMethod(String channelName, String methodName, List<Object> arguments) {
      return new Completer<>().complete("return_value").completable;
    }

    @Override
    public Completable<Object> sendInvokeMethod(String channelName, PairedInstance pairedInstance, String methodName, List<Object> arguments) {
      return new Completer<>().complete("return_value").completable;
    }

    @Override
    public Completable<Object> sendInvokeMethodOnUnpairedReference(NewUnpairedInstance unpairedInstance, String methodName, List<Object> arguments) {
      return new Completer<>().complete("return_value").completable;
    }

    @Override
    public Completable<Void> sendDisposePair(String channelName, PairedInstance pairedInstance) {
      return new Completer<Void>().complete(null).completable;
    }
  }

  private static class TestHandler implements TypeChannelHandler<TestClass> {
    final TestClass testClassInstance;

    private TestHandler(TestManager manager) {
      testClassInstance = new TestClass(manager);
    }

    @Override
    public List<Object> getCreationArguments(TypeChannelManager manager, TestClass instance) {
      return Collections.emptyList();
    }

    @Override
    public TestClass createInstance(TypeChannelManager manager, List<Object> arguments) {
      return testClassInstance;
    }

    @Override
    public Object invokeStaticMethod(TypeChannelManager manager, String methodName, List<Object> arguments) {
      return "return_value";
    }

    @Override
    public Object invokeMethod(TypeChannelManager manager, TestClass instance, String methodName, List<Object> arguments) {
      return "return_value";
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, TestClass instance) {

    }
  }

  private static class TestClass implements PairableInstance<TestClass> {
    private final TestManager manager;

    TestClass(TestManager manager) {
      this.manager = manager;
    }

    @Override
    public TypeChannel<TestClass> getTypeChannel() {
      return new TypeChannel<>(manager, "test_channel");
    }
  }

  private static class TestListener<T> implements Completable.OnCompleteListener<T> {
    T result;

    @Override
    public void onComplete(T result) {
      this.result = result;
    }

    @Override
    public void onError(Throwable throwable) { }
  }

  @Before
  public void setUp() {
    testManager = new TestManager();
    testChannel = new TypeChannel<>(testManager, "test_channel");
  }
  
  @Test
  public void createNewPair() {
    final TestClass testClass = new TestClass(testManager);
    final TestListener<PairedInstance> testListener = new TestListener<>();

    testChannel.createNewInstancePair(testClass).setOnCompleteListener(testListener);
    assertEquals(new PairedInstance("test_reference_id"), testListener.result);

    testChannel.createNewInstancePair(testClass).setOnCompleteListener(testListener);
    assertNull(testListener.result);
  }

  @Test
  public void invokeStaticMethod() {
    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeStaticMethod("aStaticMethod", Collections.emptyList()).setOnCompleteListener(testListener);
    assertEquals("return_value", testListener.result);
  }

  @Test
  public void invokeMethod() {
    final TestClass testClass = new TestClass(testManager);
    testChannel.createNewInstancePair(testClass);
    
    final TestListener<Object> testListener = new TestListener<>();
    
    testChannel.invokeMethod(testClass, "aMethod", Collections.emptyList()).setOnCompleteListener(testListener);
    assertEquals("return_value", testListener.result);
  }

  @Test
  public void invokeMethodOnUnpairedInstance() {
    final TestListener<Object> testListener = new TestListener<>();

    testChannel.invokeMethod(new TestClass(testManager), "aMethod", Collections.emptyList()).setOnCompleteListener(testListener);
    assertEquals("return_value", testListener.result);
  }

  @Test
  public void disposePair() {
    final TestClass testClass = new TestClass(testManager);
    final TestListener<Void> testListener = new TestListener<>();

    testChannel.createNewInstancePair(testClass);
    testChannel.disposePair(testClass).setOnCompleteListener(testListener);
    assertFalse(testManager.isPaired(testClass));
    
    // Test that this completes with second call.
    testChannel.disposePair(testClass).setOnCompleteListener(testListener);
  }
}
