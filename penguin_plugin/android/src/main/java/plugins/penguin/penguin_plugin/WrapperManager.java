package plugins.penguin.penguin_plugin;

import java.util.HashMap;

public class WrapperManager {
  public final HashMap<String, Wrapper> allocatedWrappers = new HashMap<>();
  private final HashMap<String, Wrapper> temporaryWrappers = new HashMap<>();

  public void addAllocatedWrapper(final Wrapper wrapper) {
    addWrapper(wrapper, allocatedWrappers);
  }

  public void removeAllocatedWrapper(String uniqueId) {
    allocatedWrappers.remove(uniqueId);
  }

  public void addTemporaryWrapper(final Wrapper wrapper) {
    addWrapper(wrapper, temporaryWrappers);
  }

  private void addWrapper(final Wrapper wrapper, HashMap<String, Wrapper> wrapperMap) {
    final Wrapper existingWrapper;
    try {
      existingWrapper = getWrapper(wrapper.$uniqueId);
    } catch (WrapperNotFoundException exception) {
      wrapperMap.put(wrapper.$uniqueId, wrapper);
      return;
    }

    if (existingWrapper.$getValue() != wrapper.$getValue()) {
      final String message = String.format("Object for uniqueId already exists: %s", wrapper.$uniqueId);
      throw new IllegalArgumentException(message);
    }

    if (!wrapperMap.containsKey(wrapper.$uniqueId)) wrapperMap.put(wrapper.$uniqueId, wrapper);
  }

  public Wrapper getWrapper(String uniqueId) throws WrapperNotFoundException {
    if (allocatedWrappers.containsKey(uniqueId)) return allocatedWrappers.get(uniqueId);
    if (temporaryWrappers.containsKey(uniqueId)) return temporaryWrappers.get(uniqueId);
    throw new WrapperNotFoundException(uniqueId);
  }

  public void clearTemporaryWrappers() {
    temporaryWrappers.clear();
  }
}
