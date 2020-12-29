import 'package:reference/reference.dart';

/// A class that can be paired with another instance in a [TypeChannelManager].
mixin PairableInstance<T extends Object> {
  TypeChannel<T> get typeChannel;
}

/// Represents a object instance in a [TypeChannelManager].
///
/// When two [TypeChannelManager]s each maintain access to one of two
/// paired objects, this class is used to represent both objects.
///
/// Two [PairedInstance]s are equal if they share the same [referenceId].
class PairedInstance {
  /// Default constructor for [PairedInstance].
  const PairedInstance(this.referenceId);

  /// Unique identifier used to retrieve the instance this represents from a
  /// [TypeChannelManager].
  ///
  /// No two [PairedInstance]s in a [TypeChannelManager] can have the same
  /// [referenceId].
  final String referenceId;

  @override
  bool operator ==(other) =>
      other is PairedInstance && referenceId == other.referenceId;

  @override
  int get hashCode => referenceId.hashCode & super.hashCode;

  @override
  String toString() {
    return '$runtimeType($referenceId)';
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
    return '$runtimeType($channelName, $creationArguments)';
  }
}
