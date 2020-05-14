package github.penguin.reference.templates;

import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteReferenceCommunicationHandler;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.TypeReference;
import io.flutter.plugin.common.BinaryMessenger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GeneratedReferencePairManager extends MethodChannelReferencePairManager {
  public interface ClassTemplate extends LocalReference {
    int getFieldTemplate();
    ClassTemplate getReferenceFieldTemplate();
    List<ClassTemplate> getReferenceListTemplate();
    Map<String, ClassTemplate> getReferenceMapTemplate();
    CompletableRunnable<String> methodTemplate(String parameterTemplate,
                                               ClassTemplate referenceParameterTemplate,
                                               List<ClassTemplate> referenceListTemplate,
                                               Map<String, ClassTemplate> referenceMapTemplate) throws Exception;
    CompletableRunnable<ClassTemplate> returnsReference() throws Exception;
  }

  public static class GeneratedMethodNames {
    public static final String methodTemplate = "methodTemplate";
    public static final String returnsReference = "returnsReference";
  }

  public static abstract class GeneratedLocalReferenceCommunicationHandler implements LocalReferenceCommunicationHandler {
    public abstract ClassTemplate createClassTemplate(
        ReferencePairManager referencePairManager,
        int fieldTemplate,
        ClassTemplate referenceFieldTemplate,
        List<ClassTemplate> referenceListTemplate,
        Map<String, ClassTemplate> referenceMapTemplate) throws Exception;

    @Override
    public LocalReference createLocalReferenceFor(TypeReference typeReference, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
      if (typeReference.equals(new TypeReference(0))) {
        return createClassTemplate(
            referencePairManager,
            (Integer) arguments.get(0),
            (ClassTemplate) arguments.get(1),
            arguments.get(2) != null ? new ArrayList<ClassTemplate>((List) arguments.get(2)) : null,
            arguments.get(3) != null ? new HashMap<String, ClassTemplate>((Map) arguments.get(3)) : null
        );
      }

      final String message = String.format("Could not instantiate a %s: for %s with arguments: %s.",
          LocalReference.class.getSimpleName(),
          typeReference.toString(),
          arguments.toString());
      throw new IllegalStateException(message);
    }

    @Override
    public Object executeLocalMethod(LocalReference localReference, String methodName, List<Object> arguments) throws Exception {
      if (localReference instanceof ClassTemplate && methodName.equals(GeneratedMethodNames.methodTemplate)) {
        return ((ClassTemplate) localReference).methodTemplate(
            (String) arguments.get(0),
            (ClassTemplate) arguments.get(1),
            arguments.get(2) != null ? new ArrayList<ClassTemplate>((List) arguments.get(2)) : null,
            arguments.get(3) != null ? new HashMap<String, ClassTemplate>((Map) arguments.get(3)) : null
        );
      } else if (localReference instanceof ClassTemplate && methodName.equals(GeneratedMethodNames.returnsReference)) {
        return ((ClassTemplate) localReference).returnsReference();
      }

      final String message = String.format("Could not call %s on %s.", methodName, localReference.getClass().getName());
      throw new IllegalStateException(message);
    }

    @Override
    public void disposeLocalReference(LocalReference localReference) throws Exception {
      // Do nothing.
    }
  }

  public static class GeneratedRemoteReferenceCommunicationHandler extends MethodChannelRemoteReferenceCommunicationHandler {
    @Override
    public List<Object> creationArgumentsFor(LocalReference localReference) {
      if (localReference instanceof ClassTemplate) {
        final ClassTemplate value = (ClassTemplate) localReference;
        return Arrays.asList(value.getFieldTemplate(),
            value.getReferenceFieldTemplate(),
            value.getReferenceListTemplate(),
            value.getReferenceMapTemplate()
        );
      }

      final String message = String.format("Could not get creation arguments for a %s.", localReference.getClass().getName());
      throw new IllegalStateException(message);
    }
  }

  public GeneratedReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final GeneratedLocalReferenceCommunicationHandler localHandler) {
    super(binaryMessenger, channelName, localHandler,
        new GeneratedRemoteReferenceCommunicationHandler(),
        new ReferenceMessageCodec());
  }

  public GeneratedReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final GeneratedLocalReferenceCommunicationHandler localHandler,
      final GeneratedRemoteReferenceCommunicationHandler remoteHandler,
      final ReferenceMessageCodec messageCodec) {
    super(binaryMessenger, channelName, localHandler, remoteHandler, messageCodec);
  }

  @Override
  public TypeReference typeReferenceFor(LocalReference localReference) {
    if (localReference instanceof ClassTemplate) return new TypeReference(0);

    final String message = String.format("Could not find a %s for %s.",
        TypeReference.class.getSimpleName(),
        localReference.getClass().getName());
    throw new IllegalStateException(message);
  }
}
