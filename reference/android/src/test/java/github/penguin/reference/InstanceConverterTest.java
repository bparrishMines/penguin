package github.penguin.reference;

import static github.penguin.reference.ReferenceMatchers.isUnpairedInstance;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.InstanceConverter.StandardInstanceConverter;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelManager;
import github.penguin.reference.reference.TypeChannelMessenger;
import java.util.Collections;
import java.util.List;
import org.junit.Before;
import org.junit.Test;

public class InstanceConverterTest {
  private static final StandardInstanceConverter converter = new StandardInstanceConverter();
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
  public void convertForRemoteManager_handlesPairedObject()
          throws Exception {
    testManager.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList());

    assertEquals(new PairedInstance("test_id"),
        converter.convertForRemoteManager(testManager, testManager.testHandler.testClassInstance)
    );
  }

  @Test
  public void convertForRemoteManager_handlesUnpairedObject() {
    assertThat(converter.convertForRemoteManager(testManager, new TestClass(testManager)),
        isUnpairedInstance("test_channel", Collections.emptyList()));
  }

  @Test
  public void convertForRemoteManager_handlesNonPairableInstance() {
    assertEquals("potato", converter.convertForRemoteManager(testManager, "potato"));
  }

  @Test
  public void convertForLocalManager_handlesPairedInstance() throws Exception {
    final PairedInstance pairedInstance = new PairedInstance("test_id");
    testManager.onReceiveCreateNewInstancePair(
        "test_channel",
        pairedInstance,
        Collections.emptyList()
      );

    assertEquals(
        converter.convertForLocalManager(testManager, pairedInstance),
        testManager.testHandler.testClassInstance
    );
  }

  @Test
  public void convertForLocalManager_handlesNewUnpairedInstance() throws Exception {
    assertEquals(converter.convertForLocalManager(
        testManager,
        new NewUnpairedInstance("test_channel", Collections.emptyList())
      ),
        testManager.testHandler.testClassInstance);
  }
}
