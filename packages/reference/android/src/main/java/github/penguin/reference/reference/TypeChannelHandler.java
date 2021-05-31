package github.penguin.reference.reference;

import java.util.List;

public interface TypeChannelHandler<T> {
  T createInstance(TypeChannelMessenger manager, List<Object> arguments) throws Exception;

  Object invokeStaticMethod(
      TypeChannelMessenger manager, String methodName, List<Object> arguments) throws Exception;

  Object invokeMethod(
      TypeChannelMessenger manager, T instance, String methodName, List<Object> arguments)
      throws Exception;
}
