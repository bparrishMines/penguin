package github.penguin.reference.reference;

import java.util.List;

public interface ReferenceChannelHandler {
  List<Object> getCreationArguments(
      ReferenceChannelManager manager,
      Object instance
      );

  /// Instantiates a new [LocalReference].
  ///
  /// When a remote [ReferencePairManager] would like to create a new pair, this
  /// method is called to instantiate a [LocalReference] to be stored in a local
  /// [ReferencePairManager] and paired with a [RemoteReference]. This method is
  /// also called to convert an [UnpairedReference] into a [LocalReference].
  ///
  /// Assuming [LocalReference] is being created to be paired with a
  /// [RemoteReference]:
  ///
  /// The LOCAL [ReferencePairManager] stores the returned [LocalReference] and
  /// a [RemoteReference] with a generated `referenceId` are stored as a pair
  /// and the LOCAL [ReferencePairManager] will facilitate communication between
  /// their object instances they represent.
  ///
  /// The REMOTE [ReferencePairManager] will represent the returned value as a
  /// [RemoteReference] and represent the generated [RemoteReference] as a
  /// [LocalReference]. It will also store both references as a pair.
  Object createInstance(
      ReferenceChannelManager manager,
      List<Object> arguments
      )throws Exception;

  /// Invoke a static method on [referenceType].
  Object invokeStaticMethod(
      ReferenceChannelManager manager,
      String methodName,
      List<Object> arguments
      )throws Exception;

  /// Invoke a method on the object instance represented by [localReference].
  Object invokeMethod(
      ReferenceChannelManager manager,
      Object instance,
      String methodName,
      List<Object> arguments
  )throws Exception;

  /// Dispose [localReference] and the value it represents.
  ///
  /// This also stops the [ReferencePairManager] from maintaining the connection
  /// with its paired [RemoteReference] and will allow for either value to be
  /// attached to new references.
  void onInstanceDisposed(ReferenceChannelManager manager, Object instance)throws Exception;
}
