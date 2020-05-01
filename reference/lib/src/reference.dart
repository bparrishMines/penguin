///// Represents an accessible instance of another object.
/////
///// A [Reference] is equal if they share the same [referenceId].
/////
///// See:
///// [ReferenceManager]
///// [RemoteReference]
///// [LocalReference]
//class _Reference {
//  const _Reference(this.referenceBinding);
//
//  /// Unique identifier used to access this object with a [ReferenceManager].
//  final ReferenceBinding referenceBinding;
//
//  @override
//  bool operator ==(other) => hashCode == other.hashCode;
//
//  @override
//  int get hashCode => referenceBinding.hashCode;
//}

/// Represents an accessible instance of a remote object.
///
/// Two [RemoteReference]s are equal if they share the same [referenceId].
class RemoteReference {
  const RemoteReference(this.referenceId) : assert(referenceId != null);

  /// Unique identifier used to access this object with a [ReferenceManager].
  final String referenceId;

  @override
  bool operator ==(other) =>
      other is RemoteReference && hashCode == other.hashCode;

  @override
  int get hashCode => referenceId.hashCode;
}

mixin LocalReference {}

///// Represents an accessible instance of a local object.
/////
///// [value] is the local object that this represents.
/////
///// Two [LocalReference]s are equal if they share the same [value].
//class LocalReference {
//  const LocalReference(this.value) : assert(value != null);
//
//  /// The value this [LocalReference] represents.
//  final Referencable value;
//
//  @override
//  bool operator ==(other) => other is LocalReference && value == other.value;
//
//  @override
//  int get hashCode => value.hashCode;
//}
//
///// Indicates that a class can be represented as a [Reference].
/////
///// This is an empty mixin that allows a [ReferenceManager] to know that a class
///// can be represented locally as a [LocalReference] and remotely as a
///// [RemoteReference].
//mixin Referencable {}
