package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public abstract class ReferenceChannelManager {
  private final Map<String, ReferenceChannelHandler<?>> channelHandlers = new HashMap<>();

  final RemoteReferenceMap referencePairs = new RemoteReferenceMap();

  public abstract ReferenceChannelMessenger getMessenger();

  public boolean isPaired(Object instance) {
    return referencePairs.getPairedRemoteReference(instance) != null;
  }

  public void registerHandler(String channelName, ReferenceChannelHandler<?> handler) {
    channelHandlers.put(channelName, handler);
  }

  public ReferenceChannelHandler getChannelHandler(String channelName) {
    return channelHandlers.get(channelName);
  }

  public ReferenceConverter getConverter() {
    return new ReferenceConverter.StandardReferenceConverter();
  }

  public Object onReceiveCreateNewPair(
      String handlerChannel,
      RemoteReference remoteReference,
      List<Object> arguments
  ) throws Exception {
    if (referencePairs.getPairedObject(remoteReference) != null) return null;

    final Object object = getChannelHandler(handlerChannel).createInstance(
        this,
        (List<Object>) getConverter().convertForLocalManager(this, arguments)
    );

    assert(referencePairs.getPairedRemoteReference(object) == null);

    referencePairs.add(object, remoteReference);
    return object;
  }

  public Object onReceiveInvokeStaticMethod(
      String handlerChannel,
      String methodName,
      List<Object> arguments) throws Exception {
    final Object result = getChannelHandler(handlerChannel).invokeStaticMethod(
        this,
        methodName,
        (List<Object>) getConverter().convertForLocalManager(this, arguments)
    );

    return getConverter().convertForRemoteManager(this, result);
  }

  public UnpairedReference createUnpairedReference(
      String handlerChannel,
      Object object
  ) {
    return new UnpairedReference(
        handlerChannel,
        getChannelHandler(handlerChannel).getCreationArguments(this, object));
  }

  public Object onReceiveInvokeMethod(
      String handlerChannel,
      RemoteReference remoteReference,
      String methodName,
      List<Object> arguments
      ) throws Exception {
    final Object result = getChannelHandler(handlerChannel).invokeMethod(
        this,
        referencePairs.getPairedObject(remoteReference),
        methodName,
        (List<Object>) getConverter().convertForLocalManager(this, arguments)
    );

    return getConverter().convertForRemoteManager(this, result);
  }

  public Object onReceiveInvokeMethodOnUnpairedReference(
      UnpairedReference unpairedReference,
      String methodName,
      List<Object> arguments
      ) throws  Exception {

    final Object result = getChannelHandler(unpairedReference.handlerChannel).invokeMethod(this,
    getChannelHandler(unpairedReference.handlerChannel).createInstance(
        this,
        (List<Object>) getConverter().convertForLocalManager(
            this,
            unpairedReference.creationArguments
        )
    ),
        methodName,
        (List<Object>) getConverter().convertForLocalManager(this, arguments));

    return getConverter().convertForRemoteManager(this, result);
  }

  public void onReceiveDisposePair(
      String handlerChannel,
      RemoteReference remoteReference
      ) throws Exception {
    final Object instance = referencePairs.getPairedObject(remoteReference);
    if (instance == null) return;

    referencePairs.removePairWithObject(instance);
    getChannelHandler(handlerChannel).onInstanceDisposed(this, instance);
  }

  protected String getNewReferenceId() {
    return UUID.randomUUID().toString();
  }
}
