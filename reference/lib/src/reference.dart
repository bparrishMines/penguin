import 'reference_pair_manager.dart';

/// Represents an accessible object instance on a remote thread/process.
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

/// Represents an accessible object instance on a local thread/process.
///
/// This is an empty mixin that allows a [ReferencePairManager] to know that a
/// class is able be paired with a [RemoteReference].
mixin LocalReference {}

/// Represents a type that exists on a local and remote thread/process.
///
/// For example, this could represent a class named `Apple` in `apple.dart`
/// and `Apple.java` files.
///
/// This is used to help instantiate [LocalReference]s for
/// [ReferencePairManager]s.
///
/// Two [TypeReference]s are equal if they share the same [typeId].
class TypeReference {
  const TypeReference(this.typeId);

  /// Unique identifier to help reference a specific class between [ReferencePairManager]s.
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
/// This act as a replacement for a [RemoteReference] that has no
/// [LocalReference].
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
