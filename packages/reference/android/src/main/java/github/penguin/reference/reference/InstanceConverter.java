package github.penguin.reference.reference;

import androidx.annotation.Nullable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InstanceConverter {
  @Nullable
  Object convertForRemoteMessenger(TypeChannelMessenger manager, @Nullable Object object);

  @Nullable
  Object convertForLocalMessenger(TypeChannelMessenger manager, @Nullable Object object) throws Exception;

  class StandardInstanceConverter implements InstanceConverter {
    @Nullable
    @Override
    public Object convertForRemoteMessenger(TypeChannelMessenger manager, @Nullable Object object) {
      if (object == null) {
        return null;
      } else if (manager.isPaired(object)) {
        return manager.getPairedPairedInstance(object);
      } else/* if (!manager.isPaired(object) && object instanceof ReferenceType) {
        final String referenceChannelName =
            ((ReferenceType<?>) object).getTypeChannel().name;
        return manager.createUnpairedInstance(referenceChannelName, object);
      } else*/ if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List<?>) object) {
          result.add(convertForRemoteMessenger(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertForRemoteMessenger(manager, entry.getKey()),
              convertForRemoteMessenger(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Nullable
    @Override
    public Object convertForLocalMessenger(TypeChannelMessenger manager, @Nullable Object object)
        throws Exception {
      if (object instanceof PairedInstance) {
        return manager.getPairedObject((PairedInstance) object);
      } else if (object instanceof NewUnpairedInstance) {
        final NewUnpairedInstance unpairedInstance = (NewUnpairedInstance) object;
        return manager
            .getChannelHandler(unpairedInstance.channelName)
            .createInstance(
                manager,
                (List<Object>)
                    convertForLocalMessenger(
                        manager, ((NewUnpairedInstance) object).creationArguments));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertForLocalMessenger(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertForLocalMessenger(manager, entry.getKey()),
              convertForLocalMessenger(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
