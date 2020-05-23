import 'reference_pair_manager.dart';

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

/// Represents an object on the same thread/process.
///
/// This is an empty mixin that allows a [ReferencePairManager] to know that a
/// class is able be paired with a [RemoteReference].
mixin LocalReference {}

/// Represents a type that exists on a local and remote thread/process.
///
/// For example, a class named `Apple` in an `apple.dart` file and an
/// `Apple.java` file could both be represented by a [TypeReference] with the
/// same [typeId].
///
/// Every type given a unique type reference must implement [LocalReference].
/// This class is used to help instantiate [LocalReference]s for
/// [ReferencePairManager]s.
///
/// Two [TypeReference]s are equal if they share the same [typeId].
class TypeReference {
  const TypeReference(this.typeId);

  /// Unique identifier to reference a specific type between [ReferencePairManager]s.
  final int typeId;

  @override
  bool operator ==(other) => other is TypeReference && typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;

  @override
  String toString() {
    return '$runtimeType($typeId)';
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
/// [LocalReferenceCommunicationHandler.createLocalReferenceFor].
class UnpairedRemoteReference {
  const UnpairedRemoteReference(this.typeReference, this.creationArguments);

  /// Represents the type that is represented.
  final TypeReference typeReference;

  /// Arguments used to create the instance this represents.
  final List<dynamic> creationArguments;

  @override
  String toString() {
    return '$runtimeType($typeReference, $creationArguments)';
  }
}
