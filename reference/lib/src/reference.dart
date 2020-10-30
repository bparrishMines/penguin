/// Represents a specific object instance.
///
/// See:
///   [LocalReference]
///   [RemoteReference]
///   [UnpairedReference]
class Reference {
  const Reference();
}

/// Represents an object that is remotely accessible.
///
/// This is paired with a [LocalReference] in a [ReferencePairManager].
///
/// Two [RemoteReference]s are equal if they share the same [referenceId].
class RemoteReference implements Reference {
  const RemoteReference(this.referenceId) : assert(referenceId != null);

  /// Unique identifier used to retrieve the instance this represents from a remote [ReferencePairManager].
  ///
  /// No two [RemoteReference]s in a [ReferencePairManager] can have the same
  /// [referenceId].
  final String referenceId;

  @override
  bool operator ==(other) =>
      other is RemoteReference && referenceId == other.referenceId;

  @override
  int get hashCode => referenceId.hashCode;

  @override
  String toString() {
    return '$runtimeType($referenceId)';
  }
}

/// Represents an object that is not paired like a [LocalReference] or [RemoteReference].
///
/// This acts as a replacement for a [LocalReference] that has no paired
/// [RemoteReference] when a [ReferencePairManager] passes arguments to a
/// [RemoteReferenceCommunicationHandler].
///
/// When passed to [ReferencePairManager.onReceiveInvokeMethod] or
/// [ReferencePairManager.onReceiveInvokeMethodOnUnpairedReference], the
/// [ReferencePairManager] will try to convert it into a [LocalReference] with
/// [LocalReferenceCommunicationHandler.createInstance].
class UnpairedReference implements Reference {
  const UnpairedReference(
    this.handlerChannel,
    this.creationArguments,
  );

  final String handlerChannel;

  /// Arguments used to create the instance this represents.
  final List<Object> creationArguments;

  @override
  String toString() {
    return '$runtimeType($handlerChannel, $creationArguments, )';
  }
}
