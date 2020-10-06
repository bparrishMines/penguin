package github.penguin.reference.templates;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import github.penguin.reference.async.Completable;
import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteHandler;
import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager.LocalReferenceCommunicationHandler;
import io.flutter.plugin.common.BinaryMessenger;

@SuppressWarnings({"ArraysAsListWithZeroOrOneArgument", "unused"})
class LibraryTemplate {
  private static abstract class $LocalCreatorHandler {
    abstract LocalReference call($LocalHandler localHandler,
                                 ReferencePairManager referencePairManager,
                                 List<Object> arguments) throws Exception;
  }

  private static abstract class $LocalStaticMethodHandler {
    abstract Object call($LocalHandler localHandler,
                         ReferencePairManager referencePairManager,
                         List<Object> arguments) throws Exception;
  }

  private static abstract class $LocalMethodHandler {
    abstract Object call(LocalReference localReference,
                         List<Object> arguments) throws Exception;
  }

  private static abstract class $CreationArgumentsHandler {
    abstract List<Object> call(LocalReference localReference);
  }

  static abstract class $ClassTemplate implements LocalReference {
    abstract Integer getFieldTemplate();

    abstract Object methodTemplate(String parameterTemplate) throws Exception;

    protected static Completable<Object> $staticMethodTemplate($ReferencePairManager manager,
                                                        String parameterTemplate) {
      return manager.invokeRemoteStaticMethod($ClassTemplate.class,
          "staticMethodTemplate",
          Arrays.asList((Object) parameterTemplate)
      );
    }

    protected Completable<Object> $methodTemplate($ReferencePairManager manager,
                                                  String parameterTemplate) {
      if (manager.getPairedRemoteReference(this) == null) {
        return manager.invokeRemoteMethodOnUnpairedReference(this,
            "methodTemplate",
            Arrays.asList((Object) parameterTemplate));
      }

      return manager.invokeRemoteMethod(manager.getPairedRemoteReference(this),
          "methodTemplate",
          Arrays.asList((Object) parameterTemplate));
    }

    @Override
    public Class<? extends LocalReference> getReferenceClass() {
      return $ClassTemplate.class;
    }
  }

  static class $ClassTemplateCreationArgs {
    Integer fieldTemplate;
  }

  static abstract class $ReferencePairManager extends MethodChannelReferencePairManager {
    $ReferencePairManager(final BinaryMessenger binaryMessenger, final String channelName) {
      this(binaryMessenger, channelName, new ReferenceMessageCodec());
    }

    @SuppressWarnings("ArraysAsListWithZeroOrOneArgument")
    $ReferencePairManager(
        final BinaryMessenger binaryMessenger,
        final String channelName,
        final ReferenceMessageCodec messageCodec) {
      super(Arrays.<Class<? extends LocalReference>>asList($ClassTemplate.class),
          binaryMessenger,
          channelName,
          channelName,
          messageCodec
      );
    }

    @Override
    public abstract $LocalHandler getLocalHandler();

    @Override
    public MethodChannelRemoteHandler getRemoteHandler() {
      return new $RemoteHandler(binaryMessenger, channelName);
    }
  }

  static abstract class $LocalHandler implements LocalReferenceCommunicationHandler {
    static private final Map<Class<? extends LocalReference>, $LocalCreatorHandler> creators =
        new HashMap<Class<? extends LocalReference>, $LocalCreatorHandler>() {{
          put($ClassTemplate.class, new $LocalCreatorHandler() {
            @Override
            LocalReference call($LocalHandler localHandler, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
              final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
              args.fieldTemplate = (Integer) arguments.get(0);
              return localHandler.createClassTemplate(referencePairManager, args);
            }
          });
        }};

    static private final Map<Class<? extends LocalReference>, $LocalStaticMethodHandler> staticMethods =
        new HashMap<Class<? extends LocalReference>, $LocalStaticMethodHandler>() {{
          put($ClassTemplate.class, new $LocalStaticMethodHandler() {
            @Override
            Object call($LocalHandler localHandler, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
              return localHandler.classTemplate$staticMethodTemplate(referencePairManager, (String) arguments.get(0));
            }
          });
        }};

    static private final Map<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>> methods =
        new HashMap<Class<? extends LocalReference>, Map<String, $LocalMethodHandler>>(){{
          put($ClassTemplate.class, new HashMap<String, $LocalMethodHandler>(){{
            put("methodTemplate", new $LocalMethodHandler() {
              @Override
              Object call(LocalReference localReference, List<Object> arguments) throws Exception {
                return (($ClassTemplate) localReference).methodTemplate((String) arguments.get(0));
              }
            });
          }});
        }};

    public abstract $ClassTemplate createClassTemplate(
        ReferencePairManager referencePairManager,
        $ClassTemplateCreationArgs args)
        throws Exception;

    public abstract Double classTemplate$staticMethodTemplate(
        ReferencePairManager referencePairManager,
        String parameterTemplate) throws Exception;

    @SuppressWarnings("ConstantConditions")
    @Override
    public LocalReference create(
        ReferencePairManager referencePairManager,
        Class<? extends LocalReference> referenceClass,
        List<Object> arguments)
        throws Exception {
      return creators.get(referenceClass).call(this, referencePairManager, arguments);
    }

    @SuppressWarnings("ConstantConditions")
    @Override
    public Object invokeStaticMethod(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, String methodName, List<Object> arguments) throws Exception {
      return staticMethods.get(referenceClass).call(this, referencePairManager, arguments);
    }

    @SuppressWarnings({"ConstantConditions", "SwitchStatementWithTooFewBranches"})
    @Override
    public Object invokeMethod(
        ReferencePairManager referencePairManager,
        LocalReference localReference,
        String methodName,
        List<Object> arguments) throws Exception {
      final $LocalMethodHandler handler = methods.get(localReference.getReferenceClass()).get(methodName);
      if (handler != null) return handler.call(localReference, arguments);

      // Based on inheritance.
      if (localReference instanceof ClassTemplate) {
        switch(methodName) {
          case "methodTemplate":
            return ((ClassTemplate) localReference).methodTemplate((String) arguments.get(0));
        }
      }

      final String message = String.format("Unable to invoke method `$methodName` on (localReference): %s", localReference.toString());
      throw new IllegalArgumentException(message);
    }

    @SuppressWarnings("RedundantThrows")
    @Override
    public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception {
      // Do nothing.
    }
  }

  static class $RemoteHandler extends MethodChannelRemoteHandler {
    private static final Map<Class<? extends LocalReference>, $CreationArgumentsHandler> creationArguments =
        new HashMap<Class<? extends LocalReference>, $CreationArgumentsHandler>() {{
          put($ClassTemplate.class, new $CreationArgumentsHandler() {
            @Override
            List<Object> call(LocalReference localReference) {
              final $ClassTemplate value = ($ClassTemplate) localReference;
              return Arrays.asList((Object) value.getFieldTemplate());
            }
          });
        }};

    $RemoteHandler(BinaryMessenger binaryMessenger, String channelName) {
      super(binaryMessenger, channelName);
    }

    @SuppressWarnings("ConstantConditions")
    @Override
    public List<Object> getCreationArguments(LocalReference localReference) {
      return creationArguments.get(localReference.getReferenceClass()).call(localReference);
    }
  }
}