package plugins.penguin.penguin_plugin;

import java.util.HashMap;

public class WrapperManager {
  private final HashMap<String, Wrapper> wrappers = new HashMap<>();

  public void addWrapper(final Wrapper wrapper) {
    final Wrapper existingWrapper;
    try {
      existingWrapper = getWrapper(wrapper.$uniqueId);
    } catch (WrapperNotFoundException exception) {
      wrappers.put(wrapper.$uniqueId, wrapper);
      return;
    }

    if (existingWrapper.$getValue() != wrapper.$getValue()) {
      final String message = String.format("Object for uniqueId already exists: %s", wrapper.$uniqueId);
      throw new IllegalArgumentException(message);
    }

    if (!wrappers.containsKey(wrapper.$uniqueId)) wrappers.put(wrapper.$uniqueId, wrapper);
  }

  public void removeWrapper(String uniqueId) {
    wrappers.remove(uniqueId);
  }

  public Wrapper getWrapper(String uniqueId) throws WrapperNotFoundException {
    if (wrappers.containsKey(uniqueId)) return wrappers.get(uniqueId);
    throw new WrapperNotFoundException(uniqueId);
  }
}
