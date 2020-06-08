package github.penguin.reference.reference;

import java.util.HashMap;
import java.util.Map;

public class ReferencePairManagerPool {
  @SuppressWarnings("unused")
  public static final ReferencePairManagerPool globalInstance = new ReferencePairManagerPool();

  final Map<String, PoolableReferencePairManager> managers =
      new HashMap<>();
  final Map<Class<? extends LocalReference>, PoolableReferencePairManager> classesToManagers =
      new HashMap<>();

  @SuppressWarnings("unused")
  public boolean add(PoolableReferencePairManager manager) {
    if (managers.containsKey(manager.poolId)) return false;

    for (Class<? extends LocalReference> clazz : manager.supportedClasses) {
      if (classesToManagers.get(clazz) != null) return false;
    }

    for (Class<? extends LocalReference> clazz : manager.supportedClasses) {
      classesToManagers.put(clazz, manager);
    }

    manager.pools.add(this);
    managers.put(manager.poolId, manager);

    return true;
  }

  @SuppressWarnings("unused")
  public void remove(PoolableReferencePairManager manager) {
    if (managers.get(manager.poolId) == null) return;

    for (Class<? extends LocalReference> clazz : manager.supportedClasses) {
      classesToManagers.remove(clazz);
    }
    managers.remove(manager.poolId);
    manager.pools.remove(this);
  }
}
