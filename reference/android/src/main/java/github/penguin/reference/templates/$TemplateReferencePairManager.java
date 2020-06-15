package github.penguin.reference.templates;

public class $TemplateReferencePairManager {// extends MethodChannelReferencePairManager {
//  public interface ClassTemplate extends LocalReference {
//    Integer getFieldTemplate();
//    Object methodTemplate(String parameterTemplate) throws Exception;
//  }
//
//  static class $MethodNames {
//    static final String methodTemplate = "methodTemplate";
//  }
//
//  private static abstract class LocalCreatorHandler {
//    abstract LocalReference call($LocalReferenceCommunicationHandler localHandler,
//                                      ReferencePairManager referencePairManager,
//                                      List<Object> arguments) throws Exception;
//  }
//
//  private static abstract class LocalMethodHandler {
//    abstract Object call(LocalReference localReference,
//                               List<Object> arguments) throws Exception;
//  }
//
//  private static abstract class CreationArgumentsHandler {
//    abstract List<Object> call(LocalReference localReference);
//  }
//
//  abstract static class $LocalReferenceCommunicationHandler implements LocalReferenceCommunicationHandler {
//    static private final Map<Class<? extends LocalReference>, ImmutableMap<String, LocalMethodHandler>> methods =
//        ImmutableMap.<Class<? extends LocalReference>, ImmutableMap<String, LocalMethodHandler>>of(
//            ClassTemplate.class,
//             ImmutableMap.<String, LocalMethodHandler>of("methodTemplate", new LocalMethodHandler() {
//               @Override
//               Object call(LocalReference localReference, List<Object> arguments) throws Exception {
//                 return ((ClassTemplate) localReference).methodTemplate((String) arguments.get(0));
//               }
//             }));
//
//    static private final Map<Class<? extends LocalReference>, LocalCreatorHandler> creators =
//        ImmutableMap.<Class<? extends LocalReference>, LocalCreatorHandler>of(
//            ClassTemplate.class, new LocalCreatorHandler() {
//              @Override
//              LocalReference call($LocalReferenceCommunicationHandler localHandler, ReferencePairManager referencePairManager, List<Object> arguments) throws Exception {
//                return localHandler.createClassTemplate(referencePairManager, (Integer) arguments.get(0));
//              }
//            }
//        );
//
//    public abstract ClassTemplate createClassTemplate(
//        ReferencePairManager referencePairManager,
//        Integer fieldTemplate)
//        throws Exception;
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public LocalReference create(
//        ReferencePairManager referencePairManager,
//        Class<? extends LocalReference> referenceClass,
//        List<Object> arguments)
//        throws Exception {
//      return creators.get(referenceClass).call(this, referencePairManager, arguments);
//    }
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public Object invokeMethod(
//        ReferencePairManager referencePairManager,
//        LocalReference localReference,
//        String methodName,
//        List<Object> arguments) throws Exception {
//      return methods.get(localReference.getReferenceClass()).get(methodName).call(localReference, arguments);
//    }
//
//    @SuppressWarnings("RedundantThrows")
//    @Override
//    public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception {
//      // Do nothing.
//    }
//  }
//
//  static class $RemoteReferenceCommunicationHandler
//      extends MethodChannelRemoteReferenceCommunicationHandler {
//    private static final Map<Class<? extends LocalReference>, CreationArgumentsHandler> creationArguments =
//        ImmutableMap.<Class<? extends LocalReference>, CreationArgumentsHandler>of(
//            ClassTemplate.class, new CreationArgumentsHandler() {
//              @Override
//              List<Object> call(LocalReference localReference) {
//                final ClassTemplate value = (ClassTemplate) localReference;
//                //noinspection ArraysAsListWithZeroOrOneArgument
//                return Arrays.asList((Object) value.getFieldTemplate());
//              }
//            }
//        );
//
//    @SuppressWarnings("ConstantConditions")
//    @Override
//    public List<Object> getCreationArguments(LocalReference localReference) {
//      return creationArguments.get(localReference.getReferenceClass()).call(localReference);
//    }
//  }
//
//  $TemplateReferencePairManager(
//      final BinaryMessenger binaryMessenger,
//      final String channelName,
//      final $LocalReferenceCommunicationHandler localHandler) {
//    this(
//        binaryMessenger,
//        channelName,
//        localHandler,
//        new $RemoteReferenceCommunicationHandler(),
//        new ReferenceMessageCodec());
//  }
//
//  @SuppressWarnings({"unused", "ArraysAsListWithZeroOrOneArgument"})
//  $TemplateReferencePairManager(
//      final BinaryMessenger binaryMessenger,
//      final String channelName,
//      final $LocalReferenceCommunicationHandler localHandler,
//      final $RemoteReferenceCommunicationHandler remoteHandler,
//      final ReferenceMessageCodec messageCodec) {
//    super(Arrays.<Class<? extends LocalReference>>asList(ClassTemplate.class), binaryMessenger, channelName, localHandler, remoteHandler, null, messageCodec);
//  }
}
