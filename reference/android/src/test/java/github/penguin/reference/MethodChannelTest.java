package github.penguin.reference;

import static github.penguin.reference.ReferenceMatchers.isClassTemplate;
import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static github.penguin.reference.ReferenceMatchers.isRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedReference;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import github.penguin.reference.templates.$TemplateReferencePairManager.ClassTemplate;
import github.penguin.reference.templates.PluginTemplate.ReferencePairManagerTemplate;
import github.penguin.reference.templates.ClassTemplateImpl;
import io.flutter.plugin.common.BinaryMessenger.BinaryMessageHandler;
import io.flutter.plugin.common.BinaryMessenger.BinaryReply;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import org.hamcrest.Matcher;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class MethodChannelTest {
  private static final List<MethodCall> methodCallLog = new ArrayList<>();
  private static final List<Object> replyMethodCallLog = new ArrayList<>();

  private static MockBinaryMessenger mockMessenger;
  private static MethodChannel.MethodCallHandler methodCallHandler;
  private static ReferencePairManagerTemplate referencePairManager;

  @BeforeClass
  public static void setUpAll() {
    mockMessenger =
        new MockBinaryMessenger(
            new BinaryMessageHandler() {
              @Override
              public void onMessage(
                  @Nullable ByteBuffer message, @NonNull final BinaryReply reply) {
                Objects.requireNonNull(message).position(0);
                final MethodCall methodCall =
                    referencePairManager.methodCodec.decodeMethodCall(message);
                methodCallLog.add(methodCall);
                methodCallHandler.onMethodCall(
                    methodCall,
                    new MethodChannel.Result() {
                      @Override
                      public void success(@Nullable Object result) {
                        reply.reply(referencePairManager.methodCodec.encodeSuccessEnvelope(result));
                      }

                      @Override
                      public void error(
                          String errorCode,
                          @Nullable String errorMessage,
                          @Nullable Object errorDetails) {
                        reply.reply(
                            referencePairManager.methodCodec.encodeErrorEnvelope(
                                errorCode, errorMessage, errorDetails));
                      }

                      @Override
                      public void notImplemented() {}
                    });
              }
            },
            new BinaryReply() {
              @Override
              public void reply(@Nullable ByteBuffer reply) {
                Objects.requireNonNull(reply).position(0);
                replyMethodCallLog.add(referencePairManager.methodCodec.decodeEnvelope(reply));
              }
            });

    methodCallHandler =
        new MethodChannel.MethodCallHandler() {
          @SuppressWarnings("unchecked")
          @Override
          public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            if ("REFERENCE_METHOD".equals(call.method)) {
              final List<Object> arguments = (List<Object>) call.arguments;
              if (arguments.get(1).equals("methodTemplate")) {
                result.success("pine" + ((List<Object>) arguments.get(2)).get(0));
              }
            } else {
              result.success(null);
            }
          }
        };
  }

  @Before
  public void setUp() {
    methodCallLog.clear();
    replyMethodCallLog.clear();
    referencePairManager = new ReferencePairManagerTemplate(mockMessenger);
    referencePairManager.initialize();
  }

  @Test
  public void referenceMessageCodec_handlesRemoteReference() {
    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall("ewoif",
                new RemoteReference("hi"))
        );

    assertThat(referencePairManager.methodCodec.decodeMethodCall((ByteBuffer) message.position(0)),
        isMethodCall("ewoif",
            new RemoteReference("hi")));
  }

  @Test
  public void referenceMessageCodec_handlesUnpairedRemoteReference() {
    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall("ewoif",
                new UnpairedReference(1, Collections.emptyList(), "apple"))
        );

    assertThat(referencePairManager.methodCodec.decodeMethodCall((ByteBuffer) message.position(0)),
        isMethodCall("ewoif",
            isUnpairedReference(1, empty(), "apple")));
  }

  @Test
  public void methodChannelReferencePairManager_pairWithNewRemoteReference() {
    final ClassTemplateImpl classTemplate = new ClassTemplateImpl(23);

    referencePairManager.pairWithNewRemoteReference(classTemplate);

    final RemoteReference remoteReference = referencePairManager.getPairedRemoteReference(classTemplate);
    assertNotNull(remoteReference);
    assertNotNull(remoteReference.referenceId);
    assertEquals(referencePairManager.getPairedLocalReference(remoteReference), classTemplate);
    assertThat(
        methodCallLog,
        contains(
            isMethodCall(
                "REFERENCE_CREATE",
                contains(
                    isRemoteReference(remoteReference.referenceId),
                    equalTo(0),
                    contains(equalTo(23))))));
  }

  @Test
  public void methodChannelReferencePairManager_disposePairWithLocalReference() {
    final ClassTemplate classTemplate = new ClassTemplateImpl(23);

    referencePairManager.pairWithNewRemoteReference(classTemplate);
    assertNotNull(referencePairManager.getPairedRemoteReference(classTemplate));
    methodCallLog.clear();

    final RemoteReference remoteReference = referencePairManager.getPairedRemoteReference(classTemplate);

    referencePairManager.disposePairWithLocalReference(classTemplate);

    assertNull(referencePairManager.getPairedLocalReference(remoteReference));
    assertNull(referencePairManager.getPairedRemoteReference(classTemplate));
    assertThat(methodCallLog, contains(isMethodCall("REFERENCE_DISPOSE", remoteReference)));
  }

  @Test
  public void methodChannelReferencePairManager_invokeRemoteMethod() throws Exception {
    final ClassTemplate classTemplate =
        new ClassTemplateImpl(23).setReferencePairManager(referencePairManager);

    referencePairManager.pairWithNewRemoteReference(classTemplate);
    final RemoteReference remoteReference = referencePairManager.getPairedRemoteReference(classTemplate);
    assertNotNull(remoteReference);
    methodCallLog.clear();

    final List<Object> results = new ArrayList<>();

    @SuppressWarnings("unchecked")
    final CompletableRunnable<Object> runnable =
        (CompletableRunnable<Object>) classTemplate.methodTemplate("apple");
    runnable.setOnCompleteListener(
        new CompletableRunnable.OnCompleteListener() {
          @Override
          public void onComplete(Object result) {
            results.add(result);
          }

          @Override
          public void onError(Throwable throwable) {}
        });

    assertEquals(results.get(0), "pineapple");
    assertThat(
        methodCallLog,
        contains(
            isMethodCall(
                "REFERENCE_METHOD",
                contains(
                    isRemoteReference(remoteReference.referenceId),
                    equalTo("methodTemplate"),
                    contains(equalTo("apple"))))));
  }

  @Test
  public void methodChannelReferencePairManager_invokeRemoteMethodOnUnpairedReference() throws Exception {
    final ClassTemplate classTemplate =
        new ClassTemplateImpl(24).setReferencePairManager(referencePairManager);

    final List<Object> results = new ArrayList<>();

    @SuppressWarnings("unchecked")
    final CompletableRunnable<Object> runnable =
        (CompletableRunnable<Object>) classTemplate.methodTemplate("apple");
    runnable.setOnCompleteListener(
        new CompletableRunnable.OnCompleteListener() {
          @Override
          public void onComplete(Object result) {
            results.add(result);
          }

          @Override
          public void onError(Throwable throwable) {}
        });

    assertEquals(results.get(0), "pineapple");
    assertThat(
        methodCallLog,
        contains(
            isMethodCall(
                "REFERENCE_METHOD",
                contains(
                    isUnpairedReference(0, contains(equalTo(24)), null),
                    equalTo("methodTemplate"),
                    contains(equalTo("apple"))))));
  }

  @SuppressWarnings("RedundantThrows")
  @Test
  public void methodChannelReferencePairManager_pairWithNewLocalReference() throws Exception {
    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_CREATE",
                Arrays.asList(
                    new RemoteReference("table"),
                    0,
                    Collections.singletonList(32))));
    mockMessenger.receive("github.penguin/reference", message);

    final ClassTemplate classTemplate =
        (ClassTemplate) referencePairManager.getPairedLocalReference(new RemoteReference("table"));
    assertThat(
        classTemplate,
        isClassTemplate(32));
  }

  @SuppressWarnings({"RedundantThrows", "rawtypes"})
  @Test
  public void methodChannelReferencePairManager_invokeLocalMethod() throws Exception {
    final TestClassTemplate classTemplate = new TestClassTemplate();
    referencePairManager.pairWithNewRemoteReference(classTemplate);

    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_METHOD",
                Arrays.asList(
                    referencePairManager.getPairedRemoteReference(classTemplate),
                    "methodTemplate",
                    Collections.singletonList("Goku"))));
    mockMessenger.receive("github.penguin/reference", message);

    assertThat(replyMethodCallLog, contains((Matcher) equalTo("tornado")));
    assertThat(
        classTemplate.lastMethodTemplateArguments,
        (Matcher) contains(equalTo("Goku")));
  }

  @SuppressWarnings({"RedundantThrows", "rawtypes"})
  @Test
  public void methodChannelReferencePairManager_invokeLocalMethodOnUnpairedReference() throws Exception {
    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_METHOD",
                Arrays.asList(
                    new UnpairedReference(0, Collections.singletonList((Object) 18)),
                    "methodTemplate",
                    Collections.singletonList("Goku"))));
    mockMessenger.receive("github.penguin/reference", message);

    assertThat(
        methodCallLog,
        contains(
            isMethodCall(
                "REFERENCE_METHOD",
                contains(
                    isUnpairedReference(0, contains(equalTo(24)), null),
                    equalTo("methodTemplate"),
                    contains(equalTo("apple"))))));
  }

  @Test
  public void methodChannelReferencePairManager_disposePairWithRemoteReference() {
    final ByteBuffer createMessage =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_CREATE",
                Arrays.asList(
                    new RemoteReference("animal"),
                    0,
                    Collections.singletonList(32))));
    mockMessenger.receive("github.penguin/reference", createMessage);
    assertThat(
        referencePairManager.getPairedLocalReference(new RemoteReference("animal")), notNullValue());

    final ByteBuffer disposeMessage =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall("REFERENCE_DISPOSE", new RemoteReference("animal")));
    mockMessenger.receive("github.penguin/reference", disposeMessage);
    assertThat(referencePairManager.getPairedLocalReference(new RemoteReference("animal")), nullValue());
  }
}
