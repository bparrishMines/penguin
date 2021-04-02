package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestClass;
import github.penguin.reference.TestClasses.TestListener;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class TypeChannelTest {
  private static TestClasses.TestMessenger testManager;
  private static TypeChannel<TestClasses.TestClass> testChannel;

  @Before
  public void setUp() {
    testManager = new TestClasses.TestMessenger();
    testChannel = new TypeChannel<>(testManager, "test_channel");
  }

  @Test
  public void createNewInstancePair() {
    final TestClasses.TestClass testClass = new TestClasses.TestClass(testManager);
    final TestListener<PairedInstance> testListener = new TestListener<>();

    testChannel.createNewInstancePair(testClass, true).setOnCompleteListener(testListener);
    assertEquals(new PairedInstance("test_instance_id"), testListener.result);

    testChannel.createNewInstancePair(testClass, true).setOnCompleteListener(testListener);
    assertNull(testListener.result);

    assertTrue(testManager.isPaired(testClass));

    testChannel.createNewInstancePair(testClass, true).setOnCompleteListener(testListener);
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
    testChannel.createNewInstancePair(testClass, true);

    final TestListener<Object> testListener = new TestListener<>();

    testChannel.invokeMethod(testClass, "aMethod", Collections.emptyList()).setOnCompleteListener(testListener);
    assertEquals("return_value", testListener.result);
  }
}
