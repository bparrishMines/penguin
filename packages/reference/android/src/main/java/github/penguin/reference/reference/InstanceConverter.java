package github.penguin.reference.reference;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InstanceConverter {
  @Nullable
  Object convertInstancesToPairedInstances(TypeChannelMessenger manager, @Nullable Object object);

  @Nullable
  Object convertPairedInstancesToInstances(TypeChannelMessenger manager, @Nullable Object object);

  class StandardInstanceConverter implements InstanceConverter {
    @Nullable
    @Override
    public Object convertInstancesToPairedInstances(TypeChannelMessenger manager, @Nullable Object object) {
      if (object == null) {
        return null;
      } else if (manager.isPaired(object)) {
        return manager.getPairedPairedInstance(object);
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List<?>) object) {
          result.add(convertInstancesToPairedInstances(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertInstancesToPairedInstances(manager, entry.getKey()),
              convertInstancesToPairedInstances(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Nullable
    @Override
    public Object convertPairedInstancesToInstances(TypeChannelMessenger manager, @Nullable Object object) {
      if (object instanceof PairedInstance) {
        return manager.getPairedObject((PairedInstance) object);
      } if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertPairedInstancesToInstances(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertPairedInstancesToInstances(manager, entry.getKey()),
              convertPairedInstancesToInstances(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
