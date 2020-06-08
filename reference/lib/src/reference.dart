import 'reference_pair_manager.dart';

/// Represents an object on the same thread/process.
///
/// This is a mixin that allows a [ReferencePairManager] to know that a
/// class is able be paired with a [RemoteReference].
mixin LocalReference {
  ///// Represents a type that exists on a local and remote thread/process.
/////
///// For example, a class named `Apple` in an `apple.dart` file and an
///// `Apple.java` file could both be represented by a [TypeReference] with the
///// same [typeId].
/////
///// Every type given a unique type reference must implement [LocalReference].
///// This class is used to help instantiate [LocalReference]s for
///// [ReferencePairManager]s.
/////
///// Two [TypeReference]s are equal if they share the same [typeId].
  // TODO: documentation
  Type get referenceType;
}

/// Represents an object on a different thread/process.
///
/// This is paired with a [LocalReference] in a [ReferencePairManager].
///
/// Two [RemoteReference]s are equal if they share the same [referenceId].
class RemoteReference {
  const RemoteReference(this.referenceId) : assert(referenceId != null);

  /// Unique identifier used to retrieve the instance this represents from a remote [ReferencePairManager].
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

/// Represents a [RemoteReference] that is not paired with a [LocalReference] in a [ReferencePairManager].
///
/// This acts as a replacement for a [LocalReference] that has no
/// [RemoteReference] when a [ReferencePairManager] passes arguments to a
/// [RemoteReferenceCommunicationHandler].
///
/// When passed to a [ReferencePairManager], it will try to convert it into a
/// [LocalReference] with
/// [LocalReferenceCommunicationHandler.createLocalReference].
class UnpairedRemoteReference {
  const UnpairedRemoteReference(
    this.typeId,
    this.creationArguments, [
    this.managerPoolId,
  ]);

  /// Represents the type that is represented.
  ///
  /// Each [Type] in [ReferencePairManager.supportedTypes] is given a unique
  /// typeId.
  final int typeId;

  /// Arguments used to create the instance this represents.
  final List<Object> creationArguments;

  final String managerPoolId;

  @override
  String toString() {
    return '$runtimeType($typeId, $creationArguments, $managerPoolId)';
  }
}
