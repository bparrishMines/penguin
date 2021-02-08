package github.penguin.reference;

import org.junit.Before;
import org.junit.Test;

import java.util.Collections;

import github.penguin.reference.TestClasses.TestClass;
import github.penguin.reference.TestClasses.TestMessenger;
import github.penguin.reference.reference.InstanceConverter.StandardInstanceConverter;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairedInstance;

import static github.penguin.reference.ReferenceMatchers.isUnpairedInstance;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

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
        Collections.emptyList());

    assertEquals(new PairedInstance("test_id"),
        converter.convertForRemoteMessenger(testMessenger, testMessenger.testHandler.testClassInstance)
    );
  }

  @Test
  public void convertForRemoteManager_handlesUnpairedObject() {
    assertThat(converter.convertForRemoteMessenger(testMessenger, new TestClass(testMessenger)),
        isUnpairedInstance("test_channel", Collections.emptyList()));
  }

  @Test
  public void convertForRemoteManager_handlesNonPairableInstance() {
    assertEquals("potato", converter.convertForRemoteMessenger(testMessenger, "potato"));
  }

  @Test
  public void convertForLocalManager_handlesPairedInstance() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair(
        "test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList()
    );

    assertEquals(
        converter.convertForLocalMessenger(testMessenger, new PairedInstance("test_id")),
        testMessenger.testHandler.testClassInstance
    );
  }

  @Test
  public void convertForLocalManager_handlesNewUnpairedInstance() throws Exception {
    assertEquals(converter.convertForLocalMessenger(
        testMessenger,
        new NewUnpairedInstance("test_channel", Collections.emptyList())
        ),
        testMessenger.testHandler.testClassInstance);
  }
}
