package github.penguin.reference.reference;

import androidx.annotation.NonNull;

import java.util.List;

import github.penguin.reference.async.Completable;

public class TypeChannel<T> {
  @NonNull
  public final TypeChannelMessenger messenger;
  @NonNull
  public final String name;

  public TypeChannel(@NonNull TypeChannelMessenger messenger, @NonNull String name) {
    this.messenger = messenger;
    this.name = name;
  }

  public void setHandler(TypeChannelHandler<T> handler) {
    messenger.registerHandler(name, handler);
  }

  public void removeHandler() {
    messenger.unregisterHandler(name);
  }

  public NewUnpairedInstance createUnpairedInstance(T instance) {
    return messenger.createUnpairedInstance(name, instance);
  }

  public Completable<PairedInstance> createNewInstancePair(T instance) {
    return createNewInstancePair(instance, instance);
  }

  public Completable<PairedInstance> createNewInstancePair(T instance, Object owner) {
    return messenger.sendCreateNewInstancePair(name, instance, owner);
  }

  public Completable<Object> invokeStaticMethod(String methodName, List<Object> arguments) {
    return messenger.sendInvokeStaticMethod(name, methodName, arguments);
  }

  public Completable<Object> invokeMethod(T instance, String methodName, List<Object> arguments) {
    return messenger.sendInvokeMethod(name, instance, methodName, arguments);
  }

  public Completable<Void> disposeInstancePair(Object instance) {
    return messenger.sendDisposeInstancePair(name, instance, instance);
  }

  public Completable<Void> disposeInstancePair(Object instance, Object owner) {
    return messenger.sendDisposeInstancePair(name, instance, owner);
  }
}
