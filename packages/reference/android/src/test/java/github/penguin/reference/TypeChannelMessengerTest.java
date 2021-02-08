package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestClass;
import github.penguin.reference.TestClasses.TestMessenger;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairedInstance;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class TypeChannelMessengerTest {
  private static TestMessenger testMessenger;

  @Before
  public void setUp() {
    testMessenger = new TestMessenger();
  }

  @Test
  public void onReceiveCreateNewPair() throws Exception {
    assertEquals(
        testMessenger.onReceiveCreateNewInstancePair(
            "test_channel",
            new PairedInstance("test_id"),
            Collections.emptyList()
        ),
        testMessenger.testHandler.testClassInstance
    );
    assertTrue(testMessenger.isPaired(testMessenger.testHandler.testClassInstance));
    assertNull(
        testMessenger.onReceiveCreateNewInstancePair(
            "",
            new PairedInstance("test_id"),
            Collections.emptyList()
        ));
  }

  @Test
  public void onReceiveInvokeStaticMethod() throws Exception {
    assertEquals(
        testMessenger.onReceiveInvokeStaticMethod(
            "test_channel",
            "aStaticMethod",
            Collections.emptyList()
        ),
        "return_value"
    );
  }

  @Test
  public void createUnpairedInstance() {
    final NewUnpairedInstance unpairedInstance =
        testMessenger.createUnpairedInstance(
            "test_channel",
            new TestClass(testMessenger)
        );
    assertEquals("test_channel", unpairedInstance.channelName);
    assertTrue(unpairedInstance.creationArguments.isEmpty());
  }

  @Test
  public void onReceiveInvokeMethod() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList()
    );

    assertEquals(
        "return_value",
        testMessenger.onReceiveInvokeMethod(
            "test_channel",
            new PairedInstance("test_id"),
            "aMethod",
            Collections.emptyList()
        )
    );
  }

  @Test
  public void onReceiveInvokeMethodOnUnpairedInstance() throws Exception {
    assertEquals(
        "return_value",
        testMessenger.onReceiveInvokeMethodOnUnpairedInstance(
            new NewUnpairedInstance("test_channel", Collections.emptyList()),
            "aMethod",
            Collections.emptyList()
        )
    );
  }

  @Test
  public void onReceiveDisposePair() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList()
    );
    testMessenger.onReceiveDisposeInstancePair(
        "test_channel",
        new PairedInstance("test_id")
    );
    assertFalse(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance)
    );
  }
}
