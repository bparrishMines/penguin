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

class TypeReference {
  const TypeReference(this.typeId);

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
