package github.penguin.reference.reference;

import androidx.annotation.NonNull;

import java.util.List;

import github.penguin.reference.async.Completable;

public class TypeChannel<T> {
  @NonNull
  public final TypeChannelMessenger manager;
  @NonNull
  public final String name;

  public TypeChannel(@NonNull TypeChannelMessenger manager, @NonNull String name) {
    this.manager = manager;
    this.name = name;
  }

  public void setHandler(TypeChannelHandler<T> handler) {
    manager.registerHandler(name, handler);
  }

  public NewUnpairedInstance createUnpairedInstance(T instance) {
    return manager.createUnpairedInstance(name, instance);
  }

  public Completable<PairedInstance> createNewInstancePair(T instance) {
    return createNewInstancePair(instance, instance);
  }

  public Completable<PairedInstance> createNewInstancePair(T instance, Object owner) {
    return manager.sendCreateNewInstancePair(name, instance, owner);
  }

  public Completable<Object> invokeStaticMethod(String methodName, List<Object> arguments) {
    return manager.sendInvokeStaticMethod(name, methodName, arguments);
  }

  public Completable<Object> invokeMethod(T instance, String methodName, List<Object> arguments) {
    return manager.sendInvokeMethod(name, instance, methodName, arguments);
  }

  public Completable<Void> disposeInstancePair(Object instance) {
    return manager.sendDisposeInstancePair(name, instance, instance);
  }

  public Completable<Void> disposeInstancePair(Object instance, Object owner) {
    return manager.sendDisposeInstancePair(name, instance, owner);
  }
}
