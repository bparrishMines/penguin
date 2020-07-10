import 'reference.dart';
import 'reference_pair_manager.dart';

/// Handles converting [Reference]s for a [ReferencePairManager].
///
/// When a [ReferencePairManager] receives arguments from another
/// [ReferencePairManager] or sends arguments to another [ReferencePairManager],
/// it converts [Reference]s to their paired [LocalReference]/[RemoteReference]
/// or creates a new [UnpairedReference].
///
/// See [StandardReferenceConverter].
mixin ReferenceConverter {
  /// Converts arguments to be used by a [RemoteReference].
  ///
  /// A [ReferencePairManager] should use this when creating or invoking a
  /// method on a [RemoteReference].
  Object convertForRemoteManager(ReferencePairManager manager, Object object);

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// A [ReferencePairManager] uses this when creating or invoking a method on
  /// a [LocalReference].
  Object convertForLocalManager(
    ReferencePairManager manager,
    Object object,
  );
}

/// Standard implementation of a [ReferenceConverter].
class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// Conversions:
  ///   * Paired [LocalReference]s are converted to their paired [RemoteReference].
  ///   * Unpaired [LocalReference]s are converted into [UnpairedReference].
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object convertForRemoteManager(
    ReferencePairManager manager,
    Object object,
  ) {
    if (object is LocalReference &&
        manager.getPairedRemoteReference(object) != null) {
      return manager.getPairedRemoteReference(object);
    } else if (object is LocalReference &&
        manager.getPairedRemoteReference(object) == null) {
      return UnpairedReference(
        manager.getTypeId(object.referenceType),
        manager.remoteHandler
            .getCreationArguments(object)
            .map((_) => convertForRemoteManager(manager, _))
            .toList(),
      );
    } else if (object is List) {
      return object.map((_) => convertForRemoteManager(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertForRemoteManager(manager, _)),
        object.values.map<Object>((_) => convertForRemoteManager(manager, _)),
      );
    }

    return object;
  }

  /// Converts arguments to be used with a [LocalReference].
  ///
  /// A [ReferencePairManager] uses this when creating or invoking a method on
  /// a [LocalReference].
  ///
  /// Conversions:
  ///   * [RemoteReference]s are converted to their paired [LocalReference].
  ///   * [UnpairedReference]s are converted into unpaired [LocalReference]s.
  ///   * [List]s are converted to `List<dynamic>` and this method is applied to
  ///     each value within the list.
  ///   * [Map]s are converted to `Map<dynamic, dynamic>` and this method is
  ///     applied to each key and each value.
  @override
  Object convertForLocalManager(
    ReferencePairManager manager,
    Object object,
  ) {
    if (object is RemoteReference) {
      return manager.getPairedLocalReference(object);
    } else if (object is UnpairedReference) {
      return manager.localHandler.create(
        manager,
        manager.getReferenceType(object.typeId),
        object.creationArguments
            .map((_) => convertForLocalManager(manager, _))
            .toList(),
      );
    } else if (object is List) {
      return object.map((_) => convertForLocalManager(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertForLocalManager(manager, _)),
        object.values.map<Object>((_) => convertForLocalManager(manager, _)),
      );
    }

    return object;
  }
}
