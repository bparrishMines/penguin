package github.penguin.reference;

import static github.penguin.reference.ReferenceMatchers.isClassTemplate;
import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static github.penguin.reference.ReferenceMatchers.isRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedRemoteReference;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
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
              } else if (arguments.get(1).equals("returnsReference")) {
                result.success(
                    new UnpairedRemoteReference(
                        0, Arrays.asList((Object) 123, null, null, null)));
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
                new UnpairedRemoteReference(1, Collections.emptyList()))
        );

    assertThat(referencePairManager.methodCodec.decodeMethodCall((ByteBuffer) message.position(0)),
        isMethodCall("ewoif",
            isUnpairedRemoteReference(1, empty())));
  }

  @Test
  public void referencePairManager_createRemoteReferenceFor() {
    final ClassTemplateImpl classTemplate = new ClassTemplateImpl(23);

    referencePairManager.createRemoteReferenceFor(classTemplate);

    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);
    assertNotNull(remoteReference);
    assertNotNull(remoteReference.referenceId);
    assertEquals(referencePairManager.localReferenceFor(remoteReference), classTemplate);
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
  public void referencePairManager_disposeRemoteReferenceFor() {
    final ClassTemplate classTemplate = new ClassTemplateImpl(23);

    referencePairManager.createRemoteReferenceFor(classTemplate);
    assertNotNull(referencePairManager.remoteReferenceFor(classTemplate));
    methodCallLog.clear();

    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);

    referencePairManager.disposeRemoteReferenceFor(classTemplate);

    assertNull(referencePairManager.localReferenceFor(remoteReference));
    assertNull(referencePairManager.remoteReferenceFor(classTemplate));
    assertThat(methodCallLog, contains(isMethodCall("REFERENCE_DISPOSE", remoteReference)));
  }

  @Test
  public void referencePairManager_executeRemoteMethodFor() throws Exception {
    final ClassTemplate classTemplate =
        new ClassTemplateImpl(23).setReferencePairManager(referencePairManager);

    referencePairManager.createRemoteReferenceFor(classTemplate);
    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);
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

  @SuppressWarnings("RedundantThrows")
  @Test
  public void referencePairManager_createLocalReferenceFor() throws Exception {
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
        (ClassTemplate) referencePairManager.localReferenceFor(new RemoteReference("table"));
    assertThat(
        classTemplate,
        isClassTemplate(32));
  }

  @SuppressWarnings({"RedundantThrows", "rawtypes"})
  @Test
  public void referencePairManager_executeLocalMethodFor() throws Exception {
    final TestClassTemplate classTemplate = new TestClassTemplate();
    referencePairManager.createRemoteReferenceFor(classTemplate);

    final ByteBuffer message =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall(
                "REFERENCE_METHOD",
                Arrays.asList(
                    referencePairManager.remoteReferenceFor(classTemplate),
                    "methodTemplate",
                    Collections.singletonList("Goku"))));
    mockMessenger.receive("github.penguin/reference", message);

    assertThat(replyMethodCallLog, contains((Matcher) equalTo("tornado")));
    assertThat(
        classTemplate.lastMethodTemplateArguments,
        (Matcher) contains(equalTo("Goku")));
  }

  @Test
  public void referencePairManager_disposeLocalReference() {
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
        referencePairManager.localReferenceFor(new RemoteReference("animal")), notNullValue());

    final ByteBuffer disposeMessage =
        referencePairManager.methodCodec.encodeMethodCall(
            new MethodCall("REFERENCE_DISPOSE", new RemoteReference("animal")));
    mockMessenger.receive("github.penguin/reference", disposeMessage);
    assertThat(referencePairManager.localReferenceFor(new RemoteReference("animal")), nullValue());
  }
}
