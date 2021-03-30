package github.penguin.reference.reference;

import java.util.List;

public interface TypeChannelHandler<T> {
  List<Object> getCreationArguments(TypeChannelMessenger manager, T instance);

  T createInstance(TypeChannelMessenger manager, List<Object> arguments) throws Exception;

  Object invokeStaticMethod(
      TypeChannelMessenger manager, String methodName, List<Object> arguments) throws Exception;

  Object invokeMethod(
      TypeChannelMessenger manager, T instance, String methodName, List<Object> arguments)
      throws Exception;

//  void onInstanceAdded(TypeChannelMessenger manager, T instance) throws Exception;
//
//  void onInstanceRemoved(TypeChannelMessenger manager, T instance) throws Exception;
}
