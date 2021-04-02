import 'type_channel.dart';

/// Represents a object instance in a [TypeChannelMessenger].
///
/// When two [TypeChannelMessenger]s each maintain access to one of two
/// paired objects, this class is used to represent both objects.
///
/// Two [PairedInstance]s are equal if they share the same [instanceId].
class PairedInstance {
  /// Default constructor for [PairedInstance].
  const PairedInstance(this.instanceId);

  /// Unique identifier used to retrieve the instance this represents from a
  /// [TypeChannelMessenger].
  ///
  /// No two [PairedInstance]s in a [TypeChannelMessenger] can have the same
  /// [instanceId].
  final String instanceId;

  @override
  bool operator ==(Object? other) =>
      other is PairedInstance && instanceId == other.instanceId;

  // Hash algorithm from package:quiver hash2();
  @override
  int get hashCode {
    int hash = 0x1fffffff & (17 + instanceId.hashCode);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  @override
  String toString() {
    return 'PairedInstance($instanceId)';
  }
}
