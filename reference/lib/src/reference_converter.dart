import 'reference.dart';
import 'reference_pair_manager.dart';

mixin ReferenceConverter {
  Object convertForRemoteManager(ReferencePairManager manager, Object object);
  Object convertForLocalManager(
    ReferencePairManager manager,
    Object object,
  );
}

class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

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
