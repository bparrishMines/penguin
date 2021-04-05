import 'instance.dart';
import 'type_channel.dart';

/// Handles converting references for a [TypeChannelMessenger].
///
/// See [StandardInstanceConverter].
mixin InstanceConverter {
  /// Converts arguments to be used by a [PairedInstance].
  Object? convertForRemoteMessenger(
    TypeChannelMessenger messenger,
    Object? object,
  );

  /// Converts arguments to be used with a object paired to a [PairedInstance].
  Object? convertForLocalMessenger(
    TypeChannelMessenger messenger,
    Object? object,
  );
}

/// Standard implementation of [InstanceConverter].
class StandardInstanceConverter implements InstanceConverter {
  const StandardInstanceConverter();

  /// Converts arguments to be used with a remote [TypeChannelMessenger].
  ///
  /// Conversions:
  ///   * Objects paired in a [TypeChannelMessenger] are converted to their
  ///     paired [PairedInstance].
  ///   * Unpaired instances are converted into [NewUnpairedInstance].
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForRemoteMessenger(
    TypeChannelMessenger messenger,
    Object? object,
  ) {
    if (object == null) {
      return null;
    } else if (messenger.isPaired(object)) {
      return messenger.getPairedPairedInstance(object);
    } else if (object is List) {
      return object
          .map<Object?>((_) => convertForRemoteMessenger(messenger, _))
          .toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys
            .map<Object?>((_) => convertForRemoteMessenger(messenger, _)),
        object.values
            .map<Object?>((_) => convertForRemoteMessenger(messenger, _)),
      );
    }

    return object;
  }

  /// Converts arguments to be used by a local [TypeChannelMessenger].
  ///
  /// Conversions:
  ///   * [PairedInstance]s are converted to the object instance they're paired
  ///     to.
  ///   * [NewUnpairedInstance]s are converted in to an instantiation using the
  ///     specified channel name.
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertForLocalMessenger(
    TypeChannelMessenger messenger,
    Object? object,
  ) {
    if (object is PairedInstance) {
      return messenger.getPairedObject(object);
    } else if (object is List) {
      return object
          .map<Object?>((_) => convertForLocalMessenger(messenger, _))
          .toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys.map<Object?>((_) => convertForLocalMessenger(messenger, _)),
        object.values
            .map<Object?>((_) => convertForLocalMessenger(messenger, _)),
      );
    }

    return object;
  }
}
