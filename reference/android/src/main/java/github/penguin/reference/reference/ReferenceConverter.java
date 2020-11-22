package github.penguin.reference.reference;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReferenceConverter {
  Object convertForRemoteManager(ReferenceChannelManager manager, Object object);

  Object convertForLocalManager(ReferenceChannelManager manager, Object object) throws Exception;

  class StandardReferenceConverter implements ReferenceConverter {
    @Override
    public Object convertForRemoteManager(ReferenceChannelManager manager, Object object) {
      if (manager.isPaired(object)) {
        return manager.referencePairs.getPairedRemoteReference(object);
      } else if (!manager.isPaired(object) && object instanceof Referencable) {
        final String referenceChannelName =
            ((Referencable) object).getReferenceChannel().channelName;
        return manager.createUnpairedReference(referenceChannelName, object);
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

    @Override
    public Object convertForLocalManager(ReferenceChannelManager manager, Object object)
        throws Exception {
      if (object instanceof RemoteReference) {
        return manager.referencePairs.getPairedObject((RemoteReference) object);
      } else if (object instanceof UnpairedReference) {
        final UnpairedReference unpairedReference = (UnpairedReference) object;
        return manager
            .getChannelHandler(unpairedReference.handlerChannel)
            .createInstance(
                manager,
                (List<Object>)
                    convertForLocalManager(
                        manager, ((UnpairedReference) object).creationArguments));
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
