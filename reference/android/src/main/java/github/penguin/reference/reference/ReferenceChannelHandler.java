package github.penguin.reference.reference;

import java.util.List;

public interface ReferenceChannelHandler<T> {
  List<Object> getCreationArguments(
      ReferenceChannelManager manager,
      T instance
  );

  T createInstance(
      ReferenceChannelManager manager,
      List<Object> arguments
  ) throws Exception;

  Object invokeStaticMethod(
      ReferenceChannelManager manager,
      String methodName,
      List<Object> arguments
  ) throws Exception;

  Object invokeMethod(
      ReferenceChannelManager manager,
      T instance,
      String methodName,
      List<Object> arguments
  ) throws Exception;

  void onInstanceDisposed(ReferenceChannelManager manager, T instance)throws Exception;
}
