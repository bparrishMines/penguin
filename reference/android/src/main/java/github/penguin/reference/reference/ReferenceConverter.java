package github.penguin.reference.reference;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReferenceConverter {
  Object convertReferencesForRemoteManager(ReferencePairManager manager, Object object);

  Object convertReferencesForLocalManager(ReferencePairManager manager, Object object)
      throws Exception;

  class StandardReferenceConverter implements ReferenceConverter {
    @Override
    public Object convertReferencesForRemoteManager(ReferencePairManager manager, Object object) {
      if (object instanceof LocalReference
          && manager.getPairedRemoteReference((LocalReference) object) != null) {
        return manager.getPairedRemoteReference((LocalReference) object);
      } else if (object instanceof LocalReference
          && manager.getPairedRemoteReference((LocalReference) object) == null) {
        return new UnpairedReference(
            manager.getClassId(((LocalReference) object).getReferenceClass()),
            (List<Object>)
                convertReferencesForRemoteManager(
                    manager,
                    manager.getRemoteHandler().getCreationArguments((LocalReference) object)));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertReferencesForRemoteManager(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertReferencesForRemoteManager(manager, entry.getKey()),
              convertReferencesForRemoteManager(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Override
    public Object convertReferencesForLocalManager(ReferencePairManager manager, Object object)
        throws Exception {
      if (object instanceof RemoteReference) {
        return manager.getPairedLocalReference((RemoteReference) object);
      } else if (object instanceof UnpairedReference) {
        return manager
            .getLocalHandler()
            .create(
                manager,
                manager.getReferenceClass(((UnpairedReference) object).classId),
                (List<Object>)
                    convertReferencesForLocalManager(
                        manager, ((UnpairedReference) object).creationArguments));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertReferencesForLocalManager(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertReferencesForLocalManager(manager, entry.getKey()),
              convertReferencesForLocalManager(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
