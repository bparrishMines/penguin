package github.penguin.reference.reference;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import java.util.List;

public class TypeChannel<T> {
  @NonNull public final TypeChannelManager manager;
  @NonNull public final String name;

  public TypeChannel(@NonNull TypeChannelManager manager, @NonNull String name) {
    this.manager = manager;
    this.name = name;
  }

  public void setHandler(TypeChannelHandler<T> handler) {
    manager.registerHandler(name, handler);
  }
  
  NewUnpairedInstance createUnpairedInstance(T instance) {
    return manager.createUnpairedInstance(name, instance);
  }

  public Completable<PairedInstance> createNewInstancePair(T instance) {
    if (manager.isPaired(instance)) return new Completer<PairedInstance>().complete(null).completable;

    final Completer<PairedInstance> instanceCompleter = new Completer<>();
    final PairedInstance pairedInstance = new PairedInstance(manager.generateUniqueReferenceId());

    manager.instancePairs.add(instance, pairedInstance);

    manager
        .getMessenger()
        .sendCreateNewInstancePair(
            name,
            pairedInstance,
            (List<Object>)
                manager
                    .getConverter()
                    .convertForRemoteManager(
                        manager,
                        manager
                            .getChannelHandler(name)
                            .getCreationArguments(manager, instance)))
        .setOnCompleteListener(
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

  public Completable<Object> invokeStaticMethod(String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeStaticMethod(
            name,
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
    if (!manager.isPaired(instance)) {
      return invokeMethodOnUnpairedReference(instance, methodName, arguments);
    }
      
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeMethod(
            name,
            manager.instancePairs.getPairedPairedInstance(instance),
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

  private Completable<Object> invokeMethodOnUnpairedReference(
      Object object, String methodName, List<Object> arguments) {
    final Completer<Object> returnCompleter = new Completer<>();

    manager
        .getMessenger()
        .sendInvokeMethodOnUnpairedReference(
            manager.createUnpairedInstance(name, object),
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
    final PairedInstance pairedInstance =
        manager.instancePairs.getPairedPairedInstance(instance);
    if (pairedInstance == null) return new Completer<Void>().complete(null).completable;

    manager.instancePairs.removePairWithObject(instance);
    return manager.getMessenger().sendDisposePair(name, pairedInstance);
  }
}
