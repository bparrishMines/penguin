import 'package:reference/reference.dart';

/// A class that can be represented by a [PairedReference].
mixin Referencable<T extends Object> {
  ReferenceChannel<T> get referenceChannel;
}

/// Represents a paired object instance in a [ReferenceChannelManager].
///
/// When two [ReferenceChannelManager]s each maintain access to one of two
/// paired objects, this class is used to represent both objects.
///
/// Two [PairedReference]s are equal if they share the same [referenceId].
class PairedReference {
  /// Default constructor for [PairedReference].
  const PairedReference(this.referenceId);

  /// Unique identifier used to retrieve the instance this represents from a
  /// [ReferenceChannelManager].
  ///
  /// No two [PairedReference]s in a [ReferencePairManager] can have the same
  /// [referenceId].
  final String referenceId;

  @override
  bool operator ==(other) =>
      other is PairedReference && referenceId == other.referenceId;

  @override
  int get hashCode => referenceId.hashCode;

  @override
  String toString() {
    return '$runtimeType($referenceId)';
  }
}

/// Represents an object that is not paired to a specific object instance, but can be instantiated in a [ReferenceChannelManager].
class UnpairedReference {
  /// Default constructor for [UnpairedReference].
  const UnpairedReference(this.channelName, this.creationArguments);

  /// Name of the [ReferenceChannel] used create this and handle instantiation.
  final String channelName;

  /// Arguments used to create the instance this represents.
  final List<Object?> creationArguments;

  @override
  String toString() {
    return '$runtimeType($channelName, $creationArguments)';
  }
}
