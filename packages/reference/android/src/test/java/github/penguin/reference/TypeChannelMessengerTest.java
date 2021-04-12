package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestMessenger;
import github.penguin.reference.reference.PairedInstance;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
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
            Collections.emptyList(), true
        ),
        testMessenger.testHandler.testClassInstance
    );
    assertTrue(testMessenger.isPaired(testMessenger.testHandler.testClassInstance));
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
  public void onReceiveInvokeMethod() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(), true
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
  public void onReceiveDisposePair() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(),
        true
    );
    testMessenger.onReceiveDisposeInstancePair(new PairedInstance("test_id"));
    assertFalse(testMessenger.isPaired(testMessenger.testHandler.testClassInstance));
  }
}
