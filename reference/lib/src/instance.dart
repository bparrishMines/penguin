import 'package:reference/reference.dart';

// TODO: ReferenceType?
/// A class that can be paired with another instance in a [TypeChannelManager].
mixin PairableInstance<T extends Object> {
  TypeChannel<T> get typeChannel;
}

/// Represents a object instance in a [TypeChannelManager].
///
/// When two [TypeChannelManager]s each maintain access to one of two
/// paired objects, this class is used to represent both objects.
///
/// Two [PairedInstance]s are equal if they share the same [instanceId].
class PairedInstance {
  /// Default constructor for [PairedInstance].
  const PairedInstance(this.instanceId);

  /// Unique identifier used to retrieve the instance this represents from a
  /// [TypeChannelManager].
  ///
  /// No two [PairedInstance]s in a [TypeChannelManager] can have the same
  /// [instanceId].
  final String instanceId;

  @override
  bool operator ==(Object? other) =>
      other is PairedInstance && instanceId == other.instanceId;

  // TODO: Avoid hash code collision with String value
  @override
  int get hashCode => instanceId.hashCode;

  @override
  String toString() {
    return 'PairedInstance($instanceId)';
  }
}

/// Represents a new object that can be instantiated in a [TypeChannelManager].
class NewUnpairedInstance {
  /// Default constructor for [NewUnpairedInstance].
  const NewUnpairedInstance(this.channelName, this.creationArguments);

  /// Name of the type channel used to get [creationArguments] and handle instantiation.
  final String channelName;

  /// Arguments used to create the instance this represents.
  final List<Object?> creationArguments;

  @override
  String toString() {
    return 'NewUnpairedInstance($channelName, $creationArguments)';
  }
}
