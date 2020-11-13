package github.penguin.reference.reference;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import java.util.List;

public class ReferenceChannel<T> {
  @NonNull public final ReferenceChannelManager manager;
  @NonNull public final String channelName;

  public ReferenceChannel(@NonNull ReferenceChannelManager manager, @NonNull String channelName) {
    this.manager = manager;
    this.channelName = channelName;
  }

  public void registerHandler(ReferenceChannelHandler<T> handler) {
    manager.registerHandler(channelName, handler);
  }

  public Completable<RemoteReference> createNewPair(T instance) {
    if (manager.isPaired(instance)) return null;

    final Completer<RemoteReference> referenceCompleter = new Completer<>();
    final RemoteReference remoteReference = new RemoteReference(manager.getNewReferenceId());

    manager.referencePairs.add(instance, remoteReference);

    manager
        .getMessenger()
        .sendCreateNewPair(
            channelName,
            remoteReference,
            (List<Object>)
                manager
                    .getConverter()
                    .convertForRemoteManager(
                        manager,
                        manager
                            .getChannelHandler(channelName)
                            .getCreationArguments(manager, instance)))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Void>() {
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

  public Completable<Object> invokeStaticMethod(String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeStaticMethod(
            channelName,
            methodName,
            (List<Object>) manager.getConverter().convertForRemoteManager(manager, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(
                      manager.getConverter().convertForLocalManager(manager, result));
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

  public Completable<Object> invokeMethod(T instance, String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeMethod(
            channelName,
            manager.referencePairs.getPairedRemoteReference(instance),
            methodName,
            (List<Object>) manager.getConverter().convertForRemoteManager(manager, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(
                      manager.getConverter().convertForLocalManager(manager, result));
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
      Object object, String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeMethodOnUnpairedReference(
            manager.createUnpairedReference(channelName, object),
            methodName,
            (List<Object>) manager.getConverter().convertForRemoteManager(manager, arguments))
        .setOnCompleteListener(
            new Completable.OnCompleteListener<Object>() {
              @Override
              public void onComplete(Object result) {
                try {
                  returnCompleter.complete(
                      manager.getConverter().convertForLocalManager(manager, result));
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

  public Completable<Void> disposePair(Object instance) {
    final RemoteReference remoteReference =
        manager.referencePairs.getPairedRemoteReference(instance);
    if (remoteReference == null) return null;

    manager.referencePairs.removePairWithObject(instance);
    return manager.getMessenger().sendDisposePair(channelName, remoteReference);
  }
}
