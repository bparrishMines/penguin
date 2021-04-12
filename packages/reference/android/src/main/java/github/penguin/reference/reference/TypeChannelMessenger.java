package github.penguin.reference.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;

public abstract class TypeChannelMessenger {
  private final Map<String, TypeChannelHandler<?>> channelHandlers = new HashMap<>();
  private final InstancePairManager instancePairManager = new InstancePairManager();

  public abstract TypeChannelMessageDispatcher getMessageDispatcher();

  private boolean addInstancePair(Object instance, PairedInstance pairedInstance, boolean owner) {
    return getInstancePairManager().addPair(instance, pairedInstance.instanceId, owner);
  }

  private void removeInstancePair(PairedInstance pairedInstance) {
    getInstancePairManager().removePair(pairedInstance.instanceId);
  }

  public boolean isPaired(@NonNull Object instance) {
    return getInstancePairManager().isPaired(instance);
  }

  @Nullable
  PairedInstance getPairedPairedInstance(@NonNull Object instance) {
    final String instanceId = getInstancePairManager().getInstanceId(instance);
    return instanceId == null ? null : new PairedInstance(instanceId);
  }

  @Nullable
  Object getPairedObject(@NonNull PairedInstance pairedInstance) {
    return getInstancePairManager().getInstance(pairedInstance.instanceId);
  }

  public void registerHandler(String channelName, @NonNull TypeChannelHandler<?> handler) {
    channelHandlers.put(channelName, handler);
  }

  public void unregisterHandler(String channelName) {
    channelHandlers.remove(channelName);
  }

  @SuppressWarnings("rawtypes")
  @Nullable
  public TypeChannelHandler getChannelHandler(String channelName) {
    return channelHandlers.get(channelName);
  }

  @NonNull
  public InstanceConverter getConverter() {
    return new InstanceConverter.StandardInstanceConverter();
  }

  @NonNull
  public InstancePairManager getInstancePairManager() {
    return instancePairManager;
  }

  @NonNull
  public Completable<PairedInstance> createNewInstancePair(String channelName, Object instance, boolean owner) {
    if (isPaired(instance)) return new Completer<PairedInstance>().complete(null).completable;

    //noinspection rawtypes
    final TypeChannelHandler handler = getChannelHandler(channelName);
    if (handler == null) {
      throw new IllegalArgumentException("A `TypeChannelHandler` must be set for channel of: $channelName.");
    }

    final PairedInstance pairedInstance = new PairedInstance(generateUniqueInstanceId(instance));

    addInstancePair(instance, pairedInstance, owner);

    final Completer<PairedInstance> instanceCompleter = new Completer<>();
    getMessageDispatcher().sendCreateNewInstancePair(
        channelName,
        pairedInstance,
        (List<Object>) getConverter().convertInstancesToPairedInstances(
            this,
            handler.getCreationArguments(this, instance)),
        !owner
    ).setOnCompleteListener(
        new Completable.OnCompleteListener<Void>() {
          @Override
          public void onComplete(Void result) {
            instanceCompleter.complete(pairedInstance);
          }

          @Override
          public void onError(Throwable throwable) {
            instanceCompleter.completeWithError(throwable);
          }
        });

    return instanceCompleter.completable;
  }

  public Completable<Object> sendInvokeStaticMethod(String channelName, String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    getMessageDispatcher()
        .sendInvokeStaticMethod(
            channelName,
            methodName,
            (List<Object>) getConverter().convertInstancesToPairedInstances(this, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(getConverter().convertPairedInstancesToInstances(TypeChannelMessenger.this, result));
                } catch (Exception exception) {
                  onError(exception);
                }
              }

              @Override
              public void onError(Throwable throwable) {
                returnCompleter.completeWithError(throwable);
              }
            });

    return returnCompleter.completable;
  }

  public Completable<Object> sendInvokeMethod(String channelName, Object instance, String methodName, List<Object> arguments) {
    if (!isPaired(instance)) throw new AssertionError();

    final Completer<Object> returnCompleter = new Completer<>();

    getMessageDispatcher()
        .sendInvokeMethod(
            channelName,
            getPairedPairedInstance(instance),
            methodName,
            (List<Object>) getConverter().convertInstancesToPairedInstances(this, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(getConverter().convertPairedInstancesToInstances(TypeChannelMessenger.this, result));
                } catch (Exception exception) {
                  onError(exception);
                }
              }

              @Override
              public void onError(Throwable throwable) {
                returnCompleter.completeWithError(throwable);
              }
            });

    return returnCompleter.completable;
  }

  @NonNull
  public Completable<Void> disposeInstancePair(Object instance) {
    if (!isPaired(instance)) return new Completer<Void>().complete(null).completable;
    final PairedInstance pairedInstance = getPairedPairedInstance(instance);
    removeInstancePair(pairedInstance);
    return getMessageDispatcher().sendDisposeInstancePair(pairedInstance);
  }

  public Object onReceiveCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments, boolean owner)
      throws Exception {
    if (getPairedObject(pairedInstance) != null) {
      throw new AssertionError("An object with `PairedInstance` has already been created.");
    }

    final Object instance =
        getChannelHandler(channelName)
            .createInstance(
                this, (List<Object>) getConverter().convertPairedInstancesToInstances(this, arguments));

    if (isPaired(instance)) throw new AssertionError();

    addInstancePair(instance, pairedInstance, owner);
    return instance;
  }

  public Object onReceiveInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments) throws Exception {
    final Object result =
        getChannelHandler(channelName)
            .invokeStaticMethod(
                this,
                methodName,
                (List<Object>) getConverter().convertPairedInstancesToInstances(this, arguments));

    return getConverter().convertInstancesToPairedInstances(this, result);
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
                getPairedObject(pairedInstance),
                methodName,
                (List<Object>) getConverter().convertPairedInstancesToInstances(this, arguments));

    return getConverter().convertInstancesToPairedInstances(this, result);
  }

  public void onReceiveDisposeInstancePair(PairedInstance pairedInstance) {
    final Object instance = getPairedObject(pairedInstance);
    if (instance == null) {
      throw new AssertionError(
          "The Object with the following PairedInstance has already been disposed: "
              + pairedInstance);
    }
    removeInstancePair(pairedInstance);
  }

  protected String generateUniqueInstanceId(Object instance) {
    return String.valueOf(instance.hashCode());
  }
}
