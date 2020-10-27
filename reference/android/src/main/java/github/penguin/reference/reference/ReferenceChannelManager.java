package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import androidx.annotation.CallSuper;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;

public abstract class ReferenceChannelManager {
  private final Map<String, ReferenceChannelHandler> channelHandlers = new HashMap<>();
  private boolean initialized = false;

  public final RemoteReferenceMap referencePairs = new RemoteReferenceMap();

  public abstract ReferenceChannelMessenger getMessenger();

  @CallSuper
  public void initialize() {
    initialized = true;
  }

  public void registerHandler(String channelName, ReferenceChannelHandler handler) {
    channelHandlers.put(channelName, handler);
  }

  public void unregisterHandler(String channelName) {
    channelHandlers.remove(channelName);
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
    assertIsInitialized();
    if (referencePairs.getPairedObject(remoteReference) != null) return null;

    final Object object = getChannelHandler(handlerChannel).createInstance(
        this,
        // getReferenceType(typeId),
        (List<Object>) getConverter().convertForLocalManager(this, arguments)
    );

    assert(referencePairs.getPairedRemoteReference(object) == null);

    referencePairs.add(object, remoteReference);
    return object;
  }

  public Object onReceiveInvokeStaticMethod(
      // Type referenceType,
      String handlerChannel,
      String methodName,
      List<Object> arguments) throws Exception {
    assertIsInitialized();
    // assert(getTypeId(referenceType) != null);
    final Object result = getChannelHandler(handlerChannel).invokeStaticMethod(
        this,
        // referenceType,
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

  /// Invoke a method on [localReference].
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  public Object onReceiveInvokeMethod(
      String handlerChannel,
      Object instance,
      String methodName,
      List<Object> arguments
      ) throws Exception {
    assertIsInitialized();

    final Object result = getChannelHandler(handlerChannel).invokeMethod(
        this,
        instance,
        methodName,
        (List<Object>) getConverter().convertForLocalManager(this, arguments)
    );

    return getConverter().convertForRemoteManager(this, result);
  }

  /// Creates a [LocalReference] from [unpairedReference] and invoke a method.
  ///
  /// This method uses [ReferenceConverter.convertForLocalManager] to convert
  /// [arguments] and [ReferenceConverter.convertForRemoteManager] to convert
  /// the result.
  public Object onReceiveInvokeMethodOnUnpairedReference(
      UnpairedReference unpairedReference,
      String methodName,
      List<Object> arguments
      ) throws  Exception {
    assertIsInitialized();
    return onReceiveInvokeMethod(
        unpairedReference.handlerChannel,
        getChannelHandler(unpairedReference.handlerChannel).createInstance(
            this,
            (List<Object>) getConverter().convertForLocalManager(
                this,
                unpairedReference.creationArguments
                )
            ),
        methodName,
        arguments
    );
  }

  public void onReceiveDisposePair(
      String handlerChannel,
      RemoteReference remoteReference
      ) throws Exception {
    assertIsInitialized();

    final Object instance = referencePairs.getPairedObject(remoteReference);
    if (instance == null) return;

    referencePairs.removePairWithObject(instance);
    getChannelHandler(handlerChannel).onInstanceDisposed(this, instance);
  }


  public Completable<RemoteReference> createNewPair(
      String handlerChannel,
      Object instance
      )  {
    assertIsInitialized();
    if (referencePairs.getPairedRemoteReference(instance) != null) {
      return null;
    }

    final Completer<RemoteReference> referenceCompleter = new Completer<>();
    final RemoteReference remoteReference = new RemoteReference(getNewReferenceId());

    referencePairs.add(instance, remoteReference);

    getMessenger().sendCreateNewPair(
        handlerChannel,
        remoteReference,
        (List<Object>) getConverter().convertForRemoteManager(
            this,
            getChannelHandler(handlerChannel).getCreationArguments(this, instance)
        )).setOnCompleteListener(new Completable.OnCompleteListener<Void>() {
      @Override
      public void onComplete(Void result) {
        referenceCompleter.complete(remoteReference);
      }

      @Override
      public void onError(Throwable throwable) {
        referenceCompleter.completeWithError(throwable);
      }
    });

    return referenceCompleter.completable;
  }

  public Completable<Object> invokeStaticMethod(
      String handlerChannel,
      String methodName,
      List<Object> arguments
      ) {
    assertIsInitialized();

    final Completer<Object> returnCompleter = new Completer<>();

    getMessenger().sendInvokeStaticMethod(
        handlerChannel,
        methodName,
        (List<Object>) getConverter().convertForRemoteManager(this, arguments)
    ).setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        try {
          returnCompleter.complete(getConverter().convertForLocalManager(ReferenceChannelManager.this, result));
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

  public Completable<Object> invokeMethod(
      String handlerChannel,
      RemoteReference remoteReference,
      String methodName,
      List<Object> arguments
      ) {
    assertIsInitialized();

    final Completer<Object> returnCompleter = new Completer<>();

    getMessenger().sendInvokeMethod(
        handlerChannel,
        remoteReference,
        methodName,
        (List<Object>) getConverter().convertForRemoteManager(this, arguments)
    ).setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        try {
          returnCompleter.complete(getConverter().convertForLocalManager(ReferenceChannelManager.this, result));
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

  public Completable<Object> invokeMethodOnUnpairedReference(
      String handlerChannel,
      Object object,
      String methodName,
      List<Object> arguments
      ) {
    assertIsInitialized();

    final Completer<Object> returnCompleter = new Completer<>();

    getMessenger().sendInvokeMethodOnUnpairedReference(
        createUnpairedReference(handlerChannel, object),
        methodName,
        (List<Object>) getConverter().convertForRemoteManager(this, arguments)
    ).setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
      @Override
      public void onComplete(Object result) {
        try {
          returnCompleter.complete(getConverter().convertForLocalManager(ReferenceChannelManager.this, result));
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

  public Completable<Void> disposePair(String handlerChannel, Object instance) {
    assertIsInitialized();

    final RemoteReference remoteReference = referencePairs.getPairedRemoteReference(instance);
    if (remoteReference == null) return null;

    referencePairs.removePairWithObject(instance);
    return getMessenger().sendDisposePair(handlerChannel, remoteReference);
  }

  void assertIsInitialized() {
    if (!initialized) throw new AssertionError("Initialize has not been called.");
  }

  protected String getNewReferenceId() {
    return UUID.randomUUID().toString();
  }
}
