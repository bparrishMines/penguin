package github.penguin.reference.templates;

import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteReferenceCommunicationHandler;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.TypeReference;
import io.flutter.plugin.common.BinaryMessenger;
import com.google.common.collect.ImmutableMap;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class $TemplateReferencePairManager extends MethodChannelReferencePairManager {
  public interface ClassTemplate extends LocalReference {
    Integer getFieldTemplate();
    Object methodTemplate(String parameterTemplate) throws Exception;
  }

  static class $MethodNames {
    static final String methodTemplate = "methodTemplate";
  }

  abstract static class $LocalReferenceCommunicationHandler implements LocalReferenceCommunicationHandler {
    static private Map<TypeReference, ImmutableMap<String, Method>> methods;
    static {
      try {
        methods = ImmutableMap.of(
            new TypeReference(0),
            ImmutableMap.of("methodTemplate", ClassTemplate.class.getMethod("methodTemplate", String.class))
        );
      } catch (NoSuchMethodException exception) {
        throw new RuntimeException(exception.getMessage());
      }
    }

    public abstract ClassTemplate createClassTemplate(
        ReferencePairManager referencePairManager,
        int fieldTemplate)
        throws Exception;

    @Override
    public LocalReference createLocalReference(
        ReferencePairManager referencePairManager,
        TypeReference typeReference,
        List<Object> arguments)
        throws Exception {
      if (typeReference.equals(new TypeReference(0))) {
        return createClassTemplate(referencePairManager, (Integer) arguments.get(0));
      }

      final String message =
          String.format(
              "Could not instantiate a %s: for %s with arguments: %s.",
              LocalReference.class.getSimpleName(), typeReference.toString(), arguments.toString());
      throw new IllegalStateException(message);
    }

    @SuppressWarnings({"ConstantConditions"})
    @Override
    public Object executeLocalMethod(
        ReferencePairManager referencePairManager,
        LocalReference localReference,
        String methodName,
        List<Object> arguments) throws Exception {
      final Method method = methods.get(referencePairManager.typeReferenceFor(localReference)).get(methodName);
      return method.invoke(localReference, arguments.toArray());
    }

    @SuppressWarnings("RedundantThrows")
    @Override
    public void disposeLocalReference(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception {
      // Do nothing.
    }
  }

  static class $RemoteReferenceCommunicationHandler
      extends MethodChannelRemoteReferenceCommunicationHandler {
    @Override
    public List<Object> creationArgumentsFor(LocalReference localReference) {
      if (localReference instanceof ClassTemplate) {
        final ClassTemplate value = (ClassTemplate) localReference;
        return Collections.singletonList((Object) value.getFieldTemplate());
      }

      final String message =
          String.format(
              "Could not get creation arguments for a %s.", localReference.getClass().getName());
      throw new IllegalStateException(message);
    }
  }

  $TemplateReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final $LocalReferenceCommunicationHandler localHandler) {
    this(
        binaryMessenger,
        channelName,
        localHandler,
        new $RemoteReferenceCommunicationHandler(),
        new ReferenceMessageCodec());
  }

  @SuppressWarnings({"unused", "ArraysAsListWithZeroOrOneArgument"})
  $TemplateReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final $LocalReferenceCommunicationHandler localHandler,
      final $RemoteReferenceCommunicationHandler remoteHandler,
      final ReferenceMessageCodec messageCodec) {
    super(Arrays.<Class<? extends LocalReference>>asList(ClassTemplate.class), binaryMessenger, channelName, localHandler, remoteHandler, messageCodec);
  }
}
