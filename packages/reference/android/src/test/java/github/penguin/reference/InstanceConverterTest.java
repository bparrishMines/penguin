package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestMessenger;
import github.penguin.reference.reference.InstanceConverter.StandardInstanceConverter;
import github.penguin.reference.reference.PairedInstance;

import static org.junit.Assert.assertEquals;

public class InstanceConverterTest {
  private static final StandardInstanceConverter converter = new StandardInstanceConverter();
  private static TestMessenger testMessenger;

  @Before
  public void setUp() {
    testMessenger = new TestMessenger();
  }

  @Test
  public void convertForRemoteManager_handlesPairedObject()
      throws Exception {
    testMessenger.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(), true);

    assertEquals(new PairedInstance("test_id"),
        converter.convertForRemoteMessenger(testMessenger, testMessenger.testHandler.testClassInstance)
    );
  }

  @Test
  public void convertForRemoteManager_handlesUnpairedObject() {
    assertEquals("potato", converter.convertForRemoteMessenger(testMessenger, "potato"));
  }

  @Test
  public void convertForLocalManager_handlesPairedInstance() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(), true
    );

    assertEquals(
        converter.convertForLocalMessenger(testMessenger, new PairedInstance("test_id")),
        testMessenger.testHandler.testClassInstance
    );
  }

  @Test
  public void convertForLocalManager_handlesNewUnpairedObject() {
    assertEquals("potato", converter.convertForLocalMessenger(testMessenger, "potato"));
  }
}
