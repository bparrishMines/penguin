package github.penguin.reference;

import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static github.penguin.reference.ReferenceMatchers.isRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedReference;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.isA;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import androidx.annotation.Nullable;
import github.penguin.reference.method_channel.MethodChannelManager;
import github.penguin.reference.method_channel.MethodChannelMessenger;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.NewUnpairedInstance;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.BinaryMessenger.BinaryMessageHandler;
import io.flutter.plugin.common.BinaryMessenger.BinaryReply;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

public class MethodChannelTest {
  private static final ReferenceMessageCodec messageCodec = new ReferenceMessageCodec();
  private static final MethodCodec methodCodec = new StandardMethodCodec(messageCodec);
  private static TestTypePairManager testManager;

  private static class TestClass {
    @Override
    public Class<? extends LocalReference> getReferenceClass() {
      return TestClass.class;
    }
  }

  private static class TestRemoteHandler extends MethodChannelMessenger {
    private TestRemoteHandler() {
      super(mock(BinaryMessenger.class), "test_channel");
    }

    @Override
    public List<Object> getCreationArguments(LocalReference localReference) {
      return Collections.emptyList();
    }
  }

  private static class TestTypePairManager extends MethodChannelManager {
    private final LocalReferenceCommunicationHandler localHandler;
    private final TestRemoteHandler remoteHandler;

    private TestTypePairManager() {
      super(
          Collections.<Class<? extends LocalReference>>singletonList(TestClass.class),
          mock(BinaryMessenger.class),
          "test_channel");
      this.localHandler = mock(LocalReferenceCommunicationHandler.class);
      this.remoteHandler = new TestRemoteHandler();
    }

    @Override
    public TestRemoteHandler getRemoteHandler() {
      return remoteHandler;
    }

    @Override
    public LocalReferenceCommunicationHandler getLocalHandler() {
      return localHandler;
    }
  }

  private static MethodCall getRemoteHandlerMethodCall() {
    final ArgumentCaptor<ByteBuffer> byteBufferCaptor = ArgumentCaptor.forClass(ByteBuffer.class);
    verify(testManager.remoteHandler.binaryMessenger)
        .send(eq("test_channel"), byteBufferCaptor.capture(), any(BinaryReply.class));

    return methodCodec.decodeMethodCall((ByteBuffer) byteBufferCaptor.getValue().position(0));
  }

  private static BinaryMessageHandler getBinaryMessageHandler() {
    final ArgumentCaptor<BinaryMessageHandler> handlerCaptor =
        ArgumentCaptor.forClass(BinaryMessageHandler.class);
    verify(testManager.binaryMessenger)
        .setMessageHandler(eq("test_channel"), handlerCaptor.capture());

    return handlerCaptor.getValue();
  }

  @Before
  public void setUp() {
    testManager = new TestTypePairManager();
    testManager.initialize();
  }

  @Test
  public void referenceMessageCodec_encodeAndDecodeRemoteReference() {
    final ByteBuffer message = messageCodec.encodeMessage(new PairedInstance("hi"));

    assertNotNull(message);
    assertEquals(
        messageCodec.decodeMessage((ByteBuffer) message.position(0)), new PairedInstance("hi"));
  }

  @Test
  public void referenceMessageCodec_encodeAndDecodeUnpairedRemoteReference() {
    final ByteBuffer message =
        messageCodec.encodeMessage(new NewUnpairedInstance(1, Collections.emptyList(), "apple"));

    assertNotNull(message);
    assertThat(
        messageCodec.decodeMessage((ByteBuffer) message.position(0)),
        isUnpairedReference(1, empty(), "apple"));
  }

  @Test
  public void methodChannelReferencePairManager_pairWithNewRemoteReference() {
    final TestClass testClass = new TestClass();

    testManager.pairWithNewRemoteReference(testClass);
    final PairedInstance pairedInstance = testManager.getPairedRemoteReference(testClass);

    assertThat(
        getRemoteHandlerMethodCall(),
        isMethodCall(
            "REFERENCE_CREATE",
            contains(isRemoteReference(pairedInstance.referenceId), equalTo(0), empty())));
  }

  @Test
  public void methodChannelReferencePairManager_invokeRemoteStaticMethod() {
    testManager.invokeRemoteStaticMethod(TestClass.class, "aStaticMethod", Collections.emptyList());
    assertThat(
        getRemoteHandlerMethodCall(),
        isMethodCall(
            "REFERENCE_STATIC_METHOD", contains(0, "aStaticMethod", Collections.emptyList())));
  }

  @Test
  public void methodChannelReferencePairManager_invokeRemoteMethod() {
    final TestClass testClass = new TestClass();

    testManager.pairWithNewRemoteReference(testClass);
    final PairedInstance pairedInstance = testManager.getPairedRemoteReference(testClass);

    reset(testManager.remoteHandler.binaryMessenger);
    testManager.invokeRemoteMethod(pairedInstance, "aMethod", Collections.emptyList());

    assertThat(
        getRemoteHandlerMethodCall(),
        isMethodCall(
            "REFERENCE_METHOD",
            contains(isRemoteReference(pairedInstance.referenceId), equalTo("aMethod"), empty())));
  }

  @Test
  public void methodChannelReferencePairManager_invokeRemoteMethodOnUnpairedReference() {
    final TestClass testClass = new TestClass();
    testManager.invokeRemoteMethodOnUnpairedReference(
        testClass, "aMethod", Collections.emptyList());

    assertThat(
        getRemoteHandlerMethodCall(),
        isMethodCall(
            "REFERENCE_METHOD",
            contains(isUnpairedReference(0, empty(), null), equalTo("aMethod"), empty())));
  }

  @Test
  public void methodChannelReferencePairManager_disposePairWithLocalReference() {
    final TestClass testClass = new TestClass();

    testManager.pairWithNewRemoteReference(testClass);
    final PairedInstance pairedInstance = testManager.getPairedRemoteReference(testClass);

    reset(testManager.remoteHandler.binaryMessenger);
    testManager.disposePairWithLocalReference(testClass);

    assertThat(
        getRemoteHandlerMethodCall(),
        isMethodCall("REFERENCE_DISPOSE", isRemoteReference(pairedInstance.referenceId)));
  }

  @Test
  public void methodChannelReferencePairManager_pairWithNewLocalReference() throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final ByteBuffer message =
        methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_CREATE",
                Arrays.asList(new PairedInstance("table"), 0, Collections.emptyList())));

    getBinaryMessageHandler()
        .onMessage(
            (ByteBuffer) message.position(0),
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {}
            });

    final TestClass testClass =
        (TestClass) testManager.getPairedLocalReference(new PairedInstance("table"));
    assertThat(testClass, isA(TestClass.class));
  }

  @Test
  public void methodChannelReferencePairManager_invokeLocalStaticMethod() throws Exception {
    final ByteBuffer message =
        methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_STATIC_METHOD",
                Arrays.asList(0, "aStaticMethod", Collections.emptyList())));

    getBinaryMessageHandler()
        .onMessage(
            (ByteBuffer) message.position(0),
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {}
            });

    verify(testManager.localHandler)
        .invokeStaticMethod(eq(testManager), eq(TestClass.class), eq("aStaticMethod"), anyList());
  }

  @Test
  public void methodChannelReferencePairManager_invokeLocalMethod() throws Exception {
    final TestClass testClass = new TestClass();
    testManager.pairWithNewRemoteReference(testClass);

    final ByteBuffer message =
        methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_METHOD",
                Arrays.asList(
                    testManager.getPairedRemoteReference(testClass),
                    "aMethod",
                    Collections.emptyList())));

    getBinaryMessageHandler()
        .onMessage(
            (ByteBuffer) message.position(0),
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {}
            });

    verify(testManager.localHandler)
        .invokeMethod(eq(testManager), eq(testClass), eq("aMethod"), anyList());
  }

  @Test
  public void methodChannelReferencePairManager_invokeLocalMethodOnUnpairedReference()
      throws Exception {
    when(testManager.localHandler.create(eq(testManager), eq(TestClass.class), anyList()))
        .thenReturn(new TestClass());

    final ByteBuffer message =
        methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_METHOD",
                Arrays.asList(
                    new NewUnpairedInstance(0, Collections.emptyList()),
                    "aMethod",
                    Collections.emptyList())));
    getBinaryMessageHandler()
        .onMessage(
            (ByteBuffer) message.position(0),
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {}
            });

    verify(testManager.localHandler)
        .invokeMethod(eq(testManager), any(TestClass.class), eq("aMethod"), anyList());
  }

  @Test
  public void methodChannelReferencePairManager_disposePairWithRemoteReference() throws Exception {
    final TestClass testClass = new TestClass();

    testManager.pairWithNewRemoteReference(testClass);
    final PairedInstance pairedInstance = testManager.getPairedRemoteReference(testClass);

    final ByteBuffer message =
        methodCodec.encodeMethodCall(new MethodCall("REFERENCE_DISPOSE", pairedInstance));
    getBinaryMessageHandler()
        .onMessage(
            (ByteBuffer) message.position(0),
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {}
            });

    verify(testManager.localHandler).dispose(testManager, testClass);
    assertNull(testManager.getPairedLocalReference(pairedInstance));
  }
}
