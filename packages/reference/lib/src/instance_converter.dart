import 'instance.dart';
import 'instance_manager.dart';

/// Handles converting paired instances for an [InstanceManager].
///
/// See [StandardInstanceConverter].
mixin InstanceConverter {
  /// Converts objects to [PairedInstance]s with ids stored in [manager].
  Object? convertInstances(InstanceManager manager, Object? object);

  /// Converts [PairedInstances] to objects stored in [manager].
  Object? convertPairedInstances(InstanceManager manager, Object? object);
}

/// Standard implementation of [InstanceConverter].
///
/// Converts paired objects, lists, and maps.
class StandardInstanceConverter implements InstanceConverter {
  /// Default constructor for [StandardInstanceConverter].
  const StandardInstanceConverter();

  /// Converts objects to [PairedInstance]s with ids stored in [manager].
  ///
  /// Conversions:
  ///   * Objects paired in a [TypeChannelMessenger] are converted to their
  ///     paired [PairedInstance].
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertInstances(InstanceManager manager, Object? object) {
    if (object == null) {
      return null;
    } else if (manager.containsInstance(object)) {
      return PairedInstance(manager.getInstanceId(object)!);
    } else if (object is List) {
      return object.map<Object?>((_) => convertInstances(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys.map<Object?>((_) => convertInstances(manager, _)),
        object.values.map<Object?>((_) => convertInstances(manager, _)),
      );
    }

    return object;
  }

  /// Converts [PairedInstances] to objects stored in [manager].
  ///
  /// Conversions:
  ///   * [PairedInstance]s are converted to the object instance they're paired
  ///     to.
  ///   * [List]s are converted to `List<Object?>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<Object?, Object?>` and this method is
  ///     applied to each key and each value.
  @override
  Object? convertPairedInstances(InstanceManager manager, Object? object) {
    if (object is PairedInstance) {
      return manager.getInstance(object.instanceId);
    } else if (object is List) {
      return object
          .map<Object?>((_) => convertPairedInstances(manager, _))
          .toList();
    } else if (object is Map) {
      return Map<Object?, Object?>.fromIterables(
        object.keys.map<Object?>((_) => convertPairedInstances(manager, _)),
        object.values.map<Object?>((_) => convertPairedInstances(manager, _)),
      );
    }

    return object;
  }
}
