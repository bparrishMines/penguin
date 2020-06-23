import 'reference.dart';
import 'reference_pair_manager.dart';

mixin ReferenceConverter {
  Object convertAllLocalReferences(ReferencePairManager manager, Object object);
  Object convertAllRemoteReferences(
    ReferencePairManager manager,
    Object object,
  );
}

class StandardReferenceConverter implements ReferenceConverter {
  const StandardReferenceConverter();

  @override
  Object convertAllLocalReferences(
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
            .map((_) => convertAllLocalReferences(manager, _))
            .toList(),
      );
    } else if (object is List) {
      return object.map((_) => convertAllLocalReferences(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertAllLocalReferences(manager, _)),
        object.values.map<Object>((_) => convertAllLocalReferences(manager, _)),
      );
    }

    return object;
  }

  @override
  Object convertAllRemoteReferences(
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
            .map((_) => convertAllRemoteReferences(manager, _))
            .toList(),
      );
    } else if (object is List) {
      return object.map((_) => convertAllRemoteReferences(manager, _)).toList();
    } else if (object is Map) {
      return Map<Object, Object>.fromIterables(
        object.keys.map<Object>((_) => convertAllRemoteReferences(manager, _)),
        object.values
            .map<Object>((_) => convertAllRemoteReferences(manager, _)),
      );
    }

    return object;
  }
}
