package github.penguin.reference.reference;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import androidx.annotation.Nullable;

public interface InstanceConverter {
  @Nullable
  Object convertForRemoteManager(TypeChannelManager manager, @Nullable Object object);

  @Nullable
  Object convertForLocalManager(TypeChannelManager manager, @Nullable Object object) throws Exception;

  class StandardInstanceConverter implements InstanceConverter {
    @Nullable
    @Override
    public Object convertForRemoteManager(TypeChannelManager manager, @Nullable Object object) {
      if (manager.isPaired(object)) {
        return manager.instancePairs.getPairedPairedInstance(object);
      } else if (!manager.isPaired(object) && object instanceof PairableInstance) {
        final String referenceChannelName =
            ((PairableInstance) object).getTypeChannel().name;
        return manager.createUnpairedInstance(referenceChannelName, object);
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertForRemoteManager(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertForRemoteManager(manager, entry.getKey()),
              convertForRemoteManager(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }

    @Nullable
    @Override
    public Object convertForLocalManager(TypeChannelManager manager, @Nullable Object object)
        throws Exception {
      if (object instanceof PairedInstance) {
        return manager.instancePairs.getPairedObject((PairedInstance) object);
      } else if (object instanceof NewUnpairedInstance) {
        final NewUnpairedInstance unpairedInstance = (NewUnpairedInstance) object;
        return manager
            .getChannelHandler(unpairedInstance.channelName)
            .createInstance(
                manager,
                (List<Object>)
                    convertForLocalManager(
                        manager, ((NewUnpairedInstance) object).creationArguments));
      } else if (object instanceof List) {
        final List<Object> result = new ArrayList<>();
        for (final Object obj : (List) object) {
          result.add(convertForLocalManager(manager, obj));
        }
        return result;
      } else if (object instanceof Map) {
        final Map<Object, Object> oldMap = new HashMap<Object, Object>((Map) object);
        final Map<Object, Object> newMap = new HashMap<>();
        for (Map.Entry<Object, Object> entry : oldMap.entrySet()) {
          newMap.put(
              convertForLocalManager(manager, entry.getKey()),
              convertForLocalManager(manager, entry.getValue()));
        }
        return newMap;
      }

      return object;
    }
  }
}
