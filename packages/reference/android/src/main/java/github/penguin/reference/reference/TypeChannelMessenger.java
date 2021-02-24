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

  private boolean addInstancePair(String channelName, Object instance, PairedInstance pairedInstance, Object owner)
      throws Exception {
    if (instancePairManager.addPair(instance, pairedInstance, owner)) {
      final TypeChannelHandler handler = getChannelHandler(channelName);
      if (handler != null) handler.onInstanceAdded(this, instance);
      return true;
    }
    return false;
  }

  private boolean removeInstancePair(String channelName, Object instance, Object owner, boolean force) throws Exception {
    if (instancePairManager.removePairWithObject(instance, owner, force)) {
      final TypeChannelHandler handler = getChannelHandler(channelName);
      if (handler != null) handler.onInstanceRemoved(this, instance);
      return true;
    }

    return false;
  }

  public boolean isPaired(@NonNull Object instance) {
    return instancePairManager.isPaired(instance);
  }

  @Nullable
  PairedInstance getPairedPairedInstance(@NonNull Object instance) {
    return instancePairManager.getPairedPairedInstance(instance);
  }

  @Nullable
  Object getPairedObject(@NonNull PairedInstance pairedInstance) {
    return instancePairManager.getPairedObject(pairedInstance);
  }

  public void registerHandler(String channelName, @NonNull TypeChannelHandler<?> handler) {
    channelHandlers.put(channelName, handler);
  }

  public void unregisterHandler(String channelName) {
    channelHandlers.remove(channelName);
  }

  @Nullable
  public TypeChannelHandler getChannelHandler(String channelName) {
    return channelHandlers.get(channelName);
  }

  @NonNull
  public InstanceConverter getConverter() {
    return new InstanceConverter.StandardInstanceConverter();
  }

  @NonNull
  public Completable<PairedInstance> sendCreateNewInstancePair(String channelName, Object instance, Object owner) {
    final PairedInstance pairedInstance = new PairedInstance(generateUniqueInstanceId(instance));

    final TypeChannelHandler handler = getChannelHandler(channelName);
    if (handler == null) {
      throw new IllegalArgumentException("A `TypeChannelHandler` must be set for channel of: $channelName.");
    }

    final boolean createdNewInstance;
    try {
      createdNewInstance = addInstancePair(channelName, instance, pairedInstance, owner);
    } catch (Exception exception) {
      return new Completer<PairedInstance>().completeWithError(exception).completable;
    }

    if (!createdNewInstance) return new Completer<PairedInstance>().complete(null).completable;

    final Completer<PairedInstance> instanceCompleter = new Completer<>();
    getMessageDispatcher().sendCreateNewInstancePair(
        channelName,
        pairedInstance,
        (List<Object>) getConverter().convertForRemoteMessenger(
            this,
            handler.getCreationArguments(this, instance))
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
            (List<Object>) getConverter().convertForRemoteMessenger(this, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(getConverter().convertForLocalMessenger(TypeChannelMessenger.this, result));
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
    if (!isPaired(instance)) {
      return sendInvokeMethodOnUnpairedInstance(channelName, instance, methodName, arguments);
    }

    final Completer<Object> returnCompleter = new Completer<>();

    getMessageDispatcher()
        .sendInvokeMethod(
            channelName,
            instancePairManager.getPairedPairedInstance(instance),
            methodName,
            (List<Object>) getConverter().convertForRemoteMessenger(this, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(getConverter().convertForLocalMessenger(TypeChannelMessenger.this, result));
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

  private Completable<Object> sendInvokeMethodOnUnpairedInstance(
      String channelName, Object object, String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    getMessageDispatcher()
        .sendInvokeMethodOnUnpairedReference(
            createUnpairedInstance(channelName, object),
            methodName,
            (List<Object>) getConverter().convertForRemoteMessenger(this, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(getConverter().convertForLocalMessenger(TypeChannelMessenger.this, result));
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
  public Completable<Void> sendDisposeInstancePair(String channelName, Object instance, Object owner) {
    if (!isPaired(instance)) return new Completer<Void>().complete(null).completable;

    final PairedInstance pairedInstance = getPairedPairedInstance(instance);

    final boolean removedInstance;
    try {
      removedInstance = removeInstancePair(channelName, instance, owner, false);
    } catch (Exception exception) {
      return new Completer<Void>().completeWithError(exception).completable;
    }

    if (removedInstance) return getMessageDispatcher().sendDisposePair(channelName, pairedInstance);
    return new Completer<Void>().complete(null).completable;
  }

  public Object onReceiveCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments)
      throws Exception {
    if (instancePairManager.getPairedObject(pairedInstance) != null) return null;

    final Object object =
        getChannelHandler(channelName)
            .createInstance(
                this, (List<Object>) getConverter().convertForLocalMessenger(this, arguments));

    if (instancePairManager.getPairedPairedInstance(object) != null) throw new AssertionError();

    addInstancePair(channelName, object, pairedInstance, object);
    return object;
  }

  public Object onReceiveInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments) throws Exception {
    final Object result =
        getChannelHandler(channelName)
            .invokeStaticMethod(
                this,
                methodName,
                (List<Object>) getConverter().convertForLocalMessenger(this, arguments));

    return getConverter().convertForRemoteMessenger(this, result);
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
                instancePairManager.getPairedObject(pairedInstance),
                methodName,
                (List<Object>) getConverter().convertForLocalMessenger(this, arguments));

    return getConverter().convertForRemoteMessenger(this, result);
  }

  public Object onReceiveInvokeMethodOnUnpairedInstance(
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
                                .convertForLocalMessenger(this, unpairedInstance.creationArguments)),
                methodName,
                (List<Object>) getConverter().convertForLocalMessenger(this, arguments));

    return getConverter().convertForRemoteMessenger(this, result);
  }

  public void onReceiveDisposeInstancePair(String channelName, PairedInstance pairedInstance)
      throws Exception {
    final Object instance = instancePairManager.getPairedObject(pairedInstance);
    if (instance == null) return;

    removeInstancePair(channelName, instance, instance, true);
  }

  protected String generateUniqueInstanceId(Object instance) {
    return String.valueOf(instance.hashCode());
  }
}
