/// Represents a specific object instance.
///
/// See:
///   [LocalReference]
///   [RemoteReference]
///   [UnpairedReference]
class Reference {
  const Reference();
}

/// Represents an object that is locally accessible.
///
/// This is a mixin that allows a [ReferencePairManager] to know that a
/// class is able be paired with a [RemoteReference].
mixin LocalReference implements Reference {
  /// The unique [Type] used to represent this class in a [ReferencePairManager].
  ///
  /// The [Type] returned by this value should be added to
  /// [ReferencePairManager.supportedTypes] of the [ReferencePairManager] that
  /// supports this class.
  Type get referenceType;
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
/// When passed to [ReferencePairManager.invokeLocalMethod] or
/// [ReferencePairManager.invokeLocalMethodOnUnpairedReference], the
/// [ReferencePairManager] will try to convert it into a [LocalReference] with
/// [LocalReferenceCommunicationHandler.create].
class UnpairedReference implements Reference {
  const UnpairedReference(
    this.typeId,
    this.creationArguments, [
    this.managerPoolId,
  ])  : assert(typeId != null),
        assert(creationArguments != null);

  /// Serialized version of type that is represented.
  ///
  /// This is derived from the indexes of [ReferencePairManager.supportedTypes].
  final int typeId;

  /// Arguments used to create the instance this represents.
  final List<Object> creationArguments;

  /// Unique identifier used to identify the [PoolableReferencePairManager] that can handle the creation and serialization of this type.
  final String managerPoolId;

  @override
  String toString() {
    return '$runtimeType($typeId, $creationArguments, $managerPoolId)';
  }
}
