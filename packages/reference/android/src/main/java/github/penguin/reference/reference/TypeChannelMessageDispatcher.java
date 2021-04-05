package github.penguin.reference.reference;

import java.util.List;

import github.penguin.reference.async.Completable;

public interface TypeChannelMessageDispatcher {
  Completable<Void> sendCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments, boolean owner);

  Completable<Object> sendInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments);

  Completable<Object> sendInvokeMethod(
      String channelName,
      PairedInstance pairedInstance,
      String methodName,
      List<Object> arguments);
}
