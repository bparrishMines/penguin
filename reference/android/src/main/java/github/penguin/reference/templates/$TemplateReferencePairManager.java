package github.penguin.reference.templates;

import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteReferenceCommunicationHandler;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.plugin.common.BinaryMessenger;
import com.google.common.collect.ImmutableMap;
import java.lang.reflect.Method;
import java.util.ArrayList;
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
    static private Map<Class<? extends LocalReference>, ImmutableMap<String, Method>> methods;
    static private Map<Class<? extends LocalReference>, Method> creators;
    static {
      try {
        methods = ImmutableMap.<Class<? extends LocalReference>, ImmutableMap<String, Method>>of(
            ClassTemplate.class,
            ImmutableMap.of("methodTemplate", ClassTemplate.class.getMethod("methodTemplate", String.class))
        );
        creators = ImmutableMap.<Class<? extends LocalReference>, Method>of(
            ClassTemplate.class,
            $LocalReferenceCommunicationHandler.class.getMethod("createClassTemplate",
                ReferencePairManager.class,
                Integer.class
            ));
      } catch (NoSuchMethodException exception) {
        throw new RuntimeException(exception.getMessage());
      }
    }

    public abstract ClassTemplate createClassTemplate(
        ReferencePairManager referencePairManager,
        Integer fieldTemplate)
        throws Exception;

    @SuppressWarnings("ConstantConditions")
    @Override
    public LocalReference createLocalReference(
        ReferencePairManager referencePairManager,
        Class<? extends LocalReference> referenceClass,
        List<Object> arguments)
        throws Exception {
      final Method method = creators.get(referenceClass);
      final List<Object> methodParams = new ArrayList<>(1 + arguments.size());
      methodParams.add(referencePairManager);
      methodParams.addAll(arguments);
      return (LocalReference) method.invoke(this, methodParams.toArray());
    }

    @SuppressWarnings("ConstantConditions")
    @Override
    public Object executeLocalMethod(
        ReferencePairManager referencePairManager,
        LocalReference localReference,
        String methodName,
        List<Object> arguments) throws Exception {
      final Method method = methods.get(localReference.getReferenceClass()).get(methodName);
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
