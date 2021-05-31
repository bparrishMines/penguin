package github.penguin.reference.reference;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InstanceConverter {
  @Nullable
  Object convertInstances(InstanceManager manager, @Nullable Object object);

  @Nullable
  Object convertPairedInstances(InstanceManager manager, @Nullable Object object);

  class StandardInstanceConverter implements InstanceConverter {
    @Nullable
    @Override
    public Object convertInstances(InstanceManager manager, @Nullable Object object) {
      if (object == null) {
        return null;
      } else if (manager.containsInstance(object)) {
        return new PairedInstance(manager.getInstanceId(object));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List<?>) object) {
          result.add(convertInstances(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertInstances(manager, entry.getKey()),
              convertInstances(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Nullable
    @Override
    public Object convertPairedInstances(InstanceManager manager, @Nullable Object object) {
      if (object instanceof PairedInstance) {
        return manager.getInstance(((PairedInstance) object).instanceId);
      } if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertPairedInstances(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertPairedInstances(manager, entry.getKey()),
              convertPairedInstances(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
