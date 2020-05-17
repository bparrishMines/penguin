package github.penguin.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.common.collect.ImmutableMap;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.templates.GeneratedReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager.ClassTemplate;
import io.flutter.plugin.common.BinaryMessenger.BinaryMessageHandler;
import io.flutter.plugin.common.BinaryMessenger.BinaryReply;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class ReferencePairManagerTest {
  private static MockBinaryMessenger mockMessenger;
  private static MethodChannel.MethodCallHandler methodCallHandler;
  private static final List<MethodCall> methodCallLog = new ArrayList<>();

  private GeneratedReferencePairManager referencePairManager;

  @BeforeClass
  public static void setUpAll() {
    final MethodCodec codec = new StandardMethodCodec(new ReferenceMessageCodec());
    mockMessenger = new MockBinaryMessenger(new BinaryMessageHandler() {
      @Override
      public void onMessage(@Nullable ByteBuffer message, @NonNull final BinaryReply reply) {
        Objects.requireNonNull(message).position(0);
        final MethodCall methodCall = codec.decodeMethodCall(message);
        methodCallLog.add(methodCall);
        methodCallHandler.onMethodCall(methodCall, new MethodChannel.Result() {
          @Override
          public void success(@Nullable Object result) {
            reply.reply(codec.encodeSuccessEnvelope(result));
          }

          @Override
          public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
            reply.reply(codec.encodeErrorEnvelope(errorCode, errorMessage, errorDetails));
          }

          @Override
          public void notImplemented() {
          }
        });
      }
    }, new BinaryReply() {
      @Override
      public void reply(@Nullable ByteBuffer reply) {

      }
    });

    methodCallHandler = new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(null);
      }
    };
  }

  @Before
  public void setUo() {
    methodCallLog.clear();
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
    assertEquals(methodCallLog.size(), 1);

    final MethodCall methodCall = methodCallLog.get(0);
    assertEquals(methodCall.method, "REFERENCE_CREATE");
  }
}