package github.penguin.reference;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelManager;
import github.penguin.reference.reference.TypeChannelMessenger;

import java.util.Collections;
import java.util.List;
import org.junit.Before;
import org.junit.Test;

public class TypeChannelManagerTest {
  private static TestManager testManager;

  private static class TestManager extends TypeChannelManager {
    private final TestHandler testHandler;

    private TestManager() {
      testHandler = new TestHandler(this);
      registerHandler("test_channel", testHandler);
    }

    @Override
    public TypeChannelMessenger getMessenger() {
      return null;
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

  @Before
  public void setUp() {
    testManager = new TestManager();
  }

  @Test
  public void onReceiveCreateNewPair() throws Exception {
    assertEquals(
        testManager.onReceiveCreateNewInstancePair(
            "test_channel",
            new PairedInstance("test_id"),
            Collections.emptyList()
        ),
    testManager.testHandler.testClassInstance
      );
    assertTrue(testManager.isPaired(testManager.testHandler.testClassInstance));
    assertNull(
        testManager.onReceiveCreateNewInstancePair(
            "",
            new PairedInstance("test_id"),
            Collections.emptyList()
        ));
  }

  @Test
  public void onReceiveInvokeStaticMethod() throws Exception {
    assertEquals(
        testManager.onReceiveInvokeStaticMethod(
            "test_channel",
            "aStaticMethod",
            Collections.emptyList()
        ),
    "return_value"
      );
  }

  @Test
  public void createUnpairedReference() {
    final NewUnpairedInstance unpairedReference =
        testManager.createUnpairedReference(
            "test_channel",
            new TestClass(testManager)
            );
    assertEquals("test_channel", unpairedReference.channelName);
    assertTrue(unpairedReference.creationArguments.isEmpty());
  }

  @Test
  public void onReceiveInvokeMethod() throws Exception {
    testManager.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList()
      );

    assertEquals(
        "return_value",
        testManager.onReceiveInvokeMethod(
            "test_channel",
            new PairedInstance("test_id"),
            "aMethod",
            Collections.emptyList()
        )
      );
  }

  @Test
  public void onReceiveInvokeMethodOnUnpairedReference() throws Exception {
    assertEquals(
        "return_value",
        testManager.onReceiveInvokeMethodOnUnpairedReference(
            new NewUnpairedInstance("test_channel", Collections.emptyList()),
    "aMethod",
          Collections.emptyList()
        )
      );
  }

  @Test
  public void onReceiveDisposePair() throws Exception {
    testManager.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList()
      );
    testManager.onReceiveDisposePair(
        "test_channel",
        new PairedInstance("test_id")
        );
    assertFalse(
        testManager.isPaired(testManager.testHandler.testClassInstance)
        );
  }
}
