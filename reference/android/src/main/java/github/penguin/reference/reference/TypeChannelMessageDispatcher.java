package github.penguin.reference.reference;

import github.penguin.reference.async.Completable;
import java.util.List;

public interface TypeChannelMessageDispatcher {
  Completable<Void> sendCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments);

  Completable<Object> sendInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments);

  Completable<Object> sendInvokeMethod(
      String channelName,
      PairedInstance pairedInstance,
      String methodName,
      List<Object> arguments);

  Completable<Object> sendInvokeMethodOnUnpairedReference(
      NewUnpairedInstance unpairedInstance, String methodName, List<Object> arguments);

  Completable<Void> sendDisposePair(String channelName, PairedInstance pairedInstance);
}
