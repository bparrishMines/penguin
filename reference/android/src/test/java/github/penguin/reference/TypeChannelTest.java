package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestClass;
import github.penguin.reference.TestClasses.TestListener;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
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

    testChannel.createNewInstancePair(testClass).setOnCompleteListener(testListener);
    assertEquals(new PairedInstance("test_instance_id"), testListener.result);

    testChannel.createNewInstancePair(testClass).setOnCompleteListener(testListener);
    assertNull(testListener.result);

    assertTrue(testManager.isPaired(testClass));

    testChannel.createNewInstancePair(testClass, new Object()).setOnCompleteListener(testListener);
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
  public void disposeInstancePair() {
    final TestClass testClass = new TestClass(testManager);
    final TestListener<Void> testListener = new TestListener<>();

    testChannel.createNewInstancePair(testClass);
    testChannel.disposeInstancePair(testClass).setOnCompleteListener(testListener);
    assertFalse(testManager.isPaired(testClass));

    // Test that this completes with second call.
    testChannel.disposeInstancePair(testClass).setOnCompleteListener(testListener);

    final Object owner = new Object();
    testChannel.createNewInstancePair(testClass, owner);
    testChannel.disposeInstancePair(testClass).setOnCompleteListener(testListener);
    assertTrue(testManager.isPaired(testClass));
    testChannel.disposeInstancePair(testClass, owner).setOnCompleteListener(testListener);
    assertFalse(testManager.isPaired(testClass));
  }
}
