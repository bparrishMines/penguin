package github.penguin.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.common.collect.ImmutableMap;

import org.hamcrest.Matchers;
import org.hamcrest.collection.IsMapContaining;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.TypeReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
import github.penguin.reference.templates.GeneratedReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager.ClassTemplate;
import io.flutter.plugin.common.BinaryMessenger.BinaryMessageHandler;
import io.flutter.plugin.common.BinaryMessenger.BinaryReply;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static github.penguin.reference.ReferenceMatchers.isClassTemplate;
import static github.penguin.reference.ReferenceMatchers.isMethodCall;
import static github.penguin.reference.ReferenceMatchers.isRemoteReference;
import static github.penguin.reference.ReferenceMatchers.isTypeReference;
import static github.penguin.reference.ReferenceMatchers.isUnpairedRemoteReference;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertNull;

public class ReferencePairManagerTest {
  private static final List<MethodCall> methodCallLog = new ArrayList<>();
  private static final List<Object> replyMethodCallLog = new ArrayList<>();

  private static MockBinaryMessenger mockMessenger;
  private static MethodChannel.MethodCallHandler methodCallHandler;
  private static GeneratedReferencePairManager referencePairManager;

  @BeforeClass
  public static void setUpAll() {
    mockMessenger = new MockBinaryMessenger(new BinaryMessageHandler() {
      @Override
      public void onMessage(@Nullable ByteBuffer message, @NonNull final BinaryReply reply) {
        Objects.requireNonNull(message).position(0);
        final MethodCall methodCall = referencePairManager.methodCodec.decodeMethodCall(message);
        methodCallLog.add(methodCall);
        methodCallHandler.onMethodCall(methodCall, new MethodChannel.Result() {
          @Override
          public void success(@Nullable Object result) {
            reply.reply(referencePairManager.methodCodec.encodeSuccessEnvelope(result));
          }

          @Override
          public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
            reply.reply(referencePairManager.methodCodec.encodeErrorEnvelope(errorCode, errorMessage, errorDetails));
          }

          @Override
          public void notImplemented() {
          }
        });
      }
    }, new BinaryReply() {
      @Override
      public void reply(@Nullable ByteBuffer reply) {
        Objects.requireNonNull(reply).position(0);
        replyMethodCallLog.add(referencePairManager.methodCodec.decodeEnvelope(reply));
      }
    });

    methodCallHandler = new MethodChannel.MethodCallHandler() {
      @SuppressWarnings("unchecked")
      @Override
      public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch(call.method) {
          case "REFERENCE_METHOD": {
            final List<Object> arguments = (List<Object>) call.arguments;
            if (arguments.get(1).equals("methodTemplate")) {
              result.success("pine" + ((List<Object>) arguments.get(2)).get(0));
            } else if (arguments.get(1).equals("returnsReference")) {
              result.success(new UnpairedRemoteReference(new TypeReference(0), Arrays.asList((Object) 123, null, null, null)));
            }
          }
          break;
          default:
            result.success(null);
        }
      }
    };
  }

  @Before
  public void setUp() {
    methodCallLog.clear();
    replyMethodCallLog.clear();
    referencePairManager = new GeneratedReferencePairManager(
        mockMessenger,
        "reference_plugin",
        new GeneratedReferencePairManager.GeneratedLocalReferenceCommunicationHandler() {
          @Override
          public GeneratedReferencePairManager.ClassTemplate createClassTemplate(ReferencePairManager referencePairManager, int fieldTemplate, GeneratedReferencePairManager.ClassTemplate referenceFieldTemplate, List<GeneratedReferencePairManager.ClassTemplate> referenceListTemplate, Map<String, GeneratedReferencePairManager.ClassTemplate> referenceMapTemplate) throws Exception {
            return new ClassTemplateImpl(referencePairManager, fieldTemplate, referenceFieldTemplate, referenceListTemplate, referenceMapTemplate);
          }
        });
    referencePairManager.initialize();
  }

  @Test
  public void referencePairManager_createRemoteReferenceFor() {
    final ClassTemplateImpl classTemplate = new ClassTemplateImpl(
        referencePairManager,
        23,
        new ClassTemplateImpl(null, 11, null, null, null),
        Collections.singletonList((ClassTemplate) new ClassTemplateImpl(null, 13, null, null, null)),
        ImmutableMap.of("apple", (ClassTemplate) new ClassTemplateImpl(null, 43, null, null,null))
    );

    referencePairManager.createRemoteReferenceFor(classTemplate);

    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);
    assertNotNull(remoteReference);
    assertNotNull(remoteReference.referenceId);
    assertEquals(referencePairManager.localReferenceFor(remoteReference), classTemplate);
    assertThat(methodCallLog, contains(isMethodCall("REFERENCE_CREATE", contains(
        isRemoteReference(remoteReference.referenceId),
        isTypeReference(0),
        contains(
            equalTo(23),
            isUnpairedRemoteReference(new TypeReference(0), contains(11, null, null, null)),
            contains(isUnpairedRemoteReference(new TypeReference(0), contains(13, null, null, null))),
            new IsMapContaining<String, UnpairedRemoteReference>(equalTo("apple"), isUnpairedRemoteReference(new TypeReference(0), contains(43, null, null, null)))
        )
    ))));
  }

  @Test
  public void referencePairManager_disposeRemoteReferenceFor() {
    final ClassTemplate classTemplate = new ClassTemplateImpl(referencePairManager, 23, null, null, null);

    referencePairManager.createRemoteReferenceFor(classTemplate);
    assertNotNull(referencePairManager.remoteReferenceFor(classTemplate));
    methodCallLog.clear();

    final RemoteReference remoteReference =
        referencePairManager.remoteReferenceFor(classTemplate);

    referencePairManager.disposeRemoteReferenceFor(classTemplate);

    assertNull(referencePairManager.localReferenceFor(remoteReference));
    assertNull(referencePairManager.remoteReferenceFor(classTemplate));
    assertThat(methodCallLog, contains(isMethodCall("REFERENCE_DISPOSE", remoteReference)));
  }

  @Test
  public void referencePairManager_executeRemoteMethodFor() throws Exception {
    final ClassTemplate classTemplate = new ClassTemplateImpl(referencePairManager, 23, null, null, null);

    referencePairManager.createRemoteReferenceFor(classTemplate);
    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);
    assertNotNull(remoteReference);
    methodCallLog.clear();

    final List<Object> results = new ArrayList<>();

    classTemplate.methodTemplate(
        "apple",
        new ClassTemplateImpl(null, 11, null, null, null),
        Collections.singletonList((ClassTemplate) new ClassTemplateImpl(null, 13, null, null, null)),
        ImmutableMap.of("apple", (ClassTemplate) new ClassTemplateImpl(null, 43, null, null,null))
    ).setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
      @Override
      public void onComplete(Object result) {
        results.add(result);
      }

      @Override
      public void onError(Throwable throwable) {

      }
    });

    assertEquals(results.get(0), "pineapple");
    assertThat(methodCallLog, contains(isMethodCall("REFERENCE_METHOD", contains(
        isRemoteReference(remoteReference.referenceId),
        equalTo("methodTemplate"),
        contains(
            equalTo("apple"),
            isUnpairedRemoteReference(new TypeReference(0), contains(11, null, null, null)),
            contains(isUnpairedRemoteReference(new TypeReference(0), contains(13, null, null, null))),
            new IsMapContaining<String, UnpairedRemoteReference>(equalTo("apple"), isUnpairedRemoteReference(new TypeReference(0), contains(43, null, null, null)))
        )
    ))));
  }

  @Test
  public void referencePairManager_executeRemoteMethodFor_returnsReference() throws Exception {
    final ClassTemplate classTemplate = new ClassTemplateImpl(referencePairManager, 23, null, null, null);

    referencePairManager.createRemoteReferenceFor(classTemplate);
    final RemoteReference remoteReference = referencePairManager.remoteReferenceFor(classTemplate);
    assertNotNull(remoteReference);
    methodCallLog.clear();

    final List<Object> results = new ArrayList<>();

    classTemplate.returnsReference().setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
      @Override
      public void onComplete(Object result) {
        results.add(result);
      }

      @Override
      public void onError(Throwable throwable) {

      }
    });

    assertThat(results.get(0), isClassTemplate(123, null, null, null));
  }

  @Test
  public void referencePairManager_createLocalReferenceFor() throws Exception {
    final ByteBuffer message = referencePairManager.methodCodec.encodeMethodCall(
        new MethodCall("REFERENCE_CREATE", Arrays.asList(
            new RemoteReference("table"),
            new TypeReference(0),
            Arrays.asList(
                32,
                new UnpairedRemoteReference(new TypeReference(0), Arrays.asList((Object) 15, null, null, null)),
                Collections.singletonList(new UnpairedRemoteReference(new TypeReference(0), Arrays.asList((Object) 16, null, null, null))),
                ImmutableMap.of("apple", new UnpairedRemoteReference(new TypeReference(0), Arrays.asList((Object) 43, null, null, null)))
            )
        ))
    );
    mockMessenger.receive("reference_plugin", message);

    final ClassTemplate classTemplate = (ClassTemplate) referencePairManager.localReferenceFor(new RemoteReference("table"));
    assertThat(classTemplate, isClassTemplate(32,
        isClassTemplate(15, null, null, null),
        contains(isClassTemplate(16, null, null, null)),
        new IsMapContaining<String, ClassTemplate>(equalTo("apple"), isClassTemplate(43, null, null, null)))
    );
  }
}