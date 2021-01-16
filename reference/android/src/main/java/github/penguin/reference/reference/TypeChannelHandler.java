package github.penguin.reference.reference;

import java.util.List;

public interface TypeChannelHandler<T> {
  List<Object> getCreationArguments(TypeChannelManager manager, T instance);

  T createInstance(TypeChannelManager manager, List<Object> arguments) throws Exception;

  Object invokeStaticMethod(
      TypeChannelManager manager, String methodName, List<Object> arguments) throws Exception;

  Object invokeMethod(
      TypeChannelManager manager, T instance, String methodName, List<Object> arguments)
      throws Exception;

  void onInstanceDisposed(TypeChannelManager manager, T instance) throws Exception;
}
