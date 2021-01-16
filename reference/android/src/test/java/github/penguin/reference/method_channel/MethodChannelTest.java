package github.penguin.reference.method_channel;

import org.junit.Before;
import org.junit.Test;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static github.penguin.reference.ReferenceMatchers.isUnpairedInstance;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairableInstance;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelManager;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public class MethodChannelTest {
  private static final ReferenceMessageCodec messageCodec = new ReferenceMessageCodec();
  private static final MethodCodec methodCodec = new StandardMethodCodec(messageCodec);

  private static TestManager testManager;
  private static TypeChannel<TestClass> testChannel;

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
          public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) { }

          @Override
          public void notImplemented() { }
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

  private static class TestManager extends MethodChannelManager {
    private final TestBinaryMessenger testMessenger;
    private final TestHandler testHandler;

    private TestManager() {
      super(new TestBinaryMessenger(), "test_method_channel");
      this.testMessenger = (TestBinaryMessenger) binaryMessenger;
      this.testHandler = new TestHandler(this);
      registerHandler("test_channel", testHandler);
    }

    @Override
    public String generateUniqueInstanceId() {
      return "test_instance_id";
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

  private static class TestListener<T> implements Completable.OnCompleteListener<T> {
    T result;

    @Override
    public void onComplete(T result) {
      this.result = result;
    }

    @Override
    public void onError(Throwable throwable) { }
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

  @Before
  public void setUp() {
    testManager = new TestManager();
    testChannel = new TypeChannel<>(testManager, "test_channel");
  }

  @Test
  public void referenceMessageCodec_encodeAndDecodePairedInstance() {
    final ByteBuffer message = messageCodec.encodeMessage(new PairedInstance("hi"));

    assertNotNull(message);
    assertEquals(
        messageCodec.decodeMessage((ByteBuffer) message.position(0)), new PairedInstance("hi"));
  }

  @Test
  public void referenceMessageCodec_encodeAndDecodeNewUnpairedInstance() {
    final ByteBuffer message =
        messageCodec.encodeMessage(new NewUnpairedInstance("test_channel", Collections.emptyList()));

    assertNotNull(message);
    assertThat(
        messageCodec.decodeMessage((ByteBuffer) message.position(0)),
        isUnpairedInstance("test_channel", Collections.emptyList()));
  }

  @Test
  public void methodChannelManager_onReceiveCreateNewInstancePair() {
    final List<Object> arguments = Arrays.asList("test_channel", new PairedInstance("test_instance_id"), Collections.emptyList());
    final MethodCall methodCall = new MethodCall("REFERENCE_CREATE", arguments);
    testManager.testMessenger.handlePlatformMessage(
        "test_method_channel",
        methodCodec.encodeMethodCall(methodCall), null);

    assertTrue(testManager.isPaired(testManager.testHandler.testClassInstance));
  }

  @Test
  public void methodChannelManager_onReceiveInvokeStaticMethod() {
    final List<Object> arguments = Arrays.asList("test_channel", "aStaticMethod", Collections.emptyList());
    final MethodCall methodCall = new MethodCall("REFERENCE_STATIC_METHOD", arguments);

    final TestResult testResult = new TestResult();
    testManager.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall), testResult);
    assertEquals("return_value", testResult.result);
  }

  @Test
  public void methodChannelManager_onReceiveInvokeMethod() throws Exception {
    testManager.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList());

    final List<Object> arguments = Arrays.asList("test_channel",
        new PairedInstance("test_id"),
        "aMethod",
        Collections.emptyList());
    final MethodCall methodCall = new MethodCall("REFERENCE_METHOD", arguments);

    final TestResult testResult = new TestResult();
    testManager.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall), testResult);

    assertEquals("return_value", testResult.result);
  }

  @Test
  public void methodChannelManager_onReceiveInvokeMethodOnUnpairedInstance() {
    final List<Object> arguments = Arrays.asList(
        new NewUnpairedInstance("test_channel", Collections.emptyList()),
        "aMethod",
        Collections.emptyList());
    final MethodCall methodCall = new MethodCall("REFERENCE_UNPAIRED_METHOD", arguments);

    final TestResult testResult = new TestResult();
    testManager.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall), testResult);

    assertEquals("return_value", testResult.result);
  }

  @Test
  public void methodChannelManager_onReceiveDisposePair() throws Exception {
    testManager.onReceiveCreateNewInstancePair("test_channel",
        new PairedInstance("test_id"),
        Collections.emptyList());

    final List<Object> arguments = Arrays.asList("test_channel", new PairedInstance("test_id"));
    final MethodCall methodCall = new MethodCall("REFERENCE_DISPOSE", arguments);

    testManager.testMessenger.handlePlatformMessage("test_method_channel",
        methodCodec.encodeMethodCall(methodCall),
        null);

    assertFalse(testManager.isPaired(testManager.testHandler.testClassInstance));
  }

  @Test
  public void methodChannelMessenger_createNewPair() {
    testChannel.createNewInstancePair(new TestClass(testManager));

    final List<MethodCall> methodCalls = testManager.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_CREATE",
            Arrays.asList("test_channel",
                new PairedInstance("test_instance_id")
                , Collections.emptyList())));
  }

  @Test
  public void methodChannelMessenger_sendInvokeStaticMethod() {
    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeStaticMethod("aStaticMethod", Collections.emptyList()).setOnCompleteListener(testListener);

    assertEquals("return_value", testListener.result);

    final List<MethodCall> methodCalls = testManager.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_STATIC_METHOD",
            Arrays.asList("test_channel",
                "aStaticMethod"
                , Collections.emptyList())));
  }

  @Test
  public void methodChannelMessenger_sendInvokeMethod() {
    final TestClass testClass = new TestClass(testManager);
    testChannel.createNewInstancePair(testClass);
    testManager.testMessenger.methodCalls.clear();

    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeMethod(testClass,"aMethod", Collections.emptyList()).setOnCompleteListener(testListener);

    assertEquals("return_value", testListener.result);

    final List<MethodCall> methodCalls = testManager.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_METHOD",
            Arrays.asList("test_channel",
                new PairedInstance("test_instance_id"),
                "aMethod"
                , Collections.emptyList())));
  }

  @Test
  public void methodChannelMessenger_sendInvokeMethodOnUnpairedReference() {
    final TestListener<Object> testListener = new TestListener<>();
    testChannel.invokeMethod(new TestClass(testManager),
        "aMethod",
        Collections.emptyList()).setOnCompleteListener(testListener);

    assertEquals("return_value", testListener.result);

    final List<MethodCall> methodCalls = testManager.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_UNPAIRED_METHOD",
            contains(isUnpairedInstance("test_channel",
                Collections.emptyList()),
                equalTo("aMethod"),
                equalTo(Collections.emptyList()))));
  }

  @Test
  public void methodChannelMessenger_disposePair() {
    final TestClass testClass = new TestClass(testManager);
    testChannel.createNewInstancePair(testClass);
    testManager.testMessenger.methodCalls.clear();


    testChannel.disposePair(testClass);
    final List<MethodCall> methodCalls = testManager.testMessenger.methodCalls;
    assertEquals(1, methodCalls.size());
    assertThat(methodCalls.get(0),
        isMethodCall("REFERENCE_DISPOSE",
            Arrays.asList("test_channel",
                new PairedInstance("test_instance_id"))));
  }
}
