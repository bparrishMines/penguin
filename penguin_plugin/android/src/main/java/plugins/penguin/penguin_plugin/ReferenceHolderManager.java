package plugins.penguin.penguin_plugin;

import java.util.HashMap;

public class ReferenceHolderManager {
  private static final ReferenceHolderManager GLOBAL_INSTANCE = new ReferenceHolderManager();

  private final HashMap<String, MethodChannelReferenceHolder> referenceHolders = new HashMap<>();

  public static ReferenceHolderManager getGlobalInstance() {
    return GLOBAL_INSTANCE;
  }

  public void addReferenceHolder(final MethodChannelReferenceHolder holder) {
    if (referenceHolders.containsKey(holder.referenceId)) {
      final String message = String.format("%s with following referenceId already exists: %s",
          holder.getClass().getSimpleName(),
          holder.referenceId);
      throw new IllegalArgumentException(message);
    }

    referenceHolders.put(holder.referenceId, holder);
  }

  public MethodChannelReferenceHolder removeReferenceHolder(final String referenceId) {
    return referenceHolders.remove(referenceId);
  }

  public MethodChannelReferenceHolder getReferenceHolder(final String referenceId) throws ReferenceHolderNotFoundException {
    if (referenceHolders.containsKey(referenceId)) return referenceHolders.get(referenceId);
    throw new ReferenceHolderNotFoundException(referenceId);
  }
}
