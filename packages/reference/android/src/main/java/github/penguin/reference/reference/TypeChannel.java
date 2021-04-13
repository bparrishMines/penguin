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

  public Completable<PairedInstance> createNewInstancePair(T instance, boolean owner) {
    return messenger.createNewInstancePair(name, instance, owner);
  }

  public Completable<Object> invokeStaticMethod(String methodName, List<Object> arguments) {
    return messenger.sendInvokeStaticMethod(name, methodName, arguments);
  }

  public Completable<Object> invokeMethod(T instance, String methodName, List<Object> arguments) {
    return messenger.sendInvokeMethod(name, instance, methodName, arguments);
  }

  public Completable<Void> disposeInstancePair(T instance) {
    return messenger.disposeInstancePair(instance);
  }
}
