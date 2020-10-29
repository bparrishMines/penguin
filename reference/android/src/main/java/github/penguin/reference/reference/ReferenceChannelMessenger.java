package github.penguin.reference.reference;

import java.util.List;

import github.penguin.reference.async.Completable;

public interface ReferenceChannelMessenger {
  Completable<Void> sendCreateNewPair(
      String handlerChannel,
      RemoteReference remoteReference,
      List<Object> arguments
      );

  Completable<Object> sendInvokeStaticMethod(
      String handlerChannel,
      // int typeId,
      String methodName,
      List<Object> arguments
      );

  Completable<Object> sendInvokeMethod(
      String handlerChannel,
      RemoteReference remoteReference,
      String methodName,
      List<Object> arguments
  );

  Completable<Object> sendInvokeMethodOnUnpairedReference(
      UnpairedReference unpairedReference,
      String methodName,
      List<Object> arguments
  );

  Completable<Void> sendDisposePair(
      String handlerChannel,
      RemoteReference remoteReference
  );
}
