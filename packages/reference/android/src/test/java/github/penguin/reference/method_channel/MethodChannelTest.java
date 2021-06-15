package github.penguin.reference.method_channel;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.junit.Before;
import org.junit.Test;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import github.penguin.reference.TestClasses.TestInstanceManager;
import github.penguin.reference.TestClasses.TestClass;
import github.penguin.reference.TestClasses.TestHandler;
import github.penguin.reference.TestClasses.TestListener;
import github.penguin.reference.reference.InstanceManager;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;

import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class MethodChannelTest {
  private static final ReferenceMessageCodec messageCodec = new ReferenceMessageCodec();
  private static final MethodCodec methodCodec = new StandardMethodCodec(messageCodec);

  private static TestMessenger testMessenger;
  private static TypeChannel<TestClass> testChannel;

  @Before
  public void setUp() {
    testMessenger = new TestMessenger();
    testChannel = new TypeChannel<>(testMessenger, "test_channel");
  }

  @Test
  public void referenceMessageCodec_encodeAndDecodePairedInstance() {
    final ByteBuffer message = messageCodec.encodeMessage(new PairedInstance("hi"));

    assertNotNull(message);
    assertEquals(
        messageCodec.decodeMessage((ByteBuffer) message.position(0)), new PairedInstance("hi"));
  }

  @Test
  public void methodChannelManager_onReceiveCreateNewInstancePair() {
    final List<Object> arguments = Arrays.asList("test_channel", new PairedInstance("test_instance_id"), Collections.emptyList(), true);
    final MethodCall methodCall = new MethodCall("REFERENCE_CREATE", arguments);
    testMessenger.testMessenger.handlePlatformMessage(
        "test_method_channel",
        methodCodec.encodeMethodCall(methodCall), null);

    assertTrue(testMessenger.isPaired(testMessenger.testHandler.testClassInstance));
  }

  @Test
  public void methodChannelManager_onReceiveInvokeStaticMethod() {
    final List<Object> arguments = Arrays.asList("test_channel", "aStaticMethod", Collections.emptyList());
    final MethodCall methodCall = new MethodCall("REFERENCE_STATIC_METHOD", arguments);

    final TestResult testResult = new TestResult();
    testMessenger.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall), testResult);
    assertEquals("return_value", testResult.result);
  }

  @Test
  public void methodChannelManager_onReceiveInvokeMethod() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(), true);

    final List<Object> arguments = Arrays.asList("test_channel",
        new PairedInstance("test_id"),
        "aMethod",
        Collections.emptyList(), true);
    final MethodCall methodCall = new MethodCall("REFERENCE_METHOD", arguments);

    final TestResult testResult = new TestResult();
    testMessenger.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall), testResult);

    assertEquals("return_value", testResult.result);
  }

  @Test
  public void methodChannelManager_onReceiveDisposeInstancePair() throws Exception {
    testMessenger.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList(), true);

    final List<Object> arguments = Collections.singletonList((Object) new PairedInstance("test_id"));
    final MethodCall methodCall = new MethodCall("REFERENCE_DISPOSE", arguments);

    testMessenger.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall),
        null);

    assertFalse(testMessenger.isPaired(testMessenger.testHandler.testClassInstance));
  }

  @Test
  public void methodChannelMessenger_createNewInstancePair() {
    testChannel.createNewInstancePair(new TestClass(), Collections.emptyList(),true);

    final List<MethodCall> methodCalls = testMessenger.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_CREATE",
            Arrays.asList("test_channel",
                new PairedInstance("test_instance_id")
                , Collections.emptyList(), false)));
  }

  @Test
  public void methodChannelMessenger_sendInvokeStaticMethod() {
    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeStaticMethod("aStaticMethod", Collections.emptyList()).setOnCompleteListener(testListener);

    assertEquals("return_value", testListener.result);

    final List<MethodCall> methodCalls = testMessenger.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_STATIC_METHOD",
            Arrays.asList("test_channel",
                "aStaticMethod"
                , Collections.emptyList())));
  }

  @Test
  public void methodChannelMessenger_sendInvokeMethod() {
    final TestClass testClass = new TestClass();
    testChannel.createNewInstancePair(testClass, Collections.emptyList(),true);
    testMessenger.testMessenger.methodCalls.clear();

    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeMethod(testClass, "aMethod", Collections.emptyList()).setOnCompleteListener(testListener);

    assertEquals("return_value", testListener.result);

    final List<MethodCall> methodCalls = testMessenger.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_METHOD",
            Arrays.asList("test_channel",
                new PairedInstance("test_instance_id"),
                "aMethod"
                , Collections.emptyList())));
  }

  @Test
  public void methodChannelMessenger_disposeInstancePair() {
    final TestClass testClass = new TestClass();
    testChannel.createNewInstancePair(testClass, Collections.emptyList(),true);
    testMessenger.testMessenger.methodCalls.clear();

    testChannel.disposeInstancePair(testClass);
    final List<MethodCall> methodCalls = testMessenger.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_DISPOSE",
            Collections.singletonList(
                new PairedInstance("test_instance_id"))));
  }

  private static class TestMethodCallHandler implements MethodChannel.MethodCallHandler {
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
      final List<Object> arguments = call.arguments();
      if (call.method.equals("REFERENCE_METHOD") && arguments.get(2).equals("aMethod")) {
        result.success("return_value");
      } else if (call.method.equals("REFERENCE_STATIC_METHOD") && arguments.get(1).equals("aStaticMethod")) {
        result.success("return_value");
      } else if (call.method.equals("REFERENCE_UNPAIRED_METHOD") && arguments.get(1).equals("aMethod")) {
        result.success("return_value");
      } else {
        result.success(null);
      }
    }
  }

  private static class TestBinaryMessenger implements BinaryMessenger {
    private final List<MethodCall> methodCalls = new ArrayList<>();
    private final Map<String, BinaryMessageHandler> handlers = new HashMap<>();
    private final TestMethodCallHandler testMethodCallHandler = new TestMethodCallHandler();

    @Override
    public void send(@NonNull String channel, @Nullable ByteBuffer message) {
      send(channel, message, null);
    }

    @Override
    public void send(@NonNull String channel, @Nullable ByteBuffer message, @Nullable final BinaryReply callback) {
      if (channel.equals("test_method_channel")) {
        final MethodCall methodCall = methodCodec.decodeMethodCall((ByteBuffer) message.position(0));
        methodCalls.add(methodCall);
        testMethodCallHandler.onMethodCall(methodCall, new MethodChannel.Result() {
          @Override
          public void success(@Nullable Object result) {
            if (callback != null) {
              callback.reply((ByteBuffer) methodCodec.encodeSuccessEnvelope(result).position(0));
            }
          }

          @Override
          public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
          }

          @Override
          public void notImplemented() {
          }
        });
      }
    }

    @Override
    public void setMessageHandler(@NonNull String channel, @Nullable BinaryMessageHandler handler) {
      if (handler == null) throw new AssertionError();
      handlers.put(channel, handler);
    }

    public void handlePlatformMessage(String channel, final ByteBuffer message, @Nullable final MethodChannel.Result result) {
      final BinaryMessageHandler handler = handlers.get(channel);
      if (handler != null) {
        handler.onMessage((ByteBuffer) message.position(0), new BinaryReply() {
          @Override
          public void reply(@Nullable ByteBuffer reply) {
            if (result != null && reply != null) {
              result.success(methodCodec.decodeEnvelope((ByteBuffer) reply.position(0)));
            }
          }
        });
      }
    }
  }

  private static class TestMessenger extends MethodChannelMessenger {
    public final TestInstanceManager testInstancePairManager = new TestInstanceManager();
    public final TestBinaryMessenger testMessenger;
    public final TestHandler testHandler = new TestHandler();

    private TestMessenger() {
      super(new TestBinaryMessenger(), "test_method_channel");
      this.testMessenger = (TestBinaryMessenger) binaryMessenger;
      registerHandler("test_channel", testHandler);
    }

    @NonNull
    @Override
    public InstanceManager getInstanceManager() {
      return testInstancePairManager;
    }
  }

  private static class TestResult implements MethodChannel.Result {
    private Object result;

    @Override
    public void success(@Nullable Object result) {
      this.result = result;
    }

    @Override
    public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {

    }

    @Override
    public void notImplemented() {

    }
  }
}
