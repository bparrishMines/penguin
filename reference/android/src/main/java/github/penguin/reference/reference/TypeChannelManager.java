package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public abstract class TypeChannelManager {
  private final Map<String, TypeChannelHandler<?>> channelHandlers = new HashMap<>();

  final PairedInstanceMap instancePairs = new PairedInstanceMap();

  public abstract TypeChannelMessenger getMessenger();

  public boolean isPaired(Object instance) {
    return instancePairs.getPairedPairedInstance(instance) != null;
  }

  public void registerHandler(String channelName, TypeChannelHandler<?> handler) {
    channelHandlers.put(channelName, handler);
  }

  public TypeChannelHandler getChannelHandler(String channelName) {
    return channelHandlers.get(channelName);
  }

  public InstanceConverter getConverter() {
    return new InstanceConverter.StandardInstanceConverter();
  }

  public Object onReceiveCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments)
      throws Exception {
    if (instancePairs.getPairedObject(pairedInstance) != null) return null;

    final Object object =
        getChannelHandler(channelName)
            .createInstance(
                this, (List<Object>) getConverter().convertForLocalManager(this, arguments));

    if (instancePairs.getPairedPairedInstance(object) != null) throw new AssertionError();
    
    instancePairs.add(object, pairedInstance);
    return object;
  }

  public Object onReceiveInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments) throws Exception {
    final Object result =
        getChannelHandler(channelName)
            .invokeStaticMethod(
                this,
                methodName,
                (List<Object>) getConverter().convertForLocalManager(this, arguments));

    return getConverter().convertForRemoteManager(this, result);
  }

  public NewUnpairedInstance createUnpairedInstance(String channelName, Object object) {
    return new NewUnpairedInstance(
        channelName, getChannelHandler(channelName).getCreationArguments(this, object));
  }

  public Object onReceiveInvokeMethod(
      String channelName,
      PairedInstance pairedInstance,
      String methodName,
      List<Object> arguments)
      throws Exception {
    final Object result =
        getChannelHandler(channelName)
            .invokeMethod(
                this,
                instancePairs.getPairedObject(pairedInstance),
                methodName,
                (List<Object>) getConverter().convertForLocalManager(this, arguments));

    return getConverter().convertForRemoteManager(this, result);
  }

  public Object onReceiveInvokeMethodOnUnpairedReference(
      NewUnpairedInstance unpairedInstance, String methodName, List<Object> arguments)
      throws Exception {

    final Object result =
        getChannelHandler(unpairedInstance.channelName)
            .invokeMethod(
                this,
                getChannelHandler(unpairedInstance.channelName)
                    .createInstance(
                        this,
                        (List<Object>)
                            getConverter()
                                .convertForLocalManager(this, unpairedInstance.creationArguments)),
                methodName,
                (List<Object>) getConverter().convertForLocalManager(this, arguments));

    return getConverter().convertForRemoteManager(this, result);
  }

  public void onReceiveDisposePair(String channelName, PairedInstance pairedInstance)
      throws Exception {
    final Object instance = instancePairs.getPairedObject(pairedInstance);
    if (instance == null) return;

    instancePairs.removePairWithObject(instance);
    getChannelHandler(channelName).onInstanceDisposed(this, instance);
  }

  protected String generateUniqueReferenceId() {
    return UUID.randomUUID().toString();
  }
}
