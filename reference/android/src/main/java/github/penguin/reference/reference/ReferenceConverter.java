package github.penguin.reference.reference;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReferenceConverter {
  Object convertAllLocalReferences(ReferencePairManager manager, Object object);
  Object convertAllRemoteReferences(ReferencePairManager manager, Object object) throws Exception;

  class StandardReferenceConverter implements ReferenceConverter {
    @Override
    public Object convertAllLocalReferences(ReferencePairManager manager, Object object) {
      if (object instanceof LocalReference
          && manager.getPairedRemoteReference((LocalReference) object) != null) {
        return manager.getPairedRemoteReference((LocalReference) object);
      } else if (object instanceof LocalReference
          && manager.getPairedRemoteReference((LocalReference) object) == null) {
        return new UnpairedReference(
            manager.getClassId(((LocalReference) object).getReferenceClass()),
            (List<Object>)
                convertAllLocalReferences(manager,
                    manager.getRemoteHandler().getCreationArguments((LocalReference) object)));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertAllLocalReferences(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertAllLocalReferences(manager, entry.getKey()), convertAllLocalReferences(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Override
    public Object convertAllRemoteReferences(ReferencePairManager manager, Object object) throws Exception {
      if (object instanceof RemoteReference) {
        return manager.getPairedLocalReference((RemoteReference) object);
      } else if (object instanceof UnpairedReference) {
        return manager.getLocalHandler()
            .create(
                manager,
                manager.getReferenceClass(((UnpairedReference) object).classId),
                (List<Object>)
                    convertAllRemoteReferences(manager, ((UnpairedReference) object).creationArguments));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertAllRemoteReferences(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertAllRemoteReferences(manager, entry.getKey()), convertAllRemoteReferences(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
